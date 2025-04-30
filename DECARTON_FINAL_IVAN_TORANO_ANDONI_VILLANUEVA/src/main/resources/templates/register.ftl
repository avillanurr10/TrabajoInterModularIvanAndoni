<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DECARTON - Registro</title>
    <link rel="stylesheet" href="/static/css/register.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">

</head>
<body>
<div class="container">
    <!-- Logo -->
    <div class="logo-container">
        <img src="/static/logoApp.png" alt="DECARTON" class="logo">
    </div>

    <form action="/register" method="post">
        <div class="input-group">
        <label for="username">Nombre de Usuario:</label>
        <input type="text" id="username" name="username" required>
        </div>


        <div class="input-group">
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="password">
            <div class="password-strength">
                <div class="strength-bar" id="strengthBar"></div>
            </div>
        </div>

        <button type="submit">Crear Cuenta</button>
    </form>

    <#if error??>
    <p class="error">${error}</p>
    </#if>



    <p class="login-link">¿Ya tienes cuenta? <a href="/login">Inicia sesión aquí</a></p>
</div>

<script src="/static/js/script.js"></script>
</body>
</html>