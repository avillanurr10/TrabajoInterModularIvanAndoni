<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Página Principal</title>
    <link rel="stylesheet" href="/static/css/home.css">
</head>
<body>
<div class="container">
    <!-- Botón de cerrar sesión -->
    <div class="logout-container">
        <a href="/logout" class="logout-button">Cerrar Sesión</a>
    </div>

    <!-- Botón de carrito -->
    <div class="cart-button-container">
        <a href="/cart" class="cart-button">Carrito</a>
    </div>

        <!-- Botón de búsqueda -->
        <div class="search-button-container">
            <a href="/search-page" class="search-button">Búsqueda</a>
        </div>


    <!-- Botón condicional para admin -->
    <#if isAdmin>
    <div class="admin-button-container">
        <a href="/users-table" target="_blank" class="admin-button">Mostrar Tabla de Usuarios</a>
    </div>
    </#if>

    <h1>Bienvenido a Decartón</h1>
    <h2>Lista de Productos</h2>


       <!-- Lista de productos -->
       <#if productos?size == 0>
       <p>No hay productos disponibles.</p>
       <#else>
       <table id="products-table">
           <thead>
               <tr>
                   <th>ID</th>
                   <th>Nombre</th>
                   <th>Descripción</th>
                   <th>Precio (€)</th>
                   <th>Stock</th>
                   <th>Acciones</th>
               </tr>
           </thead>
           <tbody>
               <#list productos as producto>
               <tr>
                   <td>${producto.id}</td>
                   <td>${producto.nombre}</td>
                   <td>${producto.descripccion}</td>
                   <td>${producto.precio}€</td>
                   <td>${producto.stock}</td>
                   <td>
                       <form action="/add-to-cart" method="post" style="display:inline;">
                           <input type="hidden" name="id" value="${producto.id}">
                           <button type="submit" class="add-to-cart-button">Añadir al Carrito</button>
                       </form>
                   </td>
               </tr>
               </#list>
           </tbody>
       </table>
       </#if>
       <#if message??>
       <div class="success-message">${message}</div>
       </#if>
       <!-- Botón para ver el carrito -->
       <a href="/cart" class="view-cart-button">Ver Carrito</a>
   </div>
</body>
</html>