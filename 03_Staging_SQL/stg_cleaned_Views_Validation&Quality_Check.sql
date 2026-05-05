
----staging to cleaned views row counts

SELECT COUNT(*) FROM stg.Employee;
SELECT COUNT(*) FROM stg.vEmployee_Clean;

SELECT COUNT(*) FROM stg.Timesheet;
SELECT COUNT(*) FROM stg.vTimesheet_Clean;

SELECT COUNT(*) FROM stg.PayrollTransaction;
SELECT COUNT(*) FROM stg.vPayrollTransaction_Clean;

---- cleaned views quality checks
---1/
SELECT * FROM stg.vEmployee_Clean WHERE EmployeeNumber IS NULL;
---2/
SELECT * FROM stg.vTimesheet_Clean
WHERE RegularHours < 0 OR OvertimeHours < 0;
---3/
SELECT EmployeeId, COUNT(*)
FROM stg.vEmployeeJobHistory_Clean
WHERE IsCurrent = 1
GROUP BY EmployeeId
HAVING COUNT(*) > 1;