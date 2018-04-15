<%-- 
    Document   : login
    Created on : 5 Apr, 2018, 4:28:50 PM
    Author     : Lenovo
--%>
<%@page import="java.sql.*, java.io.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");//HTTP 1.0
            response.setHeader("Expires", "0");//Proxy servers
            String DBURL = "jdbc:mysql://localhost:3306/myblog";
            String U = "root";
            String P = "root";
            String name="";
            String pd="";
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(DBURL, U, P);
                PreparedStatement pst= con.prepareStatement("select * from blogs");
                ResultSet rs = pst.executeQuery();
                name = request.getParameter("uname");
                pd = request.getParameter("pass");
                int flag=0;
                while(rs.next())
                {
                    if(name.equals(rs.getString("author")))
                    {
                        if(pd.equals(rs.getString("pass")))
                        {
                            //out.print(name);
                            session.setAttribute("uname",name);  
                            response.sendRedirect("allblogs.jsp");
                        }
                    }
                    else
                    {
                        flag++;
                    }
                }
                if(flag!=0)
                {
                    out.print("OOPS incorrect Username or Password!");
                    %>
                    <h2><a href="index.html">Try Again</a> or new to Blogger? wanna <a href="signup.html">Signup</a></h2>
                    <%
                }
            }
            catch(SQLException s){}
            catch(ClassNotFoundException c){}
            catch(Exception e){}
        %>
    </body>
</html>
