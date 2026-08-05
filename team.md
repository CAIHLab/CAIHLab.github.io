---
title: "Team"
intro: "Meet the people behind the Causal AI and Healthcare Lab."
permalink: /team/
---
{% assign members = site.data.members | sort: 'order' %}
{% for member in members %}{% include member-card.html member=member %}{% endfor %}

<section class="video-section" aria-labelledby="fellowship-video">
  <h2 id="fellowship-video">A glimpse into the journey</h2>
  <p>Recorded as part of the MPLS Enterprise and Innovation Fellowship at the University of Oxford.</p>
  <div class="video-wrapper"><iframe src="https://www.youtube-nocookie.com/embed/fclyyIpTwOU?si=Gb6UstDpZTRQIzZ8" title="Dr Vinod Kumar Chauhan discusses his journey as an MPLS Enterprise and Innovation Fellow" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen loading="lazy"></iframe></div>
</section>
