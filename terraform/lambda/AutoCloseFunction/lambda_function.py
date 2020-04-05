import json
import boto3
from boto3.dynamodb.conditions import Key, Attr
from botocore.vendored import requests
import datetime

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('smartGarage')

# raspberrypi-api-endpoint
endpoint_url = "https://bifilar-okapi-3094.dataplicity.io/led/green/"

def lambda_handler(event, context):
    response = table.scan(ProjectionExpression='id')
    id = []
    for i in response['Items']:
        id.append(int(i['id']))
    id.sort()
    result = []
    item = []
    latest_id = id[-1]
    new_id = latest_id+1
    now = datetime.datetime.now()
    time = now.strftime("%Y-%m-%d %H:%M:%S")
    try:
        response = table.query(
            KeyConditionExpression=Key('id').eq(str(latest_id))
        )
        result.append(response['Items'])
    except:
        print("Definitely something went wrong!")
    print("latest json data from dynamodb: " + str(result))
    for i in result:
        for j in i:
            status = j['details']['status']
    print("status: "+status)
    if status == "open":
        # data to be sent to api
        data = {"state":"1"}
        # sending post request and saving response as response object
        send = requests.post(endpoint_url, data = data)
        # extracting response text
        json = send.text
        status = "close"
        print("The POST json is:%s"%json)
        try:
            response = table.put_item(
                Item = {
                    "id": str(new_id),
                        "details": {
                          "timeOccured": time,
                          "status": status
                    }
                }
            )
            item.append(response)
            if item:
                posted="Posted to dynamodb with id: "+str(new_id) 
            return posted
        except:
            return ("Couldn't post to dynamodb, something went wrong")
    return result
