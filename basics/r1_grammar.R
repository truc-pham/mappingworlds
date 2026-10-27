temp_hcmc <- 33
temp_hn <- 24
temp_dif <- temp_hcmc - temp_hn
temp_dif

temp_hcm_f <- temp_hcmc * 9/5 + 32
temp_hcm_f

cities <- c("Ho Chi Minh", "Ha Noi", "Da Nang", "Da Lat")
temps <- c(33,24, 29, 19)

mean(temps)
max(temps)
min(temps)

cities[3]
cities[temps > 25]

temps_f <- temps * 9/5 + 32
cities1 <- (temps > 25)

avg_temp <- mean(temps) |> round(digits = 1)
paste("The average temperature is", avg_temp, "oC")

# 11
cities[temps < 25]

# 12
paste("The hottest city is", max(temps), "oC")

paste("The hottest city is", cities[temps == max(temps)])
