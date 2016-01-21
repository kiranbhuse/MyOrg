public class PickListController {
    
    @AuraEnabled
    public static List<SelectOption> getPicklistOptionsNew(String first_val) {
        system.debug('I m here...');
        system.debug('first_val...' + first_val);
        return null;
    }
    
    @AuraEnabled
    public static List<SelectOption> getPicklistOptions(String object_name, String field_name, String first_val) {
        system.debug('In controller........');
        List<SelectOption> options = new List<selectOption>(); //new list for holding all of the picklist options
        if (first_val != null) { //if there is a first value being provided
            options.add(new selectOption(first_val, first_val)); //add the first option
        }
        
        system.debug('object_name ==> ' + object_name);
        system.debug('field_name ==> ' + field_name);
        system.debug('first_val ==> ' + first_val);
        
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe(); 
        system.debug('Keys===> ' + globalDescribe.keySet().contains('product2'));
        
        //Schema.sObjectType sobject_type = object_name.getSObjectType(); //grab the sobject that was passed
        
        Schema.sObjectType sobject_type = globalDescribe.get('Product2');
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
        Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
        
        for(String key : field_map.keySet()) {
            system.debug('KEY ###> ' + key);
        }
        
        List<Schema.PicklistEntry> pick_list_values = field_map.get(field_name).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
        for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
            system.debug('Value ###> ' + a.getValue() + ', ' + a.getLabel());
            options.add(new SelectOption(a.getValue(), a.getLabel())); //add the value and label to our final list
        }

        return options; //return the List
    }
}