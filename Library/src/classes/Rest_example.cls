@RestResource(urlMapping='/v4/accounts/*')
global with sharing class Rest_example {
    @HttpGet
    global static Account doGet(){
        
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account results = [SELECT ID,Name,Phone FROM Account WHERE ID =: accountId];
        return results;
    }

}