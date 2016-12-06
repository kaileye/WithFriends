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
public class Group implements Serializable {
    
    private String groupId;
    private String groupName;
    private String type;
    private String ownerId;


    public Group()
    {}
    
    public String getGroupId(){return groupId;}
    public String getGroupName(){return groupName;}
    public String getType(){return type;}
    public String getOwnerId(){return ownerId;}
    
    public void setGroupId(String s){groupId = s;}
    public void setGroupName(String s){groupName = s;}
    public void setType(String s){type= s;}
    public void setOwnerId(String s){ownerId = s;}
}
