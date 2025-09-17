<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>les conditions</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les conditions</h1>
<form action="#" method="post">
    <p>Saisir la valeur A : <input type="text" id="inputValeur" name="valeurA">
    <p>Saisir la valeur B : <input type="text" id="inputValeur" name="valeurB">
    <p>Saisir la valeur C : <input type="text" id="inputValeur" name="valeurC">
    <p>Saisir un nombre pour vérifier Pair/Impair : <input type="text" name="valeurPair">
    <p><input type="submit" value="Afficher">
</form>
<%-- Récupération des valeurs --%>
    <% String valeurA = request.getParameter("valeurA"); %>
    <% String valeurB = request.getParameter("valeurB"); %>
    <% String valeurC = request.getParameter("valeurC"); %>
    <% String valeurPair = request.getParameter("valeurPair"); %>

    <%-- Vérification de la condition entre les 3 valeurs --%>
    <% if (valeurA != null && valeurB != null && valeurC != null && !valeurA.isEmpty() && !valeurB.isEmpty() && !valeurC.isEmpty()) { %>

        <% int A = Integer.parseInt(valeurA); %>
        <% int B = Integer.parseInt(valeurB); %>
        <% int C = Integer.parseInt(valeurC); %>

<h2>Exercice 1 : Comparaison 1</h2>
<p>A = <%= A %>, B = <%= B %>, C = <%= C %></p>
    <% if ((C >= A && C <= B) || (C >= B && C <= A)) { %>
        <p>Oui,C est compris entre A et B.</p>
    <% } else { %>
        <p>Non, C n'est pas compris entre A et B.</p>
    <% } %>
<% } %>

<%-- Vérification de la saisie pour Exercice 2 --%>
<% if (valeurPair != null && !valeurPair.isEmpty()) { %>
    <% int nbre = Integer.parseInt(valeurPair); %>

<h2>Exercice 2 : Pair ou Impair ?</h2>
<p>Le nombre saisi est <%= nbre %>.</p>
    <% if (nbre % 2 == 0) { %>
        <p> Ce nombre est pair.</p>
    <% } else { %>
        <p> Ce nombre est impair.</p>
    <% } %>
<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
