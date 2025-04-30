
package org.example.dao;

import org.example.entity.User;
import org.example.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDAO {

    public void save(User user) {
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            session.beginTransaction();
            session.persist(user); // Persistir el usuario
            session.getTransaction().commit(); // Confirmar la transacción
        } catch (Exception e) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback(); // Revertir la transacción en caso de error
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close(); // Cerrar la sesión después de usarla
            }
        }
    }

    // Buscar un usuario por nombre de usuario
    public User findByUsername(String username) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String query = "FROM User WHERE username = :username";
            return session.createQuery(query, User.class)
                    .setParameter("username", username)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Verificar si un nombre de usuario está disponible
    public boolean isUsernameAvailable(String username) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String query = "FROM User WHERE username = :username";
            User user = session.createQuery(query, User.class)
                    .setParameter("username", username)
                    .uniqueResult();
            return user == null;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Obtener todos los usuarios
    public List<Map<String, Object>> getAllUsers() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String query = "FROM User";
            List<User> users = session.createQuery(query, User.class).list();

            // Convertir la lista de usuarios a una lista de mapas
            return users.stream()
                    .map(user -> {
                        Map<String, Object> userInfo = new HashMap<>();
                        userInfo.put("id", user.getId());
                        userInfo.put("username", user.getUsername());
                        userInfo.put("password", user.getPassword());
                        userInfo.put("loginCount", user.getLoginCount());
                        userInfo.put("lastLogin", user.getLastLogin());
                       /* userInfo.put("createdDate", user.getCreatedDate());
                        userInfo.put("createdTime", user.getCreatedTime());*/
                        userInfo.put("isAdmin", user.isAdmin());
                        return userInfo;
                    })
                    .toList();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // Eliminar un usuario por ID
    public void deleteUser(int userId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            User user = session.get(User.class, userId);
            if (user != null) {
                session.delete(user);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
        }
    }

    public Map<String, Object> getUserDetails(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String query = "FROM User WHERE id = :userId";
            User user = session.createQuery(query, User.class)
                    .setParameter("userId", userId)
                    .uniqueResult();

            if (user == null) {
                System.out.println("Usuario no encontrado para el ID: " + userId);
                return null;
            }

            // Crear un mapa con los detalles del usuario
            Map<String, Object> userDetails = new HashMap<>();
            userDetails.put("id", user.getId());
            userDetails.put("username", user.getUsername());
            userDetails.put("password", user.getPassword());
            userDetails.put("loginCount", user.getLoginCount());
            userDetails.put("lastLogin", user.getLastLogin());
           /* userDetails.put("createdDate", user.getCreatedDate());
            userDetails.put("createdTime", user.getCreatedTime());
            userDetails.put("isAdmin", user.isAdmin());*/

            return userDetails;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}