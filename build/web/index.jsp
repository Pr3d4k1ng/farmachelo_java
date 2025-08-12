<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>Farmachelo</title>
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

    <div class="barra-busqueda" style="padding: 20px; background-color: #f8f8f8; z-index: 5;">
        <input type="text" id="buscador" placeholder="Buscar productos...">
        <button onclick="buscarProducto()">Buscar</button>
    </div>

    <section class="slider" style="text-align: center;">
        <img src="${pageContext.request.contextPath}/img/Logo Farmacia.jpg" alt="Slider" style="max-width: 100%;">
        <h3>Acerca de nosotros</h3>
    </section>
    
    <section class="farmacia-confianza">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="text">
                        <h2>Farmacia de confianza</h2>
                        <h3>¿Quiénes somos?</h3>
                        <p>Somos una farmacia con más de 10 años de experiencia atendiendo a los cartageneros. Nuestra misión es ayudar a los cartageneros a conseguir sus medicamentos de forma segura, confiable y rápida, razón por la cual tomamos la decisión de abrir esta tienda online para poner los medicamentos al alcance de su mano.</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="progress_bar">
                        <h2>Nuestros porcentajes</h2>
                        <p>Calidad</p>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
                        </div>
                        <p>Confiabilidad</p>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100" style="width:90%"></div>
                        </div>
                        <p>Ventas</p>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" aria-valuenow="88" aria-valuemin="0" aria-valuemax="100" style="width:88%"></div>
                        </div>
                        <p>Clientes satisfechos</p>
                        <div class="progress">
                            <div class="progress-bar" role="progressbar" aria-valuenow="91" aria-valuemin="0" aria-valuemax="100" style="width:91%"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="productos">
        <div class="container">
            <h2 class="text-center mb-4">Nuestros Productos</h2>
            <div class="productos-grid" id="productos-container">
                <!-- Los productos se cargarán aquí mediante JavaScript -->
            </div>
        </div>
    </section>
    
    <footer>
        <div class="footer_top">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="footer-contact">
                            <h2>CONTÁCTANOS</h2>
                            <p><i class="fa fa-map-marker" aria-hidden="true"></i> Cartagena, Colombia</p>
                            <p><i class="fa fa-phone" aria-hidden="true"></i> +57 320 0095444</p>
                            <p><i class="fa fa-envelope" aria-hidden="true"></i> ejemplo@farmachelo.com</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="footer_bottom">
            <div class="container">
                <div class="copy_txt">
                    <p>&copy; 2023 Farmachelo. Todos los derechos reservados.</p>
                </div>
            </div>
        </div>
    </footer>

    <div id="notification" class="notification"></div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Datos de productos simulados (en producción deberían venir del servidor)
            const productos = [
                {
                    id: 1, 
                    nombre: "Paracetamol 500mg x 10 tabletas", 
                    precio: 10000, 
                    imagen: "producto1.jpg",
                    categoria: "Analgésicos"
                },
                {
                    id: 2, 
                    nombre: "Ibuprofeno 400mg x 12 cápsulas", 
                    precio: 15000, 
                    imagen: "producto2.jpg",
                    categoria: "Antiinflamatorios"
                },
                {
                    id: 3, 
                    nombre: "Amoxicilina 500mg x 10 cápsulas", 
                    precio: 18000, 
                    imagen: "producto3.jpg",
                    categoria: "Antibióticos"
                },
                {
                    id: 4, 
                    nombre: "Omeprazol 20mg x 14 cápsulas", 
                    precio: 22000, 
                    imagen: "producto4.jpg",
                    categoria: "Antiácidos"
                }
            ];
            
            renderProductos(productos);
            
            // Verificar si el usuario es admin (esto debería venir del servidor)
            const esAdmin = false; // Cambiar a true para probar
            if(esAdmin) {
                document.getElementById('admin-link').style.display = 'block';
                document.getElementById('login-link').style.display = 'none';
                document.getElementById('logout-link').style.display = 'block';
            }
        });

        function renderProductos(productos) {
            const container = document.getElementById('productos-container');
            container.innerHTML = '';
            
            productos.forEach(producto => {
                const productHTML = `
                    <div class="producto" data-id="${producto.id}">
                        <img src="${pageContext.request.contextPath}/img/${producto.imagen}" alt="${producto.nombre}" onclick="cargarPaginaProducto('${producto.id}')">
                        <h3 onclick="cargarPaginaProducto('${producto.id}')">${producto.nombre}</h3>
                        <p>$${producto.precio.toLocaleString()}</p>
                        <button onclick="agregarAlCarrito(${producto.id})">
                            <i class="fa fa-shopping-cart"></i> Agregar al carrito
                        </button>
                        <span class="producto-categoria">${producto.categoria}</span>
                    </div>
                `;
                container.insertAdjacentHTML('beforeend', productHTML);
            });
        }
        
        function cargarPaginaProducto(id) {
            localStorage.setItem('productoId', id);
            window.location.href = '${pageContext.request.contextPath}/single-product.jsp';
        }
        
        function agregarAlCarrito(id) {
            const notification = document.getElementById('notification');
            notification.textContent = 'Producto añadido al carrito';
            notification.className = 'notification show success';
            
            setTimeout(() => {
                notification.className = 'notification';
            }, 3000);
            
            // Aquí iría la lógica real para añadir al carrito
            console.log(`Producto ${id} añadido al carrito`);
        }
        
        function buscarProducto() {
            const termino = document.getElementById('buscador').value.toLowerCase();
            const productos = document.querySelectorAll('.producto');
            let encontrados = 0;
            
            productos.forEach(producto => {
                const nombre = producto.querySelector('h3').textContent.toLowerCase();
                const categoria = producto.querySelector('.producto-categoria').textContent.toLowerCase();
                
                if(nombre.includes(termino) || categoria.includes(termino)) {
                    producto.style.display = 'block';
                    encontrados++;
                } else {
                    producto.style.display = 'none';
                }
            });
            
            if(encontrados === 0) {
                const notification = document.getElementById('notification');
                notification.textContent = 'No se encontraron productos con ese nombre';
                notification.className = 'notification show error';
                
                setTimeout(() => {
                    notification.className = 'notification';
                }, 3000);
            }
        }
    </script>
</body>
</html>