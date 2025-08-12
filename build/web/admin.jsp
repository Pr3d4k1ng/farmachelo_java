<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, model.Producto" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Admin - Farmachelo</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="admin.css">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <c:if test="${empty sessionScope.usuario}">
        <c:redirect url="login.jsp" />
    </c:if>
    
    <!-- Resto del contenido del admin.jsp -->
    <header class="header-top">
        <div class="logo">Farmacia Farmachelo - Admin</div>
        <nav class="menu">
            <ul>
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="admin.jsp">Admin</a></li>
                <li><a href="carrito.jsp">Carrito</a></li>
                <li><a href="logout.jsp">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>

    <div class="admin-container">
        <nav class="admin-tabs">
            <button class="admin-tab-btn active" data-tab="create">Crear</button>
            <button class="admin-tab-btn" data-tab="read">Inventario</button>
            <button class="admin-tab-btn" data-tab="update">Actualizar</button>
            <button class="admin-tab-btn" data-tab="delete">Eliminar</button>
        </nav>

        <div class="admin-tab-content active" id="create">
            <!-- Contenido del formulario de creación -->
            <div class="admin-stats">
                <div class="admin-stat-card">
                    <h3>Total Productos</h3>
                    <p id="total-products">${totalProductos}</p>
                </div>
            </div>

            <section class="admin-section">
                <h3>Agregar Nuevo Producto</h3>
                
                <form id="create-form" action="ProductoServlet" method="POST">
                    <input type="hidden" name="action" value="create">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="product-name">Nombre del Producto</label>
                            <input type="text" id="product-name" name="nombre" placeholder="Ej: Paracetamol 500mg" required>
                        </div>
                        <div class="form-group">
                            <label for="product-code">Código</label>
                            <input type="text" id="product-code" name="codigo" placeholder="Ej: PARS600" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="product-price">Precio ($)</label>
                            <input type="number" id="product-price" name="precio" placeholder="0" required>
                        </div>
                        <div class="form-group">
                            <label for="product-stock">Stock</label>
                            <input type="number" id="product-stock" name="stock" placeholder="0" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="product-category">Categoría</label>
                            <select id="product-category" name="categoria" required>
                                <option value="">Seleccionar categoría</option>
                                <option value="Analgésicos">Analgésicos</option>
                                <option value="Antiinflamatorios">Antiinflamatorios</option>
                                <option value="Antibióticos">Antibióticos</option>
                                <option value="Antialérgicos">Antialérgicos</option>
                                <option value="Antiácidos">Antiácidos</option>
                                <option value="Antidiabéticos">Antidiabéticos</option>
                                <option value="Cardiovasculares">Cardiovasculares</option>
                                <option value="Respiratorios">Respiratorios</option>
                                <option value="Vitaminas">Vitaminas</option>
                                <option value="Dermatológicos">Dermatológicos</option>
                                <option value="Antisépticos">Antisépticos</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="product-lab">Laboratorio</label>
                            <input type="text" id="product-lab" name="laboratorio" placeholder="Ej: Laboratorio ABD" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="product-image">Imagen (nombre del archivo)</label>
                            <input type="text" id="product-image" name="imagen" placeholder="Ej: Paracetamol.jpg" required>
                        </div>
                        <div class="form-group">
                            <label for="product-expiry">Fecha de Vencimiento</label>
                            <input type="date" id="product-expiry" name="vencimiento" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group full-width">
                            <label for="product-desc">Descripción</label>
                            <textarea id="product-desc" name="descripcion" placeholder="Descripción del producto..." required></textarea>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="product-presentation">Presentación</label>
                            <input type="text" id="product-presentation" name="presentacion" placeholder="Ej: Caja con 20 tabletas" required>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-primary">Agregar Producto</button>
                </form>
            </section>
        </div>

        <div class="admin-tab-content" id="read">
            <!-- Contenido del listado de productos -->
            <div class="admin-stats">
                <div class="admin-stat-card">
                    <h3>Total Productos</h3>
                    <p id="total-products-read">${totalProductos}</p>
                </div>
                <div class="admin-stat-card">
                    <h3>Stock Total</h3>
                    <p id="total-stock">${totalStock}</p>
                </div>
                <div class="admin-stat-card">
                    <h3>Productos con Stock Bajo</h3>
                    <p id="low-stock">${productosBajoStock}</p>
                </div>
            </div>

            <section class="admin-section">
                <h3>Inventario de Productos</h3>
                
                <div class="search-bar">
                    <input type="text" id="search-products" placeholder="Buscar por nombre, código o laboratorio...">
                    <button><i class="fas fa-search"></i></button>
                </div>
                
                <div class="table-container">
                    <table class="inventory-table">
                        <thead>
                            <tr>
                                <th>Producto</th>
                                <th>Código</th>
                                <th>Categoría</th>
                                <th>Precio</th>
                                <th>Stock</th>
                                <th>Laboratorio</th>
                                <th>Vencimiento</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody id="products-table-body">
                            <c:forEach var="producto" items="${productos}">
                                <tr>
                                    <td>${producto.nombre}</td>
                                    <td>${producto.codigo}</td>
                                    <td>${producto.categoria}</td>
                                    <td>${producto.precio}</td>
                                    <td>${producto.stock}</td>
                                    <td>${producto.laboratorio}</td>
                                    <td>${producto.vencimiento}</td>
                                    <td>
                                        <button class="btn-action view-btn" data-id="${producto.id}"><i class="fas fa-eye"></i></button>
                                        <button class="btn-action edit-btn" data-id="${producto.id}"><i class="fas fa-edit"></i></button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>

        <div class="admin-tab-content" id="update">
            <!-- Contenido de actualización -->
            <div class="admin-stats">
                <div class="admin-stat-card">
                    <h3>Total Productos</h3>
                    <p id="total-products-update">${totalProductos}</p>
                </div>
            </div>

            <section class="admin-section">
                <h3>Editar Producto</h3>
                <p>Selecciona un producto para editar</p>
                
                <div class="search-bar">
                    <input type="text" id="search-products-update" placeholder="Buscar por nombre, código o laboratorio...">
                    <button><i class="fas fa-search"></i></button>
                </div>
                
                <div class="product-select-list" id="product-list-update">
                    <c:forEach var="producto" items="${productos}">
                        <div class="product-select-item" data-id="${producto.id}">
                            <span>${producto.nombre} (${producto.codigo})</span>
                            <button class="select-btn">Seleccionar</button>
                        </div>
                    </c:forEach>
                </div>
                
                <form id="update-form" action="ProductoServlet" method="POST" style="display: none;">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" id="update-id" name="id">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="update-name">Nombre del Producto</label>
                            <input type="text" id="update-name" name="nombre" required>
                        </div>
                        <div class="form-group">
                            <label for="update-code">Código</label>
                            <input type="text" id="update-code" name="codigo" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="update-price">Precio ($)</label>
                            <input type="number" id="update-price" name="precio" required>
                        </div>
                        <div class="form-group">
                            <label for="update-stock">Stock</label>
                            <input type="number" id="update-stock" name="stock" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="update-category">Categoría</label>
                            <select id="update-category" name="categoria" required>
                                <option value="">Seleccionar categoría</option>
                                <option value="Analgésicos">Analgésicos</option>
                                <option value="Antiinflamatorios">Antiinflamatorios</option>
                                <option value="Antibióticos">Antibióticos</option>
                                <option value="Antialérgicos">Antialérgicos</option>
                                <option value="Antiácidos">Antiácidos</option>
                                <option value="Antidiabéticos">Antidiabéticos</option>
                                <option value="Cardiovasculares">Cardiovasculares</option>
                                <option value="Respiratorios">Respiratorios</option>
                                <option value="Vitaminas">Vitaminas</option>
                                <option value="Dermatológicos">Dermatológicos</option>
                                <option value="Antisépticos">Antisépticos</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="update-lab">Laboratorio</label>
                            <input type="text" id="update-lab" name="laboratorio" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="update-image">Imagen (nombre del archivo)</label>
                            <input type="text" id="update-image" name="imagen" required>
                        </div>
                        <div class="form-group">
                            <label for="update-expiry">Fecha de Vencimiento</label>
                            <input type="date" id="update-expiry" name="vencimiento" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group full-width">
                            <label for="update-desc">Descripción</label>
                            <textarea id="update-desc" name="descripcion" required></textarea>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="update-presentation">Presentación</label>
                            <input type="text" id="update-presentation" name="presentacion" required>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-primary">Guardar Cambios</button>
                </form>
            </section>
        </div>

        <div class="admin-tab-content" id="delete">
            <!-- Contenido de eliminación -->
            <div class="admin-stats">
                <div class="admin-stat-card">
                    <h3>Total Productos</h3>
                    <p id="total-products-delete">${totalProductos}</p>
                </div>
            </div>

            <section class="admin-section">
                <h3>Eliminar Producto</h3>
                <p>Selecciona un producto para eliminar</p>
                
                <div class="search-bar">
                    <input type="text" id="search-products-delete" placeholder="Buscar por nombre, código o laboratorio...">
                    <button><i class="fas fa-search"></i></button>
                </div>
                
                <div class="product-select-list" id="product-list-delete">
                    <c:forEach var="producto" items="${productos}">
                        <div class="product-select-item" data-id="${producto.id}">
                            <span>${producto.nombre} (${producto.codigo})</span>
                            <button class="select-btn">Seleccionar</button>
                        </div>
                    </c:forEach>
                </div>
                
                <div class="delete-confirmation" id="delete-confirmation" style="display: none;">
                    <h3>¿Estás seguro?</h3>
                    <p>Esta acción no se puede deshacer. Se eliminará permanentemente el producto <strong id="product-to-delete"></strong> del inventario.</p>
                    
                    <form id="delete-form" action="ProductoServlet" method="POST">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" id="delete-id" name="id">
                        
                        <div class="confirmation-buttons">
                            <button type="button" class="btn-secondary" id="cancel-delete">Cancelar</button>
                            <button type="submit" class="btn-danger" id="confirm-delete">Eliminar</button>
                        </div>
                    </form>
                </div>
            </section>
        </div>
    </div>

    <footer>
        <div class="footer_top">
            <div class="container">
                <div class="row">
                    <div class="col-md-2">
                        <div class="footer-contact">
                            <h2>CONTACTANOS</h2>
                            <a href="#"><p><i class="fa fa-map-marker" aria-hidden="true"></i>Cartagena, Colombia</p></a>
                            <a href="#"><p><i class="fa fa-phone" aria-hidden="true"></i>+57 320 0095444</p></a>
                            <a href="#"><p><i class="fa fa-envelope" aria-hidden="true"></i>ejemplo@gmail.com</p></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="admin.js"></script>
</body>
</html>