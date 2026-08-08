(function () {
  "use strict";

  var form = document.querySelector("[data-news-filters]");
  var items = Array.prototype.slice.call(document.querySelectorAll("[data-news-item]"));
  var status = document.querySelector("[data-news-filter-status]");
  var noResults = document.querySelector("[data-news-no-results]");

  if (!form || items.length === 0) return;

  function update() {
    var category = form.querySelector('[data-filter="category"]').value;
    var year = form.querySelector('[data-filter="year"]').value;
    var visible = 0;

    items.forEach(function (item) {
      var matches = (!category || item.dataset.category === category) &&
        (!year || item.dataset.year === year);
      item.hidden = !matches;
      if (matches) visible += 1;
    });

    status.textContent = visible + (visible === 1 ? " item" : " items") + " shown.";
    noResults.hidden = visible !== 0;
  }

  form.addEventListener("change", update);
  form.addEventListener("reset", function () { window.setTimeout(update, 0); });
  update();
}());
