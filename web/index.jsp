<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
  <head>
      <meta charset="UTF-8">
      <title>Farmachelo</title>
      <link href="https://fonts.googleapis.com/css?family=Poppins" rel="stylesheet">
      <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900" rel="stylesheet">
      <link rel="stylesheet" href="css/bootstrap.css">
      <link rel="stylesheet" href="css/font-awesome.min.css">
      <link rel="stylesheet" href="style.css">
      <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
      <script src="js/products.js" defer></script>
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

      <div class="barra-busqueda" style="padding: 20px; background-color: #f8f8f8; z-index: 5;">
          <input type="text" id="buscador" placeholder="Buscar productos...">
          <button onclick="buscarProducto()">Buscar</button>
      </div>

      <section class="slider" style="text-align: center;">
          <img src="img/Logo Farmacia.jpg" alt="Slider" style="max-width: 100%;">
          <h3>Acerca de nosotros</h3>
      </section>
      
      <section class="Farmacia de confianza">
          <div class="container">
              <div class="row">
                  <div class="col-md-3">
                      <div class="text,img">
                          <h1> Farmacia de confianza </h1>
                          <h2>¿Quienes somos?</h2>
                          <p>Somos un farmacia con "X" años de experencia atendiendo a los cartageneros, nuestra misión es
                              ayudar a los cartagener@s a lograr conseguir sus medicamentos de forma segura, confiable y
                              rápida razón por la cuál tomamos la desición de abrir esta tienda online.
                              Para de este modo darles sus medicamentos al alcance de su mano para su comodidad y accesibilidad.
                          </p>
                      </div>
                  </div>
                  <div class="col-md-6">
                       <div class="progress_bar">
                        <h2>Nuestros porcentajes</h2>
                        <p>Calidad</p>
                        <div class="progress">
                          <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width: 100%"></div>
                        </div>
                        <p>Confiablidad</p>
                        <div class="progress">
                          <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:90%"></div>
                        </div>
                        <p>Ventas</p>
                        <div class="progress">
                          <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:88%"></div>
                        </div>
                        <p>Clientes satisfechos</p>
                        <div class="progress">
                          <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:91%"></div>
                        </div>
                        </div>
                  </div>
              </div>
          </div>
      </section>

      <section class="Productos">
        <div class="productos" id="productos-container">
          <%-- Aquí puedes incluir código JSP para cargar productos dinámicamente --%>
          <%
            // Ejemplo de cómo podrías cargar productos desde Java
            // List<Producto> productos = (List<Producto>) request.getAttribute("productos");
            // for(Producto producto : productos) {
          %>
            <%-- 
            <div class="producto" data-id="${producto.id}" onclick="cargarPaginaProducto('${producto.id}')">
              <img src="img/${producto.imagen}" alt="${producto.nombre}">
              <h3>${producto.nombre}</h3>
              <p>$${producto.precio}</p>
              <button>Agregar al carrito</button>
            </div>
            --%>
          <%
            // }
          %>
        </div>
      </section>
      
      <footer>
          <div class="footer_top">
              <div class="container">
                  <div class="row">
                      <div class="col-md-2">
                          <div class="footer-contact">
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

      <script>
        document.addEventListener('DOMContentLoaded', () => {
          const container = document.getElementById('productos-container');
          
          // Esto podría reemplazarse con una carga dinámica desde el servidor
          productos.forEach(producto => {
            const productHTML = `
              <div class="producto" data-id="${producto.id}" onclick="cargarPaginaProducto('${producto.id}')">
                <img src="img/${producto.imagen}" alt="${producto.nombre}">
                <h3>${producto.nombre}</h3>
                <p>$${producto.precio.toLocaleString()}</p>
                <button>Agregar al carrito</button>
              </div>
            `;
            container.insertAdjacentHTML('beforeend', productHTML);
          });
        });

        function cargarPaginaProducto(id) {
          localStorage.setItem('productoId', id);
          window.location.href = 'single-product.jsp';
        }
      </script>
      <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
  </body>
</html>