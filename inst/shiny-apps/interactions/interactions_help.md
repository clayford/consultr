<script type="text/javascript"
  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

When the app is initialized, a random data set of predictors is loaded. X1 and X2 are each 100 random draws
from an _N_(5,1) distribution. X1 and X2 do not change while the app is in use. Each time a slider is moved,
a new response vector (y) is generated using the predictors and their associated coefficients as follows:

y = β₀ + β₁*X1 + β₂*X2 + β₃*X1*X2 + _N_(0,σ)

Think of the slider values as the “true” model and the summary output as the attempt to recover the true values.

The plot shows the relationship between X1 and y at four different values of X2. When there is no interaction (i.e., β₃ = 0), the lines should all have roughly the same slope. In that case, it doesn’t matter what value X2 takes; the relationship between X1 and y remains the same. However, when there is a non-zero interaction, the relationship between X1 and y depends on X2. Adjusting the sliders allows one to explore how the relationship between X1 and y changes given various magnitudes and directions (positive or negative) of the coefficients. See if you can guess in what ways the relationships will change as you adjust the coefficients.
