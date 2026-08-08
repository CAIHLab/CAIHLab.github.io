---
title: "News and highlights"
permalink: /news/
---
<div class="highlight-list">
  {% for item in site.data.highlights %}
  <article>
    <p class="highlight-index">{{ forloop.index | prepend: '0' }}</p>
    <div><h2>{{ item.title }}</h2><p>{{ item.text }}</p>{% if item.detail %}<p class="small-text">{{ item.detail }}</p>{% endif %}{% if item.url %}<a class="text-link" href="{{ item.url }}">{{ item.link_label }} <span aria-hidden="true">→</span></a>{% endif %}</div>
  </article>
  {% endfor %}
</div>
