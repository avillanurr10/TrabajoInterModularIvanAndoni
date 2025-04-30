<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
    <title>${titulo}</title>
    <link rel="stylesheet" href="/static/css/register.css">
</head>
<body>
<div class="container">
    <h1>${titulo}</h1>
    <form action="/register" method="post">
        <label for="username">Nombre de Usuario:</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Contrasenia:</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Registrarse</button>
    </form>
    <#if error??>
        <p class="error">${error}</p>
    </#if>
    <p>Ya tienes cuenta? <a href="/">Inicia sesion aqui</a>.</p>
</div>
<script src="/static/js/script.js"></script>
</body>
</html>