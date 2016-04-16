/**
 *@description Employee Trigger Handler
 *@author Created By Noy De Goma
 *@date Created Date Aug 9, 2013
*/
public with sharing class EmployeeTriggerHandler {
	/**
	 *@description Responsible for creating leave credits after and employe record has been inserted
	 *@author Created By Noy De Goma
	 *@date Created Date Aug 9, 2013
	 *@return N/A
	 *param empMap list of employee values and an ID as it's key
	*/
	public static void onAfterInsert(map <ID, Employee__c> empMap){
		list <Leave_Credit__c> leaveCreditList = new list<Leave_Credit__c>();
		for (Employee__c emp : empMap.Values()){
			Leave_Credit__c tempLeaveCredit = new Leave_Credit__c();
			tempLeaveCredit.Employee__c = emp.id;
			leaveCreditList.add(tempLeaveCredit);
		}
		insert leaveCreditList;
	}

}