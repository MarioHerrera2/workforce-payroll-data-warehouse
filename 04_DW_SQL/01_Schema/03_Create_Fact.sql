CREATE TABLE [dw].[FactPayroll](
	[PayrollFactId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeKey] [int] NULL,
	[DepartmentKey] [int] NULL,
	[JobTitleKey] [int] NULL,
	[PayTypeKey] [int] NULL,
	[PayDateKey] [int] NULL,
	[RegularHours] [decimal](10, 2) NULL,
	[OvertimeHours] [decimal](10, 2) NULL,
	[GrossPay] [decimal](12, 2) NULL,
	[BonusPay] [decimal](12, 2) NULL,
	[DeductionAmount] [decimal](12, 2) NULL,
	[NetPay] [decimal](12, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[PayrollFactId] ASC
)) ON [PRIMARY]
GO

