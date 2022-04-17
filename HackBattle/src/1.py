import openai
key = "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"
openai.api_key = key
import pandas as pd
from sqlalchemy import create_engine
db = create_engine('postgresql://postgres:1234567890@localhost:5432/str')

query_user = "unique product_Name whose product_Price is more than 200"

response = openai.Completion.create(
    engine="text-davinci-002",
    prompt=f"""### Postgres SQL tables, with their properties:
    #
    #marketdata(transfer_type, days_for_shipping_real,days_for_shipment_scheduled, benefit_per_order, sales_per_customer, delivery_status, late_delivery_risk,
       category_Id, category_Name, customer_City, customer_Country,
       customer_Email, customer_Fname, customer_Id, customer_Lname,
       customer_Password, customer_Segment, customer_State,
       customer_Street, customer_Zipcode, department_Id,
       department_Name, latitude, longitude, market, order_City,
       order_Country, order_Customer_Id, order_date, order_Id,
       order_Item_Cardprod_Id, order_Item_Discount,
       order_Item_Discount_Rate, order_Item_Id, order_Item_Product_Price,
       order_Item_Profit_Ratio, order_Item_Quantity, sales,
       order_Item_Total, order_Profit_Per_order, order_Region,
       order_State, order_Status, product_Card_Id, product_Category_Id,
       product_Image, product_Name, product_Price, product_Status,
       shipping_date, shipping_Mode)
  #
  ###A query to list of {str(query_user)} SELECT""",
    temperature=0,
    max_tokens=500,
    top_p=1.0,
    frequency_penalty=0.0,
    presence_penalty=0.0,
    stop=["#", ";"]
)



text = response['choices'][0]['text']

statement = "SELECT " + str(text) + ';'
print(statement)

result_set = db.execute(statement)  
df_from_records = pd.DataFrame.from_records(result_set)

print(df_from_records.head(5))





# response = openai.Completion.create(
#     engine="text-davinci-002",
#     prompt='''
#     prompt="""### Postgres SQL tables, with their properties:
#     #
#     Employee(
#     transfer_type,
#     days_for_shipping_real,
#     days_for_shipment_scheduled,
#     benefit_per_order,
#     sales_per_customer,
#     delivery_status, 
#     late_delivery_risk,
#     category_Id,
#     category_Name,

#     customer_City,
#     customer_Country,
#     customer_Email,
#     customer_Fname,
#     customer_Id,
#     customer_Lname,
#     customer_Password,
#     customer_Segment,
#     customer_State,
#     customer_Street,
#     customer_Zipcode,

#     department_Id,
#     department_Name,
#     latitude, 
#     longitude, 
#     market, 
#     order_City,
#     order_Country, 
#     order_Customer_Id, 
#     order_date, 
#     order_Id,
#     order_Item_Cardprod_Id, 
#     order_Item_Discount,
#     order_Item_Discount_Rate, 
#     order_Item_Id, 
#     order_Item_Product_Price,
#     order_Item_Profit_Ratio, 
#     order_Item_Quantity, 
#     sales,
#     order_Item_Total, 
#     order_Profit_Per_order, 
#     order_Region,
#     order_State, 
#     order_Status,
#     product_Card_Id, 
#     product_Category_Id,
#     product_Image, 
#     product_Name, 
#     product_Price, 
#     product_Status,
#     shipping_date, 
#     shipping_Mode
#        )
#     #
#     ###A query to list of costly product_Name SELECT,
#     ''',
#     temperature=0,
#     max_tokens=150,
#     top_p=1,
#     frequency_penalty=0,
#     presence_penalty=0,
#     stop=["#", ";"]
# )