# R Spellcheck Action

Github Action that uses the [spellcheck](https://github.com/ropensci/spelling) R package to verify spellings in an R package.

## Usage

Here's an example workflow demonstrating how this action can be used:

```yml
---
name: Spellcheck

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  check:
    runs-on: ubuntu-latest
    name: Check
    container:
      image: rocker/tidyverse:4.1.2
    steps:
      - name: Checkout repo
        uses: actions/checkout@v2

      - name: Run Spelling Check test
        uses: insightsengineering/r-spellcheck-action@v2
```
