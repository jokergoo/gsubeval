
# == title
# Substitute with an evaluated expression
#
# == param
# -pattern pass to `gsub`.
# -replacement replacement with template for variable intepolation.
# -x pass to `gsub`.
# -ignore.case pass to `gsub`.
# -perl pass to `gsub`.
# -fixed pass to `gsub`.
# -useBytes pass to `gsub`.
# -envir environment to look up the variables encoded in ``replacement``
#
# == example
# map = c("a" = "one", "b" = "two", "c" = "three")
# txt = "a, b, c";
# gsub_eval("([a|b|c])", "@{map['\\1']}", txt)
#
# gsub_eval("(\\d+),(\\d+)", "\\1 + \\2 = @{\\1 + \\2}", c("1,2", "3,4"))
gsub_eval = function(pattern, replacement, x, ignore.case = FALSE, perl = FALSE,
    fixed = FALSE, useBytes = FALSE, envir = parent.frame()) {
    txt = gsub(
        pattern = pattern, 
        replacement = replacement, 
        x = x, 
        ignore.case = ignore.case, 
        perl = perl,
        fixed = fixed, 
        useBytes = useBytes
    )
    fun = gsub_eval_opt$engine
    unname(sapply(txt, function(x) fun(x, envir = envir)))
}

# == title
# Parameters for the circular layout
#
# == param
# -... Arguments for the parameters, see "details" section
# -RESET reset to default values
# -READ.ONLY please ignore
# -LOCAL please ignore
# -ADD please ignore
#
# == details
# There are following global options:
#
# -``engine`` which function to do variable intepolation. By default it is `GetoptLong::qq`.
#
gsub_eval_opt = function(..., RESET = FALSE, READ.ONLY = NULL, LOCAL = FALSE, ADD = FALSE) {}

gsub_eval_opt = set_opt(
	engine = list(
		.value = GetoptLong::qq,
		.class = "function"
	)
)