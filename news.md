---
title: "News and highlights"
permalink: /news/
news_filters: true
---
<form class="publication-filters news-filters" data-news-filters aria-label="Filter news and highlights">
  <div><label for="news-category-filter">Category</label><select id="news-category-filter" data-filter="category"><option value="">All categories</option>{% assign categories = site.data.highlights | group_by: 'category' | sort: 'name' %}{% for category in categories %}<option value="{{ category.name | slugify }}">{{ category.name }}</option>{% endfor %}</select></div>
  <div><label for="news-year-filter">Year</label><select id="news-year-filter" data-filter="year"><option value="">All years</option>{% assign years = site.data.highlights | group_by: 'year' | sort: 'name' | reverse %}{% for year in years %}<option value="{{ year.name }}">{{ year.name }}</option>{% endfor %}</select></div>
  <button class="button button-secondary" type="reset">Clear filters</button>
</form>
<p class="filter-status" data-news-filter-status aria-live="polite"></p>

<div class="highlight-list">
  {% for item in site.data.highlights %}
  <article data-news-item data-category="{{ item.category | slugify }}" data-year="{{ item.year }}">
    <p class="highlight-index">{{ forloop.index | prepend: '0' }}</p>
    <div><p class="eyebrow">{{ item.category }} · {{ item.date_label | default: item.year }}</p><h2>{{ item.title }}</h2><p>{{ item.text }}</p>{% if item.detail %}<p class="small-text">{{ item.detail }}</p>{% endif %}{% if item.url %}<a class="text-link" href="{{ item.url }}">{{ item.link_label }} <span aria-hidden="true">→</span></a>{% endif %}</div>
  </article>
  {% endfor %}
</div>
<p data-news-no-results hidden>No news or highlights match those filters.</p>
