package com.farmachelo.dao;

import com.farmachelo.model.Producto;
import com.farmachelo.util.ConexionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductoDAO {
    
    public boolean crear(Producto producto) throws SQLException {
        String sql = "INSERT INTO productos (nombre, precio, imagen, categoria, codigo, stock, laboratorio, vencimiento, descripcion, presentacion) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setDouble(2, producto.getPrecio());
            stmt.setString(3, producto.getImagen());
            stmt.setString(4, producto.getCategoria());
            stmt.setString(5, producto.getCodigo());
            stmt.setInt(6, producto.getStock());
            stmt.setString(7, producto.getLaboratorio());
            stmt.setDate(8, new java.sql.Date(producto.getVencimiento().getTime()));
            stmt.setString(9, producto.getDescripcion());
            stmt.setString(10, producto.getPresentacion());
            
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
    
    public List<Producto> listarTodos() throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT * FROM productos";
        
        try (Connection conn = ConexionDB.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                productos.add(mapearProducto(rs));
            }
        }
        return productos;
    }
    
    public Producto obtenerPorId(int id) throws SQLException {
        String sql = "SELECT * FROM productos WHERE id = ?";
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapearProducto(rs);
                }
            }
        }
        return null;
    }
    
    public boolean actualizar(Producto producto) throws SQLException {
        String sql = "UPDATE productos SET nombre=?, precio=?, imagen=?, categoria=?, codigo=?, stock=?, "
                   + "laboratorio=?, vencimiento=?, descripcion=?, presentacion=? WHERE id=?";
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, producto.getNombre());
            stmt.setDouble(2, producto.getPrecio());
            stmt.setString(3, producto.getImagen());
            stmt.setString(4, producto.getCategoria());
            stmt.setString(5, producto.getCodigo());
            stmt.setInt(6, producto.getStock());
            stmt.setString(7, producto.getLaboratorio());
            stmt.setDate(8, new java.sql.Date(producto.getVencimiento().getTime()));
            stmt.setString(9, producto.getDescripcion());
            stmt.setString(10, producto.getPresentacion());
            stmt.setInt(11, producto.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    public boolean eliminar(int id) throws SQLException {
        String sql = "DELETE FROM productos WHERE id=?";
        
        try (Connection conn = ConexionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
    
    private Producto mapearProducto(ResultSet rs) throws SQLException {
        Producto producto = new Producto();
        producto.setId(rs.getInt("id"));
        producto.setNombre(rs.getString("nombre"));
        producto.setPrecio(rs.getDouble("precio"));
        producto.setImagen(rs.getString("imagen"));
        producto.setCategoria(rs.getString("categoria"));
        producto.setCodigo(rs.getString("codigo"));
        producto.setStock(rs.getInt("stock"));
        producto.setLaboratorio(rs.getString("laboratorio"));
        producto.setVencimiento(rs.getDate("vencimiento"));
        producto.setDescripcion(rs.getString("descripcion"));
        producto.setPresentacion(rs.getString("presentacion"));
        return producto;
    }
}
