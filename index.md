---
layout: default
title: "Causal AI and Healthcare Lab"
description: "The Causal AI and Healthcare Lab develops causal AI methods for personalised healthcare and real-world impact."
permalink: /
redirect_from:
  - /about/
  - /about.html
hero: true
---
<section class="hero">
  <div class="hero-inner">
    <div>
      <p class="eyebrow">Causal AI · Healthcare · Personalisation</p>
      <h1>Turning causal insight into better, personalised care.</h1>
      <p class="hero-copy">Our mission is to make data-driven personalised healthcare a reality by uniting clinicians, industry partners and health providers.</p>
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
    <h2 id="mission-heading">Causal methods for real health challenges</h2>
  </div>
  <div class="two-column-copy">
    <p>Through collaboration with clinicians, industry partners and health providers, we develop and apply pioneering causal AI methods to solve real-world health challenges and translate research into direct social impact.</p>
    <p>We work at the intersection of causality, healthcare and AI, blending theory and practice with the long-term aim of making personalised healthcare a reality.</p>
  </div>
</section>

<section class="section section-tint" aria-labelledby="themes-heading">
  <div class="page-shell">
    <div class="section-heading">
      <p class="eyebrow">Research</p>
      <h2 id="themes-heading">Research themes</h2>
    </div>
    <div class="card-grid">
      {% for theme in site.data.research_themes %}
      <article class="theme-card"><span class="card-number">0{{ forloop.index }}</span><h3>{{ theme.name }}</h3><p>{{ theme.description }}</p></article>
      {% endfor %}
    </div>
    <details class="research-scope">
      <summary>View our wider research scope</summary>
      <ul>
        <li>Personalised treatments and individualised treatment effect estimation</li>
        <li>Causal inference and discovery from observational data at scale</li>
        <li>Counterfactual reasoning for fairness, explainability and clinical decision support</li>
        <li>Causal foundation models and causal digital twins</li>
        <li>Uncertainty quantification and conformal prediction</li>
        <li>Multimodal, federated and continual learning</li>
        <li>Synthetic data generation, causal benchmarking and evaluation</li>
        <li>Optimisation methods for causal and AI models</li>
        <li>Domain adaptation and out-of-distribution detection</li>
      </ul>
    </details>
  </div>
</section>

<section class="section page-shell" aria-labelledby="highlights-heading">
  <div class="section-heading heading-row">
    <div><p class="eyebrow">Latest</p><h2 id="highlights-heading">Recent highlights</h2></div>
  </div>
  <div class="highlight-list">
    {% for item in site.data.highlights %}
    <article>
      <p class="highlight-index">{{ forloop.index | prepend: '0' }}</p>
      <div><h3>{{ item.title }}</h3><p>{{ item.text }}</p>{% if item.detail %}<p class="small-text">{{ item.detail }}</p>{% endif %}{% if item.url %}<a class="text-link" href="{{ item.url }}">{{ item.link_label }} <span aria-hidden="true">→</span></a>{% endif %}</div>
    </article>
    {% endfor %}
  </div>
</section>

<section class="section section-dark" aria-labelledby="featured-heading">
  <div class="page-shell">
    <div class="section-heading heading-row"><div><p class="eyebrow">Selected work</p><h2 id="featured-heading">Featured publications</h2></div><a class="text-link light-link" href="{{ '/publications/' | relative_url }}">View all publications <span aria-hidden="true">→</span></a></div>
    {% include publication-list.html featured_only=true %}
  </div>
</section>

<section class="section page-shell opportunity" aria-labelledby="join-heading">
  <div><p class="eyebrow">Opportunities</p><h2 id="join-heading">Join us</h2></div>
  <div><p>We are looking for curious, motivated researchers and students to join us in shaping the future of causal AI for healthcare.</p><h3>PhD studentship opportunity</h3><p>Dr Vinod Kumar Chauhan is recruiting a PhD student in <strong>Causal AI for personalised healthcare</strong>. If you are interested, please get in touch at your earliest convenience to arrange a discussion.</p><a class="button" href="mailto:vinod.kumar@strath.ac.uk">Contact the lab</a></div>
</section>
