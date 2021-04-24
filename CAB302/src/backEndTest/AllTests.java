package backEndTest;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({ItemTest.class,
	ManifestTest.class,
	OrdinaryTruckTest.class,
	RefrigeratedTruckTest.class,
	StockTest.class,
	StoreTest.class
	})

public class AllTests {

}