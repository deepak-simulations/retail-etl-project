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
  
  UK generated dominant share of revenue.
  
  Revenue fluctuated significantly month to month.
  
  No strong long-term revenue growth observed.
  
  Few products contributed disproportionately to revenue. 

## Key learnings
  Difference beween NULL vs empty vlues

  Importance of data type decisions ( int vs float)
  
  ETL vs ELT
  
  Learned how relational databases connect data across multiple table using JOIN operations. 

  Indexing
  
  CSV rexport workflow 
  
  Business-oriented visualization using Pansas and Matplotlib
