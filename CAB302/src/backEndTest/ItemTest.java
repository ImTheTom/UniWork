package backEndTest;

import org.junit.Test;

import backEnd.*;

import exceptions.*;

import static org.junit.jupiter.api.Assertions.*;

public class ItemTest {
	
	@Test public void initialise() {
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
	}
	
	@Test public void testGetName() {
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		String name = cheese.getName();
		assertEquals("Cheese", name);
	}
	
	@Test public void testGetManufacturingCost() {
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		String cost = cheese.getManufacturingCost();
		assertEquals("$1.21", cost);
	}
	
	@Test public void testGetSellPrice() {
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		String cost = cheese.getSellPrice();
		assertEquals("$2.01", cost);
	}
	
	@Test public void testGetReorderPoint() {
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		int reorderPoint = cheese.getReorderPoint();
		assertEquals(20, reorderPoint);
	}
	
	@Test public void testGetReorderAmount() {
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		int reorderAmount = cheese.getReorderAmount();
		assertEquals(50, reorderAmount);
	}
	
	@Test public void testGetTemperature() {
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		double temperature = cheese.getTemperature();
		assertEquals(4.0, temperature);
	}
	
	@Test public void initialiseWithoutTemp() {
		Item crackers = new Item("Crackers", 10.21, 13.61, 5, 10);
	}
	
	@Test public void testGetNameWithoutTemp() {
		Item crackers = new Item("Crackers", 10.21, 13.61, 5, 10);
		String name = crackers.getName();
		assertEquals("Crackers", name);
	}
	
	@Test public void testGetManufacturingCostWithoutTemp() {
		Item crackers = new Item("Crackers", 10.21, 13.61, 5, 10);
		String cost = crackers.getManufacturingCost();
		assertEquals("$10.21", cost);
	}
	
	@Test public void testGetSellPriceWithoutTemp() {
		Item crackers = new Item("Crackers", 10.21, 13.61, 5, 10);
		String cost = crackers.getSellPrice();
		assertEquals("$13.61", cost);
	}
	
	@Test public void testGetReorderPointWithoutTemp() {
		Item crackers = new Item("Crackers", 10.21, 13.61, 5, 10);
		int reorderPoint = crackers.getReorderPoint();
		assertEquals(5, reorderPoint);
	}
	
	@Test public void testGetReorderAmountWithoutTemp() {
		Item crackers = new Item("Crackers", 10.21, 13.61, 5, 10);
		int reorderAmount = crackers.getReorderAmount();
		assertEquals(10, reorderAmount);
	}
	
	//Note: I'm unsure about this test case
	@Test public void testGetTemperatureWithoutTemp() {
		Item crackers = new Item("Crackers", 10.21, 13.61, 5, 10);
		double temperature = crackers.getTemperature();
		assertEquals(null, temperature);
	}

}
