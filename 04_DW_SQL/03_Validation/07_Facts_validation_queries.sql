--- Validate Staging ---> Fact Row counts

SELECT COUNT(*) AS StagingPayrollRows
FROM stg.vPayrollTransaction_Clean;

SELECT COUNT(*) AS FactPayrollRows
FROM dw.FactPayroll;

---- Validate Totals for Staging (stg.vPayrollTransaction_Clean) & Fact Totals (dw.FactPayroll)

	---Staging
SELECT
    SUM(GrossPay) AS GrossPay,
    SUM(BonusPay) AS BonusPay,
    SUM(DeductionAmount) AS DeductionAmount,
    SUM(NetPay) AS NetPay
FROM stg.vPayrollTransaction_Clean;

	----Facts
SELECT
    SUM(GrossPay) AS GrossPay,
    SUM(BonusPay) AS BonusPay,
    SUM(DeductionAmount) AS DeductionAmount,
    SUM(NetPay) AS NetPay
FROM dw.FactPayroll;

---- Validate Dimensional Distribution 
	
	---Payroll by department
SELECT
    d.DepartmentName,
    SUM(f.GrossPay) AS TotalGrossPay
FROM dw.FactPayroll f
JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
GROUP BY d.DepartmentName
ORDER BY TotalGrossPay DESC;

	---Payroll by pay type
SELECT
    pt.PayTypeName,
    SUM(f.GrossPay) AS TotalGrossPay
FROM dw.FactPayroll f
JOIN dw.DimPayType pt
    ON f.PayTypeKey = pt.PayTypeKey
GROUP BY pt.PayTypeName;

	---Overtime by month

SELECT
    d.Year,
    d.Month,
    d.MonthName,
    SUM(f.OvertimeHours) AS TotalOvertimeHours
FROM dw.FactPayroll f
JOIN dw.DimDate d
    ON f.PayDateKey = d.DateKey
GROUP BY d.Year, d.Month, d.MonthName
ORDER BY d.Year, d.Month;

-----///////-------/////------////////-------///////------
-- 1. Fact row count by employee
SELECT
    e.EmployeeNumber,
    e.FullName,
    COUNT(*) AS PayrollRows,
    SUM(f.GrossPay) AS TotalGrossPay
FROM dw.FactPayroll f
JOIN dw.DimEmployee e
    ON f.EmployeeKey = e.EmployeeKey
GROUP BY e.EmployeeNumber, e.FullName
ORDER BY TotalGrossPay DESC;

-- 2. Payroll by job title
SELECT
    jt.JobTitleName,
    SUM(f.GrossPay) AS TotalGrossPay,
    SUM(f.OvertimeHours) AS TotalOvertimeHours
FROM dw.FactPayroll f
JOIN dw.DimJobTitle jt
    ON f.JobTitleKey = jt.JobTitleKey
GROUP BY jt.JobTitleName
ORDER BY TotalGrossPay DESC;

-- 3. Payroll by employee status
SELECT
    e.StatusName,
    COUNT(*) AS PayrollRows,
    SUM(f.GrossPay) AS TotalGrossPay
FROM dw.FactPayroll f
JOIN dw.DimEmployee e
    ON f.EmployeeKey = e.EmployeeKey
GROUP BY e.StatusName;

-- 4. Payroll by manager
SELECT
    e.ManagerName,
    SUM(f.GrossPay) AS TotalGrossPay,
    SUM(f.OvertimeHours) AS TotalOvertimeHours
FROM dw.FactPayroll f
JOIN dw.DimEmployee e
    ON f.EmployeeKey = e.EmployeeKey
GROUP BY e.ManagerName
ORDER BY TotalGrossPay DESC;

-- 5. Payroll by region/location
SELECT
    d.Region,
    d.LocationName,
    SUM(f.GrossPay) AS TotalGrossPay,
    SUM(f.OvertimeHours) AS TotalOvertimeHours
FROM dw.FactPayroll f
JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
GROUP BY d.Region, d.LocationName
ORDER BY TotalGrossPay DESC;

-- 6. Monthly gross pay trend
SELECT
    dt.Year,
    dt.Month,
    dt.MonthName,
    SUM(f.GrossPay) AS TotalGrossPay,
    SUM(f.NetPay) AS TotalNetPay
FROM dw.FactPayroll f
JOIN dw.DimDate dt
    ON f.PayDateKey = dt.DateKey
GROUP BY dt.Year, dt.Month, dt.MonthName
ORDER BY dt.Year, dt.Month;

-- 7. Overtime by department and pay type
SELECT
    d.DepartmentName,
    pt.PayTypeName,
    SUM(f.OvertimeHours) AS TotalOvertimeHours
FROM dw.FactPayroll f
JOIN dw.DimDepartment d
    ON f.DepartmentKey = d.DepartmentKey
JOIN dw.DimPayType pt
    ON f.PayTypeKey = pt.PayTypeKey
GROUP BY d.DepartmentName, pt.PayTypeName
ORDER BY TotalOvertimeHours DESC;

-- 8. Check for missing/invalid dimension keys
SELECT *
FROM dw.FactPayroll
WHERE EmployeeKey IS NULL
   OR DepartmentKey IS NULL
   OR JobTitleKey IS NULL
   OR PayTypeKey IS NULL
   OR PayDateKey IS NULL;

-- 9. Check for facts that fail dimension joins
SELECT f.*
FROM dw.FactPayroll f
LEFT JOIN dw.DimEmployee e ON f.EmployeeKey = e.EmployeeKey
LEFT JOIN dw.DimDepartment d ON f.DepartmentKey = d.DepartmentKey
LEFT JOIN dw.DimJobTitle jt ON f.JobTitleKey = jt.JobTitleKey
LEFT JOIN dw.DimPayType pt ON f.PayTypeKey = pt.PayTypeKey
LEFT JOIN dw.DimDate dt ON f.PayDateKey = dt.DateKey
WHERE e.EmployeeKey IS NULL
   OR d.DepartmentKey IS NULL
   OR jt.JobTitleKey IS NULL
   OR pt.PayTypeKey IS NULL
   OR dt.DateKey IS NULL;

-- 10. Summary validation across all main dimensions
SELECT
    COUNT(*) AS FactRows,
    COUNT(DISTINCT EmployeeKey) AS DistinctEmployees,
    COUNT(DISTINCT DepartmentKey) AS DistinctDepartments,
    COUNT(DISTINCT JobTitleKey) AS DistinctJobTitles,
    COUNT(DISTINCT PayTypeKey) AS DistinctPayTypes,
    COUNT(DISTINCT PayDateKey) AS DistinctPayDates,
    SUM(GrossPay) AS TotalGrossPay,
    SUM(NetPay) AS TotalNetPay,
    SUM(OvertimeHours) AS TotalOvertimeHours
FROM dw.FactPayroll;