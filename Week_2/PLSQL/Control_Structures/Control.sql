-- Create Customers table
CREATE TABLE Customers (
    CustomerID     NUMBER PRIMARY KEY,
    Name           VARCHAR2(100),
    DOB            DATE,
    Balance        NUMBER,
    LastModified   DATE
);

-- Create Loans table
CREATE TABLE Loans (
    LoanID         NUMBER PRIMARY KEY,
    CustomerID     NUMBER,
    LoanAmount     NUMBER,
    InterestRate   NUMBER,
    StartDate      DATE,
    EndDate        DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Accounts table
CREATE TABLE Accounts (
    AccountID      NUMBER PRIMARY KEY,
    CustomerID     NUMBER,
    AccountType    VARCHAR2(20),
    Balance        NUMBER,
    LastModified   DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID     NUMBER PRIMARY KEY,
    Name           VARCHAR2(100),
    Position       VARCHAR2(50),
    Salary         NUMBER,
    Department     VARCHAR2(50),
    HireDate       DATE
);

-- Insert sample customers
INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1955-05-15', 'YYYY-MM-DD'), 12000, SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1985-07-20', 'YYYY-MM-DD'), 8000, SYSDATE);
INSERT INTO Customers VALUES (3, 'Mark Lee', TO_DATE('1950-02-12', 'YYYY-MM-DD'), 20000, SYSDATE);

-- Insert sample loans
INSERT INTO Loans VALUES (1, 1, 5000, 6.5, SYSDATE, SYSDATE + 20); -- Due soon
INSERT INTO Loans VALUES (2, 2, 10000, 7.0, SYSDATE, SYSDATE + 40); -- Not due soon
INSERT INTO Loans VALUES (3, 3, 8000, 6.8, SYSDATE, SYSDATE + 10); -- Due soon

-- Insert accounts
INSERT INTO Accounts VALUES (1, 1, 'Savings', 1000, SYSDATE);
INSERT INTO Accounts VALUES (2, 2, 'Checking', 500, SYSDATE);
INSERT INTO Accounts VALUES (3, 3, 'Savings', 3000, SYSDATE);

-- Insert employees
INSERT INTO Employees VALUES (1, 'Alice', 'Manager', 70000, 'HR', TO_DATE('2010-01-01', 'YYYY-MM-DD'));
INSERT INTO Employees VALUES (2, 'Bob', 'Developer', 60000, 'IT', TO_DATE('2015-03-20', 'YYYY-MM-DD'));

--scenario 1
BEGIN
    FOR cust IN (
        SELECT l.LoanID
        FROM Customers c
        JOIN Loans l ON c.CustomerID = l.CustomerID
        WHERE MONTHS_BETWEEN(SYSDATE, c.DOB) / 12 > 60
    ) LOOP
        UPDATE Loans
        SET InterestRate = InterestRate - 1
        WHERE LoanID = cust.LoanID;

        DBMS_OUTPUT.PUT_LINE('1% discount applied to Loan ID: ' || cust.LoanID);
    END LOOP;
END;
/

--scenario 2
BEGIN
    FOR cust IN (
        SELECT CustomerID FROM Customers
        WHERE Balance > 10000
    ) LOOP
        -- Simulate VIP status by updating LastModified (no IsVIP column in schema)
        UPDATE Customers
        SET LastModified = SYSDATE
        WHERE CustomerID = cust.CustomerID;

        DBMS_OUTPUT.PUT_LINE('Customer ' || cust.CustomerID || ' promoted to VIP.');
    END LOOP;
END;
/

--scenario 3
BEGIN
    FOR loan IN (
        SELECT l.LoanID, c.Name, l.EndDate
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate <= SYSDATE + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || loan.LoanID || 
                             ' for customer ' || loan.Name || 
                             ' is due on ' || TO_CHAR(loan.EndDate, 'DD-MON-YYYY'));
    END LOOP;
END;
/
