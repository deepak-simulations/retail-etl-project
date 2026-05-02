import pandas as pd
import sqlite3

def extract():
    print("Extracting data..")
    df = pd.read_csv("online_retail_II.csv",encoding="ISO-8859-1")
    
    print("Data loaded successfully!")
    print("Shape:",df.shape)

    return df


# Transformantion function
def transform(df):
    print("Transforming data..")
    print("Rows before cleaning:",len(df))

    #. Handle missing Customer ID
    #1. Convert + clean text
    df["Customer ID"] = df["Customer ID"].astype(str).str.strip()

    #2.Filter bad values
    df["Customer ID"] = df["Customer ID"].replace(["","0","nan"],pd.NA)    
    
    #3. Conver to proper numeric type
    df["Customer ID"] = df["Customer ID"].astype(float).astype('Int64')
    
    4# Remove invalide rows
    df = df[(df["Quantity"] > 0) & (df["Price"]>0)]

    5#convert data types
    df["Quantity"] = df["Quantity"].astype(int)
    df["Price"] = df["Price"].astype(float)

    #6. Create new column
    df["total_price"] = df["Quantity"] * df["Price"]
    df["total_price"] = df["total_price"].round(2)

    #7. Convert InvoiceDate
    df["InvoiceDate"] = pd.to_datetime(df["InvoiceDate"])

    print("Rows after cleaning:",len(df))

    return df


## load the data in sql
def load(df):
    conn = sqlite3.connect("practice.db")
    df.to_sql("clean_retail",conn,if_exists="replace",index=False)
    conn.close()

if __name__=="__main__":
    df = extract()
    df = transform(df)
    load(df)
