package wf.user;

import java.io.Serializable;

/**
 * Created by Yida Yuan on 11/21/16.
 */
public class LoginUser implements Serializable {
    private String EmailID, PWD;

    public LoginUser() {
        EmailID = "";
        PWD = "";
    }

    public LoginUser(String EmailId, String PWD) {
        this.EmailID = EmailId;
        this.PWD = PWD;
    }

    public String getEmailID() {
        return EmailID;
    }

    public void setEmailID(String EmailId) {
        this.EmailID = EmailId;
    }

    public String getPWD() {
        return PWD;
    }

    public void setPWD(String PWD) {
        this.PWD = PWD;
    }
}
