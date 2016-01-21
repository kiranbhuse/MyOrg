public class AddProductsToDealCtrl {
    public list <Product2> products {get;set;} 
    public string title {get;set;}
    public string productType {get;set;}
    public List<SelectOption> productTypeItems;
    private static String none = 'None';
    public ProductWrapper productWrapper {get;set;} 
    public Id productIdToBeAdded {get;set;} 
    public List<Id> listProductIdsToBeAdded {get;set;} 
    
    
    public AddProductsToDealCtrl(ApexPages.StandardController controller) {
        listProductIdsToBeAdded = new List<Id>();
    }
    
    /*
    public AddProductsToDealCtrl() {
        listProductIdsToBeAdded = new List<Id>();
    }
    */
    
    public void setProductTypeItems(List<SelectOption> productTypeItems) {
        this.productTypeItems = productTypeItems; 
    }
    
    public List<SelectOption> getProductTypeItems() {
        this.productTypeItems = getPicklistValues();
        return this.productTypeItems;
    }
    
    public void search() {  
        String searchquery = getSelect() + ' ' + getWhereClause() + ' ' + getOrder();
        products = Database.query(searchquery);  
        productWrapper = new ProductWrapper(products); 
    }
    
    private String getSelect() {
        return 'SELECT Id, Name, Quantity__c, Stock__c, Picture_Thumbnail__c From Product2 Product';
    }
    
    private String getWhereClause() {
        String whereClause = '';
        Boolean shouldFilterForTitle = shouldFilterForTitle();
        Boolean shouldFilterForProductType = shouldFilterForProductType();
        
        if(shouldFilterForTitle || shouldFilterForProductType)
            whereClause = 'WHERE';
            
        if(shouldFilterForTitle)
            whereClause += ' Product.Title__r.Name like \'%' + title + '%\'';
            
        if(shouldFilterForTitle && shouldFilterForProductType) 
            whereClause += ' And Type__c like \'%' + productType + '%\'';
        else if(shouldFilterForProductType) 
            whereClause += ' Type__c like \'%' + productType + '%\'';
        
        
        return whereClause; 
    }
    
    private String getOrder() {
        return 'ORDER by Name';
    }
    
    private Boolean shouldFilterForTitle() {
        return (NULL != title && !title.equals(''));
    }
    
    private Boolean shouldFilterForProductType() {
        return (NULL != productType && ! productType.equalsIgnoreCase(none));
    }
    
    public void addProduct() {
        listProductIdsToBeAdded.add(productIdToBeAdded);
    }
      
    public void clear(){  
        products.clear();  
    }  
    
    private List<SelectOption> getPicklistValues() {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Product2.Type__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new SelectOption('None', 'None'));
        for( Schema.PicklistEntry f : ple){
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    
    public class ProductWrapper {
        public Integer productsPerRow = 5;
        public Map<Integer, List<Product2>> mapProductN {get;set;}
        
        public ProductWrapper(List<Product2> wholeProductList) {
            Integer counter = 0;
            Integer mapKey = 0;
            List<Product2> tmpProductList = new List<Product2>();
            mapProductN = new Map<Integer, List<Product2>>();
            
            for(Product2 prod : wholeProductList) {
                tmpProductList.add(prod);
                if(Math.mod(counter, productsPerRow) == 4 || counter == wholeProductList.size() - 1) {
                    mapProductN.put(mapKey, tmpProductList);
                    mapKey++;
                    tmpProductList = new List<Product2>();
                }
                counter++;
            }
        }
    }
}