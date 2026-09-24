# PDD Holdings (Temu Parent Company) — Quarterly Financial Analysis

Analysis of PDD Holdings' quarterly financial performance (Q1 2021 – Q1 2026), examining whether the company can sustain Temu's low-price, free-shipping growth model. Since Temu does not report standalone financials, PDD's consolidated results are used as the closest available proxy.

## Data Source

PDD Holdings quarterly earnings press releases:
https://investor.pddholdings.com/financial-information/quarterly-results/

All figures are GAAP (as reported), in RMB.

## Analysis

Built in R using `tidyverse`, `tsibble`, `fable`, and `feasts`. Covers:

1. **Revenue vs. Net Income** — tracking both metrics over 21 quarters
2. **Net Margin Trend** — quarterly profitability over time
3. **Revenue/Profit Growth Correlation** — YoY growth rate relationship
4. **Seasonality** — average revenue by quarter position
5. **STL Decomposition** — separating trend from seasonal pattern in revenue
6. **ARIMA Forecasting** — 4-quarter net income forecast, validated against a manually-specified ARMA alternative

## Key Findings

- **Revenue Keeps Climbing, But Profit Isn't Keeping Pace** — Revenue grew consistently from ~RMB22bn to ~RMB124bn per quarter, but net income growth has not kept pace (correlation r ≈ 0.5 between YoY growth rates)
- **Net Margin Keeps Dropping Since Its 2024 Peak** — Net margin peaked at ~33% (Q2 2024) and declined to ~11.8% (Q1 2026), the lowest since the company returned to consistent profitability
- **Strong Underlying Growth, With a Predictable Q4 Spike** — Revenue shows a clear seasonal pattern; Q4 averages RMB78bn vs. ~RMB62–67bn for other quarters, driven by Chinese shopping festivals (Double 11, Double 12)
- **Forecast** — Two models were compared: an auto-selected ARIMA(0,1,0) and a manually-specified ARMA(1,0,0)(1,0,0). The ARIMA model fit the data significantly better (AIC 134.7 vs. 142.9; BIC 135.7 vs. 146.1) and was retained as the primary forecast. It projects net income holding near RMB12.5 billion across the next four quarters (Q2 2026 – Q1 2027), with forecast uncertainty widening from a variance of 45 in Q2 2026 to 178 by Q1 2027 — reflecting genuine trend ambiguity rather than a confident rebound or continued decline.

## Limitations

- Temu does not report standalone financials; PDD's consolidated results are used as a proxy and do not isolate Temu's individual profitability
- The dataset (21 quarters) is limited for long-horizon forecasting; forecasts should be read as directional, not precise

## Author

Awoniran Damilola Fathia 
