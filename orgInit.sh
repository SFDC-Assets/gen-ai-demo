#!/usr/bin/env bash

# hosted-scratch.herokuapp.com/launch?template=https://github.com/SFDC-Assets/gen-ai-demo/tree/dev-workshop
# sfdx force:source:retrieve -m GenAiPromptTemplate,GenAiPromptTemplateActv,GenAiFunction,GenAiPlanner
# sfdx automig:dump -d data -o Account,Contact,Case,Lead,Opportunity,FinServ__FinancialAccount__c,PersonLifeEvent,Claim,InsurancePolicy,InsurancePolicyCoverage,InsurancePolicyAsset
sf demoutil org create scratch -f config/project-scratch-def.json -d 30 -s --wait 60 --userprefix dev -e agent.workshop

npm install
node run.js
sleep 120

sf demoutil user password set -p salesforce1 -g User -l User
sf org assign permset -n EinsteinGPTPromptTemplateManager
sf org assign permset -n CopilotSalesforceAdminPSG

sf project deploy start

sf org assign permset -n Workshop
sf automig load -d data
sf org open
# sleep 120
# sfdx force:source:deploy -p flow-app