# R-spelling-check-action
Github Action to implement check spelling for R package during development process


The [spelling] package simplifies the development process for developing R packages by delivering `Tools for Spell Checking in R`. This action is to simplify step of spelling verification of R package.

## Table of Contents

- [r-spelling-check-action](#r-spelling-check-action)
  - [Table of Contents](#table-of-contents)
  - [How to use](#how-to-use)
  - [Environment variables](#environment-variables)


## How to use


To use this GitHub Action you will need to complete the following:

1. Add action `Run Spelling Check test` to be one of the steps
2. Open up a pull request and observe the action working


```yml
---
name: Check R package

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
      image: rocker/verse:4.1.0
    steps:
      - name: Checkout repo
        uses: actions/checkout@v2

      - name: Run Spelling Check test
        uses: insightsengineering/r-spelling-check-action@v1
        env:
          SC_REPO_PATH: ${{ github.event.repository.name }}

      - name: Build R package
        run: |
          R CMD build ${{ github.event.repository.name }}
          echo "PKGBUILD=$(echo *.tar.gz)" >> $GITHUB_ENV
        shell: bash

      - name: Check R package
        run: R CMD check --no-manual ${{ env.PKGBUILD }}
        shell: bash

      - name: Install R package
        run: R CMD INSTALL ${{ env.PKGBUILD }}
        shell: bash
```

## Environment variables

The r-spelling-check-action allows you to pass the following `ENV` variables to be able to trigger different functionality.

| **ENV VAR** | **Default Value** | **Notes** |
| ----------- | ----------------- | --------- |
| **SC_REPO_PATH** | `.` | path to the R package |



[spelling]: https://github.com/ropensci/spelling
[spelling action in marketplace]: https://github.com/marketplace/actions/r-package-check-spelling-action
