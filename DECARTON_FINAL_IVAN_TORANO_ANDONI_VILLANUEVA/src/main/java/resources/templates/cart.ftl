<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrito de Compra</title>
    <link rel="stylesheet" href="/static/css/cart.css">
</head>
<body>
<div class="container">
    <div class="logo-container">
        <img src="/static/logoApp.png" alt="logoApp" class="logo">
        <div class="nav-buttons">
            <a href="/home" class="nav-button">Inicio</a>
            <a href="/logout" class="nav-button">Cerrar Sesión</a>
        </div>
    </div>

    <h1>Carrito de Compra</h1>
    <!-- Lista de productos en el carrito -->
    <#if cart?size == 0>
        <p>No hay productos en el carrito.</p>
    <#else>
        <table id="cart-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Precio (€)</th>
                    <th>Cantidad</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <#list cart as item>
                <tr>
                    <!-- ID del producto -->
                    <td>${item.idcompra!}</td>
                    <!-- Nombre del producto -->
                    <td>${item.nombreProducto!}</td>
                    <!-- Descripción del producto -->
                    <td>${item.descripccion!}</td>
                    <!-- Precio del producto -->
                    <td>${item.precio!"N/A"}€</td>
                    <!-- Cantidad del producto con botones + y - -->
                    <td>
                        <form action="/update-cart" method="post" class="quantity-form">
                            <input type="hidden" name="idcompra" value="${item.idcompra}">
                            <button type="submit" name="action" value="decrease" class="quantity-button">-</button>
                            <span>${item.cantidad!"0"}</span>
                            <button type="submit" name="action" value="increase" class="quantity-button">+</button>
                        </form>
                    </td>
                    <!-- Botón para eliminar el producto -->
                    <td>
                        <form action="/remove-from-cart" method="post" class="remove-form">
                            <input type="hidden" name="idcompra" value="${item.idcompra}">
                            <button type="submit" class="remove-button">Eliminar</button>
                        </form>
                    </td>
                </tr>
                </#list>
            </tbody>
        </table>
    </#if>

    <!-- Botón para volver a la página principal -->
    <div class="nav-buttons">
        <a href="/payment-gateway" class="nav-button">Comprar Ahora</a>
    </div>
</div>
</body>
</html>
