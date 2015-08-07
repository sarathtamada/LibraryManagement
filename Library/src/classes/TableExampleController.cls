public with sharing class TableExampleController {
    // account and selection set/variables
    private list<AccountSubClass> AccountList {get; set;}
    private set<Id> AccountSelectedSet;
    public Integer AccountSelectedCount {get; set;}
    public String SelectedOneAccount {get; set;}
    
    // selection and filter 
    public list<String> AlphaList {get; set;}
    public String AlphaFilter {get; set;}
    public String SearchName {get; set;}
    public String SearchBillingAddress {get; set;} 
    private String SaveSearchName;
    private String SaveSearchBillingAddress;
    private String QueryAccount;
    
    // display sort and number
    public String RecPerPage {get; set;}
    public list<SelectOption> RecPerPageOption {get; set;}  
    public String SortFieldSave;
    
    /***
    * TableExampleController - Constructor initialization
    ***/
    public TableExampleController(){
        AccountList = new list<AccountSubClass>();
        AccountSelectedSet = new set<Id>();
        
        //records for page initialization
        RecPerPageOption = new list<SelectOption>();
        RecPerPageOption.add(new SelectOption('10','10'));
        RecPerPageOption.add(new SelectOption('25','25'));
        RecPerPageOption.add(new SelectOption('50','50'));
        RecPerPageOption.add(new SelectOption('100','100'));
        RecPerPageOption.add(new SelectOption('200','200'));
        RecPerPage = '10'; //default records per page
        
        // initialization alpha list
        AlphaList = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Other', 'All'};
            SortFieldSave = SortField;
        
        // alpha filter, use page parameter or set default to all
        if (apexpages.currentpage().getparameters().get('alpha') == null) {
            AlphaFilter = 'All';
        } else {
            AlphaFilter = apexpages.currentpage().getparameters().get('alpha');
        }
        
        // list generation
        BuildQuery();  
    }
    
    /***
    * StdSetControllerAccount - paging through the Account list
    ***/ 
    public ApexPages.StandardSetController StdSetControllerAccount {
        get {
            if(StdSetControllerAccount == null) {
                StdSetControllerAccount = new ApexPages.StandardSetController(Database.getQueryLocator(QueryAccount));
                // sets the number of records in each page set
                StdSetControllerAccount.setPageSize(Integer.valueOf(RecPerPage));
            }
            return StdSetControllerAccount;
        }
        set;
    }
    
    /***
    * getCurrentAccountList - return an Account list for the table
    ***/  
    public list<AccountSubClass> getCurrentAccountList() {
        UpdateAccountSelectedSet();
        
        AccountList = new list<AccountSubClass>();
        for (Account a : (list<Account>)StdSetControllerAccount.getRecords()) {
            AccountList.add(new AccountSubClass(a, AccountSelectedSet.contains(a.Id)));
        }
        return AccountList;
    }
    
    /***
    * UpdateAccountSelectedSet - add/remove accounts from the selected account id list
    ***/
    public void UpdateAccountSelectedSet(){
        for(AccountSubClass a : AccountList ){
            if(a.aCheckBox == true) {
                AccountSelectedSet.add(a.aAccount.Id);
            } else {
                if(AccountSelectedSet.contains(a.aAccount.Id)) {
                    AccountSelectedSet.remove(a.aAccount.Id);
                }
            }
        }  
        AccountSelectedCount = AccountSelectedSet.size();
    }
    
    /***
    * ClearAccountSelectedSet - remove selected accounts and initialize counter
    ***/
    public PageReference ClearAll(){
        AccountList.clear();
        AccountSelectedSet.clear();
        AccountSelectedCount = 0;
        SearchName = '';
        SearchBillingAddress = '';
        SaveSearchName = '';
        SaveSearchBillingAddress = '';
        AlphaFilter = 'All';
        
        BuildQuery();
        
        return null;
    }
    
    /***
    * SearchAccount - set search criteria fields and refresh Account table
    ***/
    public PageReference SearchAccount() {
        SaveSearchName = SearchName;
        SaveSearchBillingAddress = SearchBillingAddress;
        
        BuildQuery();
        
        return null;
    }
    
    /***
    * BuildQuery - build query command for list selection change
    ***/
    public void BuildQuery() {
        StdSetControllerAccount = null;
        String QueryWhere = '';
        
        if (AlphaFilter == null || AlphaFilter.trim().length() == 0) {
            AlphaFilter = 'All';
        }
        
        QueryAccount = 'SELECT Id, Name, BillingStreet, BillingPostalCode, BillingCountry, BillingCity, BillingState ' +
            ' FROM Account'; 
        
        if (AlphaFilter == 'Other') {
            QueryWhere = BuildWhere(QueryWhere, '(' + String.escapeSingleQuotes(SortField) + ' < \'A\' OR ' + 
                                    String.escapeSingleQuotes(SortField) + ' > \'Z\') AND (NOT ' + 
                                    String.escapeSingleQuotes(SortField) + ' LIKE \'Z%\') ');
        } else if (AlphaFilter != 'All') {
            QueryWhere = BuildWhere(QueryWhere, '(' + String.escapeSingleQuotes(SortField) + ' LIKE \'' + String.escapeSingleQuotes(AlphaFilter) + '%\')' );
        }
        
        if (SaveSearchName != null) {
            QueryWhere = BuildWhere(QueryWhere, ' (Name LIKE \'%' + String.escapeSingleQuotes(SaveSearchName) + '%\')');
        }
        if (SaveSearchBillingAddress != null) {
            QueryWhere = BuildWhere(QueryWhere, '((BillingStreet LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\') or' +
                                    ' (BillingCity LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\') or' +
                                    ' (BillingState LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\') or' +
                                    ' (BillingPostalCode LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\') or' +
                                    ' (BillingCountry LIKE \'%' + String.escapeSingleQuotes(SaveSearchBillingAddress) + '%\'))');
        }
        
        QueryAccount += QueryWhere;
        QueryAccount += ' ORDER BY ' + String.escapeSingleQuotes(SortField) + ' ' + String.escapeSingleQuotes(SortDirection) + ' LIMIT 10000';
        
        system.debug('QueryAccount:' + QueryAccount);
    }
    
    /***
    * BuildWhere - build soql string for where criteria 
    ***/
    public String BuildWhere(String QW, String Cond) {
        if (QW == '') {
            return ' WHERE ' + Cond;
        } else {
            return QW + ' AND ' + Cond;
        }
    }
    
    /***
    * SortDirection - return sort direction. Default ascending(asc)
    ***/
    public String SortDirection {
        get { if (SortDirection == null) {  SortDirection = 'asc'; } return SortDirection;  }
        set;
    }
    
    /***
    * SortField - return sort by field. Default to Name
    ***/
    public String SortField {
        get { if (SortField == null) {SortField = 'Name'; } return SortField;  }
        set; 
    }
    
    /***
    * SortToggle - toggles the sorting of query from asc<-->desc
    ***/
    public void SortToggle() {
        SortDirection = SortDirection.equals('asc') ? 'desc NULLS LAST' : 'asc';
        // reset alpha filter and sort sequence when sorted field is changed
        if (SortFieldSave != SortField) {
            SortDirection = 'asc';
            AlphaFilter = 'All';
            SortFieldSave = SortField;
        }
        // run the query again
        BuildQuery();
    }
    
    /***
    * DoSomethingOne - do something with one selected account
    ***/
    public PageReference DoSomethingOne() {
        system.debug('SelectedOneAccount: ' + SelectedOneAccount);
        return null;
    }
    
    /***
    * DoSomethingMany - do something with many selected accounts
    ***/
    public PageReference DoSomethingMany() {
        for (Id AccountId : AccountSelectedSet) {
            system.debug('Checked: ' + AccountId);
        }
        return null;
    }
    
    /***
    * AccountSubClass - Sub-Class to hold Account and checkbox for the table
    ***/
    public class AccountSubClass {
        public Boolean aCheckBox {get;set;}
        public Account aAccount {get;set;}
        
        // sub-class initialization
        public AccountSubClass(Account a, Boolean chk){
            aAccount = a;
            aCheckBox = chk;
        }
    }
}