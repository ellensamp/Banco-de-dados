<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <title>Excluir Usuário</title>
</head>
<body>
    <div class="borda">
        <div class="centro">
            <h2>Digite a senha para excluir o usuário</h2>
            
            <form action="confirmarExclusao.jsp" method="post">
                <label for="senha">Senha:</label>
                <input type="password" id="senha" name="senha" required>
                <br>
                <input type="submit" value="Excluir Usuário">
            </form>

            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String senhaDigitada = request.getParameter("senha");

                    String url = "jdbc:postgresql://localhost:5432/usuarios";
                    String usuario = "postgres";
                    String senhaBD = "bebc2003";

                    Connection connection = null;
                    try {
                        Class.forName("org.postgresql.Driver");
                        connection = DriverManager.getConnection(url, usuario, senhaBD);

                        String verificarSenhaSQL = "SELECT * FROM usuarios WHERE senha = ?";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(verificarSenhaSQL)) {
                            preparedStatement.setString(1, senhaDigitada);

                            ResultSet resultSet = preparedStatement.executeQuery();

                            if (resultSet.next()) {
                                String excluirUsuarioSQL = "DELETE FROM usuarios WHERE senha = ?";
                                try (PreparedStatement excluirUsuarioStatement = connection.prepareStatement(excluirUsuarioSQL)) {
                                    excluirUsuarioStatement.setString(1, senhaDigitada);
                                    int linhasAfetadas = excluirUsuarioStatement.executeUpdate();

                                    if (linhasAfetadas > 0) {
                                        %>
                                        <h2>Usuário excluído com sucesso!</h2>
                                        <a href="index.html">Voltar para o Index</a>
                                        <%
                                    } else {
                                        %>
                                        <h2>Ocorreu um erro ao excluir o usuário. Tente novamente.</h2>
                                        <a href="index.html">Voltar para Index</a>
                                        <%
                                    }
                                }
                            } else {
                                %>
                                <h2>Senha incorreta ou usuário não encontrado. Exclusão cancelada.</h2>
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
