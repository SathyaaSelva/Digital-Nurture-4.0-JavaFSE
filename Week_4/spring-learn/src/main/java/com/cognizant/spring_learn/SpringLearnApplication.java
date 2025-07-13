package com.cognizant.spring_learn;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//Exercise 1

@SpringBootApplication
public class SpringLearnApplication {

	private static final Logger LOGGER = LoggerFactory.getLogger(SpringLearnApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(SpringLearnApplication.class, args);
	}

	//Exercise 2
	ApplicationContext context = new ClassPathXmlApplicationContext("country.xml");
	Country country = context.getBean("country", Country.class);
	LOGGER.debug("Country : {}", country);
	
}
