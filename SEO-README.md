# Charles Wabera — Clean SEO Foundation

This package intentionally contains NO PowerShell installer and NO patch script.

Copy these files into the existing `Cwabera.github.io` repository:
- `robots.txt`
- `sitemap.xml`
- `site.webmanifest`
- `.nojekyll`
- `seo/*.head.html`

The `seo` folder contains the page-specific `<head>` metadata to merge into each HTML page.
Do not overwrite the visual CSS or existing portfolio assets.

Canonical domain configured:
https://cwabera.github.io

Before publishing, confirm that GitHub Pages is configured to serve the `main` branch from the repository root.
