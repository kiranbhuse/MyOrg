global class LeadOperationsExposeUsingSOAP {

    webservice static String greet() {
        return 'Hello World!';
    }
    
	webservice static List<String> getLeadsP(String status) {
      	//List<Lead> leads =  [Select Id, Name, Status, Owner.Name From Lead Where Status =: status];
      	List<String> test = new List<String> {'abc', 'pqr', 'xyz'};
      	return test;
    }
    
    /*
	webservice static lead[] getLeadsP(String status) {
      	List<Lead> leads =  [Select Id, Name, Status, Owner.Name From Lead Where Status =: status];
      	return leads;
    }
    */
}