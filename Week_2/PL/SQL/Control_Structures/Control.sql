-- Create Customers table
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Age NUMBER,
    Balance NUMBER,
    IsVIP CHAR(1)
);

-- Create Loans table
CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    InterestRate NUMBER,
    DueDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert sample data
INSERT INTO Customers VALUES (1, 'Alice', 65, 12000, 'N');
INSERT INTO Customers VALUES (2, 'Bob', 45, 8000, 'N');
INSERT INTO Customers VALUES (3, 'Charlie', 70, 15000, 'N');

INSERT INTO Loans VALUES (101, 1, 7.5, SYSDATE + 20);
INSERT INTO Loans VALUES (102, 2, 6.9, SYSDATE + 40);
INSERT INTO Loans VALUES (103, 3, 8.0, SYSDATE + 10);

COMMIT;

-- scenario 1

BEGIN
    FOR cust IN (
        SELECT c.CustomerID, l.LoanID, l.InterestRate
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
        WHERE c.Age > 60
    ) LOOP
        UPDATE Loans
        SET InterestRate = InterestRate - 1
        WHERE LoanID = cust.LoanID;

        DBMS_OUTPUT.PUT_LINE('Discount applied to Loan ID: ' || cust.LoanID);
    END LOOP;
END;
/

--scenario 2
BEGIN
    FOR cust IN (
        SELECT CustomerID FROM Customers
        WHERE Balance > 10000
    ) LOOP
        UPDATE Customers
        SET IsVIP = 'Y'
        WHERE CustomerID = cust.CustomerID;

        DBMS_OUTPUT.PUT_LINE('Customer ' || cust.CustomerID || ' promoted to VIP.');
    END LOOP;
END;
/

--scenario 3

BEGIN
    FOR loan IN (
        SELECT l.LoanID, l.DueDate, c.Name
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.DueDate <= SYSDATE + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || loan.LoanID || ' for customer ' || loan.Name || 
                             ' is due on ' || TO_CHAR(loan.DueDate, 'DD-MON-YYYY'));
    END LOOP;
END;
/

