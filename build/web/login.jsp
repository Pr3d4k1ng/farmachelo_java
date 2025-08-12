<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión - Farmachelo</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="style.css">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%
        // Redirigir si ya está autenticado
        if (session.getAttribute("usuario") != null) {
            String redirectURL = (String) session.getAttribute("redirect");
            if (redirectURL != null && !redirectURL.isEmpty()) {
                session.removeAttribute("redirect");
                response.sendRedirect(redirectURL);
            } else {
                response.sendRedirect("admin.jsp");
            }
        }
    %>

    <header class="header-top">
        <div class="logo">Farmacia Farmachelo</div>
        <nav class="menu">
            <ul>
                <li><a href="index.jsp">Inicio</a></li>
                <li><a href="carrito.jsp">Carrito</a></li>
                <li><a href="login.jsp">Iniciar Sesión</a></li>
            </ul>
        </nav>
    </header>

    <div class="login-container">
        <div class="login-box">
            <h2>Iniciar Sesión</h2>
            <form id="login-form" action="AuthServlet" method="POST">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <label for="username">Usuario:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                <div class="form-group">
                    <label for="password">Contraseña:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="btn-login">Ingresar</button>
            </form>
            
            <%-- Mostrar mensaje de error si existe --%>
            <c:if test="${not empty error}">
                <div id="login-error" class="error-message">
                    ${error}
                </div>
            </c:if>
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
    <%-- Script de autenticación ahora manejado por el servlet --%>
</body>
</html>