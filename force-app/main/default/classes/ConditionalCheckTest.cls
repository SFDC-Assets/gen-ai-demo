@isTest
public with sharing class ConditionalCheckTest {
    @isTest public static void testisAccount(){
        TEST.startTest(); 
        Boolean isAccount = ConditionalCheckController.isAccount();
        system.assertNotEquals(null, isAccount);
        TEST.stopTest(); 
    }

    @isTest public static void testisLead(){
        TEST.startTest(); 
        Boolean isLead = ConditionalCheckController.isLead();
        system.assertNotEquals(null, isLead);
        TEST.stopTest(); 
    }
    
    @isTest public static void testisContact(){
        TEST.startTest(); 
        Boolean isContact = ConditionalCheckController.isContact();
        system.assertNotEquals(null, isContact);
        TEST.stopTest(); 
    }
    
    @isTest public static void testisCase(){
        TEST.startTest(); 
        Boolean isCase = ConditionalCheckController.isCase();
        system.assertNotEquals(null, isCase);
        TEST.stopTest(); 
    }
    
    @isTest public static void testisOpportunity(){
        TEST.startTest(); 
        Boolean isOpportunity = ConditionalCheckController.isOpportunity();
        system.assertNotEquals(null, isOpportunity);
        TEST.stopTest(); 
    }
    
    @isTest public static void testisCampaign(){
        TEST.startTest(); 
        Boolean isCampaign = ConditionalCheckController.isCampaign();
        system.assertNotEquals(null, isCampaign);
        TEST.stopTest(); 
    }

    @isTest public static void testisTask(){
        TEST.startTest(); 
        Boolean isTask = ConditionalCheckController.isTask();
        system.assertNotEquals(null, isTask);
        TEST.stopTest(); 
    }

    @isTest public static void testisEvent(){
        TEST.startTest(); 
        Boolean isEvent = ConditionalCheckController.isEvent();
        system.assertNotEquals(null, isEvent);
        TEST.stopTest(); 
    }

    @isTest public static void testisUser(){
        TEST.startTest(); 
        Boolean isUser = ConditionalCheckController.isUser();
        system.assertNotEquals(null, isUser);
        TEST.stopTest(); 
    }

    @isTest public static void testisOrder(){
        TEST.startTest(); 
        Boolean isOrder = ConditionalCheckController.isOrder();
        system.assertNotEquals(null, isOrder);
        TEST.stopTest(); 
    }

    @isTest public static void testisAsset(){
        TEST.startTest(); 
        Boolean isAsset = ConditionalCheckController.isAsset();
        system.assertNotEquals(null, isAsset);
        TEST.stopTest(); 
    }

    @isTest public static void testisContract(){
        TEST.startTest(); 
        Boolean isContract = ConditionalCheckController.isContract();
        system.assertNotEquals(null, isContract);
        TEST.stopTest(); 
    }

    @isTest public static void testisProduct2(){
        TEST.startTest(); 
        Boolean isProduct2 = ConditionalCheckController.isProduct2();
        system.assertNotEquals(null, isProduct2);
        TEST.stopTest(); 
    }

    @isTest public static void testisPricebook2(){
        TEST.startTest(); 
        Boolean isPricebook2 = ConditionalCheckController.isPricebook2();
        system.assertNotEquals(null, isPricebook2);
        TEST.stopTest(); 
    }

    @isTest public static void testisCampaignMember(){
        TEST.startTest(); 
        Boolean isCampaignMember = ConditionalCheckController.isCampaignMember();
        system.assertNotEquals(null, isCampaignMember);
        TEST.stopTest(); 
    }

    @isTest public static void testisActiveScratchOrg(){
        TEST.startTest(); 
        Boolean isActiveScratchOrg = ConditionalCheckController.isActiveScratchOrg();
        system.assertNotEquals(null, isActiveScratchOrg);
        TEST.stopTest(); 
    }

    @isTest public static void testisRecommendation(){
        TEST.startTest(); 
        Boolean isRecommendation = ConditionalCheckController.isRecommendation();
        system.assertNotEquals(null, isRecommendation);
        TEST.stopTest(); 
    }

    @isTest public static void testisLicense(){
        TEST.startTest(); 
        Boolean isLicense = ConditionalCheckController.isLicense();
        system.assertNotEquals(null, isLicense);
        TEST.stopTest(); 
    }

    @isTest public static void testisPackageVersion(){
        TEST.startTest(); 
        Boolean isPackageVersion = ConditionalCheckController.isPackageVersion();
        system.assertNotEquals(null, isPackageVersion);
        TEST.stopTest(); 
    }

    @isTest public static void testisPackage(){
        TEST.startTest(); 
        Boolean isPackage = ConditionalCheckController.isPackage();
        system.assertNotEquals(null, isPackage);
        TEST.stopTest(); 
    }

    @isTest public static void testisContentVersion(){
        TEST.startTest(); 
        Boolean isContentVersion = ConditionalCheckController.isContentVersion();
        system.assertNotEquals(null, isContentVersion);
        TEST.stopTest(); 
    }

    @isTest public static void testisLMA(){
        TEST.startTest(); 
        Boolean isLMA = ConditionalCheckController.isLMA();
        system.assertNotEquals(null, isLMA);
        TEST.stopTest(); 
    }

    @isTest public static void testisFma(){
        TEST.startTest(); 
        Boolean isFmaParameter = ConditionalCheckController.isFmaParameter();
        system.assertNotEquals(null, isFmaParameter);
        TEST.stopTest(); 
    }

    @isTest public static void testIsSignupRequestDemoTrials(){
        TEST.startTest(); 
        Boolean isSignUpReq = ConditionalCheckController.isSignupRequest();
        system.assertNotEquals(null, isSignUpReq);
        TEST.stopTest(); 
    }

    @isTest public static void testIsActivity(){
        TEST.startTest(); 
        Boolean isActivity = ConditionalCheckController.isActivity();
        system.assertNotEquals(null, isActivity);
        TEST.stopTest(); 
    }

    @isTest public static void testIsAddress(){
        TEST.startTest(); 
        Boolean isAddress = ConditionalCheckController.isAddress();
        system.assertNotEquals(null, isAddress);
        TEST.stopTest(); 
    }

    @isTest public static void testIsDigitalWallet(){
        TEST.startTest(); 
        Boolean isDigitalWallet = ConditionalCheckController.isDigitalWallet();
        system.assertNotEquals(null, isDigitalWallet);
        TEST.stopTest(); 
    }

    @isTest public static void testIsEmployee(){
        TEST.startTest(); 
        Boolean isEmployee = ConditionalCheckController.isEmployee();
        system.assertNotEquals(null, isEmployee);
        TEST.stopTest(); 
    }

    @isTest public static void testIsLocation(){
        TEST.startTest(); 
        Boolean isLocation = ConditionalCheckController.isLocation();
        system.assertNotEquals(null, isLocation);
        TEST.stopTest(); 
    }

    @isTest public static void testIsPayment(){
        TEST.startTest(); 
        Boolean isPayment = ConditionalCheckController.isPayment();
        system.assertNotEquals(null, isPayment);
        TEST.stopTest(); 
    }

    @isTest public static void testIsRefund(){
        TEST.startTest(); 
        Boolean isRefund = ConditionalCheckController.isRefund();
        system.assertNotEquals(null, isRefund);
        TEST.stopTest(); 
    }

    @isTest public static void testIsWorkStep(){
        TEST.startTest(); 
        Boolean isWorkStep = ConditionalCheckController.isWorkStep();
        system.assertNotEquals(null, isWorkStep);
        TEST.stopTest(); 
    }

    @isTest public static void testisSeller(){
        TEST.startTest(); 
        Boolean isSeller = ConditionalCheckController.isSeller();
        system.assertNotEquals(null, isSeller);
        TEST.stopTest(); 
    }

    @isTest public static void isPartyConsent(){
        TEST.startTest(); 
        Boolean isPartyConsent = ConditionalCheckController.isPartyConsent();
        system.assertNotEquals(null, isPartyConsent);
        TEST.stopTest(); 
    }

    @isTest public static void isScorecard(){
        TEST.startTest(); 
        Boolean isScorecard = ConditionalCheckController.isScorecard();
        system.assertNotEquals(null, isScorecard);
        TEST.stopTest(); 
    }

    @isTest public static void isProblemIncident(){
        TEST.startTest(); 
        Boolean isProblemIncident = ConditionalCheckController.isProblemIncident();
        system.assertNotEquals(null, isProblemIncident);
        TEST.stopTest(); 
    }

    @isTest public static void isPaymentLineInvoice(){
        TEST.startTest(); 
        Boolean isPaymentLineInvoice = ConditionalCheckController.isPaymentLineInvoice();
        system.assertNotEquals(null, isPaymentLineInvoice);
        TEST.stopTest(); 
    }
}