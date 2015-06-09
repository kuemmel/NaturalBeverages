<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*,java.sql.*,java.text.*,java.io.*,naturalBeverages.*"%>
<%

  SQLConnection sqlConnection = new SQLConnection(response.getWriter());
  ResultSet resultSet = sqlConnection.sqlQuery("select FlugNr, Datum, Pilotname, Flugstunden, Maschinentyp, Sitze from Pilot natural join Maschine natural join FlugEinsatzPlan;");


  while(resultSet.next())
  {
    Product product = new Product(resultSet);
%>

  <div class="row">
    <div class="col s4 m4 l4">
      <div class="card brown darken-3 white-text">
        <div class="row">
          <div class="col">
            <div class="card-image row" style="margin-top:20px;">
              <img src="<%%>" style="max-height:250px;max-width:250px;">
            </div>
            <span class="card-title" style="padding-left:10px;">Name: 1L</span> <!--style="background-color:blue;"-->
          </div>
          <div class="card-content col" ><!--style="background-color:red;"-->
            <table>
              <tr><td>In Stock!</td></tr>
              <tr><td>firm</td></tr>
              <tr><td>price</td><td>1.20€</td></tr>
              <tr><td>refund</td><td>1.20€</td></tr>
              <tr><td>price per crate(anzahl)</td><td>1.20€</td></tr>
              <tr><td>refund per crate</td><td>1.20€</td></tr>
              <tr><td></td><td>firm</td></tr>
            </table>
          </div>
        </div>
        <div class="row">
          <div class="card-action" > <!--style="background-color:green;"-->
            <a href="#">Buy</a>
          </div>
        </div>
      </div>
    </div>
  </div>
<%
}
%>