import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import Id from '@salesforce/user/Id';
import getContentDocumentId from "@salesforce/apex/SetupAssistantController.getContentDocumentId";

export default class CopilotHelpResources extends NavigationMixin(LightningElement) {

    pdfContentId;
    userId = Id;

    links = [
        {
            id: 0,
            title: 'Agentforce for Partners',
            description: "Join Partner Community Group to collaborate and learn all things related to Agentforce",
            link: 'https://partners.salesforce.com/_ui/core/chatter/groups/GroupProfilePage?g=0F9F9000000cDzfSAA',
            icon: 'standard:partners'
        },
        {
            id: 1,
            title: 'Einstein 1 Studio Developer Center',
            description: 'Explore tools and resources to build and customize AI apps',
            link: 'https://developer.salesforce.com/developer-centers/einstein-1-studio',
            icon: 'standard:story'
        },
        {
            id: 2,
            title: 'Get Ready for Agentforce on Trailhead',
            description: 'Learn how Agentforce fits your business goals, launch your first agent, and build a plan for AI success.',
            link: 'https://trailhead.salesforce.com/content/learn/trails/get-ready-for-agentforce',
            icon: 'standard:trailhead'
        },
        {
            id: 3,
            title: 'Get Started with Agentforce Agents',
            description: 'Bring the power of conversational AI to your business with Agentforce Agents. Build a trusted and customizable AI assistant that empowers your users to get more done in Salesforce.',
            link: 'https://developer.salesforce.com/docs/einstein/genai/guide/get-started-copilot.html',
            icon: 'standard:story'
        }
    ]

    handleLinkNavigate(event){
        window.open(event.currentTarget.dataset.id, "_blank");
    }

    updateUserNav(){
        window.open(`/lightning/setup/ManageUsers/page?address=%2F${this.userId}%3Fnoredirect%3D1%26isUserEntityOverride%3D1`, "_blank");
    }

    /*
    @wire(getContentDocumentId, { label: 'Official Einstein Copilot Hands-on Training Guide' })
    pacakge({ error, data }) {
        if (data) {
            this.pdfContentId = data;
        } else if (error) {
            console.error(error);
        }
    }

    pdfPreviewDownload(){
        if(this.pdfContentId){
            window.open(`https://srcorg4-dev-ed.develop.my.salesforce.com/sfc/p/a500000bgiHg/a/a5000000PLZ7/LJaoMpi9RFFwad2kgOMp1PeAeEPVIWZGjUMTo57qtIo`, '_blank');
            
            this[NavigationMixin.Navigate]({
                type: "standard__namedPage",
                attributes: {
                  pageName: "filePreview",
                },
                state: {
                  recordIds: this.pdfContentId,
                  selectedRecordId: this.pdfContentId
                },
            });
        }
    }
    */
}