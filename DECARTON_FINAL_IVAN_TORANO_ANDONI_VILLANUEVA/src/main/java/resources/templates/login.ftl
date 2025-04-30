<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
    <title>${titulo}</title>
    <link rel="stylesheet" href="/static/css/login.css">
</head>
<body>
<div class="container">
    <h1 style="color: #81D4FA;">${titulo}</h1> <!-- Título en azul Tiffany -->
    <form action="/login" method="post">
        <label for="username">Usuario:</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Contrasenia:</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Iniciar Sesion</button>
    </form>
    <#if error??>
        <p class="error">${error}</p>
    </#if>
    <#if success??>
        <p class="success">${success}</p>
    </#if>
    <p>No tienes cuenta? <a href="/register">Registrate aqui</a>.</p>
</div>
<script src="/static/js/script.js"></script>
</body>
</html>