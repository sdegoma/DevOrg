/**
 *@description Trigger handler for The Object Leave Credits
 *@author Created By Noy De Goma
 *@date Created Date Aug 8, 2013
*/
public with sharing class LeaveCreditsTriggerHandler {
	
	public static void onBeforeInsert(List <Leave_Credit__c> leaveCreditList){
		for (Leave_Credit__c lcredit : leaveCreditList){
			lcredit.Sick_Leave__c = 15;
			lcredit.Vacation_Leave__c = 15;
			lcredit.Paternity_leave__c = 7;
			lcredit.Maternity_Leave__c = 30;
			lcredit.Bereavement__c = 3;
			lcredit.Suspension__c = 5;
		}
	}
}