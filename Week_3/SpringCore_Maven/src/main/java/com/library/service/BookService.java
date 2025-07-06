package com.library.service;

import com.library.repository.BookRepository;

//Demonstrating Dependency Injection using setter

public class BookService {
    private BookRepository bookRepository;

    // Setter used for injection
    public void setBookRepository(BookRepository bookRepository) {
        this.bookRepository = bookRepository;
    }

    //Using the injected bean
    public void displayBook() {
        System.out.println("Book: " + bookRepository.getBook());
    }
}

