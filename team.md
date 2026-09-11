---
title: "Team"
permalink: /team/
---
<p class="team-join-prompt">Interested in joining CAIH Lab as a student, researcher or collaborator? <a class="text-link" href="{{ '/join/' | relative_url }}">Explore opportunities to join the lab <span aria-hidden="true">→</span></a></p>

{% assign members = site.data.members | sort: 'order' %}
{% assign member_groups = members | group_by: 'category' %}
{% for group in member_groups %}
{% if group.name == 'Principal Investigator' %}
<section class="member-group" aria-labelledby="{{ group.name | slugify }}-heading">
  <h2 id="{{ group.name | slugify }}-heading">{{ group.name }}</h2>
  <div class="member-grid">
    {% for member in group.items %}
      {% include member-card.html member=member %}
    {% endfor %}
  </div>
</section>
{% else %}
<details class="member-group member-group-disclosure"{% if group.name == 'PhD Students' %} open{% endif %}>
  <summary><span class="member-group-title" id="{{ group.name | slugify }}-heading">{{ group.name }}</span></summary>
  <div class="member-grid{% if group.name == 'PhD Students' %} member-grid--phd{% else %} member-grid--compact{% endif %}" aria-labelledby="{{ group.name | slugify }}-heading">
    {% for member in group.items %}
      {% if group.name == 'PhD Students' %}
        {% include member-card.html member=member phd=true %}
      {% else %}
        {% include member-card.html member=member compact=true %}
      {% endif %}
    {% endfor %}
  </div>
</details>
{% endif %}
{% endfor %}
