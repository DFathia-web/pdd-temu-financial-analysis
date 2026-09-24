library(readr)
library(dplyr)
library(ggplot2)
library(tsibble)
library(fable)
library(fabletools)

pdd <- read_csv("pdd_quarterly_financials.csv") %>%
  mutate(Period_Ending= as.Date(Period_Ending, format="%m/%d/%Y")) %>%
  mutate(YearQuarter = yearquarter(Period_Ending)) %>%
  as_tsibble(index = YearQuarter)

# is pdd holdings profitable?
ggplot(pdd, aes(x = Period_Ending)) +
  geom_line(aes(y = Revenue_RMB_billion, color = "Revenue")) +
  geom_line(aes(y = Net_Income_RMB_billion, color = "Net Income")) +
  labs(title = "Revenue keeps Climbing but Profit isn't keeping pace", y = "RMB billion") +
  theme_minimal()

# Net margin trend
ggplot(pdd, aes(x = Period_Ending, y = Net_Margin_pct)) +
  geom_line(color = "darkred") + geom_point() +
  labs(title = "Net Margin keeps dropping since its 2024 peak") + theme_minimal()

library(feasts)
# 3. Seasonal pattern check (confirms Q4 strength)
pdd %>%
  model(STL(Revenue_RMB_billion ~ season(window = "periodic"))) %>%
  components() %>% autoplot()

# Correlation check
yoy <- pdd %>% filter(!is.na(Revenue_YoY_pct), !is.na(Net_Income_YoY_pct))
cor(yoy$Revenue_YoY_pct, yoy$Net_Income_YoY_pct)

# Seasonality
pdd %>%
  mutate(QPos = substr(Quarter, 1, 2)) %>%
  group_by(QPos) %>%
  summarise(avg_revenue = mean(Revenue_RMB_billion)) %>%
  arrange(desc(avg_revenue))

library(ggtime)
# Forecasting next 4 quarters
fit <- pdd %>% model(arima = ARIMA(Net_Income_RMB_billion))
fc <- fit %>% forecast(h = 4)
fc %>% autoplot(pdd) + labs(title = "Net Income Forecast — Next 4 Quarters")
print(fc)

fit %>% report()

fit_arma <- pdd %>% model(arma= ARIMA(Net_Income_RMB_billion ~ pdq(d=0)))
fc_arma <- fit_arma%>% forecast(h=4)
print(fc_arma)

fit_arma %>% report()