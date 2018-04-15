<%-- 
    Document   : allblogs
    Created on : 5 Apr, 2018, 2:43:41 PM
    Author     : Lenovo
--%>

<%@page import="java.sql.*, java.io.*;"%>
<%@ page session="true"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script defer src="https://use.fontawesome.com/releases/v5.0.10/js/all.js" integrity="sha384-slN8GvtUJGnv6ca26v8EzVaR9DC58QEwsIk9q1QXdCU8Yu8ck/tL/5szYlBbqmS+" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <title>Welcome</title>
    </head>
    <body>
        <center style="background-color: darkorchid; padding-bottom: 10pt; padding-top: 10pt;"><h1>BLOGGER</h1></center>
        <div align="right">
            <form action="logout" method="POST">
                <div style="padding-top: 10pt; padding-right: 10pt;"> <button type="submit" value="LOGOUT" style="background-color: coral;">Logout</button></div>
            </form>
        </div>
        <div style="padding-left: 10pt;">
            <div style="padding-left: 10pt;"> <a href="addblog.jsp"><i class="fas fa-plus" style="size: 10pt;"></i> Blog</a></div>
            <br/>
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
            String name="";
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(DBURL, U, P);
                PreparedStatement pst= con.prepareStatement("select * from blogs");
                ResultSet rs = pst.executeQuery();
                name=(String)session.getAttribute("uname"); 
                int flag=0;
                //out.println(name);
                while(rs.next())
                {
                    //out.print(name);
                    //out.print((rs.getString("author")));
                    if(name.equals(rs.getString("author")))
                    {
                        //out.println("hey");
                        //out.println(rs.getString("btitle"));
                        if(rs.getString("btitle")!=null)
                        {
                            %>
                            <hr>
                            <div style="padding-right: 200pt;" align="right">
                                <a href="editblog.jsp?id=<%=rs.getInt("id")%>"><i class="far fa-edit"></i></a>
                                <a href="deleteblog.jsp?id=<%=rs.getInt("id")%>"><i class="far fa-trash-alt"></i></a>
                            </div>
                            <h2><div style="font-family: cursive; color: darkblue;"><%=rs.getString("btitle")%></div></h2>
                            <h6><div style="font-family: cursive;"><%=rs.getString("btext")%></div></h6><br/>
                            <div style="font-family: monospace;">
                                <h5>~<%=rs.getString("author")%></h5><br/>
                                <h6>Published Date: <%=rs.getString("cdate")%></h6>
                            </div>
                            <hr>
                            <br/>
                            <%
                        }
                    }
                    else
                    {
                        if(rs.getString("btitle")!=null)
                        {
                            %>
                            <hr>
                            <h2><div style="font-family: cursive; color: darkblue;"><%=rs.getString("btitle")%></div></h2>
                            <h6><div style="font-family: cursive;"><%=rs.getString("btext")%></div></h6><br/>
                            <div style="font-family: monospace; align-content: right;">
                                <h5>~<%=rs.getString("author")%></h5><br/>
                                <h6>Published Date: <%=rs.getString("cdate")%></h6>
                            </div>
                            <hr>
                            <br/><br/>
                            <%
                        }
                    }   
                }
            }
            catch(SQLException s){}
            catch(ClassNotFoundException c){}
            catch(Exception e){}
        %>
        </div>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    </body>
</html>
