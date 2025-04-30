<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
    <title>Resultados</title>
    <link rel="stylesheet"  href="/static/css/styles.css">
</head>
<body>
<div class="container">
    <h1>Usuarios Registrados</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>Nombre de Usuario</th>
        </tr>
        <#list users as user>
        <tr>
            <td>${user.id}</td>
            <td>${user.username}</td>
        </tr>
        </#list>
    </table>
    <a href="/">Volver al login</a>
</div>
<script src="/static/js/script.js"></script>
</body>
</html>