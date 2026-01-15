# E-Commerce Shipping Delay Analysis 🚚📦

## 📌 Problem Statement
In large e-commerce platforms, delayed deliveries directly impact customer satisfaction, SLA compliance, and operational costs.  
The operations team needs clear visibility into **where delays are occurring**, **why they are happening**, and **what actions can improve on-time delivery performance**.

This project analyzes an e-commerce logistics dataset to identify **warehouse-level, shipment-level, and customer-level factors** contributing to delivery delays.

---

## 🎯 Business Objectives
- Measure overall on-time delivery performance (SLA adherence)
- Identify underperforming warehouses
- Compare shipment modes based on delay rates
- Understand customer behavior (calls, discounts) related to delays
- Provide actionable insights for operations improvement

---

## 🧾 Dataset Overview
The analysis is based on two datasets:

### 1. Orders Table
Contains order and customer-related information such as:
- Customer care calls
- Product cost
- Discounts offered
- Product importance
- Customer demographics

### 2. Delivery Table
Contains logistics and delivery-related details:
- Warehouse block
- Mode of shipment
- Package weight
- Delivery status (On-Time / Delayed)

Both tables are joined using a common `ID`.

---

## 🛠 Tools & Technologies Used
- **Python (Pandas, Matplotlib)** – Data cleaning, feature engineering, analysis, and visualization
- **SQL** – Joins, aggregations, CASE statements, CTEs, subqueries, and window functions
- **Excel / WPS** – Data merging, pivot tables, KPI calculations, and operations dashboard
- **GitHub** – Version control and project documentation

---


---

## 🐍 Python Analysis (python/E-Commerce Shipping.ipynb)
In the Python notebook, I performed:
- Data loading and validation
- Handling missing values and duplicates
- Merging order and delivery datasets
- Feature engineering:
  - Delivery status (On-Time / Delayed)
  - Delay flag for SLA analysis
- Exploratory analysis:
  - Overall on-time delivery percentage
  - Warehouse-wise delay analysis
  - Shipment mode performance comparison
  - Customer care calls vs delay relationship
  - Product cost and discount impact on delays
- Visualizations to support operational insights

📌 **Outcome:** Identified key operational bottlenecks and patterns affecting delivery performance.

---

## 🗄 SQL Analysis (sql/E_Commerce_Shipping.sql)
The SQL file contains interview-level queries using:
- `INNER JOIN` to combine order and delivery data
- `CASE WHEN` for delay flag creation
- `GROUP BY` and `HAVING` for aggregation and filtering
- Subqueries and CTEs for cleaner logic
- Window functions (`RANK`, `LAG`, `LEAD`) for comparison analysis

Key analyses include:
- Warehouse-wise total and delayed orders
- Delay percentage by shipment mode
- Identification of high-risk warehouses
- Cost comparison of delayed vs on-time orders
- Customer care calls impact on delays

📌 **Outcome:** Demonstrated strong SQL skills aligned with real-world operations analytics.

---

## 📊 Excel Dashboard (excel/E_Commerce_Shipping.xlsx)
In Excel (WPS), I:
- Combined datasets using `XLOOKUP / VLOOKUP`
- Created operational columns like Delivery Status and Delay Flag
- Built Pivot Tables for:
  - Warehouse vs delayed orders
  - Shipment mode vs on-time percentage
  - Customer care calls vs delay trend
- Designed KPI metrics:
  - Total orders
  - Delay percentage
  - On-time delivery percentage
  - Average product cost
- Created charts for quick decision-making

📌 **Outcome:** Built a manager-friendly operations dashboard for daily SLA monitoring.

---

## 🔍 Key Insights
- Certain warehouses consistently show higher delay percentages, indicating operational bottlenecks
- Road shipment mode has higher delays compared to other modes
- Increase in customer care calls strongly correlates with delayed deliveries
- High-value orders getting delayed pose a higher customer satisfaction risk
- Heavy discounts often coincide with increased delays due to demand spikes

---

## ✅ Business Impact
- Enables operations teams to focus on problem warehouses
- Supports data-driven shipment mode decisions
- Helps prioritize high-value and high-risk orders
- Improves SLA adherence and customer experience

---

## 🚀 Future Scope (No ML / No Forecasting)
- Automate daily SLA and delay reports
- Build real-time operations dashboards
- Set alert thresholds for warehouse delay spikes
- Optimize shipment partner allocation
- Use insights for cost control and capacity planning

---

## 👤 Author
**Roopesh**  
Aspiring Operations / Data Analyst  

---

