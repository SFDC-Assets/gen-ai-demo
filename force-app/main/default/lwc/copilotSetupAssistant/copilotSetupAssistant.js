import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from "lightning/navigation";
import Id from "@salesforce/user/Id";
import getBotDefinitionId from "@salesforce/apex/SetupAssistantController.getBotDefinitionId";
import getApexClassId from "@salesforce/apex/SetupAssistantController.getApexClassId";

export default class CopilotSetupAssistant extends NavigationMixin(LightningElement) {
    userId = Id;
    //activeSections = ['1', '2','3', '4', '5', '6', '7'];

    promptValue = "You are helping a travel agent plan the best itinerary for a traveler's upcoming trip to {!$Input:Destination}. The traveler has shared their profile and interests with you. Ensure the itinerary aligns with the traveler's preferences and interests as listed here {!$Input:Traveler.Traveler_Profile__r.Interests__c} Traveler has special requirements {!$Input:Traveler.Traveler_Profile__r.Special_Requirements__c} Based on this information, provide an itinerary that includes accommodation options, must-visit attractions, local experiences, dining recommendations, and transportation activities. List the activities in a bulleted list format";

    async copyToClipboard(event){

        return navigator.clipboard.writeText(this.promptValue).then(()=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Text copied to clipboard',
                    variant: 'success',
                }),
            );
        }).catch(error => {
            console.error('Failed to copy text: ', error);
        });
    }

    async copyValueToClipboard(event){
        return navigator.clipboard.writeText(event.target.value).then(()=>{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Text copied to clipboard',
                    variant: 'success',
                }),
            );
        }).catch(error => {
            console.error('Failed to copy text: ', error);
        });
    }

    navToCopilotApexOne(){
        (async () => {
            await getApexClassId({
                label: 'GenerateActivitiesViaSFAPInvocable'
            })
                .then(result => {
                    window.open(`/lightning/setup/ApexClasses/page?address=%2F${result}`, "_blank");
                })
                .catch(error => {
                    console.error(error);
                    // Toast for Failure
                    this.dispatchEvent(
                        new ShowToastEvent({
                        title: "Error",
                        message: 'We were unable to navigate to the Apex Class',
                        variant: "error"
                        })
                    );
                });
            })();
    }

    refreshPage(){
        location.reload();
    }

    navToCopilotApexTwo(){
        (async () => {
            await getApexClassId({
                label: 'GenerateWeatherRelatedActivities'
            })
            .then(result => {
                window.open(`/lightning/setup/ApexClasses/page?address=%2F${result}`, "_blank");
            })
            .catch(error => {
                console.error(error);
                // Toast for Failure
                this.dispatchEvent(
                    new ShowToastEvent({
                    title: "Error",
                    message: 'We were unable to navigate to the Apex Class',
                    variant: "error"
                }));
            });
        })();
    }

    navToFlows(){
        window.open(`/lightning/setup/Flows/home`, "_blank");
    }

    navToRemoteSiteSettings(){
        window.open(`/lightning/setup/SecurityRemoteProxy/home`, "_blank");  
    }

    navToEinsteinCopilotBuilderBotDef(){
        (async () => {
            await getBotDefinitionId({
                label: 'Einstein Copilot'
            })
                .then(result => {
                    window.open(`/AiCopilot/copilotStudio.app#/copilot/builder?copilotId=${result}`, "_blank");
                })
                .catch(error => {
                    console.error(error);
                    // Toast for Failure
                    this.dispatchEvent(
                        new ShowToastEvent({
                        title: "Error",
                        message: 'We were unable to navigate to Einstein Copilot Builder',
                        variant: "error"
                        })
                    );
                });
            })();
    }

    handleSectionToggle(event) {
        const openSections = event.detail.openSections;
    }

    navToCopilotSetup(){
        window.open("/lightning/setup/EinsteinCopilot/home", "_blank");
    }

    navToEinsteinSetup(){
        window.open("/lightning/setup/EinsteinGPTSetup/home", "_blank");
    }

    navToPermSets(){
        window.open(`/lightning/setup/PermSets/page?address=%2Fudd%2FPermissionSet%2FassignPermissionSet.apexp%3FuserId%3D${this.userId}`, "_blank");
    }

    navToPermSetGroups(){
        window.open(`/lightning/setup/PermSetGroups/page?address=%2Fudd%2FPermissionSetGroup%2FassignPermissionSet.apexp%3FuserId%3D${this.userId}%26isPermsetGroup%3D1`, "_blank");
    }

    navToPermSetLicenses(){
        window.open( `/lightning/setup/PermissionSetLicense/page?address=%2Fudd%2FLicensing%2FassignPermissionSetLicense.apexp%3FuserId%3D${this.userId}`, "_blank");
    }

    navToCopilotActions(){
        window.open("/lightning/setup/EinsteinCopilotActions/home", "_blank");
    }

    navToCopilotStudio(){
        window.open("/lightning/setup/EinsteinCopilot/home","_blank");
    }

    navigateToSetup(){
        window.open("/lightning/setup/SetupOneHome/home","_blank");
    }

    navigateToPromptBuilderSetup(){
        window.open("/lightning/setup/EinsteinPromptStudio/home","_blank");
    }

    navigateToCopilotActionsStudioSetup(){
        window.open("/lightning/setup/EinsteinCopilotActions/home","_blank");
    }

    navToModelsApiHelpDoc(){
        window.open("https://developer.salesforce.com/docs/einstein/genai/guide/models-api.html","_blank");
    }

    navToPackageManager(){
        window.open("/lightning/setup/Package/home", "_blank");
    }

    navToModelsApiLwcFlow(){
        window.open("https://developer.salesforce.com/docs/einstein/genai/guide/build-lwc-flow-models.html", "_blank");
    }

    manageabilityRuleForApex(){
        window.open("https://developer.salesforce.com/docs/atlas.en-us.pkg2_dev.meta/pkg2_dev/packaging_packageable_components.htm#mdc_apex_class", "_blank");
    }

    manageabilityRuleForFlowDef(){
        window.open("https://developer.salesforce.com/docs/atlas.en-us.pkg2_dev.meta/pkg2_dev/packaging_packageable_components.htm#mdc_flow", "_blank");
    }

    manageabilityRuleForGenAiFunc(){
        window.open("https://developer.salesforce.com/docs/atlas.en-us.pkg2_dev.meta/pkg2_dev/packaging_packageable_components.htm#mdc_genaifunction", "_blank");
    }

    manageabilityRuleForPermSet(){
        window.open("https://developer.salesforce.com/docs/atlas.en-us.pkg2_dev.meta/pkg2_dev/packaging_packageable_components.htm#mdc_permission_set", "_blank");
    }

}