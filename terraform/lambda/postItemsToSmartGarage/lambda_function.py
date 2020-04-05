from __future__ import print_function # Python 2/3 compatibility
import boto3
import json
import datetime
from botocore.vendored import requests

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('smartGarage')
stepFuntion = boto3.client('stepfunctions')

# raspberrypi-api-endpoint
URL = "https://bifilar-okapi-3094.dataplicity.io/"

def lambda_handler(event, context):
    id = []
    item = []
    print(event)
    response = table.scan(ProjectionExpression='id')
    for i in response['Items']:
        id.append(int(i['id']))
    id.sort()
    latest_id=id[-1]
    new_id=latest_id+1
    now = datetime.datetime.now()
    time = now.strftime("%Y-%m-%d %H:%M:%S")
    status = event['Status']

    def post_to_rpi(path):
        endpoint_url = URL+path
        # data to be sent to api
        data = {"state":"1"}
        # sending post request and saving response as response object
        send = requests.post(endpoint_url, data = data)
        # extracting response text
        json = send.text
        print("The POST json is:%s"%json)
    if status == "close":
        post_to_rpi("/led/green/")
        post_to_rpi("/led/red/")
    elif status == "open":
        post_to_rpi("/led/green/")
        response = stepFuntion.start_execution(
            stateMachineArn = 'arn:aws:states:us-east-2:01234567891:stateMachine:smartGarage'
        )
    print(new_id)
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