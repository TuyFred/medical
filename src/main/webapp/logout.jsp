<%
    HttpSession Session = request.getSession();
    session.invalidate();
    response.sendRedirect("login.jsp");
%>
