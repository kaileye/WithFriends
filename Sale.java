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
    private String itemName;
    private String firstName;
    private String lastName;
    
    public Sale() {
        
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
}
