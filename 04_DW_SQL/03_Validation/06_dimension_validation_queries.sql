----Quick run checks

SELECT COUNT(*) FROM stg.vDepartment_Clean;
SELECT COUNT(*) FROM stg.vJobTitle_Clean;
SELECT COUNT(*) FROM stg.vPayType_Clean;
SELECT COUNT(*) FROM stg.vEmployee_Clean;

-----making sure all payroll payment dates have a DateKey
SELECT MIN([Date]), MAX([Date]), COUNT(*)
FROM dw.DimDate;

---Validate DimDepartment

SELECT * FROM dw.DimDepartment;
SELECT COUNT(*) FROM dw.DimDepartment;

---Validate DimJobTitle
SELECT * FROM dw.DimJobTitle;
SELECT COUNT(*) FROM dw.DimJobTitle;


----Validate DimPayType

SELECT * FROM dw.DimPayType;
SELECT COUNT(*) FROM dw.DimPayType;

------Validate DimEmploytee
SELECT TOP 20 *
FROM dw.DimEmployee;

	----Sanity Checks

SELECT COUNT(*) FROM dw.DimEmployee;

SELECT PayTypeName, COUNT(*)
FROM dw.DimEmployee
GROUP BY PayTypeName;

SELECT DepartmentName, COUNT(*)
FROM dw.DimEmployee
GROUP BY DepartmentName;

SELECT StatusName, COUNT(*)
FROM dw.DimEmployee
GROUP BY StatusName;