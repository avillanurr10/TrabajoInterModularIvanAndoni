<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Página Principal</title>
    <link rel="stylesheet" href="/static/css/home.css">
</head>
<body>
<div class="container">
    <div class="logo-container">
        <img src="/static/logoApp.png" alt="logoApp" class="logo">
    </div>

    <div class="nav-buttons">
        <a href="/logout" class="nav-button">Cerrar Sesión</a>
        <a href="/cart" class="nav-button">Carrito</a>
        <a href="/search-page" class="nav-button">Búsqueda</a>
        <#if isAdmin?? && isAdmin>
            <a href="/users-table" target="_blank" class="nav-button admin">Tabla Usuarios</a>
            <a href="/manage-stock" target="_blank" class="nav-button admin">Stock</a>
        </#if>
    </div>


    <h1>Bienvenido a Decartón</h1>
    <h2>Lista de Productos</h2>

    <form action="/filter-products" method="get" class="filter-form">
        <label for="sort-by">Ordenar por:</label>
        <select name="sort-by" id="sort-by">
            <option value="price_asc">Precio Ascendente</option>
            <option value="price_desc">Precio Descendente</option>
            <option value="stock_asc">Stock Ascendente</option>
            <option value="stock_desc">Stock Descendente</option>
            <option value="name_asc">Nombre A-Z</option>
            <option value="name_desc">Nombre Z-A</option>
        </select>
        <button type="submit" class="filter-button">Aplicar Filtro</button>
    </form>

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
                        <form action="/add-to-cart" method="post">
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
   </div>
</body>
</html>