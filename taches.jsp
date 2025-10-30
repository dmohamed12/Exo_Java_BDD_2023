<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.time.LocalDate"%>

<html>
<head>
  <title>Mini Gestionnaire de Tâches</title>
  <style>
    body { font-family: Arial; background: #f6f6f6; margin: 40px; }
    form, table { background: white; padding: 15px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    input, select { margin: 5px 0; }
    table { width: 100%; margin-top: 30px; border-collapse: collapse; }
    th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
    th { background-color: #007BFF; color: white; }
    tr:nth-child(even) { background-color: #f9f9f9; }
    tr.terminee { background-color: #c8f7c5; }
    a { text-decoration: none; color: #007BFF; }
  </style>
</head>

<body>
<h1>Mini Gestionnaire de Tâches</h1>

<!-- Formulaire d'ajout -->
<form method="post">
  <label>Titre :</label><br>
  <input type="text" name="titre" required><br>

  <label>Description :</label><br>
  <input type="text" name="desc" required><br>

  <label>Date d’échéance :</label><br>
  <input type="date" name="date" required><br>

  <input type="submit" name="ajouter" value="Ajouter la tâche">
</form>

<%!
/* Classe représentant une tâche - avec attributs privés et getters/setters */
class Task {
  private String titre;
  private String description;
  private LocalDate dateEcheance;
  private boolean terminee;

  public Task(String titre, String description, LocalDate dateEcheance) {
    this.titre = titre;
    this.description = description;
    this.dateEcheance = dateEcheance;
    this.terminee = false;
  }

  public String getTitre() { return titre; }
  public String getDescription() { return description; }
  public LocalDate getDateEcheance() { return dateEcheance; }
  public boolean isTerminee() { return terminee; }
  public void setTerminee(boolean terminee) { this.terminee = terminee; }
}
%>

<%
request.setCharacterEncoding("UTF-8");

// Récupérer la liste des tâches depuis la session
ArrayList<Task> taches = (ArrayList<Task>) session.getAttribute("taches");
if (taches == null) {
  taches = new ArrayList<Task>();
  session.setAttribute("taches", taches);
}

// Ajouter une tâche
if (request.getParameter("ajouter") != null) {
  String titre = request.getParameter("titre");
  String desc = request.getParameter("desc");
  LocalDate date = LocalDate.parse(request.getParameter("date"));
  taches.add(new Task(titre, desc, date));
}

// Supprimer une tâche
if (request.getParameter("supprimer") != null) {
  int index = Integer.parseInt(request.getParameter("supprimer"));
  if (index >= 0 && index < taches.size()) {
    taches.remove(index);
  }
}

// Marquer comme terminée
if (request.getParameter("terminer") != null) {
  int index = Integer.parseInt(request.getParameter("terminer"));
  if (index >= 0 && index < taches.size()) {
    taches.get(index).setTerminee(true);
  }
}
%>

<hr>
<h2>Liste des tâches</h2>

<%
if (taches.isEmpty()) {
%>
  <p>Aucune tâche enregistrée pour le moment.</p>
<%
} else {
%>
  <table>
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
    Task t = taches.get(i);
  %>
    <tr class="<%= t.isTerminee() ? "terminee" : "" %>">
      <td><%= i + 1 %></td>
      <td><%= t.getTitre() %></td>
      <td><%= t.getDescription() %></td>
      <td><%= t.getDateEcheance() %></td>
      <td><%= t.isTerminee() ? "Terminée" : "En cours" %></td>
      <td>
        <% if (!t.isTerminee()) { %>
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
