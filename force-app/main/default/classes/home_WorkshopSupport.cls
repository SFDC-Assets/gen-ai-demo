public with sharing class home_WorkshopSupport {
    @AuraEnabled(cacheable=true)
    public static String getWorkshopType() {
        Workshop__c ws = Workshop__c.getOrgDefaults();
        if (ws != null && ws.Type__c != null) {
            return ws.Type__c;
        }
        return null;
    }

    @AuraEnabled(cacheable=true)
    public static List<Template_Text__c> getTemplateTextRecords() {
        try {
            return [SELECT Id, Name, ActionInput1__c, ActionInput2__c, Action_Instruction__c, ActionOutput1__c, ActionOutput2__c, API_Name__c, Label__c, Prompt_Text__c, Template_Type__c, Module__c
                    FROM Template_Text__c WHERE Module__c != null];
        } catch (Exception e) {
            throw new AuraHandledException('Unable to retrieve Template Text Records: ' + e.getMessage());
        }
    }
}