<%-- 
    Document   : updateUser
    Created on : 26 nov. 2022, 20:21:04
    Author     : jesus
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Puris Carros</title>
    </head>
    <body>
        <%
            String txtName = request.getParameter("txtName");
            String txtLastName = request.getParameter("txtLastName");
            String txtEmail = request.getParameter("txtEmail");
            String txtUser = request.getParameter("txtUser");
            String txtPassword = request.getParameter("txtPassword");
            String txtPhone = request.getParameter("txtPhone");
            String txtAddress = request.getParameter("txtAddress");
        %>

        <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/purisCar", "root", "Admin$1234");
            Statement statement = connection.createStatement();

            String sql = "update users set Name = '" + txtName + 
                         "', LastName = '" + txtLastName + 
                         ", Email = '" + txtEmail + 
                         "', User = " + txtUser + 
                         ", Password = '" + txtPassword + 
                         ", Phone = '" + txtPhone + 
                         "', Address = '" + txtAddress + "'" +
                         " where Email = " + txtEmail;

            statement.executeUpdate(sql);

            out.println("<script type='text/javascript'>alert('User updated');</script>");

            RequestDispatcher rd = request.getRequestDispatcher("/users.jsp");
            rd.include(request, response);
        %>
    </body>
</html>