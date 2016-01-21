public class AddProductsToDealPgCtrl {
	public list <Product2> products {get;set;} 
   	public string title {get;set;}
   	public string productType {get;set;}
   	public List<SelectOption> productTypeItems;
   	private static String none = 'None';
	//public ProductWrapper productWrapper {get;set;} 
	public Id productIdToBeAdded {get;set;} 
	public List<Id> listProductIdsToBeAdded {get;set;} 
	
	public List<ProductWrapper> datalist; 
	private integer totalRecs = 0;
	private integer OffsetSize = 0;
	private integer LimitSize= 20;
	
	public List<ProductWrapper> getDatalist() {
		return this.datalist;
	}
	
	public void setDatalist(List<ProductWrapper> dl) {
		this.datalist = dl;
	}
   	
    /*
    public AddProductsToDealPgCtrl(ApexPages.StandardController controller) {
    	listProductIdsToBeAdded = new List<Id>();
    }
    */
    
    public AddProductsToDealPgCtrl() {
    	listProductIdsToBeAdded = new List<Id>();
    }
    
    public void setProductTypeItems(List<SelectOption> productTypeItems) {
    	this.productTypeItems = productTypeItems; 
    }
    
    public List<SelectOption> getProductTypeItems() {
    	this.productTypeItems = getPicklistValues();
    	return this.productTypeItems;
    }
    
   	public void search() {  
		prepareData(Database.query(getSelect() + ' ' + getWhereClause() + ' ' + getOrder()));
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
	
	private void prepareData(List<Product2> wholeProductList) {
		Integer productsPerRow = 5;
		Integer counter = 0;
		List<Product2> tmpProductList = new List<Product2>();	
		datalist = new List<ProductWrapper>();
			
		for(Product2 prod : wholeProductList) {
			tmpProductList.add(prod);
			if(Math.mod(counter, productsPerRow) == 4 || counter == wholeProductList.size() - 1) {
				ProductWrapper prodWrapper = new ProductWrapper();
				prodWrapper.productList = tmpProductList;
				datalist.add(prodWrapper);
				tmpProductList = new List<Product2>();
			}
			counter++;
		}
		
		system.debug('DATA ===> ' + datalist);
	}
	
	public class ProductWrapper {
		public List<Product2> productList{get; set;}
	}
	
	/*
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
	*/
	
	public void FirstPage() {
		OffsetSize = 0;
	}
	
	public void previous() {
		OffsetSize = OffsetSize - LimitSize;
	}
	
	public void next() {
		OffsetSize = OffsetSize + LimitSize;
	}
	
	public void LastPage() {
		OffsetSize = totalrecs - math.mod(totalRecs, LimitSize);
	}
	
	public boolean getprev() {
		if(OffsetSize == 0)
			return true;
		else
		return false;
	}
	
	public boolean getnxt() {
		if((OffsetSize + LimitSize) > totalRecs)
			return true;
		else
			return false;
	}
}