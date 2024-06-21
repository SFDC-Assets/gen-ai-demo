# https://hosted-scratch.herokuapp.com/launch?template=https://github.com/SFDC-Assets/gen-ai-demo/tree/main
# sfdx force:source:retrieve -m GenAiPromptTemplate,GenAiPromptTemplateActv,GenAiFunction,GenAiPlanner
sfdx shane:org:create -f config/partner-scratch-def.json -d 30 -s --wait 60 --userprefix einstein -o gpt.demo

node run.js

sfdx force:source:push

sfdx force:user:permset:assign -n EinsteinGPTPromptTemplateManager
sfdx force:user:permset:assign -n EinsteinGPTPromptTemplateUser
sfdx force:user:permset:assign -n Heroku_Endpoint_Access
sfdx force:user:permset:assign -n TDX_Demo_Build_Permissions

sfdx automig:load -d data

sfdx shane:user:password:set -p salesforce1 -g User -l User

sfdx force:org:open