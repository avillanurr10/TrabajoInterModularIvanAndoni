package org.example.dao;

import org.example.entity.Cart;
import org.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CartDAO {

    // Método para añadir un producto al carrito
    public void addToCart(int userId, Map<String, Object> product) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            Cart cartItem = new Cart();
            cartItem.setNombreProducto((String) product.get("nombre"));
            cartItem.setDescripcion((String) product.get("descripccion"));
            cartItem.setPrecio((Double) product.get("precio"));
            cartItem.setCantidad(1); // Cantidad inicial: 1
            cartItem.setIdUsuario(userId);
            cartItem.setProductId((Integer) product.get("id")); // Asegúrate de incluir el ID del producto

            session.save(cartItem);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    // Método para obtener los productos del carrito de un usuario
    public List<Cart> getCartItems(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Cart WHERE idUsuario = :userId";
            Query<Cart> query = session.createQuery(hql, Cart.class);
            query.setParameter("userId", userId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public void processPurchase(int userId) {
        Transaction transaction = null;
        try (var session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            // Obtener los productos del carrito
            List<Cart> cartItems = getCartItems(userId);
            for (var item : cartItems) {
                int productId = item.getProductId();
                int quantity = item.getCantidad();

                // Obtener el producto de la base de datos
                var product = session.get(org.example.entity.Product.class, productId);
                if (product == null || product.getStock() < quantity) {
                    transaction.rollback(); // Revertir la transacción si no hay suficiente stock
                    throw new RuntimeException("No hay suficiente stock para uno o más productos.");
                }

                // Restar el stock del producto
                product.setStock(product.getStock() - quantity);
                session.update(product);
            }

            // Eliminar los productos del carrito
            String hql = "DELETE FROM Cart WHERE idUsuario = :userId";
            session.createQuery(hql).setParameter("userId", userId).executeUpdate();

            transaction.commit(); // Confirmar la transacción
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw e;
        }
    }
}