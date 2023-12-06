<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Resultado</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
	
    <%
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        boolean loginSucesso = false;

        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
        	Class.forName("org.postgresql.Driver");

            String url = "jdbc:postgresql://localhost:5432/usuarios";
            String usuario = "postgres";
            String senhaBD = "bebc2003";

            connection = DriverManager.getConnection(url, usuario, senhaBD);

            preparedStatement = connection.prepareStatement("SELECT * FROM usuarios WHERE email=? AND senha=?");
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, senha);

            resultSet = preparedStatement.executeQuery();
            loginSucesso = resultSet.next();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>

    <h2>Resultado do Login</h2>
    <% if (loginSucesso) { %>
       <script>
        window.location.href = 'menu.html';
    </script>
    <% } else { %>
    <div class="borda">
        <div class="centro">
        <p>Login falhou. Verifique seu email e senha.</p>
        <a href="login.html">Clique aqui para voltar ao login</a>       
        </div>
    </div>
    <% } %>
    	
</body>
</html>
