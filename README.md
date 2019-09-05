Substitute with an Evaluated Expression in R
----------------------------------------------

In Perl, if we want to substitute with an evaluated expression with regular
expression, we can do as follows. 

```perl
%map = (
	"a" => "one",
	"b" => "two",
	"c" => "three",
);
$txt = "a, b, c";
$txt =~s/([a|b|c])/$map{$1}/g;
```

Here `$map{$1}` is evaluated and `$txt` will be `one, two, three`.


To be formal, the matched text _s_ is replaced by _f(s)_ where _f()_ is a
transformation to the text _s_.

In R, we use `gsub()` to perform substitution, however, the second argument
`replacement` can only be a normal string that the matched text cannot be
changed. In following example, `\\1` can be not changed.

```r
map = c("a" = "one", "b" = "two", "c" = "three")
txt = "a, b, c";
gsub("([a|b|c])", "_\\1_", txt)  # "a" is still "a"
```

But how can we also apply _f(s)_ in R?

If we go back to Perl, we can use the form `this is a $thing` to mix code
(`$thing`) and normal text that `$thing` will be evaluated later and the value
will be intepolated back to the text.

This scenario is similar as in the text substitution. Actually we can modify
the previous example a little bit:

```perl
$txt =~s/([a|b|c])/_$map{$1}_/g;
```

where in the replacement part `_$map{$1}_`, `$map{$1}` is the code and will be
evaluated. The value of `$map{$1}` will be sent back to `_$map{$1}_` to
perform the normal substitution.

In R, there are also similar functions that do variable or code intepolation,
such as `glue::glue()` or `GetoptLong::qq()`. Then we can do similar as in
Perl to substitute with the evaluated expression.

For the text `"a, b, c"`, to convert to `"one, two, three"`, we can first use `gsub()`
to replace `a/b/c` to a template:

```r
txt2 = gsub("([a|b|c])", "@{map['\\1']}", txt)
txt2
```

```
## [1] "@{map['a']}, @{map['b']}, @{map['c']}"
```

then evaluate the template by e.g. `GetoptLong:qq()`:

```r
GetoptLong::qq(txt2)
```

```
## [1] "one, two, three"
```

Or with `glue::glue()`:

```r
glue(gsub("([a|b|c])", "{map['\\1']}", txt))
```

To make it simple, `gsubeval::gsub_eval()` combines these two steps into a single function:

```{r}
gsub_eval("([a|b|c])", "@{map['\\1']}", txt)
```

```
## [1] "one, two, three"
```

You can use any type of code in the template. Following is another example
using `gsub_eval()`:

```{r}
gsub_eval("(\\d+),(\\d+)", "\\1 + \\2 = @{\\1 + \\2}", c("1,2", "3,4"))
```

```
## [1] "1 + 2 = 3" "3 + 4 = 7"
```
