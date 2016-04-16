global class WebServices {
	
	webservice static list  <Integer> generatedValues(){
		set <Integer> numbers =  new set <Integer>();
		list <Integer> numbersList =  new list <Integer>();
		integer numberToGenerate = 20;
		integer max = 100;
		integer temp = 0;
		for (integer i = 0; i < numberToGenerate ; i++){
			temp = (integer)(Math.random() * max);
			while (numbers.contains(temp)){
				temp = (integer)(Math.random() * max);
			}
			numbers.add(temp);
			numbersList.add(temp);
		}
		for (integer nums : numbers){
			System.debug(nums);
		}
		return numbersList;
	}
}