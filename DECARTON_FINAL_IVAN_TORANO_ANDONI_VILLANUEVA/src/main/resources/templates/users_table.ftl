<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DECARTON - Tabla de Usuarios</title>
    <link rel="stylesheet" href="/static/css/users_table.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>

<div class="container">

    <div class="header">
        <div class="logo-block">
            <img src="imagenes/logoApp.png" alt="logoApp" class="logo">
            <a href="/logout" class="nav-button">Cerrar Sesión</a>
        </div>
    </div>

    <h1>Tabla de Usuarios</h1>

  <!-- <#if error??> -->
        <p class="error">No hay usarios</p>
    <!-- </#if> -->

    <table id="users-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre de Usuario</th>
                <th>Acciones</th>
            </tr>
        </thead>
        <tbody>
            <!-- <#list users as user> -->
            <tr>
                    <td>${user.id}</td>
                    <td>${user.username}</td>
                <td>
                    <form action="/delete-user" method="post" style="display: inline;">
                        <input type="hidden" name="id" value="${user.id}">
                        <button type="submit" class="delete-button">Borrar</button>
                    </form>
			            <a href="/user-details/${user.id}">Ver Detalles</a>
                </td>
            </tr>
            <!-- </#list> -->
        </tbody>
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
</div>

<script src="users_table.js"></script>
</body>
</html>