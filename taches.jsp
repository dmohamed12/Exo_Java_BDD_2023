<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.time.LocalDate, java.time.temporal.ChronoUnit"%>

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
      width: 450px;
      box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    input, select, button {
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
    tr.terminee {
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
    .message {
      color: green;
      font-weight: bold;
    }
  </style>
</head>

<body>
<h1>🗂️ Gestionnaire de Tâches Collaboratif</h1>

<!-- Formulaire d'ajout -->
<form method="post">
  <label>Titre :</label><br>
  <input type="text" name="titre" required><br>

  <label>Description :</label><br>
  <input type="text" name="desc" required><br>

  <label>Date d’échéance :</label><br>
  <input type="date" name="date"><br>

  <label>Priorité :</label><br>
  <select name="priorite">
    <option value="Normale">Normale</option>
    <option value="Haute">Haute</option>
    <option value="Basse">Basse</option>
  </select><br>

  <input type="submit" name="ajouter" value="Ajouter la tâche">
  <input type="submit" name="reset" value="Réinitialiser la liste">
</form>

<!-- Filtre -->
<form method="get" style="margin-top:20px;">
  <label>Afficher :</label>
  <select name="filtre">
    <option value="toutes">Toutes</option>
    <option value="encours">En cours</option>
    <option value="terminees">Terminées</option>
  </select>
  <input type="submit" value="Filtrer">
</form>

<%! 
class Tache {
  String titre;
  String desc;
  LocalDate date;
  String priorite;
  boolean terminee;

  Tache(String t, String d, LocalDate dt, String p) {
    titre = t;
    desc = d;
    date = dt;
    priorite = p;
    terminee = false;
  }
}
%>

<%
request.setCharacterEncoding("UTF-8");
String message = "";

// Récupération des tâches
ArrayList<Tache> taches = (ArrayList<Tache>) session.getAttribute("taches");
if (taches == null) {
  taches = new ArrayList<Tache>();
  session.setAttribute("taches", taches);
}

// Ajout
if (request.getParameter("ajouter") != null) {
  String titre = request.getParameter("titre");
  String desc = request.getParameter("desc");
  String dateStr = request.getParameter("date");
  String priorite = request.getParameter("priorite");
  LocalDate date = (dateStr == null || dateStr.isEmpty()) ? LocalDate.now() : LocalDate.parse(dateStr);

  taches.add(new Tache(titre, desc, date, priorite));
  message = "✅ Tâche ajoutée avec succès !";
}

// Suppression
if (request.getParameter("supprimer") != null) {
  int index = Integer.parseInt(request.getParameter("supprimer"));
  if (index >= 0 && index < taches.size()) {
    taches.remove(index);
    message = "🗑️ Tâche supprimée avec succès !";
  }
}

// Terminer
if (request.getParameter("terminer") != null) {
  int index = Integer.parseInt(request.getParameter("terminer"));
  if (index >= 0 && index < taches.size()) {
    taches.get(index).terminee = true;
    message = "✅ Tâche marquée comme terminée !";
  }
}

// Réinitialiser
if (request.getParameter("reset") != null) {
  taches.clear();
  message = "♻️ Liste des tâches réinitialisée !";
}

// Filtrage
String filtre = request.getParameter("filtre");
if (filtre == null) filtre = "toutes";

// Compteurs
int total = taches.size();
int terminees = 0;
for (Tache t : taches) if (t.terminee) terminees++;
int encours = total - terminees;

// Trier : terminées en bas
taches.sort((a, b) -> Boolean.compare(a.terminee, b.terminee));
%>

<!-- Message -->
<% if (!message.isEmpty()) { %>
  <p class="message"><%= message %></p>
<% } %>

<!-- Compteurs -->
<p>📊 Total : <%= total %> | 🕓 En cours : <%= encours %> | ✅ Terminées : <%= terminees %></p>

<hr>
<h2>📋 Liste des tâches</h2>

<%
if (taches.isEmpty()) {
%>
  <p>Aucune tâche pour le moment.</p>
<%
} else {
%>
  <table>
    <tr>
      <th>#</th>
      <th>Titre</th>
      <th>Description</th>
      <th>Date</th>
      <th>Jours restants</th>
      <th>Priorité</th>
      <th>Statut</th>
      <th>Actions</th>
    </tr>
  <%
  for (int i = 0; i < taches.size(); i++) {
    Tache t = taches.get(i);
    boolean afficher = 
      filtre.equals("toutes") ||
      (filtre.equals("terminees") && t.terminee) ||
      (filtre.equals("encours") && !t.terminee);

    if (!afficher) continue;

    long joursRestants = ChronoUnit.DAYS.between(LocalDate.now(), t.date);
    String couleurTexte = t.priorite.equals("Haute") ? "red" : (t.priorite.equals("Basse") ? "gray" : "black");
  %>
    <tr class="<%= t.terminee ? "terminee" : "" %>">
      <td><%= i + 1 %></td>
      <td><%= t.titre %></td>
      <td><%= t.desc %></td>
      <td><%= t.date %></td>
      <td>
        <% if (joursRestants > 0) { %>
          <%= joursRestants %> jour(s) restant(s)
        <% } else if (joursRestants == 0) { %>
          ⏰ Aujourd’hui
        <% } else { %>
          ⚠️ En retard de <%= Math.abs(joursRestants) %> jour(s)
        <% } %>
      </td>
      <td style="color:<%= couleurTexte %>"><%= t.priorite %></td>
      <td><%= t.terminee ? "Terminée" : "En cours" %></td>
      <td>
        <% if (!t.terminee) { %>
          <a href="?terminer=<%= i %>">Terminer</a> |
        <% } %>
        <a href="?supprimer=<%= i %>" onclick="return confirm('Supprimer cette tâche ?');">Supprimer</a>
      </td>
    </tr>
  <% } %>
  </table>
<% } %>

</body>
</html>
