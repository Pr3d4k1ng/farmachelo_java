package com.farmachelo.model;

import java.util.ArrayList;
import java.util.List;

public class Carrito {
    private Producto producto;
    private int cantidad;
 private final List<ItemCarrito> items;

    public Carrito() {
        this.items = new ArrayList<>();
    }
 
    public void agregarItem(Producto producto, int cantidad) {
        // Lógica para agregar o actualizar items
    }
    
    public void eliminarItem(int productoId) {
        // Lógica para eliminar items
    }
    
    public void getTotal() {
        // Calcular total
    }
 
    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
    public double getSubtotal() {
        return producto.getPrecio() * cantidad;
    }

    private static class ItemCarrito {

        public ItemCarrito() {
        }
    }
}