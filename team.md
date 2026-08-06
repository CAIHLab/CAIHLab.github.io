---
title: "Team"
intro: "Meet the people behind the Causal AI and Healthcare Lab."
permalink: /team/
---
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

<section class="video-section" aria-labelledby="fellowship-video">
  <h2 id="fellowship-video">A glimpse into the journey</h2>
  <p>Recorded as part of the MPLS Enterprise and Innovation Fellowship at the University of Oxford.</p>
  <div class="video-wrapper"><iframe src="https://www.youtube-nocookie.com/embed/fclyyIpTwOU?si=Gb6UstDpZTRQIzZ8" title="Dr Vinod Kumar Chauhan discusses his journey as an MPLS Enterprise and Innovation Fellow" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen loading="lazy"></iframe></div>
</section>
