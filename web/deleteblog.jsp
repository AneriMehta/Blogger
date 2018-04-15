<%-- 
    Document   : deleteblog
    Created on : 5 Apr, 2018, 4:24:05 PM
    Author     : Lenovo
--%>
<%@page import="java.sql.*, java.io.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete</title>
    </head>
    <body>
         <%
            if(session.getAttribute("uname") == null)
            {
                response.sendRedirect("index.html");
            }
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");//HTTP 1.1
            response.setHeader("Pragma", "no-cache");//HTTP 1.0
            response.setHeader("Expires", "0");//Proxy servers
            String DBURL = "jdbc:mysql://localhost:3306/myblog";
            String U = "root";
            String P = "root";
            int id;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(DBURL, U, P);
                id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement pst= con.prepareStatement("delete from blogs where id=?");
                pst.setInt(1,id);
                pst.executeUpdate();
                response.sendRedirect("allblogs.jsp");
            }
            catch(SQLException s){}
            catch(ClassNotFoundException c){}
            catch(Exception e){}
        %>
    </body>
</html>
