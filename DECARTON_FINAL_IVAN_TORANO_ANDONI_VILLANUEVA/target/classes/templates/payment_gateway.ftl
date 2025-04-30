<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pasarela de Pago</title>
    <link rel="stylesheet" href="/static/css/pago.css">
</head>
<body>
<div class="container">
    <h1>Completa tu Compra</h1>

    <!-- Lista de productos en el carrito -->
    <table id="cart-table">
        <thead>
            <tr>
                <th>Nombre</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Cantidad</th>
            </tr>
        </thead>
        <tbody>
            <#list cart as item>
                <tr>
                    <td>${item.nombreProducto}</td>
                    <td>${item.descripcion}</td>
                    <td>${item.precio}€</td>
                    <td>${item.cantidad}</td>
                </tr>
            </#list>
        </tbody>
    </table>

    <!-- Total del carrito -->
    <h3>Total: ${total}€</h3>

    <!-- Formulario de pago -->
    <form action="/payment-gateway" method="post">
        <h2>Detalles de la Tarjeta</h2>

        <label for="cardNumber">Número de Tarjeta:</label>
        <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" required>

        <label for="expirationDate">Fecha de Expiración:</label>
        <input type="text" id="expirationDate" name="expirationDate" placeholder="MM/YY" required>

        <label for="cvv">CVV:</label>
        <input type="text" id="cvv" name="cvv" placeholder="123" required>

        <button type="submit">Completar Compra</button>
    </form>
</div>
</body>
</html>