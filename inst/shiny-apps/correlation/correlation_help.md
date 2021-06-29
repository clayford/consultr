<script type="text/javascript"
  src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML">
</script>

Correlation measures the strength of _linear association_ between two numeric 
variables. It ranges in value from -1 to 1. Drag the slider to visualize 
different correlations between _x_ and _y_. Click **New Sample** to generate new data 
at a specified correlation strength.

The correlation coefficient is calculated by:

$$r_{xy} = \frac{\text{Cov}(x,y)}{\text{SD}_x\text{SD}_y}$$

where $\text{Cov}$ is covariance and $\text{SD}$ is standard deviation. This is 
known as [Pearson's correlation](https://en.wikipedia.org/wiki/Pearson_correlation_coefficient).

This can be calculated in R as `cov(x, y)/(sd(x) * sd(y))` or simply `cor(x, y)`.

<!---
Or, broken down further:

$$r_{xy} = \frac{\sum_{i=1}^{n}(x_i - \bar{x})(y_i - \bar{y})}{\sqrt{\sum_{i=1}^{n}(x_i - \bar{x})^2}\sqrt{\sum_{i=1}^{n}(y_i - \bar{y})^2}}$$
-->
