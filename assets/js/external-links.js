const configureExternalLink = (link) => {
  const url = new URL(link.getAttribute("href"), window.location.href);

  if ((url.protocol === "http:" || url.protocol === "https:") && url.origin !== window.location.origin) {
    link.target = "_blank";
    link.rel = "noopener noreferrer";
  }
};

document.querySelectorAll("a[href]").forEach(configureExternalLink);

document.addEventListener("click", (event) => {
  const link = event.target.closest("a[href]");
  if (link) configureExternalLink(link);
});
