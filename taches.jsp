<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.time.LocalDate"%>

<html>
<head>
  <title>Gestionnaire de Tâches</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 40px;
      background-color: #f4f6f8;
    }
    h1 {
      color: #2c3e50;
    }
    form {
      background: #ffffff;
      padding: 15px;
      border-radius: 10px;
      width: 400px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    input, button {
      margin-top: 10px;
    }
    table {
      border-collapse: collapse;
      width: 100%;
      margin-top: 30px;
      background: white;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 10px;
      text-align: center;
    }
    th {
      background-color: #007BFF;
      color: white;
    }
    tr:nth-child(even) {
      background-color: #f9f9f9;
    }
    tr.terminée {
      background-color: #c6f6c6;
      color: #333;
    }
    a {
      text-decoration: none;
      color: #007BFF;
    }
    a:hover {
      text-decoration: underline;
    }
  </style>
</head>

<body>
<h1>Gestionnaire de Tâches</h1>

<!-- Formulaire -->
<form method="post">
  <label>Titre :</label><br>
  <input type="text" name="titre" required><br>

  <label>Description :</label><br>
  <input type="text" name="desc" required><br>

  <label>Date d’échéance :</label><br>
  <input type="date" name="date"><br>

  <input type="submit" name="ajouter" value="Ajouter la tâche">
  <input type="submit" name="reset" value="Réinitialiser la liste">
</form>

<%! 
class Tache {
  String titre;
  String desc;
  LocalDate date;
  boolean terminee;

  Tache(String t, String d, LocalDate dt) {
    titre = t;
    desc = d;
    date = dt;
    terminee = false;
  }
}
%>

<%
request.setCharacterEncoding("UTF-8");

// Récupérer la liste depuis la session
ArrayList<Tache> taches = (ArrayList<Tache>) session.getAttribute("taches");
if (taches == null) {
  taches = new ArrayList<Tache>();
  session.setAttribute("taches", taches);
}

// Ajouter une tâche
if (request.getParameter("ajouter") != null) {
  String titre = request.getParameter("titre");
  String desc = request.getParameter("desc");
  String dateStr = request.getParameter("date");
  LocalDate date = (dateStr == null || dateStr.isEmpty()) ? LocalDate.now() : LocalDate.parse(dateStr);
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

// Réinitialiser toutes les tâches
if (request.getParameter("reset") != null) {
  taches.clear();
}
%>

<hr>
<h2>Liste des tâches</h2>

<%
if (taches.isEmpty()) {
%>
  <p>Aucune tâche pour le moment ✅</p>
<%
} else {
  // Trier : les tâches non terminées en premier
  taches.sort((a, b) -> Boolean.compare(a.terminee, b.terminee));
%>
  <table>
    <tr>
      <th>#</th>
      <th>Titre</th>
      <th>Description</th>
      <th>Date</th>
      <th>Statut</th>
      <th>Actions</th>
    </tr>
  <%
  for (int i = 0; i < taches.size(); i++) {
    Tache t = taches.get(i);
  %>
    <tr class="<%= t.terminee ? "terminée" : "" %>">
      <td><%= i + 1 %></td>
      <td><%= t.titre %></td>
      <td><%= t.desc %></td>
      <td><%= t.date %></td>
      <td><%= t.terminee ? "Terminée" : "En cours" %></td>
      <td>
        <% if (!t.terminee) { %>
          <a href="?terminer=<%= i %>">Terminer</a> |
        <% } %>
        <a href="?supprimer=<%= i %>">Supprimer</a>
      </td>
    </tr>
  <% } %>
  </table>
<% } %>

</body>
</html>
