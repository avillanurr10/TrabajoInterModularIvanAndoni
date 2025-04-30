<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles del Usuario</title>
    <link rel="stylesheet" href="/static/css/details.css">
</head>
<body>
    <header>
        <h1>Detalles del Usuario</h1>
        <nav>
            <a href="/home">Inicio</a>
            <a href="/logout">Cerrar Sesión</a>
        </nav>
    </header>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>Nombre de Usuario</th>
            <th>Contraseña</th>
            <th>Inicios de Sesión</th>
            <th>Último Inicio de Sesión</th>
            <th>Creado</th>
            <th>Es Admin</th>
        </tr>
    </thead>
    <tbody>
            <tr>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.password!"No disponible"}</td>
                <td>${user.loginCount}</td>
                <td>${user.lastLogin!"No disponible"}</td>


            </tr>
    </tbody>
</table>

        <!-- Botón para regresar -->
        <div class="button-container">
            <a href="/users-table" class="back-button">Regresar a la Tabla de Usuarios</a>
        </div>
    </main>

    <footer>
        <p>&copy; 2023 DECARTON. Todos los derechos reservados.</p>
    </footer>
</body>
</html>