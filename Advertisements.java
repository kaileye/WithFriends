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
public class Advertisements implements Serializable {
    private String adId;
    private String employeeId;
    private String type;
    private String postDateTime;
    private String company;
    private String itemName;
     private String content;
    private String unitPrice;
    
    public Advertisements() {
        
    }
    
    public String getAdId() {
        return adId;
    }
    
    public String getEmployeeId() {
        return employeeId;
    }
    
    public String getType() {
        return type;
    }
    public String getPostDateTime() {
        return postDateTime;
    }
    
    public String getCompany() {
        return company;
    }
    
    public String getItemName() {
        return itemName;
    }
    
    public String getContent() {
        return content;
    }
    
    public String getUnitPrice() {
        return unitPrice;
    }
    
    public void setAdId(String adId) {
        this.adId = adId;
    }
    
     public void setEmployeeId(String employeeId) {
        this.employeeId = employeeId;
    }
     
      public void setType (String type) {
        this.type = type;
    }
       
        public void setPostDateTime(String postDateTime) {
        this.postDateTime = postDateTime;
    }
        
         public void setCompany(String company) {
        this.company = company;
    }
         
          public void setItemName(String itemName) {
        this.itemName = itemName;
    }
          
           public void setContent(String content) {
        this.content = content;
    }
           
           public void setUnitPrice(String unitPrice) {
        this.unitPrice = unitPrice;
    }
}
