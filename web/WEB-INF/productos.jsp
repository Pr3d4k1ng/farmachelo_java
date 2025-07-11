<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Gestión de Productos</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <header class="header-top">
        <h1>Farmachelo - Panel de Productos</h1>
    </header>
    
    <main>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Precio</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${productos}" var="p">
                    <tr>
                        <td>${p.id}</td>
                        <td>${p.nombre}</td>
                        <td>$${p.precio}</td>
                        <td>
                            <a href="productos?accion=editar&id=${p.id}">Editar</a>
                            <a href="productos?accion=eliminar&id=${p.id}" 
                               onclick="return confirm('¿Eliminar este producto?')">Eliminar</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </main>
</body>
</html>