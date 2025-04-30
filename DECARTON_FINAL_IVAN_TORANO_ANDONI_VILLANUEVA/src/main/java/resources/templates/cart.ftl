<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Carrito</title>
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
<div class="container">
    <h1>Tu Carrito</h1>

    <!-- Lista de productos en el carrito -->
    <table id="cart-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio</th>
            <th>Cantidad</th>
        </tr>
        </thead>
        <tbody>
        <#list cart as item>
            <tr>
                <td>${item.idcompra}</td>
                <td>${item.nombreProducto}</td>
                <td>${item.descripcion}</td>
                <td>${item.precio}€</td>
                <td>${item.cantidad}</td>
            </tr>
        </#list>
        </tbody>
    </table>

    <!-- Botón para ir a la pasarela de pago -->
    <form action="/checkout" method="get">
        <button type="submit">Ir a Pagar</button>
    </form>
</div>
</body>
</html>