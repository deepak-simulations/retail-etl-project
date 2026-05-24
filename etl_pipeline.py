import pandas as pd
import sqlite3
import matplotlib.pyplot as plt

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

## visualization of data 
def plot():
    
    top_products = pd.read_csv("top_product.csv")
    revenue_country = pd.read_csv("revenue_country.csv")
    monthly_revenue = pd.read_csv("monthly_revenue.csv")    


    top_products.plot(
        x="Description",
        y = "revenue",
        kind="barh" 
    )
    plt.title("Revenue generation product-wise")


    revenue_country = revenue_country.set_index("Country")

    revenue_country.plot(
        
        y = "revenue",
        kind= "pie",
        autopct='%1.1f%%',
        legend=False
    )
    plt.title("Country-wise revenue share")
    
    monthly_revenue.plot(
        x = "month",
        y = "total_revenue",
        kind="line",
        marker='o'
    )
    
    plt.title("Monthly Revenue Trend")
    plt.xlabel("Month")
    plt.ylabel("Revenue(in million)")
    plt.show()

if __name__=="__main__":
    
    plot()
