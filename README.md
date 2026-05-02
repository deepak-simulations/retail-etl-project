# Retail ETL Pipeline( Python +SQlite)

## Overview
Built an ETL pipeline to clean and analyze transactional retail data.

## Pipeline Design 
Exract the CSV data
Transform(Python - pandas):
  Handling missing Customer IDs ( Converted to NULL)
  Removed the invalid transactions( negative/zero Quantity adn Price)
  Preserved monetary precision( Price as float)
  Created 'total_price = Quantity * Price' 
Load
  Stored cleanded data into SQLite( 'practice.db')

## Analysis(SQL)
 Total revenue calculation
 Top customers by revenue 
 Top country by revenue
 Missing Customer analysis

## Key insights

 ~23% of transactions had missing Customer IDs,
  but they contributed only ~15% of total revenue, 
  indicating lower average value per transaction.
 
  Data cleaning significantly imporved consistancy 

## Key learnings
  Difference beween NULL vs empty vlues
  Importance of data type decisions ( int vs float)
  ETL vs ELT
  Querrty patters determine indexing ( next)

## Next step 
  Add indexing for query optimization
  MOve to scalable data tools ( cloud / distributed systems)
