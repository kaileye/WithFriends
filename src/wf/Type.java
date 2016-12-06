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
public class Type implements Serializable {
    private String typeName;
    private int typeCount = 0;

    
    public Type() {
        
    }
    
    public String getTypeName(){return typeName;}
    public int getTypeCount(){return typeCount;}
    public String getTypeCountString(){String s = Integer.toString(typeCount); return s;} 
    
    
  public void setTypeName(String s) {typeName = s;}
      public void setTypeCount(int s) {typeCount = s;}
      public void addTypeCount() {typeCount++;}
}
