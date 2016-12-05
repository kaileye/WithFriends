/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package wf;

import java.io.Serializable;

/**
 *
 * @author danie
 */
public class Sale implements Serializable {
    private String transactionId;
    private String customerId;
    private String accountNumber;
    private String salesDateTime;
    private String adId;
    private String units;
    private String unitPrice;
    private String itemName;
    private String firstName;
    private String lastName;
    private int sumOfSale;
    private String sumOfSaleString;
    private String adType;
    public String columnTotal = "0";
    
    public Sale() {
        
    }
    
    public String getAdType()
    {
        return adType;
        
    }
    
    public int getSumOfSale()
    {
        return sumOfSale;
        
    }
   
    public String getSumOfSaleString()
    {
        return sumOfSaleString;
    }
    
     public String getColumnTotal()
    {
        return columnTotal;
    }
    
    public void generateSumOfSaleString()
    {
        int intunits = Integer.parseInt(units);
        int intunitprice = Integer.parseInt(unitPrice);
        sumOfSale = intunits * intunitprice;
        sumOfSaleString = Integer.toString(sumOfSale);
    }
    
     public String getTransactionId() {
        return transactionId;
    }

     public String getCustomerId() {
        return customerId;
    }
     
     public String getAccountNumber() {
        return accountNumber;
    }
     
     public String getSalesDateTime() {
        return salesDateTime;
    }
     
     public String getAdId() {
        return adId;
    }
     
      public String getUnits() {
        return units;
    }
      
       public String getItemName() {
        return itemName;
    }
       
        public String getFirstName() {
        return firstName;
    }
        
         public String getLastName() {
        return lastName;
    }
         
             public String getUnitPrice() {
        return unitPrice;
    }
         
     
    
    public void setTransactionId(String TransactionId) {
        this.transactionId = TransactionId;
    }
    
    public void setCustomerId(String CustomerId) {
        this.customerId = CustomerId;
    }
    
    public void setAccountNumber(String AccountNumber) {
        this.accountNumber = AccountNumber;
    }
    
    public void setSalesDateTime(String SalesDateTime) {
        this.salesDateTime = SalesDateTime;
    }
    
    public void setAdId(String AdId) {
        this.adId = AdId;
    }
    
    public void setUnits(String Units) {
        this.units = Units;
    }
    
      public void setFirstName(String FirstName) {
        this.firstName = FirstName;
    }
      
        public void setLastName(String LastName) {
        this.lastName = LastName;
    }
    
      public void setItemName(String ItemName) {
        this.itemName = ItemName;
    }
      
       public void setUnitPrice(String UnitPrice) {
        this.unitPrice = UnitPrice;
    }
       
       public void setAdType(String AdType)
       {this.adType = AdType;
       }
       
        public void setColumnTotal(String columnTotal)
       {this.columnTotal = columnTotal;
       }
        
        public void addColumnTotal(String s)
        {
          int toadd = Integer.parseInt(s);
          int current = Integer.parseInt(columnTotal);
           current = current + toadd;
         columnTotal = Integer.toString(current);
        }
       
     
}
