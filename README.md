# Project Overview: Sales Data Analysis with SQL and Python

This project involves data analysis and manipulation of sales transaction data using Python, Pandas, and SQL, along with integration to SQL Server for storing the processed data. The dataset, "orders.csv," contains detailed information on sales transactions, including product details, pricing, quantities, discounts, and profits.

## Key Features:
- **Data Cleaning:** Missing and invalid values (e.g., "Not Available," "unknown") were cleaned and properly handled.
- **Data Transformation:** Column names were standardized, and new columns for discount, sale price, and profit were calculated.
- **SQL Database Integration:** Processed data was loaded into an SQL Server database for further analysis and reporting.

### Data Preprocessing and Transformation:
1. **Importing and Inspecting Data:**
   - Loaded sales data into a Pandas DataFrame from a CSV file.
   - Previewed the dataset and checked for any missing values or inconsistencies.
  
2. **Data Cleaning:**
   - Replaced missing or invalid shipping modes with appropriate `NaN` values for later handling.
   - Standardized column names by replacing spaces with underscores and converting to lowercase.

3. **Feature Engineering:**
   - Added new calculated columns:
     - **Discount:** Calculated from the list price and discount percent.
     - **Sale Price:** Derived by subtracting the discount from the list price.
     - **Profit:** Calculated as the difference between sale price and cost price.

4. **Data Type Conversion:**
   - Converted the `order_date` column to a datetime object for better handling of date-based analysis.

5. **SQL Integration:**
   - Dropped unnecessary columns (e.g., list price, cost price) to streamline the data.
   - Established a connection to SQL Server and appended the cleaned and transformed data to a database table (`df_orders`).

### Technologies Used:
- **Python:** Main programming language for data cleaning, transformation, and manipulation.
- **Pandas:** Library used for data manipulation and analysis.
- **SQLAlchemy:** Python library for connecting to SQL databases and performing operations.
- **SQL Server:** Database used to store processed data for easy querying and analysis.

### Example Analysis:
- The project supports various SQL queries for analyzing the sales data, such as:
  - Top 10 highest revenue-generating products.
  - Top 5 highest-selling products in each region.
  - Month-over-month growth comparisons of sales.
  - Sub-category with the highest profit growth.

### Installation and Setup:
1. Clone this repository to your local machine.
2. Install required dependencies using pip:
   ```
   pip install pandas sqlalchemy
   ```
3. Make sure you have access to a SQL Server instance and update the connection string as necessary.

### Running the Analysis:
1. Load the `orders.csv` file into the `df` DataFrame.
2. Clean and transform the data.
3. Connect to the SQL database and append the transformed data to the `df_orders` table.
4. Run SQL queries to generate insights and visualizations.

This project serves as a robust example of how to clean, manipulate, and store large datasets for advanced analysis using SQL and Python.
