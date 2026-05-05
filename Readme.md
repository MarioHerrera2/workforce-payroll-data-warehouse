# Workforce Payroll Data Warehouse Project

## 📊 Overview
Built an end-to-end data pipeline using SQL Server, SSIS, and SSRS to transform HR and payroll data into a star schema data warehouse. Implemented ETL processes with logging and validation, and developed reports to analyze payroll costs, overtime, and trends.

---

## 🛠️ Tools & Technologies
- SQL Server
- SSIS (SQL Server Integration Services)
- SSRS (SQL Server Reporting Services)

---

## 🧱 Architecture
OLTP Database  
↓  
Staging Layer (SSIS)  
↓  
Data Warehouse (Dimensions + Fact Table)  
↓  
Reporting (SSRS)

---

## 📦 Key Components

### Data Warehouse
- Star schema design
- Fact table: `FactPayroll`
- Dimensions:
  - DimEmployee
  - DimDepartment
  - DimJobTitle
  - DimPayType
  - DimDate

### ETL Pipeline
- Extracted data from OLTP
- Loaded into staging tables
- Transformed and loaded into DW
- Implemented logging with `ETL_RunLog`
- Added validation checks and failure handling

### Reporting
- Payroll by Department
- Overtime by Department
- Monthly Payroll Trend
- Parameterized filtering by department

---

## ✅ Validation & Monitoring
- Row count validation
- Aggregate (SUM) checks
- Foreign key integrity checks
- ETL logging for success/failure tracking

---

## 📈 Outcome
Delivered a complete data pipeline enabling analysis of payroll distribution, overtime usage, and workforce trends.