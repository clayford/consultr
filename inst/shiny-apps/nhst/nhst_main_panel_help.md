<script type="text/javascript"
  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>


The statistical power reported above can be thought of as the result of two stages of calculation:
- First, a null binomial distribution is generated based on the sample size and null probability, and a "critical value" (the red line---or lines, if the test is two-sided) is determined for that null distribution based on the declared significance level.
    - Effectively, the red line indicates, "What threshold for 'Number of successes' would a sample of a given size need to exceed (or undershoot, or exceed or undershoot, depending on the alternative hypothesis) for us to say that the sample probability significantly differs from the null probability?"
- Second, an *alternative* binomial distribution is generated based on the sample size and *alternative* probability.
    - Effectively: "If the true probability *is* the alternative probability, what would the binomial sampling distribution look like given the sample size?"
- The power is the expected proportion of times that the alternative sampling distribution exceeds (or undershoots, or exceeds and undershoots, depending on the alternative hypothesis) the previously calculated critical value from the null distribution.
