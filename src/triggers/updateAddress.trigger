trigger updateAddress on Quote (after insert, before update) {
	
	
	
	for (Quote quot : Trigger.new){
	
		//Bill_To__r.Name + BR() + Bill_To__r.BillingStreet  + BR() +  Bill_To__r.BillingCity + ', ' +  Bill_To__r.BillingState  + ' ' + Bill_To__r.BillingPostalCode  + ' ' +Bill_To__r.BillingCountry;
	}
}