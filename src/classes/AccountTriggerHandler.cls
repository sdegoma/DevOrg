/**
* @description handler class for account object. performs performs syncronization of website for the bulk test object.
* @author Created By Noy De Goma
* @date Created On 18.JUL.2013
* @last date Modified 19.JUL.2013
*/

public with sharing class AccountTriggerHandler {
	 /**
	 * @description Updates the value of Account Website of Bulk Test Object related to the account.
	 * @author Noy De Goma
	 * @date 19.JUL.2013
	 * @param accList Collection of Account Elements or Records
	 */
	public static void onBeforeInsert(List<Account>accList){
		Map <String, Postal_Code__c> postCodeMap = Postal_Code__c.getAll();	
		for (Account acc : accList){
			for (String pcString : postCodeMap.keySet()){
				if (postCodeMap.get(pcString).country__c.equalsIgnoreCase(acc.billingCountry.trim()) && postCodeMap.get(pcString).State__c.equalsIgnoreCase(acc.billingstate.trim())){
					acc.billingpostalcode = postCodeMap.get(pcString).postal_code__c;
					break;
				}				
			}
		}
	}
	/**
	 * @description Updates the value of Account Website of Bulk Test Object related to the account.
	 * @author Noy De Goma
	 * @date 19.JUL.2013
	 * @param accList Collection of Account Elements or Records
	 * @param counter Counter for comparison if the loop has rich the end of it's record
	 */
	public static void onBeforeUpdate(List<Account> accList){
		Map <String, Postal_Code__c> postCodeMap = Postal_Code__c.getAll();
		Integer counter;
		for (Account acc : accList){
			counter = 0;
			for (String pcString : postCodeMap.keySet()){
				counter+=1;
				if (postCodeMap.get(pcString).country__c.equalsIgnoreCase(acc.billingCountry.trim()) && postCodeMap.get(pcString).State__c.equalsIgnoreCase(acc.billingstate.trim())){
					acc.billingpostalcode = postCodeMap.get(pcString).postal_code__c;
					break;
				}else{
					if (counter==accList.size()){
						acc.billingpostalcode = '';
					}
				}
				
			}

		}
	}
	/**
	 * @description Updates the value of Account Website of Bulk Test Object related to the account.
	 * @author Noy De Goma
	 * @date 19.JUL.2013
	 * @param accMap Collection of Account Elements or Records with matching key value
	 */
	public static void onAfterUpdate(Map <id, Account> accMap){
		
		List <Bulk_Test__c> btList = [Select id, account__r.id, Account_Website__c from bulk_test__c where account__r.ID IN : accMap.keySet()];		
		for (Bulk_Test__c bt : btList){ 
			if (accMap.get(bt.account__r.id).Sync_Website__c == true){
				bt.Account_Website__c = accMap.get(bt.account__r.id).website;
			}

		} 
		update btList;
	}
	/*Set<ID> accIDSet = new Set<ID>(); 
		for (ID accID : accMap.keySet()){
			accIDSet.add(accMap.get(accID).id);
		}*
		///Map <ID, Bulk_Test__c> btMap = new Map<ID, Bulk_Test__c>([Select id, account__r.id, Account_Website__c from bulk_test__c where account__r.ID IN : accMap.KeySet()]);
		//Map <ID, Bulk_Test__c> Map 
		/*for (ID accID : accMap.keySet()){
			if (accMap.get(accID).Sync_Website__c == true){
				//btMap.get(accID).Account_Website__c = 'test';//accMap.get(accMap.get(accID).id).website;
			}
		}
		Update btMap.Values();*/
		
		 /*Set <Postal_Code__c> postCodeSet = new Set <Postal_Code__c>();
		 for (Postal_code__c pset : [Select name, country__c, state__c, postal_code__c from postal_code__c]){
		 	postCodeSet.add(pset);
		 }
		 for (Account acc : accList){
			for (postal_Code__c pcString : postCodeSet ){
				if (pcString.country__c == acc.billingCountry && pcString.State__c ==  acc.billingstate){
					acc.billingpostalcode = pcString.postal_code__c;
					break;
				}				
			}

		}*/

}