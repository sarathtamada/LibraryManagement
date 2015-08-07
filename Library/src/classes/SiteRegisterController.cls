public with sharing class SiteRegisterController {

    public PageReference registerUser() {
     PageReference page=new PageReference('https://ap1.salesforce.com/a0N/e?retURL=%2Fa0N%2Fo');
          page.setRedirect(true);   
          return page;
        
    }


    public String confirmPassword { get; set; }

    public String password { get; set; }

    public String email { get; set; }

    public String communityNickname { get; set; }

    public String username { get; set; }
}