<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Búsqueda de Productos</title>
    <link rel="stylesheet" href="/static/css/busqueda.css">
</head>
<body>
<div class="container">
    <!-- Botón de cerrar sesión -->
    <div class="logout-container">
        <a href="/home" class="logout-button">Inicio</a>
        <a href="/logout" class="logout-button">Cerrar Sesión</a>
    </div>

    <h1>Búsqueda de Productos</h1>

    <!-- Barra de búsqueda -->
    <form action="/search-products" method="post">
        <input type="text" name="query" placeholder="Buscar productos..." required>
        <button type="submit">Buscar</button>
    </form>

    <!-- Resultados de la búsqueda -->
    <#if productos??>
    <ul>
        <#list productos as producto>
        <li>
            <a href="/product-details?id=${producto.id}">${producto.nombre}</a>
        </li>
        </#list>
    </ul>
    <#else>
    </#if>
        <br>
        <br>
        <a href="/home">VOLVER A LA PAGINA DE INICIO</a>
</div>
</body>
</html>