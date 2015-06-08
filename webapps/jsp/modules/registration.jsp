<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>

<%
    /**
     * Register users into the database. 
     * validating the user input is done in register.jsp
     * PASSWORD IS STORED IN MD5! That's weak! Do not use this for anything.
     * Just don't.
     *
     * If there is an error with sql, this page will redirect the user to register.jsp
     * to alter his input
     **/
    String email       = request.getParameter("email");
    String nick        = request.getParameter("nick");
    String password    = request.getParameter("password");
    String name        = request.getParameter("name");
    String surname     = request.getParameter("surname");
    String birthString = request.getParameter("dateOfBirth");
    String address     = request.getParameter("address");
    int floor       = Integer.parseInt((String) request.getParameter("floor"));
    int zipCode     = Integer.parseInt((String) request.getParameter("zipCode"));

    DateFormat dateFormat     = new SimpleDateFormat("yyyy-mm-dd",Locale.GERMAN);
    java.sql.Date dateOfBirth = new java.sql.Date(dateFormat.parse(birthString).getTime());
    SQLConnection sqlConnection = new SQLConnection(response.getWriter());
    password = sqlConnection.encryptMD5(password);
    String query = "insert into users (email,nick,password,name,surname,dateOfBirth,address,floor,zipCode) values (\""
                +email+"\",\""
                +nick+"\",\""
                +password+"\",\""
                +name+"\",\""
                +surname+"\",\""
                +dateOfBirth+"\",\""
                +address+"\",\""
                +floor+"\",\""
                +zipCode+"\");";
    
    try 
    {
        sqlConnection.sqlUpdate(query);
        response.sendRedirect("regComplete.jsp");
    } catch(SQLException e)
    {
        session.setAttribute("sqlErrorCode",String.valueOf(e.getErrorCode()));
        response.sendRedirect("../register.jsp");
    }



%>
