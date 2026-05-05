------//////------///////--Payroll by Department----//////------///////-----
SELECT
    d.DepartmentName,
    SUM(f.GrossPay) AS TotalGrossPay,
    SUM(f.NetPay) AS TotalNetPay
FROM dw.FactPayroll f
JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
GROUP BY d.DepartmentName
ORDER BY TotalGrossPay DESC;

------//////------///////--Overtime by Department----//////------///////-----

SELECT
    d.DepartmentName,
    SUM(f.OvertimeHours) AS TotalOvertimeHours
FROM dw.FactPayroll f
JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
GROUP BY d.DepartmentName
ORDER BY TotalOvertimeHours DESC;


------//////------///////--Payroll Trend by Month----//////------///////-----

SELECT
    dt.Year,
    dt.Month,
    dt.MonthName,
    SUM(f.GrossPay) AS TotalGrossPay
FROM dw.FactPayroll f
JOIN dw.DimDate dt
    ON f.PayDateKey = dt.DateKey
GROUP BY dt.Year, dt.Month, dt.MonthName
ORDER BY dt.Year, dt.Month;