from sqlalchemy import create_engine
from sqlalchemy.inspection import inspect
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import json
import joblib
import json
from datetime import datetime
import pandas as pd
from sklearn.preprocessing import LabelEncoder
from neuralprophet import NeuralProphet
from src.gtp_call import DataAndDataTypes, GPTQuery
import pickle



key = "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"
gptCall = GPTQuery(key)
db = create_engine('postgresql://postgres:1234567890@localhost:5432/str')
io = open("./src/result.json","r")
mapping_data = json.load(io)

df_type = LabelEncoder()
df_delStatus = LabelEncoder()
df_CustomerSegment = LabelEncoder()
df_Shipping_Mode = LabelEncoder()

df_type.classes_ = mapping_data['trans_type']
df_delStatus.classes_ = mapping_data['delivery_status']
df_CustomerSegment.classes_ = mapping_data['customer_segment']
df_Shipping_Mode.classes_ = mapping_data['shipping_mode']


with open('./src/forecast_model.pckl', 'rb') as fin:
    model_forecast = pickle.load(fin)




app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)



@app.get('/{user_query}')
def index(user_query:str):
    # user_query = "unique product_Name whose product_Price is more than 200"
    #statement = gptCall.make_sql_statement(user_query)
     
    statement = "select transfer_type, count ( transfer_type) from marketdata group by transfer_type"
    result_set = db.execute(statement)
    #columns = json.dumps()

    data = [row._asdict() for row in result_set]
    return data

@app.get('/datatype/{quer}')
def giveDtype(quer:str):
    data_type = DataAndDataTypes()
    if quer == 's':
        return data_type.give_structure_data()

@app.get('/riskFraud/getforecastfraud/')
def say_transaction_isFraud():
    l = mapping_data['feature_select']
    l = ','.join(l)
    #print(tmp_df)
    qu = f"SELECT {l} from marketdata ORDER BY order_date   limit 100"
    data = db.execute(qu)
    tmp_df = pd.DataFrame(data.fetchall(),columns=data.keys())
    tmp_df.transfer_type = df_type.fit_transform(tmp_df.transfer_type)
    tmp_df.shipping_mode = df_delStatus.fit_transform(tmp_df.shipping_mode)
    tmp_df.customer_segment = df_CustomerSegment.fit_transform(tmp_df.customer_segment)
    tmp_df.delivery_status = df_Shipping_Mode.fit_transform(tmp_df.delivery_status)
    loaded_rf = joblib.load("./src/fraud.joblib")
    predict = loaded_rf.predict(tmp_df.values)
    tmp_df['fraud'] = predict
    tmp_df.transfer_type = df_type.inverse_transform(tmp_df.transfer_type)
    tmp_df.shipping_mode = df_delStatus.inverse_transform(tmp_df.shipping_mode)
    tmp_df.customer_segment = df_CustomerSegment.inverse_transform(tmp_df.customer_segment)
    tmp_df.delivery_status = df_Shipping_Mode.inverse_transform(tmp_df.delivery_status)

    statement = "SELECT count(late_delivery_risk) as count,late_delivery_risk from marketdata group by late_delivery_risk order by count"
    result_set = db.execute(statement)
    pp = tmp_df.T.to_dict()
    return [[pp[i] for i in range(len(pp))],[row._asdict() for row in result_set]]


@app.get('/insight/mostsolditem')
def most_trending_item():
    statement = '''select distinct product_Name,product_Price,order_Item_Quantity
                from marketdata where product_Status = 0 
                order by order_Item_Quantity desc,product_Price desc limit 200'''
    result_set = db.execute(statement)
    data = [row._asdict() for row in result_set]
    return data

@app.get('/insight/dailyana/{day}/{month}/{year}')
def get_product_price(day,month,year):
    statement = f'''SELECT * from marketdata  where cast(shipping_date as date) = '{month}/{day}/{year}' '''
    result_set = db.execute(statement)
    x = pd.DataFrame(result_set.fetchall() ,columns = result_set.keys())
    x['shipping_date'] = x['shipping_date'].apply(lambda x : datetime.strptime(x, '%m/%d/%Y %H:%M').date())
    res = pd.DataFrame({'count':x.groupby(['product_name','benefit_per_order']).size()}).reset_index()
    res2 = pd.DataFrame({'count':x.groupby(['order_country','product_name']).size()}).reset_index()
    res3 = pd.DataFrame({'count':x.groupby(['order_country','customer_segment']).size()}).reset_index()
    res4 = pd.DataFrame({'count':x.groupby(['order_country','transfer_type']).size()}).reset_index()
    pp = res.iloc[:,:2].T.to_dict()
    pp2 = res2.T.to_dict()
    pp3 = res3.T.to_dict()
    pp4 = res4.T.to_dict()
    return [
    [pp[i] for i in range(len(res))],
    [pp2[i] for i in range(len(res2))],
    [pp3[i] for i in range(len(res3))],
    [pp4[i] for i in range(len(res4))]
    ]


@app.get('/insight/forecasting')
def monthly_order_profit_order():
    statement = '''select shipping_date,order_Profit_Per_order from marketdata'''
    result_set = db.execute(statement)
    X = pd.DataFrame(result_set.fetchall() ,columns = result_set.keys())

    X['shipping_date'] = [datetime.strptime(date, '%m/%d/%Y %H:%M').date() for date in X.shipping_date]
    X['month'] = [X.shipping_date[i].month for i in range(len(X))]
    X['year'] = [X.shipping_date[i].year for i in range(len(X))]
    k = {}
    months = [i for i in range(1,13)]
    year = [2015 + i for i in range(3)]
    for i in year:
        for j in months:
            try:
                month_profit = sum(X.groupby('month').get_group(j).groupby('year').get_group(i).order_profit_per_order)
                k[datetime.strptime(f'{j}-{i}', '%m-%Y').date()] = month_profit
            except:
                pass
    new_df = pd.DataFrame(k.items(),columns = ['ds','y'])
    # print(new_df)
    # m = NeuralProphet()
    # metrics = m.fit(new_df, freq="auto")
    forecast = model_forecast.predict(new_df)
    future = model_forecast.make_future_dataframe(df=new_df, periods=30)
    forecast = model_forecast.predict(df=future)
    kk = forecast[['ds','season_yearly']]
    return [{'date':kk.ds[i],'sales':kk.season_yearly[i]} for i in range(len(kk))]


@app.get('/trends/topCatName')
def get_trends_on_cat():
    statement = "SELECT count(category_Name) as count,category_Name from marketdata group by category_Name order by count desc limit 10"
    statement1 = "SELECT count(customer_City) as count,customer_City from marketdata group by customer_City order by count desc limit 10"
    result_set = db.execute(statement)
    result_set1 = db.execute(statement1)
    data = [[row._asdict() for row in result_set],[row._asdict() for row in result_set1]]
    return data




    


