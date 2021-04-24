package backEndTest;

import org.junit.Test;

import backEnd.*;

import exceptions.*;

import static org.junit.jupiter.api.Assertions.*;

import java.util.ArrayList;

public class StockTest {

	@Test public void initialise() {
		Stock stock = new Stock();
	}
	
	//Don't have to do this just yet. We'll do this later.
	@Test public void initialiseWithCSV() {
		Stock stock = new Stock("manifest.csv");
	}
	
	@Test public void testAddItem() {
		Stock stock = new Stock();
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		stock.addItem(cheese, 50);
	}
	
	@Test public void testGetItemQuantity() {
		Stock stock = new Stock();
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		stock.addItem(cheese, 50);
		int quantity = stock.getQuantity("Cheese");
		assertEquals(50, quantity);
	}
	
	@Test public void testReorder() {
		Stock stock = new Stock();
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		stock.addItem(cheese, 10);
		boolean reorder = stock.reorderItem("Cheese");
		assertTrue(reorder);
	}
	
	@Test public void testGetItemsThatNeedRestocking() {
		Stock stock = new Stock();
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		stock.addItem(cheese, 10);
		Item crackers = new Item("Crackers", 10.21, 13.61, 5, 10);
		stock.addItem(crackers, 2);
		ArrayList<Item> items = stock.getItemsThatNeedRestocking();
		assertTrue(items.contains(cheese));
		assertTrue(items.contains(crackers));
	}
	
	@Test public void testSale() {
		Stock stock = new Stock();
		Item cheese = new Item("Cheese", 1.21, 2.01, 20, 50, 4.0);
		stock.addItem(cheese, 50);
		stock.sale(cheese, 30);
		int quantity = stock.getQuantity("Cheese");
		assertEquals(20, quantity);
	}

}
