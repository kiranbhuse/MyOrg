@RestResource(urlMapping='/Leads/*')
global class LeadOperationsExpose {
    public static String leadStatus;
    public static Map <String, String> params {get; set;}

    @HttpGet
    global static List<Lead> getLeads() {
        RestRequest req = RestContext.request;
        leadStatus = req.params.get('Status');
    
        return [Select Id, Name, Status, Owner.Name From Lead Where Status =: leadStatus];
    }
    
     @HttpPost
    global static List<Lead> getLeadsP() {
        RestRequest req = RestContext.request;
        	System.debug('POST Method req.params : >>>	' + req.params);
        	
        for(String key : req.params.keySet()) { 	
        	system.debug('KEY in POST method ===> ' + key);
        }
        	
        	
        String leadStatus1 = req.params.get('Status');
    
    	System.debug('POST Method: >>>	' + leadStatus1);
    	List<Lead> leads =  [Select Id, Name, Status, Owner.Name From Lead Where Status =: leadStatus1];
    	return leads;
    }

}