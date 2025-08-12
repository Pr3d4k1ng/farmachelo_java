<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Carrito de Compras - Farmachelo</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="style.css">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <header class="header-top">
        <div class="logo">Farmacia Farmachelo</div>
        <nav class="menu">
            <ul>
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="carrito.jsp">Carrito</a></li>
                <!-- El enlace de Admin solo se mostrará si el usuario está logueado -->
                <li id="admin-link" style="display: none;"><a href="admin.jsp">Admin</a></li>
                <li id="login-link"><a href="login.jsp">Iniciar Sesión</a></li>
                <li id="logout-link" style="display: none;"><a href="#" id="logout-btn">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>

    <div class="carrito-container">
        <h2 class="carrito-titulo">Tu Carrito de Compras</h2>
        
        <div class="carrito-items-container">
            <div class="carrito-items" id="carrito-items">
                <%-- Mostrar mensaje de carrito vacío o los productos --%>
                <c:choose>
                    <c:when test="${empty carrito or empty carrito.items}">
                        <div class="carrito-vacio">
                            <i class="fa fa-shopping-cart"></i>
                            <p>Tu carrito está vacío</p>
                            <a href="index.jsp#productos" class="btn-continuar">Ver productos</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <%-- Iterar sobre los productos del carrito --%>
                        <c:forEach items="${carrito.items}" var="item">
                            <div class="item-carrito" data-id="${item.producto.id}">
                                <img src="img/${item.producto.imagen}" alt="${item.producto.nombre}">
                                <div class="info-item">
                                    <h4>${item.producto.nombre}</h4>
                                    <p>Precio unitario: $${item.producto.precio}</p>
                                    <div class="cantidad-item">
                                        <button class="btn-cantidad" onclick="modificarCantidad(${item.producto.id}, -1)">-</button>
                                        <span>${item.cantidad}</span>
                                        <button class="btn-cantidad" onclick="modificarCantidad(${item.producto.id}, 1)">+</button>
                                    </div>
                                </div>
                                <div class="precio-item">
                                    <p>$${item.producto.precio * item.cantidad}</p>
                                    <button class="btn-eliminar" onclick="eliminarDelCarrito(${item.producto.id})">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="carrito-resumen" id="carrito-resumen">
                <h3>Resumen de tu compra</h3>
                <div class="resumen-detalle">
                    <p>Subtotal: <span id="subtotal">$${carrito.subtotal}</span></p>
                    <p>Envío: <span id="envio">$${carrito.envio}</span></p>
                    <p class="total">Total: <span id="total">$${carrito.total}</span></p>
                </div>
                <div class="metodo-entrega">
                    <h4>Método de entrega</h4>
                    <select id="metodo-entrega" onchange="calcularTotal()">
                        <option value="domicilio">Entrega a domicilio ($5,000)</option>
                        <option value="recoger">Recoger en tienda (Gratis)</option>
                    </select>
                </div>
                <button class="btn-finalizar" onclick="finalizarCompra()">Finalizar Compra</button>
                <button class="btn-vaciar" onclick="vaciarCarrito()">Vaciar Carrito</button>
            </div>
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

    <script>
        // Función para modificar la cantidad de un producto en el carrito
        function modificarCantidad(productoId, cambio) {
            // Implementar lógica para actualizar cantidad en el servidor
            window.location.href = 'ActualizarCarritoServlet?action=update&id=' + productoId + '&cantidad=' + cambio;
        }

        // Función para eliminar un producto del carrito
        function eliminarDelCarrito(productoId) {
            // Implementar lógica para eliminar producto en el servidor
            window.location.href = 'ActualizarCarritoServlet?action=remove&id=' + productoId;
        }

        // Función para vaciar el carrito
        function vaciarCarrito() {
            // Implementar lógica para vaciar carrito en el servidor
            window.location.href = 'ActualizarCarritoServlet?action=clear';
        }

        // Función para finalizar la compra
        function finalizarCompra() {
            const metodoEntrega = document.getElementById('metodo-entrega').value;
            // Implementar lógica para finalizar compra
            window.location.href = 'FinalizarCompraServlet?metodo=' + metodoEntrega;
        }

        // Función para calcular el total según método de entrega
        function calcularTotal() {
            // Esta función podría implementarse con JavaScript puro o llamar al servidor
            const metodoEntrega = document.getElementById('metodo-entrega').value;
            window.location.href = 'ActualizarCarritoServlet?action=calcular&metodo=' + metodoEntrega;
        }
    </script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>