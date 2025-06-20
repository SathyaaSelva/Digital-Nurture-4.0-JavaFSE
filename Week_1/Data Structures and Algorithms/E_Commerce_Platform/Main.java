
public class Main {
    public static void main(String[] args) {
        Product[] products = {
            new Product(01, "Laptop", "Electronics"),
            new Product(02, "Shampoo", "Personal Care"),
            new Product(03, "Smartphone", "Electronics"),
            new Product(04, "Notebook", "Stationery"),
            new Product(05, "Mobile", "Electronics"),
            new Product(06, "Watch", "Electronics")
        };

        String searchName = "Notebook";

        // Linear Search Test
        long startTime = System.nanoTime();
        Product foundLinear = Searchengine.linearSearch(products, searchName);
        long endTime = System.nanoTime();
        System.out.println("Linear Search Result: " + (foundLinear != null ? foundLinear : "Not Found"));
        System.out.println("Time taken (ns): " + (endTime - startTime));

        // Binary Search Test
        startTime = System.nanoTime();
        Product foundBinary = Searchengine.binarySearch(products, searchName);
        endTime = System.nanoTime();
        System.out.println("\nBinary Search Result: " + (foundBinary != null ? foundBinary : "Not Found"));
        System.out.println("Time taken (ns): " + (endTime - startTime));
    }
}

