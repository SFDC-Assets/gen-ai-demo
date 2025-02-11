import { LightningElement } from 'lwc';
import createGeneration from "@salesforce/apex/SetupAssistantController.createGeneration";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class ModelsApiLwc extends LightningElement {
    
    displaySpinner;
    prompt;
    response;
    displayResult;
    

    handlePromptChange(event){
        this.prompt = event.target.value;
    }

    get enableGenerate(){
        return !this.prompt;
    }

    handleClear(){
        this.prompt = '';
        this.response = '';
        this.displayResult = false;
    }

    handleCopyPaste(){
        return navigator.clipboard.writeText(this.response).then(()=>{
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

    handleGenerate(){
        this.displaySpinner = true;
        (async () => {
            await createGeneration({
                prompt: this.prompt
            })
                .then(result => {
                    console.log(result);
                    this.displaySpinner = false;
                    this.response = result;
                    this.displayResult = true;
                })
                .catch(error => {
                    console.error(error);
                    this.displaySpinner = false;
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: error.statusText,
                            message: error.body.message,
                            variant: "error"
                        })
                    );
                });
        })();
    }
}