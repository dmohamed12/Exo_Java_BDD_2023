<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>Les chaines</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les chaines de charactères</h1>

<form action="#" method="post">
    <p>Saisir une chaine (Du texte avec 6 caractères minimum) : 
    <input type="text" id="inputValeur" name="chaine"></p>
    <p><input type="submit" value="Afficher"></p>
</form>

<%
    String chaine = request.getParameter("chaine");
    if (chaine != null) {
        int longueurChaine = chaine.length();
        char caractereExtrait = chaine.charAt(2);
        String sousChaine = chaine.substring(2, 6);
        char recherche = 'e'; 
        int position = chaine.indexOf(recherche);
%>

<p>La longueur de votre chaîne est de <%= longueurChaine %> caractères</p>
<p>Le 3° caractère de votre chaine est la lettre <%= caractereExtrait %></p>
<p>Une sous chaine de votre texte : <%= sousChaine %></p>
<p>Votre premier "e" est en : <%= position %></p>

<h2>Exercice 1 : Combien de 'e' dans notre chaine de charactère ?</h2>
<%
    int countE = 0;
    for (int i = 0; i < chaine.length(); i++) {
        if (chaine.charAt(i) == 'e') {
            countE++;
        }
    }
%>
<p>Votre texte contient <%= countE %> lettre(s) 'e'</p>

<h2>Exercice 2 : Affichage verticale</h2>
<p>
<%
    for (int i = 0; i < chaine.length(); i++) {
        out.println(chaine.charAt(i) + "<br>");
    }
%>
</p>

<h2>Exercice 3 : Retour à la ligne</h2>
<p>
<%
    String[] mots = chaine.split(" ");
    for (String mot : mots) {
        out.println(mot + "<br>");
    }
%>
</p>

<h2>Exercice 4 : Afficher une lettre sur deux</h2>
<p>
<%
    StringBuilder uneSurDeux = new StringBuilder();
    for (int i = 0; i < chaine.length(); i += 2) {
        uneSurDeux.append(chaine.charAt(i));
    }
    out.println(uneSurDeux.toString());
%>
</p>

<h2>Exercice 5 : La phrase en verlant</h2>
<p>
<%
    StringBuilder verlant = new StringBuilder(chaine);
    out.println(velant.reverse().toString());
%>
</p>

<h2>Exercice 6 : Consonnes et voyelles</h2>
<%
    int voyelles = 0, consonnes = 0;
    String voyellesStr = "aeiouyAEIOUY";
    for (int i = 0; i < chaine.length(); i++) {
        char c = chaine.charAt(i);
        if (Character.isLetter(c)) {
            if (voyellesStr.indexOf(c) != -1) {
                voyelles++;
            } else {
                consonnes++;
            }
        }
    }
%>
<p>Votre texte contient <%= voyelles %> voyelle(s) et <%= consonnes %> consonne(s).</p>

<% } %>

<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
