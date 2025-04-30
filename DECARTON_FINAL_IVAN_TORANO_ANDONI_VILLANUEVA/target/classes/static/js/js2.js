document.addEventListener("DOMContentLoaded", () => {
    const tableBody = document.querySelector("#products-table tbody");

    // Cargar todos los productos al cargar la página
    fetch("/all-products")
        .then(response => response.json())
        .then(products => {
            displayProductsInTable(products);
        })
        .catch(error => {
            console.error("Error al cargar productos:", error);
        });

    // Función para mostrar productos en la tabla
    function displayProductsInTable(products) {
        tableBody.innerHTML = ""; // Limpiar la tabla

        if (products.length > 0) {
            products.forEach(product => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${product.id}</td>
                    <td>${product.nombre}</td>
                    <td>${product.descripccion}</td>
                    <td>${product.precio}€</td>
                    <td>${product.stock}</td>
                `;
                tableBody.appendChild(row);
            });
        } else {
            const row = document.createElement("tr");
            row.innerHTML = `<td colspan="5">No hay productos disponibles.</td>`;
            tableBody.appendChild(row);
        }
    }
});