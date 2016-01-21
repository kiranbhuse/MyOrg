public class LeadOperationsController {
    
    public string leadStatus {get;set;}
    public List<SelectOption> leadStatusItems;
    public List<Lead> leads {get;set;}
    
    public void setLeadStatusItems(List<SelectOption> leadStatusItems) {
        this.leadStatusItems = leadStatusItems; 
    }
    
    public List<SelectOption> getLeadStatusItems() {
        this.leadStatusItems= getPicklistValues();
        return this.leadStatusItems;
    }
    
    private List<SelectOption> getPicklistValues() {
        List<SelectOption> options = new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Lead.Status.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        options.add(new SelectOption('None', 'None'));
        for( Schema.PicklistEntry f : ple) {
            options.add(new SelectOption(f.getLabel(), f.getValue()));
        }       
        return options;
    }
    
    public void displayLeads() {
        //LeadOperationsConsume.getContent(leadStatus);
        //LeadOperationsConsume.getContentPost(leadStatus);
         String[] a = LeadOperationsConsume.invokeGreetSOAP1(); 
        if(a != null) {
        	system.debug('SOAPMessage  ===> ' + a);
        } else {
        	system.debug('SOAPMessage  ===> Returned null from service');
        }
        
    }
}