<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Boucles</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les boucles</h1>

<form action="#" method="post">
    <label for="inputValeur">Saisir le nombre d'étoiles : </label>
    <input type="text" id="inputValeur" name="valeur">
    <input type="submit" value="Afficher">
</form>

<%
    String valeur = request.getParameter("valeur");
    if (valeur != null && !valeur.isEmpty()) {
        int cpt = Integer.parseInt(valeur);
%>

<p>
<% for (int i = 1; i <= cpt; i++) { %>
    <%= "*" %>
<% } %>
</p>

<h2>Exercice 1 : Le carré d'étoiles</h2>
<p>
<% for (int i = 1; i <= cpt; i++) { %>
    <% for (int j = 1; j <= cpt; j++) { %>
        <%= "*" %>
    <% } %>
    <br/>
<% } %>
</p>

<h2>Exercice 2 : Triangle rectangle gauche</h2>
<p>
<% for (int i = 1; i <= cpt; i++) { %>
    <% for (int j = 1; j <= i; j++) { %>
        <%= "*" %>
    <% } %>
    <br/>
<% } %>
</p>

<h2>Exercice 3 : Triangle rectangle inversé</h2>
<p>
<% for (int i = cpt; i >= 1; i--) { %>
    <% for (int j = 1; j <= i; j++) { %>
        <%= "*" %>
    <% } %>
    <br/>
<% } %>
</p>

<h2>Exercice 4 : Triangle rectangle droite</h2>
<p>
<% for (int i = 1; i <= cpt; i++) { %>
    <% for (int j = 1; j <= cpt - i; j++) { %>
        <%= "&nbsp;" %>
    <% } %>
    <% for (int k = 1; k <= i; k++) { %>
        <%= "*" %>
    <% } %>
    <br/>
<% } %>
</p>

<h2>Exercice 5 : Triangle isocele</h2>
<p>
<% for (int i = 1; i <= cpt; i++) { %>
    <% for (int j = 1; j <= cpt - i; j++) { %>
        <%= "&nbsp;" %>
    <% } %>
    <% for (int k = 1; k <= i; k++) { %>
        <%= "*" %>
    <% } %>
    <br/>
<% } %>
</p>

<h2>Exercice 6 : Demi losange</h2>
<p>
<% for (int i = 1; i <= cpt; i++) { %>
    <% for (int j = 1; j <= cpt - i; j++) { %>
        <%= "&nbsp;" %>
    <% } %>
    <% for (int k = 1; k <= i; k++) { %>
        <%= "*" %>
    <% } %>
    <br/>
<% } %>
<% for (int i = cpt; i >= 1; i--) { %>
    <% for (int j = 1; j <= cpt - i; j++) { %>
        <%= "&nbsp;" %>
    <% } %>
    <% for (int k = 1; k <= i; k++) { %>
        <%= "*" %>
    <% } %>
    <br/>
<% } %>
</p>

<h2>Exercice 7 : Table de multiplication</h2>
<p>
<% for (int i = 1; i <= cpt; i++) { %>
    <%= cpt %> x <%= i %> = <%= cpt * i %><br/>
<% } %>
</p>

<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
