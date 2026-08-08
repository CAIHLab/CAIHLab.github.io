# Causal AI and Healthcare Lab website

This repository contains the lab’s small, custom Jekyll website. It is designed for native GitHub Pages: there is no remote theme, JavaScript framework, Node build, database or CMS.

## Repository structure

```text
_config.yml                 Site metadata and Jekyll settings
_data/
  highlights.yml            Home-page news and highlights
  members.yml               Team profiles
  navigation.yml            Header links
  publications.yml          Canonical publication records
  research_themes.yml       Home-page research themes
_includes/                  Shared HTML components
_layouts/                   The default shell and page layout
assets/css/main.css         All site styles
assets/js/publications.js   Optional publication filtering
images/                     Lab logo, team photo and favicons
index.md                    Home page
publications.md             Publication index
talks.md                    Talks and presentations
teaching.md                 Teaching
team.md                     Team page
```

## Add a publication

Edit `_data/publications.yml` and add one record. Publications are sorted newest-first automatically. Do not copy a publication to classify it under another topic; add another value to `themes` instead.

```yaml
- id: stable-short-id-2026
  title: "Exact publication title"
  authors:
    - "First Author"
    - "Second Author"
  year: 2026
  venue: "Exact venue text"
  publication_type: "Journal article"
  themes:
    - "Causal AI"
    - "AI in healthcare"
  featured: false
  doi: "10.xxxx/example"       # optional
  arxiv_id: "2601.12345"       # optional
  openalex_id: "W1234567890"   # optional DOI-less fallback
  semantic_scholar_paper_id: "paper-id" # optional DOI-less fallback
  identifier_status: "verified" # verified, fallback, partial, unresolved or none
  metrics_title: "Provider title" # optional validation title when visible text awaits review
  isbn: "9780000000000"       # optional
  page_url: "/publications/id/" # optional future detail page
  links:                        # every link is optional
    paper: ""
    preprint: ""
    code: ""
    data: ""
    poster: ""
    slides: ""
    video: ""
```

Use an ID that will not change. Preserve bibliographic spelling and punctuation from a reliable source. Empty link values are not rendered. If a future record has a dedicated page, set `page_url`; the list component already supports linking its title.

## Publication metrics

Citation counts are rendered from the committed `_data/publication_metrics.json` cache, so publication content remains complete without JavaScript or live API calls. OpenAlex is the primary count and Semantic Scholar is shown as a labelled comparison when available. Provider totals can legitimately differ.

The workflow `.github/workflows/refresh-publication-metrics.yml` refreshes the cache each Monday and commits only when cached values change. It can also be started manually from **Actions → Refresh publication metrics → Run workflow**. For a local preview without writing the cache, run:

```bash
ruby scripts/refresh_publication_metrics.rb --dry-run
```

Maintain DOI values without the `https://doi.org/` prefix. Prefer the publisher DOI; use an arXiv DOI only when no publisher DOI exists. DOI-less records may use `openalex_id` and `semantic_scholar_paper_id`. Records marked `unresolved` or `none` do not receive metrics. Failed requests and title mismatches retain the last successful cached values and print warnings.

Set the optional repository secret `SEMANTIC_SCHOLAR_API_KEY` if higher Semantic Scholar rate limits are needed. Free Altmetric attention badges are rendered directly from publication DOIs and hidden when Altmetric has no mentions. PlumX remains disabled pending approval.

## Add or edit a team member

Edit `_data/members.yml`. Add a unique `order` number to control display order. Put the image in `images/`, use a root-relative path such as `/images/name.jpg`, and write a specific `photo_alt`. Optional profile fields are omitted automatically when blank.

## Add a highlight or news item

Edit `_data/highlights.yml`. Each item needs `title` and `text`; `detail`, `url` and `link_label` are optional. Items appear on the home page in file order.

## Edit a page

Edit the matching root Markdown file. Page metadata sits between the opening `---` lines. Keep the existing `permalink` values so public URLs remain stable. Shared header, footer and metadata live in `_includes/`; site-wide styles live in `assets/css/main.css`.

## Add an image or downloadable file

1. Add an appropriately sized image to `images/`, or a download to a new `files/` directory.
2. Link it with Jekyll’s `relative_url` filter where possible: `{{ '/images/example.jpg' | relative_url }}`.
3. Give informative images meaningful alternative text. Use empty alternative text only for decorative images.
4. Use descriptive filenames and avoid spaces.

## Preview locally

Install Ruby and Bundler, then run:

```bash
bundle install
bundle exec jekyll serve --livereload
```

Open <http://127.0.0.1:4000>. To perform a production-style build without starting a server:

```bash
bundle exec jekyll build
```

Apple’s bundled Ruby 2.6 is old. The Gemfile includes a compatible Nokogiri constraint, but installing a current Ruby with Homebrew or a Ruby version manager is preferable.

## Deploy with GitHub Pages

The repository is configured for native GitHub Pages. Push reviewed changes to the publishing branch (normally `main`). In repository **Settings → Pages**, select **Deploy from a branch**, then choose that branch and the repository root. GitHub builds and publishes the site; no custom Actions workflow is required.

The production URL is configured as `https://caihlab.github.io` in `_config.yml`. There is currently no `CNAME` file. Add one only if the lab adopts a custom domain, and update `url` at the same time.

## Analytics and metadata

Set `google_analytics_id` in `_config.yml` to enable Google Analytics, or leave it blank to load no tracking script. Page titles, descriptions, canonical links, Open Graph/Twitter metadata, organisation structured data, favicons and `sitemap.xml` are generated by the shared head include and `jekyll-sitemap`.
