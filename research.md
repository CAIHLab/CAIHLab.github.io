---
title: "Research"
intro: "Our methodological research centres on causal and reliable AI for personalised decision-making, with healthcare as a principal application domain."
permalink: /research/
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

<p><a class="button" href="{{ '/publications/' | relative_url }}">View publications</a></p>
