<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.time.LocalDate"%>

<html>
<head>
  <title>Gestionnaire de Tâches</title>
</head>
<body>

<h1>Gestionnaire de Tâches</h1>

<!-- Formulaire d'ajout -->
<form method="post">
  <label>Titre :</label>
  <input type="text" name="titre" required><br><br>

  <label>Description :</label>
  <input type="text" name="desc" required><br><br>

  <label>Date d'échéance :</label>
  <input type="date" name="date" required><br><br>

  <input type="submit" name="ajouter" value="Ajouter la tâche">
</form>

<%! 
class Tache {
  String titre;
  String desc;
  LocalDate date;
  boolean terminee;

  Tache(String t, String d, LocalDate dt) {
    this.titre = t;
    this.desc = d;
    this.date = dt;
    this.terminee = false;
  }
}
%>

<%
request.setCharacterEncoding("UTF-8");

// Récupération de la liste depuis la session
ArrayList<Tache> taches = (ArrayList<Tache>) session.getAttribute("taches");
if (taches == null) {
  taches = new ArrayList<Tache>();
  session.setAttribute("taches", taches);
}

// Ajouter une tâche
if (request.getParameter("ajouter") != null) {
  String titre = request.getParameter("titre");
  String desc = request.getParameter("desc");
  LocalDate date = LocalDate.parse(request.getParameter("date"));
  taches.add(new Tache(titre, desc, date));
}

// Supprimer une tâche
if (request.getParameter("supprimer") != null) {
  int index = Integer.parseInt(request.getParameter("supprimer"));
  if (index >= 0 && index < taches.size()) {
    taches.remove(index);
  }
}

// Marquer une tâche comme terminée
if (request.getParameter("terminer") != null) {
  int index = Integer.parseInt(request.getParameter("terminer"));
  if (index >= 0 && index < taches.size()) {
    taches.get(index).terminee = true;
  }
}
%>

<hr>

<h2>Liste des Tâches</h2>
<table border="1" cellpadding="5">
<tr>
  <th>#</th>
  <th>Titre</th>
  <th>Description</th>
  <th>Date d’échéance</th>
  <th>Statut</th>
  <th>Actions</th>
</tr>

<%
for (int i = 0; i < taches.size(); i++) {
  Tache t = taches.get(i);
%>
<tr bgcolor="<%= t.terminee ? "#ccffcc" : "#ffffff" %>">
  <td><%= i + 1 %></td>
  <td><%= t.titre %></td>
  <td><%= t.desc %></td>
  <td><%= t.date %></td>
  <td><%= t.terminee ? "Terminée" : "En cours" %></td>
  <td>
    <% if (!t.terminee) { %>
      <a href="?terminer=<%= i %>">Terminer</a>
    <% } %>
    <a href="?supprimer=<%= i %>">Supprimer</a>
  </td>
</tr>
<% } %>
</table>

</body>
</html>
