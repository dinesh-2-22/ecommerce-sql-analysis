
# E-Commerce Customer Segmentation & Sales Analytics

## Project Overview
This project analyzes an e-commerce dataset to understand customer purchasing behavior, sales performance, and operational efficiency. The analysis was performed using **MySQL for data analysis** and **Power BI for visualization**.

The main objective of this project is to identify valuable customers, analyze revenue trends, and build an interactive dashboard that helps businesses make data-driven decisions.

The project focuses on **customer segmentation using RFM analysis (Recency, Frequency, Monetary)** along with key business metrics such as revenue, average order value, and purchase frequency.

---

# Dataset Description

The dataset contains transactional data from an e-commerce platform. Two main tables were used for analysis.

## Orders Dataset
This table contains order-level information.

Important columns:
- `order_id` – Unique identifier for each order  
- `customer_id` – Unique identifier for each customer  
- `order_purchase_timestamp` – Date and time when the order was placed  
- `order_status` – Status of the order  

Total rows: **~99,441**

---

## Order Payments Dataset
This table contains payment information for each order.

Important columns:
- `order_id` – Order identifier  
- `payment_type` – Payment method used by the customer  
- `payment_value` – Payment amount  

Total rows: **~103,886**

The payments dataset contains more rows because **one order may have multiple payment records**.

Example:

| order_id | payment_type | payment_value |
|---------|--------------|---------------|
| order_1 | credit_card  | 200 |
| order_1 | voucher      | 50 |

---

# Project Workflow

## 1. Data Exploration
The first step was understanding the dataset structure and volume.

Example queries:

```sql
SELECT COUNT(*) FROM olist_orders_dataset;
SELECT COUNT(*) FROM olist_order_payments_dataset;
```

---

## 2. Data Integration
Orders and payments datasets were joined using `order_id` to combine order information with payment details.

```sql
SELECT *
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id;
```

---

## 3. Revenue Analysis
Total revenue was calculated by summing the payment values.

```sql
SELECT SUM(payment_value) AS total_revenue
FROM olist_order_payments_dataset;
```

---

## 4. Average Order Value

Average Order Value measures how much customers spend per order.

Formula:

Average Order Value = Total Revenue / Total Orders

SQL logic:

```sql
SELECT
SUM(payment_value) / COUNT(DISTINCT order_id) AS avg_order_value
FROM olist_order_payments_dataset;
```

`COUNT(DISTINCT order_id)` is used because one order may have multiple payment records.

---

## 5. Purchase Frequency

Purchase frequency measures how often customers place orders.

```sql
SELECT
customer_id,
COUNT(order_id) AS purchase_frequency
FROM olist_orders_dataset
GROUP BY customer_id;
```

---

# RFM Analysis

RFM analysis is a customer segmentation technique used to identify valuable customers.

It is based on three metrics:

### Recency
How recently a customer made a purchase.

### Frequency
How often a customer purchases.

### Monetary
How much money a customer spends.

Example SQL used to calculate RFM metrics:

```sql
WITH rfm AS (
SELECT
o.customer_id,
DATEDIFF(
(SELECT MAX(order_purchase_timestamp) FROM olist_orders_dataset),
MAX(o.order_purchase_timestamp)
) AS recency,
COUNT(DISTINCT o.order_id) AS frequency,
SUM(p.payment_value) AS monetary
FROM olist_orders_dataset o
JOIN olist_order_payments_dataset p
ON o.order_id = p.order_id
GROUP BY o.customer_id
)

SELECT * FROM rfm;
```

---

# Customer Segmentation

Customers were segmented into three groups based on spending behavior.

- **High Value Customers**
- **Medium Value Customers**
- **Low Value Customers**

This segmentation helps businesses identify their most valuable customers and design targeted marketing strategies.

---

# Power BI Dashboard

After completing SQL analysis, the processed dataset was imported into **Power BI** to build an interactive dashboard.

## Dashboard Preview

![Dashboard](dashboard.png)

---

## KPIs Included

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value

---

## Visualizations

The dashboard includes several visualizations:

- **Revenue Trend by Year** – shows how sales performance changed over time  
- **Revenue by Payment Type** – analyzes customer payment preferences  
- **Revenue by Customer Segment** – shows revenue contribution from different customer groups  
- **Order Status Distribution** – displays fulfillment performance  
- **Average Delivery Days by Year** – analyzes delivery efficiency  

---

# Key Insights

The analysis revealed several important insights:

- Revenue increased significantly between **2016 and 2018**
- **Credit cards** are the most commonly used payment method
- **Low-value customers contribute a large portion of total revenue**
- The majority of orders are **successfully delivered**
- **Delivery time improved** over the years

---

# Tools & Technologies Used

- **MySQL**
- **SQL (JOINs, CTEs, Aggregations)**
- **Power BI**
- **DAX**
- **Data Analysis**
- **Data Visualization**

---

# Project Structure

``
