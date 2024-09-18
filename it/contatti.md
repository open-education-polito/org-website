---
layout: simple-page
title: Contatti
lang: it
ref: contacts 
permalink: /it/contatti
order: 20
---

Il gruppo si riunisce prevalentemente online. 

Per contattare il gruppo di lavoro è possibile utilizzare l'indirizzo mail meo [AT] polito [DOT] it.

Segue una lista dei membri attivi del progetto e dei collaboratori in
ordine alfabetico.

### Membri 
{% include people.html active='member'%}

{% assign collaborators = site.data.people | where: "active", "collaborator" %}
{% if collaborators.size > 0 %}
### Collaboratori
  {% include people.html active='collaborator' %}
{% endif %}

{% assign ex = site.data.people | where: "active", "ex" %}
{% if ex.size > 0 %}
### Hanno collaborato
  {% include people.html active='ex' %}
{% endif %}

