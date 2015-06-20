<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div id="modal1" class="modal bottom-sheet">
  <div class="modal-content">
    <h4>Cart</h4>
    <div id="cartDiv"></div>
  </div>
  <div class="modal-footer">
    <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat">Abbort</a>
    <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat" onclick="clearCart()">Clear cart</a>
    <a href="#!" class=" modal-action modal-close waves-effect waves-green btn-flat" onclick="submitCart()">Buy</a>
  </div>
</div>

<footer class="page-footer">
  <div class="container">
    <div class="row">
      <div class="col l6 s12">
        <h5 class="white-text">Footer</h5>
        <p class="grey-text text-lighten-4"> HAW MS4,RDB 2015.</p>
      </div>
      <div class="col l4 offset-l2 s12">
        <h5 class="white-text">Used Software</h5>
        <ul>
          <li><a class="grey-text text-lighten-3" href="http://materializecss.com/about.html">Materialize</a></li>
          <li><a class="grey-text text-lighten-3" href="https://www.mysql.de/">MySQL</a></li>
          <li><a class="grey-text text-lighten-3" href="http://www.oracle.com/technetwork/java/javaee/jsp/index.html">JSP</a></li>
          <li><a class="grey-text text-lighten-3" href="https://jquery.com/">JQUERY</a></li>
          <li><a class="grey-text text-lighten-3" href="https://github.com/kuemmel/naturalBeverages">Source on github</a></li>
        </ul>
      </div>
    </div>
  </div>
  <div class="footer-copyright">
    <div class="container">
        © 2015 some copyright
    </div>
  </div>
</footer>