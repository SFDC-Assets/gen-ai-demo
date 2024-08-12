#!/usr/bin/env bash

# https://hosted-scratch.herokuapp.com/launch?template=https://github.com/SFDC-Assets/gen-ai-demo/tree/main
# sfdx force:source:retrieve -m GenAiPromptTemplate,GenAiPromptTemplateActv,GenAiFunction,GenAiPlanner
# sfdx automig:dump -d data -o Account,Contact,Case,Lead,Opportunity,Phantom__c,Prompt_Search_Term_v1__c,Search_Term__c,Template_Text__c,Workshop_Config_Steps__c,Workshop__c
# sfdx shane:org:create -f config/snapshot-scratch-def.json -d 30 -s --wait 60 --userprefix einstein -o gpt.demo

sfdx shane:org:create -f config/partner-scratch-def.json -d 30 -s --wait 60 --userprefix einstein -o gpt.demo

npm install
node run.js

sleep 120

sfdx shane:user:password:set -p salesforce1 -g User -l User

sf org assign permset -n EinsteinGPTPromptTemplateManager
sf org assign permset -n EinsteinGPTPromptTemplateUser

sf project deploy start

sf org assign permset -n Heroku_Endpoint_Access
sf org assign permset -n TDX_Demo_Build_Permissions

sf automig load -d data

# sleep 120
# sf project deploy start -d flow-app

sfdx force:org:open