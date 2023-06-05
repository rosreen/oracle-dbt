# oracle-dbt


Demo accounts in software applications play a crucial role in sales, training, testing, customization, development, and support. They offer a controlled environment for learning, experimentation, and showcasing software capabilities without affecting live data or production environments. For customers onboarded on "DBT as a Service", access to the DBT Demo Scripts GIT Repository and Sample Database need to be provided. These resources serve as references for building business-specific data models based on FUSION, NETSUITE, CX data warehouse, and other relevant data sources.

Project Description: Develop comprehensive DBT demo scripts GIT Repository to cover all features of the DBT platform, including extraction, transformation, and loading. Utilize macros, seeds, SQL with Jinja, and Pandas to create intricate and complex scripts. Execute these queries on a large-scale test database to thoroughly test the various functionalities of DBT. Throughout the process, diligently document any errors or flaws encountered to aid in the creation of a robust and reliable design for the DBT Data platform.


Transformations

DBT Demo Account Platform needs to perform the below complex data transformations on the test datasets created in FAWDBTCORE Demo Datawarehouse. These features need to empower Oracle Customers to reshape and enhance their data in a flexible and scalable manner, enabling them to derive valuable insights.

    Joining and Merging Data: DBT allows customers to perform intricate data joins and merges. Customers can combine data from multiple sources, apply complex join conditions, handle different join types (inner, outer, left, right), and create unified datasets that bring together relevant information from disparate sources.

    Aggregations and Grouping: DBT enables customers to perform advanced aggregations and grouping operations on their data. Customers can calculate metrics such as sums, averages, counts, or create custom aggregations based on specific business requirements. Grouping functions allow customers to group data by one or more dimensions, creating meaningful datasets for analysis.

    Window Functions: DBT supports window functions, which allow customers to perform calculations within a specified window or subset of data. Customers can use window functions for tasks such as running totals, moving averages, rank calculations, and time-based aggregations.

    Conditional Transformations: DBT provides the flexibility to apply conditional logic during data transformations. Customers can use conditional statements (e.g., CASE statements) to perform data transformations based on specific conditions or create derived columns with dynamic values depending on different scenarios.

    Unpivoting and Pivoting Data: DBT allows customers to reshape customer's data by converting columns into rows (unpivoting) or rows into columns (pivoting). This is particularly useful when dealing with denormalized or wide datasets and when transforming data for specific reporting or analysis requirements.

    Complex Data Type Handling: DBT supports the handling of complex data types, such as arrays, JSON, or nested structures. Customers can easily extract, manipulate, and transform data within these complex structures using DBT's built-in functions and capabilities.

    Data Deduplication and Cleaning: DBT provides functionality for identifying and removing duplicate records in customer's data. Customers can implement complex deduplication logic based on specific criteria, ensuring data integrity and accuracy. Additionally, customers can perform data cleaning tasks, such as handling missing or inconsistent values, standardizing formats, or applying data validation rules.

    Custom Transformations: DBT allows customers to implement custom transformations using SQL and Jinja, a templating language. This flexibility enables customers to write complex SQL queries and create custom functions or macros to extend the capabilities of DBT for their specific transformation needs.


