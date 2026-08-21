---
title: "Team"
permalink: /team/
---
<p>Interested in joining CAIH Lab as a student, researcher or collaborator? <a class="text-link" href="{{ '/join/' | relative_url }}">Explore opportunities to join the lab <span aria-hidden="true">→</span></a></p>

{% assign members = site.data.members | sort: 'order' %}
{% assign member_groups = members | group_by: 'category' %}
{% for group in member_groups %}
<section class="member-group" aria-labelledby="{{ group.name | slugify }}-heading">
  <h2 id="{{ group.name | slugify }}-heading">{{ group.name }}</h2>
  <div class="member-grid{% unless group.name == 'Principal Investigator' %} member-grid--compact{% endunless %}">
    {% for member in group.items %}
      {% if group.name == 'Principal Investigator' %}
        {% include member-card.html member=member %}
      {% else %}
        {% include member-card.html member=member compact=true %}
      {% endif %}
    {% endfor %}
  </div>
</section>
{% endfor %}
