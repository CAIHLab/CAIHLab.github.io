---
layout: default
title: "Causal AI and Healthcare Lab"
description: "The Causal AI and Healthcare Lab develops causal and reliable AI methods for personalised decision-making, with healthcare as a central application."
permalink: /
redirect_from:
  - /about/
  - /about.html
hero: true
---
<section class="hero">
  <div class="hero-inner">
    <div>
      <p class="eyebrow">Causal AI · Personalised Decisions · Healthcare</p>
      <h1>From causal insight to personalised decisions.</h1>
      <p class="hero-copy">We develop causal and reliable AI methods for personalised decision-making, with healthcare as a central application.</p>
      <div class="button-row">
        <a class="button" href="{{ '/publications/' | relative_url }}">Explore our research</a>
        <a class="button button-secondary" href="{{ '/team/' | relative_url }}">Meet the lab</a>
      </div>
    </div>
    <img class="hero-logo" src="{{ '/images/chaii.png' | relative_url }}" alt="CAIH Lab logo: causal graph rising from a healthcare cup" width="1024" height="1024">
  </div>
</section>

<section class="section page-shell" aria-labelledby="mission-heading">
  <div class="section-heading">
    <p class="eyebrow">Our mission</p>
    <h2 id="mission-heading">Causal AI for better personalised decisions</h2>
  </div>
  <div class="two-column-copy">
    <p>We develop and apply causal AI methods to understand how interventions affect individuals, compare possible actions and support decisions under uncertainty.</p>
    <p>Our work combines methodological research with real-world applications, particularly in healthcare, where reliable personalised decisions can improve treatment selection and clinical decision support.</p>
  </div>
</section>

<section class="section section-tint" aria-labelledby="themes-heading">
  <div class="page-shell">
    <div class="section-heading">
      <p class="eyebrow">Research</p>
      <h2 id="themes-heading">Causal and reliable AI for personalised decisions</h2>
    </div>
    <p class="lead">Our research spans causal AI, agentic AI and personalised decision-making, with healthcare as a central application domain.</p>
    <a class="button" href="{{ '/research/' | relative_url }}">Explore our research</a>
  </div>
</section>

<section class="section page-shell" aria-labelledby="highlights-heading">
  <div class="section-heading heading-row">
    <div><p class="eyebrow">Latest</p><h2 id="highlights-heading">Recent highlights</h2></div>
  </div>
  <div class="highlight-list">
    {% for item in site.data.highlights limit: 5 %}
    <article>
      <p class="highlight-index">{{ forloop.index | prepend: '0' }}</p>
      <div><h3>{{ item.title }}</h3><p>{{ item.text }}</p>{% if item.detail %}<p class="small-text">{{ item.detail }}</p>{% endif %}{% if item.url %}<a class="text-link" href="{{ item.url }}">{{ item.link_label }} <span aria-hidden="true">→</span></a>{% endif %}</div>
    </article>
    {% endfor %}
  </div>
  <p><a class="text-link" href="{{ '/news/' | relative_url }}">View all news and highlights <span aria-hidden="true">→</span></a></p>
</section>

<section class="section section-dark" aria-labelledby="featured-heading">
  <div class="page-shell">
    <div class="section-heading heading-row"><div><p class="eyebrow">Selected work</p><h2 id="featured-heading">Featured publications</h2></div><a class="text-link light-link" href="{{ '/publications/' | relative_url }}">View all publications <span aria-hidden="true">→</span></a></div>
    {% include publication-list.html featured_only=true %}
  </div>
</section>

<section class="section page-shell opportunity" aria-labelledby="join-heading">
  <div><p class="eyebrow">Opportunities</p><h2 id="join-heading">Join us</h2></div>
  <div><p>We welcome motivated students, researchers and collaborators interested in advancing causal AI, agentic AI and personalised decision-making, including their application to healthcare.</p><a class="button" href="{{ '/join/' | relative_url }}">Explore opportunities</a></div>
</section>
