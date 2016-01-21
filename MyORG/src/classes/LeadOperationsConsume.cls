public class LeadOperationsConsume {

 
 /****************************************** START REST *********************************************************/
    public static void getContent(String status) {
        String url = 'https://ap1.salesforce.com/services/apexrest/Leads?Status=' + EncodingUtil.URLENCODE(status, 'UTF-8');
        HttpResponse res;
        
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('GET');

            req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
            
            Http http = new Http();
            res = http.send(req);
            
            parseJSON(res.getBody());
            
            system.debug('GET RESPONSE ===> ' + res.getBody());
        } catch (Exception e) {
            system.debug('Exception ===> ' + e.getMessage());
        }
    }
    
    public static void getContentPost(String status) {
        String url = 'https://ap1.salesforce.com/services/apexrest/Leads' ;
        HttpResponse res;
        
        try {
            HttpRequest req = new HttpRequest();
            req.setEndpoint(url);
            req.setMethod('POST');
             req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId());
             
            system.debug('STATUS ===> ' + status);
            
			req.setBody('Status=' + status);
            
            Http http = new Http();
            res = http.send(req);
            
            system.debug('POST RESPONSE ===> ' + res.getBody());
        } catch (Exception e) {
            system.debug('Exception ===> ' + e.getMessage());
        }
    }
    
    
    
    private static void parseJSON(String jsonStr) {
	    // Parse entire JSON response.
	    JSONParser parser = JSON.createParser(jsonStr);
	    
	    system.debug('PARSER ===> ' + parser);
	    
	    while (parser.nextToken() != null) {
	        // Start at the array of invoices.
	        if (parser.getCurrentToken() == JSONToken.START_ARRAY) {
            	while (parser.nextToken() != null) {
	                // Advance to the start object marker to
	                //  find next invoice statement object.
	                if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
	                	LeadData leadD = (LeadData)parser.readValueAs(LeadData.class);
	                }
            	}
	        }
	    }
    }
    
    public class LeadData {
    	
    }
    
    /****************************************** FINISH REST *********************************************************/
    
    
    /****************************************** START SOAP *********************************************************/
    public static String invokeGreetSOAP () {
		LeadOperationsExposeStub.SessionHeader_element sessionHeader = new LeadOperationsExposeStub.SessionHeader_element(); 
		sessionHeader.sessionId = UserInfo.getSessionId();
		
		LeadOperationsExposeStub.LeadOperationsExposeUsingSOAP lo = new LeadOperationsExposeStub.LeadOperationsExposeUsingSOAP();
		lo.SessionHeader = sessionHeader;
		String msg = 'Fail';
		try {
			msg = lo.greet();
		} catch (Exception e) {
			system.debug('ERROR in SOAP !!!!! ' + e.getMessage());
			msg = e.getMessage();
		}
		return msg;
    }
		
    public static  String[]  invokeGreetSOAP1 () {
		LeadOperationsExposeStub2.SessionHeader_element sessionHeader = new LeadOperationsExposeStub2.SessionHeader_element(); 
		sessionHeader.sessionId = UserInfo.getSessionId();
		
		LeadOperationsExposeStub2.LeadOperationsExposeUsingSOAP lo = new LeadOperationsExposeStub2.LeadOperationsExposeUsingSOAP();
		lo.SessionHeader = sessionHeader;
		 String[] msgs = null;
		try {
			msgs = lo.getLeadsP(null);
		} catch (Exception e) {
			system.debug('ERROR in SOAP !!!!! ' + e.getMessage());
		}
		return msgs;
    }
    
    /****************************************** FINISH SOAP *********************************************************/
}