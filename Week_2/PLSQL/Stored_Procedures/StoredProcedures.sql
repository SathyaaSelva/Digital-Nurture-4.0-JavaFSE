--scenario 1
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest IS
BEGIN
    FOR acc IN (
        SELECT AccountID FROM Accounts
        WHERE AccountType = 'Savings'
    ) LOOP
        UPDATE Accounts
        SET Balance = Balance * 1.01,
            LastModified = SYSDATE
        WHERE AccountID = acc.AccountID;

        DBMS_OUTPUT.PUT_LINE('Interest applied to Account ID: ' || acc.AccountID);
    END LOOP;
END;
/

--scenario 2
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    deptName IN VARCHAR2,
    bonusPct IN NUMBER
) IS
BEGIN
    FOR emp IN (
        SELECT EmployeeID, Salary FROM Employees
        WHERE Department = deptName
    ) LOOP
        UPDATE Employees
        SET Salary = Salary + (Salary * bonusPct / 100)
        WHERE EmployeeID = emp.EmployeeID;

        DBMS_OUTPUT.PUT_LINE('Bonus applied to Employee ID: ' || emp.EmployeeID);
    END LOOP;
END;
/

--scenario 3
CREATE OR REPLACE PROCEDURE TransferFunds(
    sourceAccID IN NUMBER,
    destAccID IN NUMBER,
    amount IN NUMBER
) IS
    sourceBalance NUMBER;
BEGIN
    SELECT Balance INTO sourceBalance
    FROM Accounts
    WHERE AccountID = sourceAccID
    FOR UPDATE;

    IF sourceBalance < amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient balance in source account.');
    END IF;

    UPDATE Accounts
    SET Balance = Balance - amount,
        LastModified = SYSDATE
    WHERE AccountID = sourceAccID;

    UPDATE Accounts
    SET Balance = Balance + amount,
        LastModified = SYSDATE
    WHERE AccountID = destAccID;

    DBMS_OUTPUT.PUT_LINE('Transferred ' || amount || 
                         ' from Account ' || sourceAccID ||
                         ' to Account ' || destAccID);
END;
/
