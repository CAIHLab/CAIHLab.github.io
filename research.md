---
title: "Research"
intro: "Our methodological research centres on causal and reliable AI for personalised decision-making, with healthcare as a principal application domain."
permalink: /research/
publication_filters: true
altmetric_badges: true
---
<aside class="research-status" aria-label="Page status">
  <strong>Page under construction</strong>
  <p>We are developing this page further. The overview below provides the lab's current research scope.</p>
</aside>

<section class="research-page-section" aria-labelledby="research-themes-heading">
  <p class="eyebrow">Core areas</p>
  <h2 id="research-themes-heading">Research themes</h2>
  <div class="card-grid">
    {% for theme in site.data.research_themes %}
    <article class="theme-card"><span class="card-number">0{{ forloop.index }}</span><h3>{{ theme.name }}</h3><p>{{ theme.description }}</p></article>
    {% endfor %}
  </div>
</section>

<section class="research-page-section" aria-labelledby="wider-scope-heading">
  <p class="eyebrow">Technical breadth</p>
  <h2 id="wider-scope-heading">Wider research scope</h2>
  <ul class="research-scope-list">
    <li>Personalised decision-making and individualised treatment-effect estimation</li>
    <li>Causal inference and discovery from large-scale observational data</li>
    <li>Counterfactual reasoning for fairness, explainability and decision support</li>
    <li>Causal foundation models and digital twins</li>
    <li>Decision-making under uncertainty and conformal prediction</li>
    <li>Agentic and collaborative AI systems</li>
    <li>Multimodal, federated and continual learning</li>
    <li>Synthetic data, causal benchmarking and evaluation</li>
    <li>Robustness, domain adaptation and out-of-distribution detection</li>
    <li>Applications in personalised healthcare and clinical decision support</li>
  </ul>
</section>

<details id="publications" class="research-publications">
  <summary>Publications</summary>
  <div class="research-publications-content">
    <p>A more up-to-date list may be available on <a href="https://scholar.google.com/citations?user=YqlZaKcAAAAJ">Google Scholar</a>.</p>
    {% if site.data.publication_metrics.refreshed_at %}<p class="data-note">Citation counts are provided by OpenAlex and Semantic Scholar and may differ between services. Altmetric reports online attention rather than citations. Citation data last updated: {{ site.data.publication_metrics.refreshed_at | date: "%e %B %Y" | strip }}.</p>{% endif %}
    <form class="publication-filters" data-publication-filters aria-label="Filter publications">
      <div><label for="theme-filter">Theme</label><select id="theme-filter" data-filter="themes"><option value="">All themes</option><option value="causal-ai">Causal AI</option><option value="agentic-ai">Agentic AI</option><option value="personalised-treatments">Personalised treatments</option><option value="ai-in-healthcare">AI in healthcare</option><option value="aviation-manufacturing-and-supply-chains">Aviation, manufacturing and supply chains</option><option value="optimisation-for-machine-learning">Optimisation for machine learning</option><option value="handwriting-recognition">Handwriting recognition</option></select></div>
      <div><label for="year-filter">Year</label><select id="year-filter" data-filter="year"><option value="">All years</option>{% assign years = site.data.publications | group_by: 'year' | sort: 'name' | reverse %}{% for year in years %}<option value="{{ year.name }}">{{ year.name }}</option>{% endfor %}</select></div>
      <div><label for="type-filter">Type</label><select id="type-filter" data-filter="type"><option value="">All types</option>{% assign types = site.data.publications | group_by: 'publication_type' | sort: 'name' %}{% for type in types %}<option value="{{ type.name | slugify }}">{{ type.name }}</option>{% endfor %}</select></div>
      <button class="button button-secondary" type="reset">Clear filters</button>
    </form>
    <p class="filter-status" data-filter-status aria-live="polite"></p>
    {% include publication-list.html %}
  </div>
</details>
