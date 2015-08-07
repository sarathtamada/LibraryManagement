public with sharing class RestDemo {
public string str{get;set;}
          public void restDemo()
          {
          String username = 'balakrishna@amzur.com';
          String password = '7569774960baluhlVKcCyC37mxCMqt22G7m3SY';
          string clientId ='3MVG9ZL0ppGP5UrB3yw6qF__OPcEBMHiEVodQTi8U3qjN8SD20J0fVvrIRvjdyNJ1MgZ_BotB.QVTyoPZ72Xp';
          string clientSecret ='8809749461944093821';    
          String tokenUrl ='https://ap2.salesforce.com/services/oauth2/token';
          
          String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
          Blob headerValue = Blob.valueOf(username + ':' + password);
          String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
          
          Http h = new Http();    
          HttpRequest req = new HttpRequest();
          req.setBody(reqbody);
          req.setMethod('POST');
          req.setEndpoint(tokenUrl);
          HttpResponse res = h.send(req);    
          OAuth2 objAuthenticationInfo = (OAuth2)JSON.deserialize(res.getbody(), OAuth2.class);
          restDemo reqst=new restDemo();
          
          if(objAuthenticationInfo.access_token!=null){    
                  Http h1 = new Http();
                  HttpRequest req1 = new HttpRequest();
                  req1.setHeader('Authorization','Bearer '+objAuthenticationInfo.access_token);
                  req1.setHeader('Content-Type','application/json');
                  req1.setHeader('accept','application/json');
                
                  //req1.setBody(jsonstr);//Send JSON body
                  req1.setMethod('GET');
                  req1.setEndpoint('https://ap2.salesforce.com/services/apexrest/accounts/00128000002nnoD');//URL will be your Salesforce REST API end point where you will doPOST,PUT,DELETEorGET
                  HttpResponse res1 = h1.send(req1);
                  
                  str=res1.getbody();
                  
                  system.debug('RESPONSE_BODY'+res1.getbody()); 
                  }
          }
     public class OAuth2{
     public String id{get;set;}
     public String issued_at{get;set;}
     public String instance_url{get;set;}
     public String signature{get;set;}
     public String access_token{get;set;}    
}
}