<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les tableaux</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les tableaux</h1>
<form action="#" method="post">
    <p>Saisir au minimu 3 chiffres à la suite, exemple : 6 78 15 <input type="text" id="inputValeur" name="chaine">
    <p><input type="submit" value="Afficher">
</form>
<%-- Récupération des valeurs --%>
    <% String chaine = request.getParameter("chaine"); %>

    <% if (chaine != null) { %>

    <%-- Division de la chaîne de chiffres séparés par des espaces --%>
    <% String[] tableauDeChiffres = chaine.split("\s+"); %>
    <%int[] tab = new int[tableauDeChiffres.length]; %>
        <%for (int i = 0; i < tableauDeChiffres.length; i++) { %>
            <%tab[i] = Integer.parseInt(tableauDeChiffres[i]); %>
       <% } %>
<p>Le tableau contient <%= tab.length %> valeurs :</p>
<p>
    <% for (int i = 0; i < tab.length; i++) { %>
           <% out.println("Valeur " + (i+1) + " : " + tab[i]); %>
       <% } %>
</p>


<h2>Exercice 1 : Le carré de la première valeur</h2>
<p>Ecrire un programme afin d'afficher le carré de la première valeur</p>
<p>Le carré de <%= tab[0] %> est : <%= (tab[0] * tab[0]) %></p>

<h2>Exercice 2 : La somme des 2 premières valeurs</h2>
<p>Ecrire un programme afin d'afficher la somme des deux premières valeurs</p>
<p>Somme = <%= (tab[0] + tab[1]) %></p>
<h2>Exercice 3 : La somme de toutes les valeurs</h2>
<p>L'utilisateur peut à présent saisir autant de valeurs qu'il le souhaite dans champs de saisie.</br>
Ecrire un programme afin de faire la somme de toutes les valeurs saisie par l'utilisateur</p>
<% int somme = 0; %>
    <% for (int n : tab) { %>
            <% somme += n; %>
        <% } %>
<p>La somme de toutes les valeurs est : <%= somme %></p>

<h2>Exercice 4 : La valeur maximale</h2>
<p>Ecrire un programme pour afficher la valeur maximale saisie par l'utilisateur</p>
<% int max = tab[0]; %>
        <% for (int n : tab) { %>
            <% if (n > max) max = n; %>
       <% } %>
    <p>La valeur maximale est : <%= max %></p>

<h2>Exercice 5 : La valeur minimale</h2>
<p>Ecrire un programme pour afficher la valeur minimale saisie par l'utilisateur</p>
<% int min = tab[0]; %>
        <% for (int n : tab) { %>
            <% if (n < min) min = n; %>
       <% } %>
<p>La valeur minimale est : <%= min %></p>
<h2>Exercice 6 : La valeur le plus proche de 0</h2>
<p>Trouvez la valeur la plus proche de 0 (chiffres positifs ou négatifs)</p>
<% int procheZero = tab[0]; %>
        <% for (int n : tab) { %>
            <% if (Math.abs(n) < Math.abs(procheZero)) { %>
                <% procheZero = n; %>
           <% } %>
       <% } %>
<p>La valeur la plus proche de 0 est : <%= procheZero %></p>

<h2>Exercice 7 : La valeur le plus proche de 0 (2° version)</h2>
<p>Trouvez la valeur la plus proche de 0 (chiffres positifs ou négatifs)</p>
<p>En cas d'égalité entre un chiffre positif et négatif, affichez le chiffre positif</p>
<% int procheZero2 = tab[0]; %>
       <% for (int n : tab) { %>
           <% if (Math.abs(n) < Math.abs(procheZero2)) { %>
               <% procheZero2 = n; %>
           <% } else if (Math.abs(n) == Math.abs(procheZero2) && n > procheZero2) { %>
                // Cas d’égalité : garder le positif
               <% procheZero2 = n; %>
           <% } %>
       <% } %>
<p>La valeur la plus proche de 0 (avec priorité au positif) est : <%= procheZero2 %></p>

<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
