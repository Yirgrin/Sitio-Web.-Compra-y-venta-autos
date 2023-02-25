<%-- 
    Document   : guardarRegistro
    Created on : 27 nov. 2022, 17:01:50
    Author     : PC_Lenovo
--%>

<%@page import="Datos.CuentaUsuario"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItem"%>
<%@page import="org.apache.tomcat.util.http.fileupload.FileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registrar auto nuevo</title>
    </head>
    <body>

        <%
            try {
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                List<FileItem> uploadItems = upload.parseRequest(new ServletRequestContext(request));
                for (FileItem uploadItem : uploadItems) {
                    if (uploadItem.isFormField()) {
                        String fieldname = uploadItem.getFieldName();
                        String value = uploadItem.getString();
                        switch (fieldname) {
                            case "txtMarca":
                                CuentaUsuario.marca = value;
                                break;
                            case "txtModelo":
                                CuentaUsuario.modelo = value;
                                break;
                            case "txtYear":
                                CuentaUsuario.afabri = Integer.parseInt(value);
                                break;
                            case "txtEstilo":
                                CuentaUsuario.estilo = value;
                                break;
                        }
                    } else {
                        Random rand = new Random();
                        int upperbound = 1000000;
                        int random = rand.nextInt(upperbound);
                        File file;
                        String filePath = "C:/Users/PC_Lenovo/OneDrive/Documentos/NetBeansProjects/Proyecto 1/web/imagenes/";
                        file = new File(filePath + random + ".jpg");
                        uploadItem.write(file);
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost/purisCar", "root", "Admin$1234");
                        Statement statement = connection.createStatement(); 
                        Statement statement2 = connection.createStatement(); 
                        ResultSet resultSet2 = statement2.executeQuery("select * from users where Email = '" + CuentaUsuario.correo + "'");
                        resultSet2.next();
                        CuentaUsuario.nombre = resultSet2.getString("Name");
                        CuentaUsuario.apellido = resultSet2.getString("Lastname");
                        CuentaUsuario.usuario = resultSet2.getString("User");
                        CuentaUsuario.telefono = resultSet2.getInt("Phone");
                
                        String sql = ("insert into autos (correoUsuario, nombreUsuario, apellidoUsuario, usuario, telefono, marca, modelo, fabricacion, estilo, img, estatus) "
                                + "values ('"
                                + CuentaUsuario.correo + "', '"
                                + CuentaUsuario.nombre + "', '"
                                + CuentaUsuario.apellido + "', '"
                                + CuentaUsuario.usuario + "', '"
                                + CuentaUsuario.telefono + "', '"
                                + CuentaUsuario.marca + "', '"
                                + CuentaUsuario.modelo + "', "
                                + CuentaUsuario.afabri + ", '"
                                + CuentaUsuario.estilo + "', '"
                                + "imagenes/" +random + ".jpg', "
                                + "'En venta')");
                        statement.executeUpdate(sql);
                        RequestDispatcher rd = request.getRequestDispatcher("/misAutosServlet");
                        rd.include(request, response);
                    }
                }
            } catch (NumberFormatException | ClassNotFoundException | SQLException e) {
                out.println(e.getMessage());
            }%>
    </body>
</html>
