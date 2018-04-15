<%-- 
    Document   : editblog
    Created on : 5 Apr, 2018, 4:10:08 PM
    Author     : Lenovo
--%>
<%@page import="java.sql.*, java.io.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
        <title>Edit</title>
    </head>
    <body>
        <center style="background-color: darkorchid; padding-bottom: 10pt; padding-top: 10pt;"><h1>BLOGGER</h1></center>
        <form action="saveblog.jsp" method="POST">
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
                PreparedStatement pst= con.prepareStatement("select * from blogs where id=?");
                pst.setInt(1,id);
                ResultSet rs = pst.executeQuery();
                while(rs.next())
                {
                    %>
                    <div style="padding-left: 300pt;">
                        <div class="form-group col-md-6">
                            <label>Title</label>
                            <input type="text" class="form-control" value="<%=rs.getString("btitle")%>" id="inputtext4" name="title" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label>Text</label>
                            <input type="text" class="form-control" value="<%=rs.getString("btext")%>" id="inputtext4" name="text" required>
                        </div>
                        <input type="hidden" name="id" value="<%=id%>">
                        <div style="padding-left: 120pt;">
                         <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </div>
                    <%
                }
            }
            catch(SQLException s){}
            catch(ClassNotFoundException c){}
            catch(Exception e){}
        %>
        </form>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js" integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js" integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm" crossorigin="anonymous"></script>
    </body>
</html>
