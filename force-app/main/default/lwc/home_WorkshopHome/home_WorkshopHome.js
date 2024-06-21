import { LightningElement, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getWorkshopType from '@salesforce/apex/home_WorkshopSupport.getWorkshopType';
import getTemplateTextRecords from '@salesforce/apex/home_WorkshopSupport.getTemplateTextRecords';
import einsteinHeader from '@salesforce/resourceUrl/einsteinHeader';
import transferOwnershipToCurrentUser from '@salesforce/apex/TransferOwnershipController.transferOwnershipToCurrentUser';


export default class Home_WorkshopHome extends LightningElement {
    workshopType;
    templateTextRecords;
    einsteinHeaderUrl = einsteinHeader;
    @track isButtonDisabled = false;
    @track moduleNames = {
        'pb1': 'Module 1: Getting Started',
        'pb2': 'Module 2: Einstein AI Case Response',
        'pb3': 'Module 3: Testing Sentiment',
        'c1': 'Module 1: Meet Salesforce Copilot and say Hello!',
        'c2': 'Module 2: Build A Copilot Action',
    };
    @track isToggleOn = false;

    // @wire(getWorkshopType)
    // wiredWorkshopType({ error, data }) {
    //     if (data) {
    //         this.workshopType = data;
    //         console.log('workshopType:', this.workshopType);
    //     } else if (error) {
    //         console.log('error:', error);
    //     }
    // }

    handlePromptBuilderClick(event){
        this.workshopType = 'pb';
    }

    handleCopilotClick(event){
        this.workshopType = 'c';
    }

    @wire(getTemplateTextRecords)
    wiredTemplateText({ error, data }) {
        console.log(data);
        if (data) {
            this.templateTextRecords = data;
            console.log('templateTextRecords:', this.templateTextRecords);
        } else if (error) {
            console.log('error:', error);
        }
    }

    get isPromptBuilder() {
        if (this.workshopType === 'pb') {
            let filteredRecords = this.templateTextRecords
                ? this.groupModules(this.templateTextRecords.filter(record => record.Template_Type__c === 'Prompt'))
                : [];
            console.log('isPromptBuilder:', filteredRecords);
            return filteredRecords.length > 0 ? filteredRecords : null;
        }
        return null;
    }

    get isCopilot() {
        if (this.workshopType === 'c') {
            let filteredRecords = this.templateTextRecords
                ? this.groupModules(this.templateTextRecords.filter(record => record.Template_Type__c === 'Copilot Action'))
                : [];
            console.log('isCopilot:', filteredRecords);
            return filteredRecords.length > 0 ? filteredRecords : null;
        }
        return null;
    }

    get workshopModules() {
        if (this.workshopType === 'pb') {
            return this.isPromptBuilder;
        } else if (this.workshopType === 'c') {
            return this.isCopilot;
        }
        return null;
    }

    get welcomeMessage() {
        if (this.workshopType === 'pb') {
            return 'Welcome to the Prompt Builder workshop!';
        } else if (this.workshopType === 'c') {
            return 'Welcome to the Copilot workshop!';
        }
        return '';
    }

    groupModules(records) {
        let groupedRecords = {};
        records.forEach(record => {
            if (!groupedRecords[record.Module__c]) {
                groupedRecords[record.Module__c] = {
                    key: record.Module__c,
                    label: this.moduleNames[this.workshopType + record.Module__c] || 'Module ' + record.Module__c,
                    records: []
                };
            }
            groupedRecords[record.Module__c].records.push(record);
        });
        return Object.values(groupedRecords);
    }

    handleButtonClick(event) {
        const promptText = event.target.dataset.promptText;
        navigator.clipboard.writeText(promptText).then(() => {
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

    handleToggleChange(event) {
        this.isToggleOn = event.target.checked;
    }

    get buttonWrapperClasses() {
        return this.isToggleOn ? 'slds-col slds-size_1-of-2 slds-text-align_center' : 'slds-col slds-size_1-of-1 slds-text-align_center';
    }

    handlePrepareDataClick() {
        this.isButtonDisabled = true;
        transferOwnershipToCurrentUser()
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Data prepared successfully',
                        variant: 'success',
                    }),
                );
                this.isButtonDisabled = false;
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error preparing data',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                this.isButtonDisabled = false;
            });
    }

}