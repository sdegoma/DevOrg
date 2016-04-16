/**
 *@description Employee MasterTrigger
 *@author Created By Noy De Goma
 *@date Created Date Aug 9, 2013
*/
trigger EmployeeMasterTrigger on Employee__c (after insert) {
	if (trigger.isAfter){
		if(trigger.isInsert){
			EmployeeTriggerHandler.onAfterInsert(trigger.newMap);
		}
	}
}