package com.example;

import org.junit.jupiter.api.Test;

import main.java.com.example.ExternalApi;
import main.java.com.example.MyService;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class MyServiceTest {

    @Test
    public void testExternalApi() {
        ExternalApi mockApi = mock(ExternalApi.class);
        when(mockApi.getData()).thenReturn("Mock Data");

        MyService service = new MyService(mockApi);
        String result = service.fetchData();

        assertEquals("Mock Data", result);
    }

     @Test
    public void testVerifyInteraction() {
        // Exercise 2: Verifying Interaction
        ExternalApi mockApi = mock(ExternalApi.class);

        MyService service = new MyService(mockApi);
        service.fetchData(); // Should internally call getData()

        // Verify that getData() was called
        verify(mockApi).getData();
    }
}
