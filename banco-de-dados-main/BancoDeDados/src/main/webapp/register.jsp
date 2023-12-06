<%@ page import="java.sql.*" %>
<%@ page import="java.io.*,java.util.*" %>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <title>registro</title>
</head>
<%
    String nome = request.getParameter("nome");
    String nascimento = request.getParameter("nascimento");
    String email = request.getParameter("email");
    String endereco = request.getParameter("endereco");
    String telefone = request.getParameter("telefone");
    String senha = request.getParameter("senha");

    try {
        Class.forName("org.postgresql.Driver");

        String url = "jdbc:postgresql://localhost:5432/usuarios";
        String username = "postgres";
        String password = "bebc2003";

        Connection connection = DriverManager.getConnection(url, username, password);

        String sql = "INSERT INTO usuarios (nome, nascimento, email, endereco, telefone, senha) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, nome);
        preparedStatement.setString(2, nascimento);
        preparedStatement.setString(3, email);
        preparedStatement.setString(4, endereco);
        preparedStatement.setString(5, telefone);
        preparedStatement.setString(6, senha);

        int rowsAffected = preparedStatement.executeUpdate();

        preparedStatement.close();
        connection.close();

        if (rowsAffected > 0) {%>
            <div class="borda">
        		<div class="centro">
        		<h2>Registro bem sucedido</h2>
        		<a href="menu.html">ir para o menu</a>
        		</div>
        	</div>
        <%} else {
            out.println("Erro ao registrar o usuário.");
        }
    } catch (Exception e) {
        out.println("Erro: " + e.getMessage());
    }
%>
</html>
