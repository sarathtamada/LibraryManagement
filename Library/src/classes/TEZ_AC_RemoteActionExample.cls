global class TEZ_AC_RemoteActionExample {  
    //Variables  
    public String accountName { get; set; }  
    public static Account account { get; set; }  
      
    // constructor  
    public TEZ_AC_RemoteActionExample() { }    
      
    //Remote Action  
    @RemoteAction  
    global static Account getAccount(String accountName) {  
        account = [SELECT Id, Name, Phone, Type, NumberOfEmployees FROM Account WHERE Name = :accountName];  
        return account;  
    }  
}