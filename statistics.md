---
title: "Visitor statistics"
intro: "Aggregated statistics showing the reach of the CAIH Lab website."
permalink: /statistics/
---
{% assign analytics = site.data.site_analytics %}

<p class="statistics-privacy">These figures are collected using privacy-first Cloudflare Web Analytics. No personally identifiable visitor information is displayed.</p>

<dl class="statistics-overview">
  <div><dt>Total visits</dt><dd>{{ analytics.visits | default: '—' }}</dd><small>Since {{ analytics.tracking_since }}</small></div>
  <div><dt>Page views</dt><dd>{{ analytics.page_views | default: '—' }}</dd><small>Since {{ analytics.tracking_since }}</small></div>
  <div><dt>Countries reached</dt><dd>{{ analytics.countries_reached | default: '—' }}</dd><small>Since {{ analytics.tracking_since }}</small></div>
</dl>

<section class="statistics-countries" aria-labelledby="countries-heading">
  <div class="statistics-heading-row">
    <h2 id="countries-heading">Visits by country</h2>
    {% if analytics.updated %}<p>Last updated: {{ analytics.updated }}</p>{% endif %}
  </div>

  {% if analytics.countries and analytics.countries != empty %}
  <ol class="country-statistics">
    {% for country in analytics.countries %}
    <li>
      <div class="country-statistics-label"><span>{{ country.name }}</span><strong>{{ country.visits }}</strong></div>
      <div class="country-statistics-track" aria-hidden="true"><span style="width: {{ country.percentage }}%"></span></div>
    </li>
    {% endfor %}
  </ol>
  <p class="small-text">Only countries with at least five recorded visits are shown separately. Lower counts are grouped under “Other countries”.</p>
  {% else %}
  <p class="statistics-pending">Statistics are now being collected. Aggregated totals and the country breakdown will appear here after the first data update.</p>
  {% endif %}
</section>

<section class="statistics-about" aria-labelledby="statistics-about-heading">
  <h2 id="statistics-about-heading">About these statistics</h2>
  <p>Visit totals may differ from server logs or other analytics services. The public summary contains aggregated counts only and does not expose information about individual visitors.</p>
</section>
