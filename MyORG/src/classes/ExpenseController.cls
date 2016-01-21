public class ExpenseController {
    @AuraEnabled
    public static List<Expense__c> getExpenses() {
        List<Expense__c> exp = [SELECT id, name, amount__c, client__c, date__c,
        reimbursed__c, createdDate FROM Expense__c];
        system.debug('exp ==> ' + exp);
        return exp;
    }
    
    @AuraEnabled
    public static Expense__c saveExpense(Expense__c expense) {
        upsert expense;
        return expense;
    }
}