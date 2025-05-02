package org.example;

import io.javalin.Javalin;
import io.javalin.rendering.template.JavalinFreemarker;
import freemarker.template.Configuration;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.example.dao.CartDAO;
import org.example.dao.ProductDAO;
import org.example.dao.UserDAO;
import org.example.entity.User;
import org.example.entity.Cart;

import static org.example.dao.ProductDAO.getProductDetails;

public class Main {
    public static void main(String[] args) {
        // Configurar FreeMarker
        Configuration freemarkerConfig = new Configuration(Configuration.VERSION_2_3_32);
        freemarkerConfig.setClassForTemplateLoading(Main.class, "/templates");

        freemarkerConfig.setDateTimeFormat("yyyy-MM-dd'T'HH:mm:ss");
        freemarkerConfig.setDateFormat("yyyy-MM-dd");
        freemarkerConfig.setTimeFormat("HH:mm:ss");

        // Inicializar Javalin con FreeMarker y archivos estáticos
        Javalin app = Javalin.create(config -> {
            config.fileRenderer(new JavalinFreemarker(freemarkerConfig));
            config.staticFiles.add(staticFiles -> {
                staticFiles.directory = "/static";
                staticFiles.hostedPath = "/static";
            });
        }).start(8080);

        // DAOs y controlador
        UserDAO userDAO = new UserDAO();
        ProductDAO productDAO = new ProductDAO();
        CartDAO cartDAO = new CartDAO();

        // Rutas
        app.get("/", ctx -> ctx.redirect("/login"));

        app.get("/payment-gateway", ctx -> {
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            int userId = 1;
            List<Cart> cartItems = cartDAO.getCartItems(userId);

            if (cartItems.isEmpty()) {
                ctx.status(400).result("El carrito está vacío.");
                return;
            }

            // Convertir List<Cart> a List<Map<String, Object>>
            List<Map<String, Object>> cartItemsAsMaps = cartItems.stream()
                    .map(item -> {
                        Map<String, Object> product = new HashMap<>();
                        product.put("idcompra", item.getIdCompra());
                        product.put("nombreProducto", item.getNombreProducto());
                        product.put("descripcion", item.getDescripcion());
                        product.put("precio", item.getPrecio());
                        product.put("cantidad", item.getCantidad());
                        return product;
                    })
                    .toList();

            // Calcular el total del carrito
            double total = cartItemsAsMaps.stream()
                    .mapToDouble(item -> (double) item.get("precio"))
                    .sum();

            // Pasar los datos al modelo
            Map<String, Object> model = new HashMap<>();
            model.put("cart", cartItemsAsMaps);
            model.put("total", total);
            ctx.render("payment_gateway.ftl", model); // Renderizar la plantilla de la pasarela de pago
        });


        // Ruta para mostrar la tabla de usuarios
        app.get("/users-table", ctx -> {
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            // Verificar si el usuario es administrador
           /* Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            if (isAdmin == null || !isAdmin) {
                ctx.status(403).result("Acceso denegado. Solo los administradores pueden ver esta página.");
                return;
            }*/

            // Obtener todos los usuarios
            List<Map<String, Object>> users = userDAO.getAllUsers();

            // Pasar los usuarios al modelo
            Map<String, Object> model = new HashMap<>();
            model.put("users", users);
            ctx.render("users_table.ftl", model);
        });

        app.get("/user-details/{id}", ctx -> {
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            try {
                // Extraer el ID del usuario de la URL
                String idParam = ctx.pathParam("id");
                int userId = Integer.parseInt(idParam);

                // Obtener los detalles del usuario
                Map<String, Object> userDetails = userDAO.getUserDetails(userId);
                if (userDetails == null) {
                    ctx.status(404).result("Usuario no encontrado.");
                    return;
                }

                // Pasar los detalles al modelo
                Map<String, Object> model = new HashMap<>();
                model.put("user", userDetails);
                model.put("isAdmin", isAdmin);
                ctx.render("user_details.ftl", model);
            } catch (NumberFormatException e) {
                ctx.status(400).result("ID inválido.");
            }
        });

// Ruta para eliminar un usuario (solo para administradores)
        app.post("/delete-user", ctx -> {

            // Verificar si el usuario es administrador
            // Obtener el ID del usuario a eliminar
            int userId = Integer.parseInt(ctx.formParam("id"));
            // Eliminar el usuario
            userDAO.deleteUser(userId);
            // Redirigir a la tabla de usuarios
            ctx.redirect("/users-table");
        });

        app.post("/payment-gateway", ctx -> {
            int userId = 1; // Obtener el ID del usuario desde la sesión (simulado)

            // Simulación de validación de la tarjeta
            String cardNumber = ctx.formParam("cardNumber");
            String expirationDate = ctx.formParam("expirationDate");
            String cvv = ctx.formParam("cvv");

            // Validar que todos los campos estén completos
            if (cardNumber == null || cardNumber.isEmpty() ||
                    expirationDate == null || expirationDate.isEmpty() ||
                    cvv == null || cvv.isEmpty()) {
                ctx.status(400).result("Por favor, completa todos los campos de la tarjeta.");
                return;
            }

            try {
                cartDAO.processPurchase(userId); // Procesar la compra usando el DAO
                ctx.result("Compra realizada con éxito. ¡Gracias por tu pedido!");
            } catch (Exception e) {
                e.printStackTrace();
                ctx.status(500).result("Error al procesar la compra.");
            }
        });


        app.get("/logout", ctx -> {

            ctx.sessionAttribute("username", null);
            ctx.sessionAttribute("isAdmin", null);
            ctx.redirect("/login");
        });


        app.get("/register", ctx -> {

            Map<String, Object> model = new HashMap<>();
            model.put("error", ctx.sessionAttribute("error"));
            ctx.sessionAttribute("error", null);
            ctx.render("register.ftl", model);
        });

        app.post("/register", ctx -> {
            String username = ctx.formParam("username");
            String password = ctx.formParam("password");

            // Validar que el nombre de usuario no exista ya
            if (!userDAO.isUsernameAvailable(username)) {
                ctx.sessionAttribute("error", "El nombre de usuario ya está en uso");
                ctx.redirect("/register");
                return;
            }

            // Crear un nuevo usuario
            User newUser = new User(username, password);

            // Guardar el usuario en la base de datos usando el DAO
            userDAO.save(newUser);

            // Redirigir al login con mensaje de éxito
            Map<String, Object> model = new HashMap<>();
            model.put("success", "Registro exitoso. Por favor, inicia sesión.");
            ctx.render("login.ftl", model);
        });

        app.get("/filter-products", ctx -> {
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            // Obtener el criterio de ordenación del formulario
            String sortBy = ctx.queryParam("sort-by");

            // Obtener los productos ordenados según el criterio
            List<Map<String, Object>> products;
            switch (sortBy) {
                case "price_asc":
                    products = productDAO.getProductsSortedByPrice(true); // Ascendente
                    break;
                case "price_desc":
                    products = productDAO.getProductsSortedByPrice(false); // Descendente
                    break;
                case "stock_asc":
                    products = productDAO.getProductsSortedByStock(true); // Ascendente
                    break;
                case "stock_desc":
                    products = productDAO.getProductsSortedByStock(false); // Descendente
                    break;
                case "name_asc":
                    products = productDAO.getProductsSortedByName(true); // A-Z
                    break;
                case "name_desc":
                    products = productDAO.getProductsSortedByName(false); // Z-A
                    break;
                default:
                    products = productDAO.getAllProducts(); // Por defecto, sin filtrar
            }
            // Pasar los productos al modelo
            Map<String, Object> model = new HashMap<>();
            model.put("productos", products);
            model.put("isAdmin", isAdmin);
            ctx.render("home.ftl", model);
        });

        app.get("/manage-stock", ctx -> {
            // Verificar si el usuario es administrador
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");

            // Obtener todos los productos
            List<Map<String, Object>> products = productDAO.getAllProducts();

            // Pasar los productos al modelo
            Map<String, Object> model = new HashMap<>();
            model.put("productos", products);
            ctx.render("manage_stock.ftl", model);
        });

        app.get("/search-products-stock", ctx -> {
            // Obtener el término de búsqueda
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            String query = ctx.queryParam("query");

            // Buscar productos que coincidan con el término
            List<Map<String, Object>> products = productDAO.searchProducts(query);

            // Pasar los productos al modelo
            Map<String, Object> model = new HashMap<>();
            model.put("productos", products);
            model.put("isAdmin", isAdmin);
            ctx.render("manage_stock.ftl", model);
        });

        app.post("/update-cart", ctx -> {
            int userId = 1; // Simulación de ID de usuario
            int idCompra = Integer.parseInt(ctx.formParam("idcompra"));
            String action = ctx.formParam("action");

            // Actualizar la cantidad en el carrito
            cartDAO.updateCartItemQuantity(idCompra, action);

            // Redirigir al carrito
            ctx.redirect("/cart");
        });

        app.post("/remove-from-cart", ctx -> {
            int userId = 1; // Simulación de ID de usuario
            int idCompra = Integer.parseInt(ctx.formParam("idcompra"));

            // Eliminar el producto del carrito
            cartDAO.removeFromCart(idCompra);

            // Redirigir al carrito
            ctx.redirect("/cart");
        });

        app.post("/update-stock", ctx -> {
            // Verificar si el usuario es administrador
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");

            // Obtener el ID del producto y la cantidad a añadir
            int productId = Integer.parseInt(ctx.formParam("productId"));
            int quantity = Integer.parseInt(ctx.formParam("quantity"));

            // Actualizar el stock usando el DAO
            boolean success = productDAO.updateStock(productId, quantity);

            if (success) {
                ctx.redirect("/manage-stock?success=Stock+actualizado+correctamente");
            } else {
                ctx.redirect("/manage-stock?error=Error+al+actualizar+el+stock");
            }
        });

        app.get("/login", ctx -> {
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            Map<String, Object> model = new HashMap<>();
            model.put("error", ctx.sessionAttribute("error"));
            ctx.sessionAttribute("error", null);
            ctx.render("login.ftl", model);
        });

        app.post("/login", ctx -> {
            String username = ctx.formParam("username");
            String password = ctx.formParam("password");

            // Autenticar al usuario
            User user = userDAO.findByUsername(username);
            if (user != null && user.getPassword().equals(password)) {
                // Determinar si el usuario es admin
                boolean isAdmin = "admin".equals(username);

                // Guardar el estado del usuario en la sesión
                ctx.sessionAttribute("username", username);
                ctx.sessionAttribute("isAdmin", isAdmin);

                // Renderizar la página principal con el modelo
                Map<String, Object> model = new HashMap<>();
                model.put("isAdmin", isAdmin); // Pasar isAdmin al modelo
                model.put("productos", productDAO.getAllProducts());
                ctx.render("home.ftl", model);
            } else {
                // Mostrar mensaje de error si las credenciales son incorrectas
                Map<String, Object> model = new HashMap<>();
                model.put("error", "Credenciales incorrectas");
                ctx.render("login.ftl", model);
            }
        });

        app.get("/home", ctx -> {
            // Recuperar el estado del usuario desde la sesión
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");

            // Obtener los productos
            List<Map<String, Object>> products = productDAO.getAllProducts();

            // Crear el modelo
            Map<String, Object> model = new HashMap<>();
            model.put("isAdmin", isAdmin); // Pasar isAdmin al modelo
            model.put("productos", products);

            // Renderizar la página
            ctx.render("home.ftl", model);
        });

        app.post("/add-to-cart", ctx -> {
            int userId = 1;
            int productId = Integer.parseInt(ctx.formParam("id"));

            Map<String, Object> product = productDAO.getProductDetails(productId);
            if (product != null) {
                cartDAO.addToCart(userId, product);
                ctx.status(200);
            } else {
                ctx.status(404).result("Producto no encontrado");
            }
        });

        app.get("/cart", ctx -> {
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            int userId = 1;
            List<Map<String, Object>> cartItems = cartDAO.getCartItems(userId).stream().map(item -> {
                Map<String, Object> product = new HashMap<>();
                product.put("idcompra", item.getIdCompra());
                product.put("nombreProducto", item.getNombreProducto());
                product.put("descripcion", item.getDescripcion());
                product.put("precio", item.getPrecio());
                product.put("cantidad", item.getCantidad());
                return product;
            }).toList();

            Map<String, Object> model = new HashMap<>();
            model.put("cart", cartItems);
            ctx.render("cart.ftl", model);
        });

        app.get("/search-page", ctx -> {
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            Map<String, Object> model = new HashMap<>();
            model.put("productos", null);
            model.put("isAdmin", isAdmin);
            ctx.render("search_page.ftl", model);
        });

       app.post("/create-user", ctx -> {
            // Obtener los datos del formulario
            String username = ctx.formParam("username");
            String password = ctx.formParam("password");
            // Validar que los campos no estén vacíos
            if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
                ctx.status(400).result("Todos los campos son obligatorios.");
                return;
            }
            // Verificar si el nombre de usuario ya existe
            if (!userDAO.isUsernameAvailable(username)) {
                ctx.status(400).result("El nombre de usuario ya está en uso.");
                return;
            }
            // Crear un nuevo usuario
            User newUser = new User(username, password);
            // Guardar el usuario en la base de datos usando el DAO
            userDAO.save(newUser);
            // Redirigir a la página de la tabla de usuarios con un mensaje de éxito
            ctx.redirect("/users-table");
        });

        app.post("/search-products", ctx -> {
            String query = ctx.formParam("query");
            List<Map<String, Object>> products = ProductDAO.searchProducts(query);
            Map<String, Object> model = new HashMap<>();
            model.put("productos", products);
            ctx.render("search_page.ftl", model);
        });

        app.get("/product-details", ctx -> {
            Boolean isAdmin = ctx.sessionAttribute("isAdmin");
            int productId = Integer.parseInt(ctx.queryParam("id"));
            Map<String, Object> product = getProductDetails(productId);
            Map<String, Object> model = new HashMap<>();
            model.put("producto", product);
            model.put("isAdmin", isAdmin);
            ctx.render("product_details.ftl", model);
        });
    }
}
