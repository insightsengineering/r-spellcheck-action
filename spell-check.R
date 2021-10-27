#!/usr/bin/env Rscript
repo_path <- Sys.getenv("SC_REPO_PATH", ".")

cat("\n==================================\n")
cat(paste("repo_path: \"", repo_path, "\"\n", sep=""))
cat("==================================\n")

spell_check_result <- devtools::spell_check(pkg = repo_path)
print(spell_check_result)
# count detected words
no_of_detected_words <- length(spell_check_result[,1])
if (no_of_detected_words > 0) {
    print(paste0('Number of unrecognized words: ', no_of_detected_words) )
    cat('Please add above words to file "inst\\WORDLIST" only if they should be accepted\n')
} else {
    cat("Spelling accepted\n")
}
# return error code as number of detected words as a result of script
quit(save = "no", status = no_of_detected_words, runLast = FALSE)
