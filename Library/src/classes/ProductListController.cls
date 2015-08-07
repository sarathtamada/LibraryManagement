public class ProductListController {
    public Boolean CheckBox { get; set; }
    public list<String> alphabetListing { get; set;}
    public List<Product2> selectedList {get;set;}
    public string searchstring {get;set;}   
    public List<ProductWrapper> proList{get;set;}
    public integer NoOfRecords {get; set;}
    public set<id> ProductSetId;
    public integer pagesize {get;set;}
    
    public ProductListController(){
        ProductSetId=new set<ID>();
        proList=new List<ProductWrapper>();
        selectedList =new List<Product2>();
        alphabetListing = new list<String> {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'Other', 'All'};
        
    }
   
    public ApexPages.StandardSetController setCon {
        get {
             pagesize = 3;
            if(setCon == null) {
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([select Name,ProductCode,Family from Product2]));
                setcon.setpagesize(pagesize);
                NoOfRecords = setcon.getResultsize();
            }
            return setCon;
        }
        set;
    }
    
    // Initialize setCon and return a list of records 
    
    public List<ProductWrapper> getProductList() {
       proList.clear();
         for(Product2 ol : (list<Product2>)setcon.getrecords()){
            proList.add(new ProductWrapper(ol,ProductSetId.contains(ol.id)));
         }
         
        return proList;
    }
    
    public PageReference addRecord() {
        Product2 Rec=[select Name,ProductCode,Family  from Product2 where id=:ApexPages.CurrentPage().getParameters().get('schId')];
        integer A=0;
        boolean CheckBox=false;
        A=selectedList.size();
        if(A>0)
            for (Integer i = A-1; i >= 0 ;i-- ) {
                if (selectedList.get(i) == Rec || selectedList.get(i).get('id') == Rec.get('id')) {
                    selectedList.remove(i); 
                    ProductSetId.remove((ID)Rec.get('id'));
                    CheckBox=true;
                }
            }
        if(CheckBox==false)
        {
            selectedList.add(Rec);
            ProductSetId.add(Rec.id);
        }
        return null;
    }
    public void alphabetClick(){
        try{
            String searchText=ApexPages.currentPage().getParameters().get('alpha')+'%';
            System.debug('ProductListController.alphabetClick searchText '+searchText);
            CheckBox=false;
            if(searchText.contains('All') || searchText.contains('Other')){
                setCon =new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id,Name,ProductCode,Family FROM Product2 ])); 
                setcon.setpagesize(pagesize);
                return;
            }
            setCon =new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Id,Name,ProductCode,Family FROM Product2 WHERE Name LIKE : searchText OR ProductCode LIKE : searchText]));
            setcon.setpagesize(pagesize); 
        }
        catch(Exception ex){
            System.debug('Exception in ProductListController.search  '+ex.getMessage());
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'An Error Occured'));
        }
    }
    
    public void search(){  
        String searchStr = '%' + searchstring + '%';
        setCon = new ApexPages.StandardSetController(Database.getQueryLocator([select Name,ProductCode,Family from Product2 where name like :searchStr]));
        setcon.setpagesize(pagesize);
    }  
    public PageReference Save() {
       List<OpportunityLineItem> OpLnIt= new List<OpportunityLineItem>();
       map<Id,Id> mapPBList=new map<Id,Id>();
       for(PriceBookEntry PBE: [SELECT Id, Product2Id, Product2.Id, Product2.Name FROM PriceBookEntry WHERE  PriceBook2.isStandard=true ])
       {
       mapPBList.put(PBE.Product2.Id,PBE.Id);
       
       }
       OpportunityLineItem opp;
       id id=ApexPages.CurrentPage().getParameters().get('Id');

           for(Product2 p:selectedList )
           {
           opp=new OpportunityLineItem();
           opp.Quantity=1; 
           
           opp.PricebookEntryId=(Id)mapPBList.get(p.Id);
           opp.OpportunityId=id;
           opp.TotalPrice=200;
           OpLnIt.add(opp);
           }
        insert OpLnIt;
        return null;
    }

        
    public class ProductWrapper{
    public Product2 pr{get;set;}
    public Boolean CheckBox{get;set;}
    public ProductWrapper(Product2 prod, Boolean check){
            pr = prod;
            CheckBox = check;
     }
   }   
}