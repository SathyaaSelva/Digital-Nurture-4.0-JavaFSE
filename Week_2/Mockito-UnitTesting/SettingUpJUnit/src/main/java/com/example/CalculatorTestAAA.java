package com.example;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class CalculatorTestAAA {

    private Calculator calculator;

    // Setup method - runs before each test
    @Before
    public void setUp() {
        System.out.println("Setting up test...");
        calculator = new Calculator(); // Arrange
    }

    // Teardown method - runs after each test
    @After
    public void tearDown() {
        System.out.println("Tearing down test...");
        calculator = null;
    }

    @Test
    public void testAddition() {
        // Arrange is done in @Before

        // Act
        int result = calculator.add(3, 7);

        // Assert
        assertEquals(10, result);
    }

    @Test
    public void testMultiplication() {
        // Act
        int result = calculator.multiply(4, 5);

        // Assert
        assertEquals(20, result);
    }
}

