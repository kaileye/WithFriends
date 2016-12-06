package wf.userbean;

import java.io.Serializable;

/**
 * Created by Yida Yuan on 11/22/16.
 */
public class User implements Serializable {
    // common part: applies to all users
    private String userId;
    private String firstname;
    private String lastname;
    private String sex;
    private String email;
    private String pwd;
    private String dob;
    private String address;
    private String city;
    private String state;
    private String zipcode;
    private String telephone;
    private String accNum;
    private String accDate;
    private String creditCardNum;
    private String preference;
    private String rating;
    // Employee part: applies to only employees
    private String ssn;
    private String hourlyRate;
    private String revenueGenerated = "0";
    private String employeeId;

    public User() {
        
    }

    // Getters
    public String getUserId() {
        return userId;
    }

    public String getFirstname() {
        return firstname;
    }

    public String getLastname() {
        return lastname;
    }

    public String getSex() {
        return sex;
    }

    public String getEmail() {
        return email;
    }

    public String getPwd() {
        return pwd;
    }

    public String getDob() {
        return dob;
    }

    public String getAddress() {
        return address;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getZipcode() {
        return zipcode;
    }

    public String getTelephone() {
        return telephone;
    }

    public String getAccNum() {
        return accNum;
    }

    public String getAccDate() {
        return accDate;
    }

    public String getCreditCardNum() {
        return creditCardNum;
    }

    public String getPreference() {
        return preference;
    }

    public String getRating() {
        return rating;
    }

    public String getSsn() {
        return ssn;
    }

    public String getHourlyRate() {
        return hourlyRate;
    }

    public String getRevenueGenerated()
    {
        return revenueGenerated;
    }
    
     public int getRevenueGeneratedInt()
    {
        int revgen = Integer.parseInt(revenueGenerated);
        return revgen;
    }
    
    public String getEmployeeId()
    {
        return employeeId;
    }
    
    // Setters
    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setFirstname(String firstname) {
        this.firstname = firstname;
    }

    public void setLastname(String lastname) {
        this.lastname = lastname;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setState(String state) {
        this.state = state;
    }

    public void setZipcode(String zipcode) {
        this.zipcode = zipcode;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public void setAccNum(String accNum) {
        this.accNum = accNum;
    }

    public void setAccDate(String accDate) {
        this.accDate = accDate;
    }

    public void setCreditCardNum(String creditCardNum) {
        this.creditCardNum = creditCardNum;
    }

    public void setPreference(String preference) {
        this.preference = preference;
    }

    public void setRating(String rating) {
        this.rating = rating;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public void setHourlyRate(String hourlyRate) {
        this.hourlyRate = hourlyRate;
    }
    
    public void setRevenueGenerated(String s)
    {   this.revenueGenerated = s;
    }
    
    public void addToRevenueGenerated(String s)
    {   int toadd = Integer.parseInt(s);
          int current = Integer.parseInt(revenueGenerated);
          current = current + toadd;
         revenueGenerated = Integer.toString(current);
    }
    
    public void setEmployeeId(String s)
        {
            employeeId = s;
        }
}

