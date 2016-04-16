/**
* @description Master Trigger for Account Object
* @author Created By Noy De Goma
* @date Created 18.JUL.2013
* @last date Modified 19.JUL.2013
*/
trigger AccountMasterTrigger on Account (before insert, before update, after update) {
    if (Trigger.isBefore && Trigger.isInsert){ 
        AccountTriggerHandler.onBeforeInsert(Trigger.new);    
    }
    else if (Trigger.isBefore && Trigger.isUpdate){ 
        AccountTriggerHandler.onBeforeUpdate(Trigger.new);
    }
    else if (Trigger.isAfter && Trigger.isUpdate){ 
        //AccountTriggerHandler.onAfterUpdate(Trigger.newMap);
    }

}