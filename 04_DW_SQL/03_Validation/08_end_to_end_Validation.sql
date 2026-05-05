----- Validate Warehouse Compare to Staging Totals

SELECT COUNT(*) FROM dw.FactPayroll;

SELECT SUM(GrossPay) FROM dw.FactPayroll;

SELECT DepartmentKey, SUM(GrossPay)
FROM dw.FactPayroll
GROUP BY DepartmentKey;

-----Sanity Business Queries

	-- Payroll by Department

SELECT
    d.DepartmentName,
    SUM(f.GrossPay) AS TotalPayroll
FROM dw.FactPayroll f
JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
GROUP BY d.DepartmentName;

	--- Overtime By Month

SELECT
    dd.MonthName,
    SUM(f.OvertimeHours)
FROM dw.FactPayroll f
JOIN dw.DimDate dd
    ON f.PayDateKey = dd.DateKey
GROUP BY dd.MonthName;

SELECT COUNT(*) FROM stg.vDepartment_Clean;
SELECT COUNT(*) FROM stg.vJobTitle_Clean;
SELECT COUNT(*) FROM stg.vPayType_Clean;
SELECT COUNT(*) FROM stg.vEmployee_Clean;

SELECT MIN([Date]), MAX([Date]), COUNT(*)
FROM dw.DimDate;