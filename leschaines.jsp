<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les chaines</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les chaines de charactères</h1>
<form action="#" method="post">
    <p>Saisir une chaine (Du texte avec 6 caractères minimum) : <input type="text" id="inputValeur" name="chaine">
    <p><input type="submit" value="Afficher">
</form>
<%-- Récupération des valeurs --%>
    <% String chaine = request.getParameter("chaine"); %>
    
    <% if (chaine != null) { %>

    <%-- Obtention de la longueur de la chaîne --%>
    <% int longueurChaine = chaine.length(); %>
    <p>La longueur de votre chaîne est de <%= longueurChaine %> caractères</p>

    
<h2>Exercice 1 : Combien de 'e' dans notre chaine de charactère ?</h2>
<p>Ecrire un programme pour compter le nombre de lettre e dans votre chaine de charactères</p>
<% int compteurE = 0; %>
        <% for (int i = 0; i < chaine.length(); i++) { %>
           <% if (chaine.charAt(i) == 'e' || chaine.charAt(i) == 'E') { %>
               <% compteurE++; %>
           <% } %>
       <% } %>
<p>Il y a <%= compteurE %> lettre(s) 'e' dans la chaîne.</p>

<h2>Exercice 2 : Affichage verticale</h2>
<p>Ecrire le programme pour afficher le texte en vertical</br>
<p>
    <% for (int i = 0; i < chaine.length(); i++) { %>
           <p><% out.println(chaine.charAt(i)); %></br>
       <% } %>
</p>

<h2>Exercice 3 : Retour à la ligne</h2>
<p>La présence d'un espace provoque un retour à la ligne </br>
<p>
    <% String[] mots = chaine.split(" ");  %>
       <% for (String mot : mots) {  %>
           <p> <% out.println(mot); %> </br>
       <% } %>
</p>

<h2>Exercice 4 : Afficher une lettre sur deux</h2>
<p>Ecrire le programme pour afficher seulement une lettre sur deux de votre texte </br>
<p>
    <% for (int i = 0; i < chaine.length(); i += 2) { %>
           <% out.print(chaine.charAt(i)); %>
       <% } %>
</p>
<h2>Exercice 2 : Affichage verticale</h2>
<p>Ecrire le programme pour afficher le texte en vertical</br>
<p>
    <% for (int i = 0; i < chaine.length(); i++) { %>
           <p><% out.println(chaine.charAt(i)); %></br>
       <% } %>
</p>

<h2>Exercice 3 : Retour à la ligne</h2>
<p>La présence d'un espace provoque un retour à la ligne </br>
<p>
    <% String[] mots = chaine.split(" ");  %>
       <% for (String mot : mots) {  %>
           <p> <% out.println(mot); %> </br>
       <% } %>
</p>

<h2>Exercice 4 : Afficher une lettre sur deux</h2>
<p>Ecrire le programme pour afficher seulement une lettre sur deux de votre texte </br>
<p>
    <% for (int i = 0; i < chaine.length(); i += 2) { %>
           <% out.print(chaine.charAt(i)); %>
       <% } %>
</p>

<h2>Exercice 5 : La phrase en verlant</h2>
<p>Ecrire le programme afin d'afficher le texte en verlant </br>
<p>
    <% StringBuilder sb = new StringBuilder(chaine); %>
       <% out.println(sb.reverse().toString()); %>
</p>

<h2>Exercice 6 : Consonnes et voyelles</h2>
<p>Ecrire le programme afin de compter les consonnes et les voyelles dans votre texte</p>
<% int voyelles = 0, consonnes = 0; %>
        <% String voyelleStr = "aeiouyAEIOUY"; %>
        <% for (int i = 0; i < chaine.length(); i++) { %>
            <% char c = chaine.charAt(i); %>
            <% if (Character.isLetter(c)) { %>
                <% if (voyelleStr.indexOf(c) != -1) { %>
                    <% voyelles++; %>
                <% } else { %>
                    <% consonnes++; %>
                <% } %>
            <% } %>
       <% } %>
    <p>Voyelles : <%= voyelles %></p>
    <p>Consonnes : <%= consonnes %></p>


<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
