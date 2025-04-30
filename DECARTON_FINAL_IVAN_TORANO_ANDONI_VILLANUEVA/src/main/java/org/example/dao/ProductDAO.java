package org.example.dao;

import org.example.entity.Product;
import org.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ProductDAO {

    // Método para obtener todos los productos
    public static List<Map<String, Object>> getAllProducts() {
        List<Map<String, Object>> products = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Product"; // Consulta HQL para obtener todos los productos
            List<Product> productList = session.createQuery(hql, Product.class).list();

            for (Product product : productList) {
                Map<String, Object> productMap = new HashMap<>();
                productMap.put("id", product.getId());
                productMap.put("nombre", product.getNombre());
                productMap.put("descripccion", product.getDescripccion());
                productMap.put("precio", product.getPrecio());
                productMap.put("stock", product.getStock());
                products.add(productMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Método para eliminar un producto por ID
    public void deleteProduct(int productId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Product product = session.get(Product.class, productId);
            if (product != null) {
                session.delete(product);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public boolean updateStock(int productId, int quantity) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            session.beginTransaction();

            // Obtener el producto actual
            String query = "FROM Product WHERE id = :productId";
            Product product = session.createQuery(query, Product.class)
                    .setParameter("productId", productId)
                    .uniqueResult();

            if (product != null) {
                // Aumentar el stock
                product.setStock(product.getStock() + quantity);
                session.merge(product); // Actualizar el producto
                session.getTransaction().commit();
                return true;
            } else {
                session.getTransaction().rollback();
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }



    public static List<Map<String, Object>> searchProducts(String query) {
        List<Map<String, Object>> products = new ArrayList<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "FROM Product WHERE nombre LIKE :query OR descripccion LIKE :query";
            Query<Product> productQuery = session.createQuery(hql, Product.class);
            productQuery.setParameter("query", "%" + query + "%");

            List<Product> productList = productQuery.list();
            for (Product product : productList) {
                Map<String, Object> productMap = new HashMap<>();
                productMap.put("id", product.getId());
                productMap.put("nombre", product.getNombre());
                productMap.put("descripccion", product.getDescripccion());
                productMap.put("precio", product.getPrecio());
                productMap.put("stock", product.getStock());
                products.add(productMap);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }

    // Método para obtener los detalles de un producto por ID
    public static Map<String, Object> getProductDetails(int productId) {
        Map<String, Object> productDetails = new HashMap<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Product product = session.get(Product.class, productId);
            if (product != null) {
                productDetails.put("id", product.getId());
                productDetails.put("nombre", product.getNombre());
                productDetails.put("descripccion", product.getDescripccion());
                productDetails.put("precio", product.getPrecio());
                productDetails.put("stock", product.getStock());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productDetails;
    }

    public List<Map<String, Object>> getProductsSortedByPrice(boolean ascending) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String order = ascending ? "ASC" : "DESC";
            String hql = "FROM Product ORDER BY precio " + order;
            List<Product> products = session.createQuery(hql, Product.class).list();

            // Convertir la lista de productos a una lista de mapas
            return products.stream()
                    .map(product -> {
                        Map<String, Object> productInfo = new HashMap<>();
                        productInfo.put("id", product.getId());
                        productInfo.put("nombre", product.getNombre());
                        productInfo.put("descripccion", product.getDescripccion());
                        productInfo.put("precio", product.getPrecio());
                        productInfo.put("stock", product.getStock());
                        return productInfo;
                    })
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Map<String, Object>> getProductsSortedByStock(boolean ascending) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String order = ascending ? "ASC" : "DESC";
            String hql = "FROM Product ORDER BY stock " + order;
            List<Product> products = session.createQuery(hql, Product.class).list();

            // Convertir la lista de productos a una lista de mapas
            return products.stream()
                    .map(product -> {
                        Map<String, Object> productInfo = new HashMap<>();
                        productInfo.put("id", product.getId());
                        productInfo.put("nombre", product.getNombre());
                        productInfo.put("descripccion", product.getDescripccion());
                        productInfo.put("precio", product.getPrecio());
                        productInfo.put("stock", product.getStock());
                        return productInfo;
                    })
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Map<String, Object>> getProductsSortedByName(boolean ascending) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String order = ascending ? "ASC" : "DESC";
            String hql = "FROM Product ORDER BY nombre " + order;
            List<Product> products = session.createQuery(hql, Product.class).list();

            // Convertir la lista de productos a una lista de mapas
            return products.stream()
                    .map(product -> {
                        Map<String, Object> productInfo = new HashMap<>();
                        productInfo.put("id", product.getId());
                        productInfo.put("nombre", product.getNombre());
                        productInfo.put("descripccion", product.getDescripccion());
                        productInfo.put("precio", product.getPrecio());
                        productInfo.put("stock", product.getStock());
                        return productInfo;
                    })
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}