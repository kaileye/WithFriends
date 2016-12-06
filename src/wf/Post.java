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
public class Post implements Serializable {
    
    private String posterId;
    private String postId;
    private String pageId;
    private String postDateTime;
    private String content;


    public Post()
    {}
    
    public String getPosterId(){return posterId;}
    public String getPostId(){return postId;}
    public String getPageId(){return pageId;}
    public String getPostDateTime(){return postDateTime;}
    public String getContent(){return content;}
    
    public void setPosterId(String s){posterId = s;}
    public void setPostId(String s){postId = s;}
    public void setPageId(String s){pageId= s;}
    public void setPostDateTime(String s){postDateTime = s;}
    public void setContent(String s){content = s;}
}
