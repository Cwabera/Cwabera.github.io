$ErrorActionPreference = "Stop"

$site = "https://cwabera.github.io"
$common = @"
<meta name="robots" content="index, follow, max-image-preview:large, max-snippet:-1, max-video-preview:-1">
<meta name="author" content="Charles Wabera">
<meta name="theme-color" content="#050506">
<link rel="icon" type="image/png" href="assets/charles-favicon.png">
<link rel="apple-touch-icon" href="assets/charles-favicon.png">
<link rel="manifest" href="site.webmanifest">
"@

$pages = @{
  "index.html" = @{
    Title = "Charles Wabera | Software Engineer, Systems Builder & Full-Stack Developer"
    Description = "Charles Wabera is a software engineer and full-stack builder in Kenya, working across React, Python, Flask, APIs, authentication and relational data systems."
    Canonical = "$site/"
    Type = "website"
  }
  "about.html" = @{
    Title = "About Charles Wabera | Software Engineer & Builder"
    Description = "Learn about Charles Wabera, a software engineer building frontend applications, backend services, REST APIs and relational data systems from Kenya."
    Canonical = "$site/about.html"
    Type = "profile"
  }
  "expertise.html" = @{
    Title = "Charles Wabera | Software Engineering Capabilities"
    Description = "Explore Charles Wabera's engineering capabilities across full-stack development, backend APIs, databases, frontend engineering, authentication and delivery."
    Canonical = "$site/expertise.html"
    Type = "website"
  }
  "projects.html" = @{
    Title = "Projects | Charles Wabera Software Engineering Portfolio"
    Description = "Explore selected software projects by Charles Wabera, including full-stack applications and backend APIs built with React, Flask, Python, SQLAlchemy and PostgreSQL."
    Canonical = "$site/projects.html"
    Type = "website"
  }
  "engineering.html" = @{
    Title = "Engineering | Charles Wabera | React, Python, Flask & SQL"
    Description = "See how Charles Wabera approaches software engineering across React interfaces, Python services, REST APIs, SQL, SQLite, PostgreSQL and SQLAlchemy."
    Canonical = "$site/engineering.html"
    Type = "website"
  }
  "repositories.html" = @{
    Title = "GitHub Repositories | Charles Wabera"
    Description = "Browse Charles Wabera's public GitHub repository trail, including software projects, engineering experiments and code across JavaScript, Python, HTML and CSS."
    Canonical = "$site/repositories.html"
    Type = "website"
  }
  "contact.html" = @{
    Title = "Contact Charles Wabera | Software Engineer"
    Description = "Connect with Charles Wabera for software engineering projects, technical collaboration and professional opportunities in Kenya and beyond."
    Canonical = "$site/contact.html"
    Type = "website"
  }
}

$personJson = @"
{
  "@context": "https://schema.org",
  "@type": "Person",
  "@id": "$site/#charles-wabera",
  "name": "Charles Wabera",
  "alternateName": "Cwabera",
  "url": "$site/",
  "jobTitle": "Software Engineer",
  "description": "Software engineer and full-stack builder working across frontend applications, backend services, APIs, authentication and relational data systems.",
  "image": "$site/assets/charles-portrait.png",
  "sameAs": [
    "https://github.com/Cwabera",
    "https://www.linkedin.com/in/charles-wabera"
  ],
  "knowsAbout": [
    "Software Engineering",
    "Full-Stack Development",
    "Python",
    "Flask",
    "React",
    "JavaScript",
    "REST APIs",
    "SQL",
    "SQLite",
    "PostgreSQL",
    "SQLAlchemy",
    "JWT Authentication",
    "Git",
    "GitHub"
  ]
}
"@

$websiteJson = @"
{
  "@context": "https://schema.org",
  "@type": "WebSite",
  "@id": "$site/#website",
  "url": "$site/",
  "name": "Charles Wabera",
  "description": "Executive engineering portfolio of Charles Wabera.",
  "publisher": { "@id": "$site/#charles-wabera" }
}
"@

$profileJson = @"
{
  "@context": "https://schema.org",
  "@type": "ProfilePage",
  "url": "$site/about.html",
  "name": "About Charles Wabera",
  "mainEntity": { "@id": "$site/#charles-wabera" }
}
"@

foreach ($entry in $pages.GetEnumerator()) {
  $path = $entry.Key
  if (!(Test-Path $path)) { continue }

  $html = Get-Content -Raw -Encoding UTF8 $path

  # Remove a previous SEO block so the script is safe to run repeatedly.
  $html = [regex]::Replace($html, '(?s)\s*<!-- CHARLES SEO V1 START -->.*?<!-- CHARLES SEO V1 END -->', '')

  $p = $entry.Value
  $ogImage = "$site/assets/charles-logo.png"

  $seo = @"
<!-- CHARLES SEO V1 START -->
$common
<title>$($p.Title)</title>
<meta name="description" content="$($p.Description)">
<link rel="canonical" href="$($p.Canonical)">
<meta property="og:type" content="$($p.Type)">
<meta property="og:site_name" content="Charles Wabera">
<meta property="og:title" content="$($p.Title)">
<meta property="og:description" content="$($p.Description)">
<meta property="og:url" content="$($p.Canonical)">
<meta property="og:image" content="$ogImage">
<meta property="og:image:alt" content="Charles Wabera — Software Engineer">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="$($p.Title)">
<meta name="twitter:description" content="$($p.Description)">
<meta name="twitter:image" content="$ogImage">
<script type="application/ld+json">
$websiteJson
</script>
<script type="application/ld+json">
$personJson
</script>
$(if ($path -eq "about.html") { "<script type=`"application/ld+json`>`n$profileJson`n</script>" })
<!-- CHARLES SEO V1 END -->
"@

  $html = $html -replace '</head>', "$seo`n</head>"
  $html = $html -replace '<title>.*?</title>', '', 1
  Set-Content -Path $path -Value $html -Encoding UTF8
}

# GitHub Pages is already serving a static site. This makes the intent explicit
# and avoids Jekyll processing surprises for this HTML/CSS/JS portfolio.
if (!(Test-Path ".nojekyll")) {
  New-Item ".nojekyll" -ItemType File | Out-Null
}

Write-Host ""
Write-Host "Charles Wabera SEO V1 installed." -ForegroundColor Green
Write-Host "Run: python -m http.server 8000"
Write-Host "Then inspect: http://localhost:8000"
