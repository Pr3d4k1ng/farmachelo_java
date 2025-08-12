package com.farmachelo.controller;

import com.farmachelo.dao.ProductoDAO;
import com.farmachelo.model.Producto;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductoServlet", urlPatterns = {"/productos"})
public class ProductoServlet extends HttpServlet {
    
    private ProductoDAO productoDAO = new ProductoDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        try {
            if (accion == null) {
                listarProductos(request, response);
            } else {
                switch (accion) {
                    case "nuevo":
                        mostrarFormularioNuevo(request, response);
                        break;
                    case "editar":
                        mostrarFormularioEdicion(request, response);
                        break;
                    case "eliminar":
                        eliminarProducto(request, response);
                        break;
                    default:
                        listarProductos(request, response);
                        break;
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error en la base de datos", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        try {
            if (accion == null) {
                listarProductos(request, response);
            } else {
                switch (accion) {
                    case "crear":
                        crearProducto(request, response);
                        break;
                    case "actualizar":
                        actualizarProducto(request, response);
                        break;
                    default:
                        listarProductos(request, response);
                        break;
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error en la base de datos", e);
        }
    }
    
    private void listarProductos(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        request.setAttribute("productos", productoDAO.listarTodos());
        request.getRequestDispatcher("/WEB-INF/views/productos.jsp").forward(request, response);
    }
    
    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/WEB-INF/views/formularioProducto.jsp").forward(request, response);
    }
    
    private void mostrarFormularioEdicion(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        Producto producto = productoDAO.obtenerPorId(id);
        request.setAttribute("producto", producto);
        request.getRequestDispatcher("/WEB-INF/views/formularioProducto.jsp").forward(request, response);
    }
    
    private void crearProducto(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
        Producto producto = new Producto();
        producto.setNombre(request.getParameter("nombre"));
        producto.setPrecio(Double.parseDouble(request.getParameter("precio")));
        producto.setImagen(request.getParameter("imagen"));
        producto.setCategoria(request.getParameter("categoria"));
        
        productoDAO.crear(producto);
        response.sendRedirect("productos");
    }
    
    private void actualizarProducto(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
        Producto producto = new Producto();
        producto.setId(Integer.parseInt(request.getParameter("id")));
        producto.setNombre(request.getParameter("nombre"));
        producto.setPrecio(Double.parseDouble(request.getParameter("precio")));
        producto.setImagen(request.getParameter("imagen"));
        producto.setCategoria(request.getParameter("categoria"));
        
        productoDAO.actualizar(producto);
        response.sendRedirect("productos");
    }
    
    private void eliminarProducto(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        productoDAO.eliminar(id);
        response.sendRedirect("productos");
    }
}