<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestionar Stock</title>
    <link rel="stylesheet" href="/static/css/stock.css">
</head>
<body>
    <header>
        <h1>Gestionar Stock</h1>
        <nav>
            <a href="/home">Inicio</a>
            <a href="/logout">Cerrar Sesión</a>
        </nav>
    </header>

    <main>
        <!-- Mostrar mensajes de éxito o error -->
        <#if success??>
            <div class="success-message">${success}</div>
        </#if>

        <#if error??>
            <div class="error-message">${error}</div>
        </#if>

        <!-- Campo de búsqueda -->
        <form action="/search-products-stock" method="get" class="search-form">
            <label for="query">Buscar producto:</label>
            <input type="text" name="query" id="query" placeholder="Nombre del producto" required>
            <button type="submit" class="search-button">Buscar</button>
        </form>

        <!-- Desplegable con los productos -->
        <form action="/update-stock" method="post" class="stock-form">
            <label for="productId">Seleccionar producto:</label>
            <select name="productId" id="productId" required>
                <option value="" disabled selected>Selecciona un producto</option>
                <#list productos as producto>
                    <option value="${producto.id}">${producto.nombre}</option>
                </#list>
            </select>

            <!-- Campo para aumentar el stock -->
            <label for="quantity">Cantidad a añadir:</label>
            <input type="number" name="quantity" id="quantity" min="1" required>

            <!-- Botón para actualizar el stock -->
            <button type="submit" class="update-stock-button">Actualizar Stock</button>
        </form>
    </main>

    <footer>
        <p>&copy; 2023 DECARTON. Todos los derechos reservados.</p>
    </footer>
</body>
</html>