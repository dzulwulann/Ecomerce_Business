# 💳 Analyzing E-commerce Business Performance

Welcome to my project on **Analyzing E-commerce Business Performance**! 😊 This project focuses on leveraging **SQL** to explore and analyze key aspects of an e-commerce business. The goal is to extract meaningful insights that can drive strategic decision-making.

---

## 🚀 Introduction

In this project, I conducted a comprehensive analysis of an e-commerce company's performance using SQL. The analysis is divided into three main sections:

1. **Annual Customer Activity Growth Analysis**  
2. **Annual Product Category Quality Analysis**  
3. **Analysis of Annual Payment Type Usage**  

By breaking down these aspects, we gain insights into customer behavior, product performance, and payment trends over time.

---

## 📊 Data Overview

The dataset used in this project includes transaction records from an e-commerce platform.
There are seven table included in this dataset, such as : 
- **Customers** : Customer data and demographic
- **Orders** : Including details of the order transaction, such as order_id, order_status, time etc.
- **Order_payments** : include paymments details of each order that've been made.
- **Products** : details of the selling products, included product_id.
- **sellers** : the data of sellers
- **geolocation** : details of geolocation data

The data was cleaned and prepared using SQL queries to ensure accuracy and consistency before performing the analysis.

---

## 📅 Annual Customer Activity Growth Analysis

In this section, I analyzed customer activity over the years to identify growth trends. Key points include:

- **Monthly active user by year:** Measuring changes in the number of active customers annually.
- **Year-over-Year New Customer Growth:** Tracking the increase in new customer sign-ups.
<p align="center">
<img src="./images/Increasing MAU & New User.png" alt="drawing"/>
</p>
 The data for 2016 is very limited, so I decided to compare only from 2017 to 2018. The visualization shows that user activity and the number of new users are increasing each year. This suggests increased engagement and successful customer acquisition during this period.

---

## 🌟 Annual Product Category Quality Analysis

This analysis focuses on evaluating the performance of different product categories. Key insights include:
- **Total Revenue Annually:** Determining total annual revenue.
- **Revenue Contribution:** Determining which categories contribute most significantly to annual revenue.
- **Top Canceled Categories:** Identifying products with the highest canceled status. 
<p align="center">
<img src="./images/Total Revenue by year.png" alt="drawing"/>
</p>
<p align="center">
<img src="./images/Top Categories Revenue.png" alt="drawing"/>
</p>


The visualization highlights the product categories contributing most to the company’s revenue. Each year, a **different category** leads in revenue generation. In 2018, **Watches Gifts** emerged as the top contributor, driving a significant portion of total sales. Despite these shifts, the company's overall revenue showed steady growth year over year.

<p align="center">
<img src="./images/Most Canceled Categories.png" alt="drawing"/>
</p>

The category with the most cancellations changes from year to year. In 2017, the category that contributed the most to revenue was also the most canceled category: **Sport Leisure**. This could indicate that this specific category experienced the highest transaction volume that year. However, further analysis is needed to confirm this insight.

---

## 💳 Analysis of Annual Payment Type Usage

Understanding payment preferences is crucial for enhancing user experience. In this section, I explored:

- **Most Popular Payment Methods:** Identifying the most frequently used payment options.
- **Yearly Trends in Payment Types:** Observing shifts in customer payment behavior over time.

<p align="center">
<img src="./images/Payment type.png" alt="drawing"/>
</p>

Credit Card is the most popular payment that is used by user for transaction. We need to analyze futher about user's behavior in using credit card, such as tenor, limit of the payment etc.
Other insight that we should highlight also the number of credit card's user from 2017 to 2018 was increasing more than 100%. While on the other hand, The number of user that used voucher were decreased from 2017 to 2018. 

---

## 📊 Tools & Technologies

- **SQL:** For data extraction, cleaning, and analysis.
- **Database Management Systems:** MySQL/BigQuery (depending on your specific DBMS).
- **Data Visualization:** (Optional) Tools like Tableau or Power BI can be used for visualizing insights.

---

## 🔗 How to Navigate This Project

- **`/SQL Queries`**: Contains all the SQL scripts used for data extraction and analysis.
- **`/Reports`**: Includes detailed reports summarizing key findings from each analysis section.

---

## 📢 Conclusion

Through this project, we gained valuable insights into customer behavior, product performance, and payment preferences. These insights can help e-commerce businesses make data-driven decisions to enhance growth and optimize operations.

---

## 📧 Contact

If you have any questions or feedback, feel free to reach out:

- **Email:** dzulwulann@gmail.com  
- **LinkedIn:** [Dzul Wulan Ningtyas](https://www.linkedin.com/in/dzulwulan/)  

---

**Thank you for checking out my project!** 🌟


