public class getSubtotal{
    list <decimal> dec = new List <decimal>();
	public List <product__c> prod = [select unit_price__c from product__c];
}