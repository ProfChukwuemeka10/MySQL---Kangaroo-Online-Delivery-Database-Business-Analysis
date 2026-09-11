# MySQL---Kangaroo-Online-Delivery-Database-Business-Analysis
A relational database project that models the day-to-day operations of Kangaroo Online Delivery Company, a food-ordering and motorbike-delivery business.
The project goes beyond storing records: it connects customers, restaurants, menu items, orders, drivers, managers, motorbikes, and driving licenses into a structured database that can answer practical business questions about revenue, customer activity, restaurant performance, menu demand, delivery workload, and payroll.

📌 Project Objectives
This project was designed to demonstrate how SQL can be used to:

- Build a normalized relational database from the ground up
- Represent real-world business relationships with primary and foreign keys
- Protect data integrity through constraints and referential actions
- Populate a database with realistic demonstration data
- Combine operational records across multiple tables
- Calculate order values and business revenue
- Evaluate customers, restaurants, drivers, menu items, and managers
- Inspect and validate the completed database structure

🔐 Data Integrity & Relational Design
The schema uses several database controls to improve consistency and reliability:

- Auto-incrementing primary keys
- Composite primary keys for junction tables
- Foreign-key relationships
- Unique email, registration, category, and license values
- Positive quantity and engine-size checks
- Nonnegative salary and price checks
- License expiry validation
- ON UPDATE CASCADE for related identifier changes
- ON DELETE RESTRICT for important operational records
- ON DELETE CASCADE for dependent menu and order-item records
- The Order_Item table stores the unit price charged when an order was placed. This preserves historical order value, even if a restaurant later changes the current price recorded in Restaurant_Item.

🔎 Business Questions Answered
The analytical queries explore questions such as:

Customer Analysis
- How many orders has each customer placed?
- Which customers have not yet placed an order?
- What are the details associated with each customer order?
- Order & Revenue Analysis
- Which items appear in each order?
- What is the line total for every ordered item?
- What is the complete value of each order?
- Which orders contribute the most revenue?
- Restaurant Performance
- Which restaurants receive the most orders?
- How much revenue does each restaurant generate?
- Which menu items does each restaurant currently offer?
- How do item prices vary across restaurants?
- Product & Category Performance
- Which items sell the greatest number of units?
- Which items generate the most revenue?
- Which food categories lead by quantity and revenue?
- Driver & Management Analysis
- How many deliveries has each driver completed?
- How does delivery activity compare with driver salary?
- Which manager supervises each driver?
- How many drivers report to each manager?
- Which restaurant, motorbike, and license are assigned to each driver?
- Payroll Analysis
- What is the total payroll represented in the sample data?
- What are the minimum, maximum, and average driver salaries?


🧠 SQL Skills Demonstrated
- Technique	Application in the Project
- DDL	Creates the database, tables, relationships, and constraints
- Multi-row inserts	Populates all entities with demonstration data
- Primary and foreign keys	Defines identity and relationships across the schema
- Composite keys	Protects many-to-many junction-table records
- INNER JOIN	Combines matching operational records across tables
- LEFT JOIN	Retains customers, restaurants, or drivers with no matching activity
- GROUP BY	Summarizes performance by business entity
- Aggregate functions	Uses COUNT, SUM, AVG, MIN, and MAX
- COUNT DISTINCT	Prevents duplicated order counts after item-level joins
- COALESCE	Displays zero rather than NULL for missing activity
- Calculated expressions	Computes line totals and complete order values
- CONCAT	Produces readable customer, driver, and manager names
- UNION ALL	Creates a table-by-table record-count summary
- Metadata commands	Uses SHOW, DESCRIBE, and SHOW CREATE TABLE for inspection
