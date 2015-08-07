global with sharing class SiteLoginController {

global String username {get; set;}
global String password {get; set;}
global string startUrl{get;set;}
global SiteLoginController(){
     startUrl = System.currentPageReference().getParameters().get('startURL');
}

global PageReference login() {
    //normal implementation
    startUrl = System.currentPageReference().getParameters().get('startURL');
    PageReference result =  Site.login(username, password, startUrl);
    system.debug(result);
    return result;
}


@RemoteAction
global static string remotelogin(string username, string password,string startUrL){
    //remote implementation
    system.debug('------------------>remotelogin()');
    //String startUrl = System.currentPageReference().getParameters().get('startURL'); //null reference 
    //system.debug('-------------------->'+startUrl);

    Pagereference result =  Site.login(username, password,startUrL);

    if(result == null){
        return 'NULL';
    }else{
        system.debug(result);
        system.debug(result.geturl());
        return  result.geturl(); 
    }
}}