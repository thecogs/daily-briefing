# Daily Briefing

[![Live](https://img.shields.io/badge/live-thecogs.github.io%2Fdaily--briefing-2ea44f)](https://thecogs.github.io/daily-briefing/)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

A personal daily-routine dashboard — a single static HTML page, no build step, no backend.

**Live:** https://thecogs.github.io/daily-briefing/

## Contents

- [What it does](#what-it-does)
- [Why some things link out instead of embedding](#why-some-things-link-out-instead-of-embedding)
- [Data and storage](#data-and-storage)
- [Running locally](#running-locally)
- [Deploying changes](#deploying-changes)
- [Content sources and licensing](#content-sources-and-licensing)

## What it does

Tracks 14 daily habits as one-tap checkboxes that disappear into a "Completed today" list when done (undo by tapping the chip back). Progress, a 14-day history strip, and a day streak are computed from what you've checked off. A **History** tab lists every past day with what got done that day.

Beyond plain checkboxes, a few tasks open into their own tile:

- **Strength training** — a plain yes/no for whatever's on the day's lifting plan.
- **Cardio** — check off however you did it: hike, run, or 10k steps.
- **Read a poem** — a rotating set of complete public-domain poems, with a link to [today's actual pick on Poetry Foundation](https://www.poetryfoundation.org/poems/poem-of-the-day).
- **Pray** — a rotating KJV verse, with a link to [today's actual pick on Bible.com](https://www.bible.com/verse-of-the-day).
- **20 min of French** — six rotating B1/B2-level reading lessons, each with a grammar note, vocab list, and text-to-speech playback (`SpeechSynthesis`).
- **Crossword** — a genuinely new mini crossword generated every day (a 5-letter "spine" word paired with three procedurally matched 3-letter across words — thousands of possible combinations, not a fixed set), plus a link to [Dictionary.com's daily crossword](https://www.dictionary.com/games/crossword) for the full-size version.
- **Morning stretch** — Baduanjin, the classical "Eight Pieces of Brocade" qigong set, with a cue for each move.
- **Learn something new** — a shuffleable fun-fact tile.

## Why some things link out instead of embedding

This was originally built as a Claude Artifact, which sandboxes the page and blocks nearly all outbound network requests and embeds. Moving it to a plain static page (this repo) lifted that restriction, but two things are still out of reach for a different reason: both Poetry Foundation and Bible.com block cross-site fetching from any origin (no CORS headers, and Poetry Foundation additionally sits behind a bot challenge), and Dictionary.com's crossword blocks being framed by any other site. None of that is fixable from the client side without those sites' cooperation, so those tiles link out instead of mirroring the content.

## Data and storage

Everything lives in the browser via `localStorage` — no account, no server, no analytics:

| Key | What it holds |
|---|---|
| `morning-ledger-v7` | Every day's checkbox state, keyed by date (this is also what powers the History tab) |
| `morning-ledger-idx-v7` | Which rotating poem/verse/lesson was picked for each date |
| `morning-ledger-cardio-log-v1` | Which cardio option(s) were checked each day |

Because it's local to the browser, progress doesn't sync across devices — opening this on a different browser or device starts fresh.

## Running locally

It's a single self-contained HTML file. Either:

```bash
open index.html
```

or serve it (needed for some browsers' handling of local files):

```bash
python3 -m http.server 8080
# then open http://localhost:8080
```

## Deploying changes

Pushing to `main` is enough — GitHub Pages serves directly from the branch root (Settings → Pages → Deploy from a branch → `main` / `/`).

```bash
git add index.html
git commit -m "Describe the change"
git push
```

## Content sources and licensing

- Poems: Frost, Blake, Dickinson — all public domain in the US.
- Bible verses: King James Version, public domain.
- Fun facts, French lessons, the qigong set descriptions, and the crossword word/clue bank: written for this project.

## License

Code in this repo is MIT-licensed (see [LICENSE](LICENSE)). The public-domain poems and KJV verse text embedded in `index.html` are not under copyright.
