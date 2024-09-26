#!/usr/bin/env bash

# https://hosted-scratch.herokuapp.com/launch?template=https://github.com/SFDC-Assets/gen-ai-demo/tree/main
# sfdx force:source:retrieve -m GenAiPromptTemplate,GenAiPromptTemplateActv,GenAiFunction,GenAiPlanner
# sfdx automig:dump -d data -o Account,Contact,Case,Lead,Opportunity,FinServ__FinancialAccount__c,PersonLifeEvent,Claim,InsurancePolicy,InsurancePolicyCoverage,InsurancePolicyAsset
sfdx shane:org:create -f config/fscai-scratch-def.json -d 30 -s --wait 60 --userprefix fsc -o agent.workshop

npm install
node run.js
sleep 120

sfdx shane:user:password:set -p salesforce1 -g User -l User
# sfdx force:package:install --package=04t4W000003ChfP --wait 20 -r
sfdx force:package:install --package=04tHn000001dvY4 --wait 30
sfdx force:package:install --package=04t1E000001Iql5 --wait 2
sfdx force:user:permset:assign -n FinancialServicesCloudStandard
sfdx force:user:permset:assign -n FinancialServicesCloudExtension
sfdx force:user:permset:assign -n EinsteinGPTPromptTemplateManager
sf org assign permset -n CopilotSalesforceAdminPSG

sfdx force:source:push -f


sfdx force:user:permset:assign -n TDX_Demo_Build_Permissions

# sfdx automig:load -d data

sfdx force:org:open

# sleep 120
# sfdx force:source:deploy -p flow-app