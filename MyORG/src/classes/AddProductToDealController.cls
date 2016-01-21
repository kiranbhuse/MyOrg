public class AddProductToDealController {
    @AuraEnabled
    public static List<Product2> getProducts() {
        List<Product2> products = [SELECT Id, Name, Type__c FROM Product2];
        system.debug('Products ===> ' + products);
        return products;
    }
}