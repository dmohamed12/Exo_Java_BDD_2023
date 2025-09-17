<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les tableaux</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les tableaux</h1>

<form action="#" method="post">
    <p>Saisir au minimum 3 chiffres à la suite, exemple : 6 78 15 
    <input type="text" id="inputValeur" name="chaine"></p>
    <p><input type="submit" value="Afficher"></p>
</form>

<%
    String chaine = request.getParameter("chaine");

    if (chaine != null) {
        String[] tableauDeChiffres = chaine.trim().split("\\s+");
        int[] tab = new int[tableauDeChiffres.length];
        for (int i = 0; i < tableauDeChiffres.length; i++) {
            tab[i] = Integer.parseInt(tableauDeChiffres[i]);
        }
%>

<p>Le tableau contient <%= tab.length %> valeurs :</p>
<p>
<% for (int i = 0; i < tab.length; i++) { %>
    Valeur <%= (i+1) %> : <%= tab[i] %><br>
<% } %>
</p>

<h2>Exercice 1 : Le carré de la première valeur</h2>
<p>Le carré de <%= tab[0] %> est : <%= (tab[0] * tab[0]) %></p>

<h2>Exercice 2 : La somme des 2 premières valeurs</h2>
<p>Somme = <%= (tab[0] + tab[1]) %></p>

<h2>Exercice 3 : La somme de toutes les valeurs</h2>
<%
    int somme = 0;
    for (int n : tab) {
        somme += n;
    }
%>
<p>La somme de toutes les valeurs est : <%= somme %></p>

<h2>Exercice 4 : La valeur maximale</h2>
<%
    int max = tab[0];
    for (int n : tab) {
        if (n > max) max = n;
    }
%>
<p>La valeur maximale est : <%= max %></p>

<h2>Exercice 5 : La valeur minimale</h2>
<%
    int min = tab[0];
    for (int n : tab) {
        if (n < min) min = n;
    }
%>
<p>La valeur minimale est : <%= min %></p>

<h2>Exercice 6 : La valeur la plus proche de 0</h2>
<%
    int procheZero = tab[0];
    for (int n : tab) {
        if (Math.abs(n) < Math.abs(procheZero)) {
            procheZero = n;
        }
    }
%>
<p>La valeur la plus proche de 0 est : <%= procheZero %></p>

<h2>Exercice 7 : La valeur la plus proche de 0 (2° version)</h2>
<%
    int procheZero2 = tab[0];
    for (int n : tab) {
        if (Math.abs(n) < Math.abs(procheZero2)) {
            procheZero2 = n;
        } else if (Math.abs(n) == Math.abs(procheZero2) && n > procheZero2) {
            procheZero2 = n;
        }
    }
%>
<p>La valeur la plus proche de 0 (avec priorité au positif) est : <%= procheZero2 %></p>

<% } %>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
