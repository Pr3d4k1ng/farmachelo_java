<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>Producto - Farmachelo</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css">
    <script src="${pageContext.request.contextPath}/js/products.js" defer></script>
</head>
<body>
    <header class="header-top">
        <div class="logo">Farmacia Farmachelo</div>
        <nav class="menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
                <li><a href="${pageContext.request.contextPath}/carrito.jsp">Carrito</a></li>
                <!-- El enlace de Admin solo se mostrará si el usuario está logueado -->
                <li id="admin-link" style="display: none;"><a href="${pageContext.request.contextPath}/admin.jsp">Admin</a></li>
                <li id="login-link"><a href="${pageContext.request.contextPath}/login.jsp">Iniciar Sesión</a></li>
                <li id="logout-link" style="display: none;"><a href="#" id="logout-btn">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>

    <div class="single-product-container">
        <div class="single-product">
            <div class="product-image">
                <img id="product-image" src="${pageContext.request.contextPath}/img/producto1.jpg" alt="Imagen del producto">
            </div>
            
            <div class="product-details">
                <h1 id="product-name">Nombre del Producto</h1>
                <div class="product-price" id="product-price">$10,000</div>
                
                <div class="product-rating">
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star checked"></span>
                    <span class="fa fa-star"></span>
                    <span class="rating-count">(24 valoraciones)</span>
                </div>
                
                <div class="product-description">
                    <p id="product-description">Descripción detallada del producto. Este es un medicamento de alta calidad que ayuda a aliviar los síntomas de X condición. Formulado para máxima eficacia y seguridad.</p>
                </div>
                
                <ul class="product-features">
                    <li><i class="fa fa-check"></i> Alta eficacia comprobada</li>
                    <li><i class="fa fa-check"></i> Efectos secundarios mínimos</li>
                    <li><i class="fa fa-check"></i> Fabricado bajo estrictos controles de calidad</li>
                    <li><i class="fa fa-check"></i> Aprobado por el INVIMA</li>
                </ul>
                
                <div class="product-actions">
                    <div class="quantity-selector">
                        <label for="quantity">Cantidad:</label>
                        <div class="quantity-control">
                            <button class="quantity-btn minus">-</button>
                            <input type="number" id="quantity" value="1" min="1" max="10">
                            <button class="quantity-btn plus">+</button>
                        </div>
                    </div>
                    
                    <button class="btn-add-to-cart" id="add-to-cart">
                        <i class="fa fa-shopping-cart"></i> Añadir al carrito
                    </button>
                    
                    <button class="btn-buy-now" id="buy-now">
                        Comprar ahora
                    </button>
                </div>
                
                <div class="product-meta">
                    <p><strong>Categoría:</strong> <span id="product-category">Medicamentos</span></p>
                    <p><strong>Disponibilidad:</strong> <span class="in-stock">En stock (15 unidades)</span></p>
                    <p><strong>Código del producto:</strong> <span id="product-code">FARM-001</span></p>
                </div>
            </div>
        </div>
        
        <div class="related-products">
            <h2>Productos relacionados</h2>
            <div class="related-grid" id="related-products">
                <!-- Productos relacionados se cargarán aquí -->
            </div>
        </div>
    </div>

    <footer>
        <div class="footer_top">
            <div class="container">
                <div class="row">
                    <div class="col-md-2">
                        <div class="footer">
                            <h2>CONTACTANOS</h2>
                            <a href="#"><p><i class="fa fa-map-marker" aria-hidden="true"></i>Cartagena, Colombia</p></a>
                            <a href="#"><p><i class="fa fa-phone" aria-hidden="true"></i>+57 320 0095444 (este numero solo es un ejemplo)</p></a>
                            <a href="#"><p><i class="fa fa-envelope" aria-hidden="true"></i>ejemplo@gmail.com</p></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <div id="notification" class="notification"></div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Obtener el ID del producto de localStorage (como en tu index.jsp)
            const productId = localStorage.getItem('productoId') || '1';
            
            // Simulación de datos del producto (en un caso real, esto vendría de una petición AJAX al servidor)
            const productos = [
                {
                    id: 1,
                    nombre: "Paracetamol 500mg x 10 tabletas",
                    precio: 10000,
                    imagen: "producto1.jpg",
                    descripcion: "Analgésico y antipirético indicado para el alivio del dolor leve a moderado y fiebre. Cada tableta contiene 500mg de paracetamol.",
                    categoria: "Analgésicos",
                    codigo: "FARM-001",
                    stock: 15
                },
                {
                    id: 2,
                    nombre: "Ibuprofeno 400mg x 12 cápsulas",
                    precio: 15000,
                    imagen: "producto2.jpg",
                    descripcion: "Antiinflamatorio no esteroideo (AINE) indicado para el alivio del dolor, inflamación y fiebre. Cada cápsula contiene 400mg de ibuprofeno.",
                    categoria: "Antiinflamatorios",
                    codigo: "FARM-002",
                    stock: 8
                }
            ];
            
            // Productos relacionados (simulación)
            const relacionados = [
                {id: 3, nombre: "Amoxicilina 500mg x 10 cápsulas", precio: 18000, imagen: "producto3.jpg"},
                {id: 4, nombre: "Omeprazol 20mg x 14 cápsulas", precio: 22000, imagen: "producto4.jpg"},
                {id: 5, nombre: "Loratadina 10mg x 10 tabletas", precio: 12000, imagen: "producto5.jpg"}
            ];
            
            // Cargar datos del producto actual
            const producto = productos.find(p => p.id == productId) || productos[0];
            
            document.getElementById('product-name').textContent = producto.nombre;
            document.getElementById('product-price').textContent = `$${producto.precio.toLocaleString()}`;
            document.getElementById('product-image').src = `${pageContext.request.contextPath}/img/${producto.imagen}`;
            document.getElementById('product-image').alt = producto.nombre;
            document.getElementById('product-description').textContent = producto.descripcion;
            document.getElementById('product-category').textContent = producto.categoria;
            document.getElementById('product-code').textContent = producto.codigo;
            
            // Cargar productos relacionados
            const relatedContainer = document.getElementById('related-products');
            relacionados.forEach(prod => {
                const relatedHTML = `
                    <div class="related-item" onclick="cargarProductoRelacionado(${prod.id})">
                        <img src="${pageContext.request.contextPath}/img/${prod.imagen}" alt="${prod.nombre}">
                        <h3>${prod.nombre}</h3>
                        <div class="price">$${prod.precio.toLocaleString()}</div>
                    </div>
                `;
                relatedContainer.insertAdjacentHTML('beforeend', relatedHTML);
            });
            
            // Manejar cantidad
            const quantityInput = document.getElementById('quantity');
            document.querySelector('.quantity-btn.minus').addEventListener('click', () => {
                if (quantityInput.value > 1) quantityInput.value--;
            });
            document.querySelector('.quantity-btn.plus').addEventListener('click', () => {
                if (quantityInput.value < 10) quantityInput.value++;
            });
            
            // Manejar botón añadir al carrito
            document.getElementById('add-to-cart').addEventListener('click', () => {
                const notification = document.getElementById('notification');
                notification.textContent = `${producto.nombre} añadido al carrito`;
                notification.className = 'notification show success';
                
                setTimeout(() => {
                    notification.className = 'notification';
                }, 3000);
                
                // Aquí iría la lógica real para añadir al carrito
                console.log(`Añadiendo ${quantityInput.value} unidades de ${producto.nombre} al carrito`);
            });
            
            // Manejar botón comprar ahora
            document.getElementById('buy-now').addEventListener('click', () => {
                // Aquí iría la lógica para redirigir al carrito con este producto
                console.log(`Comprando ahora ${quantityInput.value} unidades de ${producto.nombre}`);
                window.location.href = '${pageContext.request.contextPath}/carrito.jsp';
            });
        });
        
        function cargarProductoRelacionado(id) {
            localStorage.setItem('productoId', id);
            window.location.reload();
        }
    </script>
</body>
</html>