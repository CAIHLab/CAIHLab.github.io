---
title: "Publications"
intro: "One canonical list of the lab’s publications, grouped by year and available in full without JavaScript."
permalink: /publications/
publication_filters: true
---
<p>A more up-to-date list may be available on <a href="https://scholar.google.com/citations?user=YqlZaKcAAAAJ">Google Scholar</a>.</p>

<form class="publication-filters" data-publication-filters aria-label="Filter publications">
  <div><label for="theme-filter">Theme</label><select id="theme-filter" data-filter="themes"><option value="">All themes</option><option value="causal-ai">Causal AI</option><option value="personalised-treatments">Personalised treatments</option><option value="ai-in-healthcare">AI in healthcare</option><option value="aviation-manufacturing-and-supply-chains">Aviation, manufacturing and supply chains</option><option value="optimisation-for-machine-learning">Optimisation for machine learning</option><option value="handwriting-recognition">Handwriting recognition</option></select></div>
  <div><label for="year-filter">Year</label><select id="year-filter" data-filter="year"><option value="">All years</option>{% assign years = site.data.publications | group_by: 'year' | sort: 'name' | reverse %}{% for year in years %}<option value="{{ year.name }}">{{ year.name }}</option>{% endfor %}</select></div>
  <div><label for="type-filter">Type</label><select id="type-filter" data-filter="type"><option value="">All types</option>{% assign types = site.data.publications | group_by: 'publication_type' | sort: 'name' %}{% for type in types %}<option value="{{ type.name | slugify }}">{{ type.name }}</option>{% endfor %}</select></div>
  <button class="button button-secondary" type="reset">Clear filters</button>
</form>

<p class="filter-status" data-filter-status aria-live="polite"></p>
{% include publication-list.html %}
