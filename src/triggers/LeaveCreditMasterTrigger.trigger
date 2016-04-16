/**
 *@description Leave Credits Master Trigger
 *@author Created By Noy De Goma
 *@date Created Date Aug 8, 2013
*/
 
trigger LeaveCreditMasterTrigger on Leave_Credit__c (before insert) {
	if (trigger.isBefore){
		if (trigger.isInsert){
			LeaveCreditsTriggerHandler.onBeforeInsert(trigger.new);
		}
	}

}