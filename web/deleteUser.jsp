<%-- 
    Document   : deleteUser
    Created on : 26 nov. 2022, 20:21:14
    Author     : jesus
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String txtEmail = request.getParameter("txtEmail");
        %>

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/purisCar", "root", "Admin$1234");
            Statement statement = connection.createStatement();

            String sql = "delete from users where Email = " + txtEmail;

            statement.executeUpdate(sql);

            out.println("<script type='text/javascript'>alert('User deleted');</script>");

            RequestDispatcher rd = request.getRequestDispatcher("/users.jsp");
            rd.include(request, response);
        %>
    </body>
</html>
