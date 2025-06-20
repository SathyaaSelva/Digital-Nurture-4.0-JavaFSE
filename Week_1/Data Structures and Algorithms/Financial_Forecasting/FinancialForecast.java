public class FinancialForecast {
    public static double futureValueRecursive(double initialValue, double rate, int years) {
        if (years == 0) {
            return initialValue;
        }
        // Recursive case
        return futureValueRecursive(initialValue, rate, years - 1) * (1 + rate);
    }

    public static double futureValueMemoized(double initialValue, double rate, int years, Double[] memo) {
        if (years == 0) {
            return initialValue;
        }
        if (memo[years] != null) {
            return memo[years];
        }
        memo[years] = futureValueMemoized(initialValue, rate, years - 1, memo) * (1 + rate);
        return memo[years];
    }

    public static void main(String[] args) {
        double initial = 1000.0; // Initial investment
        double rate = 0.05;      // 5% growth rate
        int years = 10;

        double futureValue = futureValueRecursive(initial, rate, years);
        System.out.printf("Future value (recursive): %.2f%n", futureValue);

        Double[] memo = new Double[years + 1];
        double memoizedValue = futureValueMemoized(initial, rate, years, memo);
        System.out.printf("Future value (memoized): %.2f%n", memoizedValue);
    }
}
