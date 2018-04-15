<%-- 
    Document   : saveblog
    Created on : 5 Apr, 2018, 4:27:38 PM
    Author     : Lenovo
--%>
<%@page import="java.sql.*, java.io.*, java.lang.*;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Save</title>
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
            String title, text, name, date;
            int id=0;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(DBURL, U, P);
                id = Integer.parseInt(request.getParameter("id"));
                //out.println(id);
                title = request.getParameter("title");
                text = request.getParameter("text");
                if(id>0)
                {
                    PreparedStatement pst= con.prepareStatement("update blogs set btitle=?, btext=? where id=?");
                    pst.setString(1,title);
                    pst.setString(2,text);
                    pst.setInt(3,id);
                    pst.executeUpdate();
                    response.sendRedirect("allblogs.jsp");
                }
                else
                {
                    date = request.getParameter("cdate");
                    int flag=0;
                    name=(String)session.getAttribute("uname"); 
                    PreparedStatement pst = con.prepareStatement("select * from blogs");
                    //pst.setString(1,name);
                    //out.println(name);
                    ResultSet rs = pst.executeQuery();
                    while(rs.next())
                    {
                        String tit = rs.getString("btitle");
                        int n = rs.getInt("id");
                        out.println(n);
                        if(name.equals(rs.getString("author")))
                        {
                           if(tit==null)
                           {
                                pst= con.prepareStatement("update blogs set btitle=?, btext=?, cdate=? where id=?");
                                pst.setString(1,title);
                                pst.setString(2,text);
                                pst.setString(3,date);
                                pst.setInt(4, n);
                                pst.executeUpdate();
                                flag++;
                                response.sendRedirect("allblogs.jsp");
                           }
                        }
                    }
                    if(flag==0)
                    {
                        pst= con.prepareStatement("insert into blogs(author, btitle, btext, cdate) values(?, ?, ?, ?)");
                        pst.setString(1,name);
                        pst.setString(2,title);
                        pst.setString(3,text);
                        pst.setString(4,date);
                        pst.executeUpdate();
                        response.sendRedirect("allblogs.jsp");
                    }
                }
            }
            catch(SQLException s){out.println(s);}
            catch(ClassNotFoundException c){out.println(c);}
            catch(Exception e){out.println(e);}
        %>
    </body>
</html>
