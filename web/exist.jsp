<%-- 
    Document   : exist
    Created on : 8 Apr, 2018, 5:49:01 PM
    Author     : Lenovo
--%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exists</title>
    </head>
    <body>
        <%
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con =(Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/myblog", "root", "root");
                    PreparedStatement pst = con.prepareStatement("SELECT  * FROM blogs WHERE author = ?");
                    String unm = request.getParameter("username");
                    pst.setString(1,unm);
                    String pass = request.getParameter("password");
                    String cpass = request.getParameter("cpassword");
                    ResultSet rs = pst.executeQuery();
                    if(rs.first()){
                        out.print("UserName already exists!!");
                        %>
                        <h2>Try another UserName <a href="signup.html">Click Here</a></h2>
                        <%
                    }
                    else{
                        if(pass.equals(cpass))
                        {
                            pst = con.prepareStatement("insert into blogs(author, pass) values(?, ?)");
                            pst.setString(1,unm);
                            pst.setString(2,pass);
                            int i = pst.executeUpdate();
                            //out.println(i);
                            out.print("User created!!");
                            %>
                            <h2><a href="index.html">Login Now</a></h2>
                            <%
                        }
                        else
                        {
                            out.print("Passwords don't match!!");
                            %>
                            <h2><a href="signup.html">Try again</a></h2>
                            <%
                        }
                    }
                } 
                catch(SQLException s){out.println(s);}
                catch(ClassNotFoundException c){out.println(c);}
                catch(Exception e){}  
        %>
    </body>
</html>
