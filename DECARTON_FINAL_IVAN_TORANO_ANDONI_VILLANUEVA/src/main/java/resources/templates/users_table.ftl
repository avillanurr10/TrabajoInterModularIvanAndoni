<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tabla de Usuarios</title>
    <link rel="stylesheet" href="/static/css/users_table.css">
</head>
<body>
<h1>Tabla de Usuarios</h1>

<!-- Mostrar mensaje de error si existe -->
<#if error??>
    <p class="error">${error}</p>
</#if>

<table>
    <tr>
        <th>ID</th>
        <th>Nombre de Usuario</th>
        <th>Acciones</th>
    </tr>
    <#list users as user>
    <tr>
        <td>${user.id}</td>
        <td>${user.username}</td>
        <td>
            <form action="/delete-user" method="post" style="display: inline;">
                <input type="hidden" name="id" value="${user.id}">
                <button type="submit" class="delete-button">Borrar</button>
            </form>
        </td>
    </tr>
    </#list>
</table>

<h2>Crear Nuevo Usuario</h2>
<div class="create-user-form">
    <form action="/create-user" method="post">
        <div class="form-group">
            <label for="username">Nombre de Usuario:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <button type="submit" class="create-button">Crear Usuario</button>
    </form>
</div>
</body>
</html>