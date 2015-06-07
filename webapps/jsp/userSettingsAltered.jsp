<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>

<%
    /**
     * Alter user data
     * validating the user input is done in userSettings.jsp
     * PASSWORD IS STORED IN MD5! That's weak! Do not use this for anything.
     * Just don't.
     *
     * If there is an error with sql, this page will redirect the user to register.jsp
     * to alter his/her input
     **/
    String email       = request.getParameter("email");
    String nick        = request.getParameter("nick");
    String oldPassword = request.getParameter("oldPassword");
    String password    = request.getParameter("password");
    String name        = request.getParameter("name");
    String surname     = request.getParameter("surname");
    String address     = request.getParameter("address");
    int floor          = Integer.parseInt(request.getParameter("floor"));
    int zipCode        = Integer.parseInt(request.getParameter("zipCode"));

    SQLConnection sqlConnection = new SQLConnection(response.getWriter());
    oldPassword = sqlConnection.encryptMD5(oldPassword);
    password = sqlConnection.encryptMD5(password);

    String userId = (String) session.getAttribute("userID");
    String query = "update users set "
                +"email="      +"\""+email      +"\","
                +"nick="       +"\""+nick       +"\","
                +"password="   +"\""+password   +"\","
                +"name="       +"\""+name       +"\","
                +"surname="    +"\""+surname    +"\","
                +"address="    +"\""+address    +"\","
                +"floor="      +"\""+floor      +"\","
                +"zipCode="    +"\""+zipCode    +"\" where id="+userId+";";    

    try 
    {
        ResultSet resultSet = sqlConnection.selectAllFromWhere("users","id",userId);
        if ( resultSet.next() && resultSet.getString("password").equals(oldPassword) )
        {
            sqlConnection.sqlUpdate(query);
            out.println("User data altered!");
        } else
        {
                    out.println("Invalid password <a href='userSettings.jsp'>try again</a>");
        }
 
    } catch(SQLException e)
    {
        out.println("Error Error Error");
        session.setAttribute("sqlErrorCode",String.valueOf(e.getErrorCode()));
        response.sendRedirect("userSettings.jsp");
    }



%>
