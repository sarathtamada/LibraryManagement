@RestResource(urlMapping='/ad/accounts/*')
global with sharing class Rest_AccountService_v1 {
    
    @HttpGet
    global static List<Account> doGet(){
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Account> results = [SELECT Id,Name,Phone,Website,BillingState FROM Account WHERE ID =: accountId];
        return results;
    }
    
    
   
}