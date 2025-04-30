<!DOCTYPE html>
<html>
<head>
        <meta charset="UTF-8">
    <title>Detalles del Producto</title>
    <link rel="stylesheet" href="/static/css/home.css">
</head>
<body>
<div class="container">
    <!-- Botón de cerrar sesión -->
    <div class="logout-container">
        <a href="/logout" class="logout-button">Cerrar Sesión</a>
    </div>

    <h1>Detalles del Producto</h1>

    <!-- Mostrar los detalles del producto -->
    <#if producto??>
    <div class="producto">
        <h2>${producto.nombre}</h2>
        <p><strong>Descripción:</strong> ${producto.descripccion!"Sin descripción"}</p>
        <p><strong>Precio:</strong> ${producto.precio}€</p>
        <p><strong>Stock:</strong> ${producto.stock}</p>
    </div>
    <#else>
    <p>No se encontró el producto.</p>
    </#if>

    <!-- Enlace para volver a la página de búsqueda -->
    <a href="/search-page">Volver a la búsqueda</a>
</div>
</body>
</html>