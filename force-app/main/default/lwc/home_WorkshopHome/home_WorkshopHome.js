import { LightningElement, wire, track } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import getTemplateTextRecords from "@salesforce/apex/home_WorkshopSupport.getTemplateTextRecords";
import einsteinHeader from "@salesforce/resourceUrl/einsteinHeader";
import transferOwnershipToCurrentUser from "@salesforce/apex/TransferOwnershipController.transferOwnershipToCurrentUser";

export default class Home_WorkshopHome extends LightningElement {
  size;
  templateTextRecords;
  einsteinHeaderUrl = einsteinHeader;
  @track isButtonDisabled = false;
  @track isToggleOn = false;

  @wire(getTemplateTextRecords)
  wiredTemplateText({ error, data }) {
    console.log(data);
    if (data) {
      this.templateTextRecords = data;
      console.log("templateTextRecords:", this.templateTextRecords);
    } else if (error) {
      console.log("error:", error);
    }
  }

  get workshopModules() {
    let filteredRecords = this.templateTextRecords
      ? this.groupModules(this.templateTextRecords)
      : [];

    return filteredRecords.length > 0 ? filteredRecords : null;
  }

  groupModules(records) {
    let groupedRecords = {};
    records.forEach((record) => {
      if (!groupedRecords[record.Module__c]) {
        groupedRecords[record.Module__c] = {
          key: record.Module__c,
          label: "Build #" + record.Module__c,
          records: []
        };
      }
      groupedRecords[record.Module__c].records.push(record);
    });
    return Object.values(groupedRecords);
  }

  handleButtonClick(event) {
    const promptText = event.target.dataset.promptText;
    navigator.clipboard
      .writeText(promptText)
      .then(() => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Text copied to clipboard",
            variant: "success"
          })
        );
      })
      .catch((error) => {
        console.error("Failed to copy text: ", error);
      });
  }

  handleToggleChange(event) {
    this.isToggleOn = event.target.checked;
  }

  get buttonWrapperClasses() {
    return this.isToggleOn
      ? "slds-col slds-size_1-of-2 slds-text-align_center"
      : "slds-col slds-size_1-of-1 slds-text-align_center";
  }

  handlePrepareDataClick() {
    this.isButtonDisabled = true;
    transferOwnershipToCurrentUser()
      .then(() => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Success",
            message: "Data prepared successfully",
            variant: "success"
          })
        );
        this.isButtonDisabled = false;
      })
      .catch((error) => {
        this.dispatchEvent(
          new ShowToastEvent({
            title: "Error preparing data",
            message: error.body.message,
            variant: "error"
          })
        );
        this.isButtonDisabled = false;
      });
  }
}
