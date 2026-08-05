(function () {
  "use strict";

  var form = document.querySelector("[data-publication-filters]");
  var publications = Array.prototype.slice.call(document.querySelectorAll("[data-publication]"));
  var yearHeadings = Array.prototype.slice.call(document.querySelectorAll("[data-year-heading]"));
  var status = document.querySelector("[data-filter-status]");
  var noResults = document.querySelector("[data-no-results]");

  if (!form || publications.length === 0) return;

  function update() {
    var theme = form.querySelector('[data-filter="themes"]').value;
    var year = form.querySelector('[data-filter="year"]').value;
    var type = form.querySelector('[data-filter="type"]').value;
    var visible = 0;

    publications.forEach(function (publication) {
      var themes = publication.dataset.themes.split("|");
      var matches = (!theme || themes.indexOf(theme) !== -1) &&
        (!year || publication.dataset.year === year) &&
        (!type || publication.dataset.type === type);
      publication.hidden = !matches;
      if (matches) visible += 1;
    });

    yearHeadings.forEach(function (heading) {
      heading.hidden = !publications.some(function (publication) {
        return !publication.hidden && publication.dataset.year === heading.dataset.yearHeading;
      });
    });

    status.textContent = visible + (visible === 1 ? " publication" : " publications") + " shown.";
    noResults.hidden = visible !== 0;
  }

  form.addEventListener("change", update);
  form.addEventListener("reset", function () { window.setTimeout(update, 0); });
  update();
}());
