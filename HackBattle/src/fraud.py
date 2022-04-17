import joblib
import json
io = open("result.json","r")
mapping_data = json.load(io)


l = mapping_data['feature_select']
l = ','.join(l)
qu = f"SELECT {l} from marketdata"
print(qu)