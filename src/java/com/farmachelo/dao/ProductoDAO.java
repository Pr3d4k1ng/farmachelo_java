package com.farmachelo.dao;

import com.farmachelo.model.Producto;
import com.farmachelo.util.ConexionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {
    
    // CREATE
    public boolean crear(Producto producto) throws SQLException {
        String sql = "INSERT INTO productos (nombre, precio, imagen, categoria) VALUES (?, ?, ?, ?)";
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setDouble(2, producto.getPrecio());
            stmt.setString(3, producto.getImagen());
            stmt.setString(4, producto.getCategoria());
            
            int filasAfectadas = stmt.executeUpdate();
            if (filasAfectadas == 0) return false;
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    producto.setId(generatedKeys.getInt(1));
                }
            }
            return true;
        }
    }
    
    // READ (Todos)
    public List<Producto> listarTodos() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos";
        
        try (Connection conn = ConexionDB.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Producto p = new Producto();
                p.setId(rs.getInt("id"));
                p.setNombre(rs.getString("nombre"));
                p.setPrecio(rs.getDouble("precio"));
                p.setImagen(rs.getString("imagen"));
                p.setCategoria(rs.getString("categoria"));
                productos.add(p);
            }
        }
        return productos;
    }
    
    // UPDATE
    public boolean actualizar(Producto producto) throws SQLException {
        String sql = "UPDATE productos SET nombre=?, precio=?, imagen=?, categoria=? WHERE id=?";
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setDouble(2, producto.getPrecio());
            stmt.setString(3, producto.getImagen());
            stmt.setString(4, producto.getCategoria());
            stmt.setInt(5, producto.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    // DELETE
    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM productos WHERE id=?";
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
}
