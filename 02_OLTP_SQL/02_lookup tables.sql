
------//////-------//////---LookUp Tables -----///////------///////

--hr.Department
CREATE TABLE hr.Department (
    DepartmentId INT IDENTITY PRIMARY KEY,
    DepartmentName VARCHAR(100),
    CostCenter VARCHAR(50),
    LocationId INT
);

--hr.JobTitle
CREATE TABLE hr.JobTitle (
    JobTitleId INT IDENTITY PRIMARY KEY,
    JobTitleName VARCHAR(100),
    JobLevel INT
);

--hr.PayType
CREATE TABLE hr.PayType (
    PayTypeId INT IDENTITY PRIMARY KEY,
    PayTypeName VARCHAR(50)
);

--hr.EmployeeStatus
CREATE TABLE hr.EmployeeStatus (
    StatusId INT IDENTITY PRIMARY KEY,
    StatusName VARCHAR(50)
);

--hr.Location
CREATE TABLE hr.Location (
    LocationId INT IDENTITY PRIMARY KEY,
    LocationName VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(50),
    Region VARCHAR(50)
);