public class Fridge {
	
	public String modelNumber;
	public Integer numberInStock;
	public void updateStock (Integer justSold) {
		
	numberInStock = numberInStock - justSold;
	
	}
}