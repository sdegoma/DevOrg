trigger testTrigger on TestObject1__c (after insert) {
	
	List <TestObject1__c> TO1 = [Select t.name__c from TestObject1__c t]; 
	for (TestObject1__c TO : TO1){
		//if (TO.name == TO.name){
			TO.name__c = 'good bye';
		//}
	}
	update TO1;

}