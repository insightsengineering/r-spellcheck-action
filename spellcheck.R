#!/usr/bin/env Rscript

repo_path <- Sys.getenv("INPUT_PATH", ".")
exclusions <- Sys.getenv("INPUT_EXCLUDE", "")

setwd(repo_path)

# Temporarily delete excluded files
removed <- FALSE
if (exclusions != "") {
    excluded_paths <- dir(pattern=exclusions)
    removed <- file.remove(excluded_paths)
}

spell_check_result <- spelling::spell_check_package(
    pkg = repo_path,
    vignettes = TRUE,
    use_wordlist = TRUE
)
print(spell_check_result)

# count detected words
no_of_detected_words <- length(spell_check_result[, 1])
if (no_of_detected_words > 0) {
    cat(paste('Number of misspelled words:', no_of_detected_words))
    cat('You may correct the spellings of the words above or add them to the "inst\\WORDLIST" file by running spelling::update_wordlist()\n')
} else {
    cat("Spellcheck passed!\n")
}

# Restore excluded files
if (removed) {
    system("git checkout .", ignore.stdout = TRUE)
}

# return error code as number of detected words as a result of script
quit(save = "no", status = no_of_detected_words, runLast = FALSE)
