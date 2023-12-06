<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <title>Mudar Senha</title>
</head>
<body>
    <div class="borda">
        <div class="centro">
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String senhaAntiga = request.getParameter("senhaAntiga");
                    String novaSenha = request.getParameter("novaSenha");

                    String url = "jdbc:postgresql://localhost:5432/usuarios";
                    String usuario = "postgres";
                    String senhaBD = "bebc2003";

                    Connection connection = null;
                    try {
                        Class.forName("org.postgresql.Driver");
                        connection = DriverManager.getConnection(url, usuario, senhaBD);

                        String verificarSenhaSQL = "SELECT senha FROM usuarios WHERE senha = ?";
                        try (PreparedStatement verificarSenhaStatement = connection.prepareStatement(verificarSenhaSQL)) {
                            verificarSenhaStatement.setString(1, senhaAntiga);
                            ResultSet resultSet = verificarSenhaStatement.executeQuery();

                            if (resultSet.next()) {
                                String atualizarSenhaSQL = "UPDATE usuarios SET senha = ? WHERE senha = ?";
                                try (PreparedStatement atualizarSenhaStatement = connection.prepareStatement(atualizarSenhaSQL)) {
                                    atualizarSenhaStatement.setString(1, novaSenha);
                                    atualizarSenhaStatement.setString(2, senhaAntiga);

                                    int linhasAfetadas = atualizarSenhaStatement.executeUpdate();

                                    if (linhasAfetadas > 0) {
                                        %>
                                        <h2>Senha alterada com sucesso!</h2>
                                        <a href="menu.html">Voltar para o menu</a>
                                        <%
                                    } else {
                                        %>
                                        <h2>Ocorreu um erro ao alterar a senha. Tente novamente.</h2>
                                        <a href="index.html">Voltar para Index</a>
                                        <%
                                    }
                                }
                            } else {
                                %>
                                <h2>Senha antiga incorreta. A alteração de senha foi cancelada.</h2>
                                <a href="index.html">Voltar para Index</a>
                                <%
                            }
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (connection != null) {
                            try {
                                connection.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                }
            %>
        </div>
    </div>
</body>
</html>
