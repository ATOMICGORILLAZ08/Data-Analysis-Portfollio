# Libraries used
library(tidyverse)
library(ggplot2)
library(dplyr)
library(readr)

# View of Chain Fountain Data
View(X3_0mmChain)


View(X6_0mmChain)

View(X6_0mm_0_96m_Velocity_time)

View(X6_0mm_5m_Velocity_time)


# Height graphs
 ggplot(data = X3_0mmChain) + 
  geom_point(mapping = aes(y = Average_Fountain_Height_m, x = Measured_Drop_Height_m), color="blue") +
  geom_point(mapping = aes(y = Theoritical_Fountain_Height_m,  x = Theoritical_Drop_Height_m), color="Red") +
  labs(title = "3.0 mm Chain: Fountain Height vs. Drop Height") +
   scale_color_manual(name = "Data", values = c("blue" = "Measured", "Red" = "Theoretical"))
 
 ## Baseline graphs for X3_0mmChain
 ggplot(data = X3_0mmChain) + 
   geom_point(mapping = aes(y = Average_Fountain_Height_m, x = Measured_Drop_Height_m, color = "Measured")) +
   geom_point(mapping = aes(y = Theoritical_Fountain_Height_m,  x = Theoritical_Drop_Height_m, color = "Theoretical")) +
   labs(title = "3.0 mm Chain: Fountain Height vs. Drop Height") +
   guides(color = guide_legend(override.aes = list(shape = c(16, 17))))

## Finished X3_0mmChain graph
  ggplot(X3_0mmChain, aes(Measured_Drop_Height_m, Average_Fountain_Height_m, color= "Measured")) + geom_point() + geom_smooth(method = "lm",color ="gold") + 
    geom_point(mapping = aes(y = Theoritical_Fountain_Height_m,  x = Theoritical_Drop_Height_m, color= "Theoretical")) +
    labs(title = "3.0 mm Chain: Fountain Height vs. Drop Height")+
    guides(color = guide_legend(override.aes = list(shape = c(16, 17))))+
    theme(panel.grid = element_blank())+
    geom_errorbar(aes(y=Average_Fountain_Height_m,
                      xmin=NULL,
                      xmax=NULL,
                      x=Measured_Drop_Height_m, ymin = Average_Fountain_Height_m - Standard_Deviation,
                      ymax = Average_Fountain_Height_m + Standard_Deviation), width=.2, position = position_dodge(.9))
## Finished X6_0mmChain graph
ggplot(X6_0mmChain, aes(Measured_Drop_Height_m, Average_Fountain_Height_m, color= "Measured")) + geom_point() + geom_smooth(method = "lm",color ="gold") + 
  geom_point(mapping = aes(y = Theoritical_Fountain_Height_m,  x = Theoritical_Drop_Height_m, color= "Theoretical")) +
  labs(title = "3.0 mm Chain: Fountain Height vs. Drop Height")+
  guides(color = guide_legend(override.aes = list(shape = c(16, 17))))+
  theme(panel.grid = element_blank())+
  geom_errorbar(aes(y=Average_Fountain_Height_m,
                    xmin=NULL,
                    xmax=NULL,
                    x=Measured_Drop_Height_m, ymin = Average_Fountain_Height_m - Standard_Deviation,
                    ymax = Average_Fountain_Height_m + Standard_Deviation), width=.2, position = position_dodge(.9))

# Velocity graphs
 ##
ggplot(data = X6_0mm_5m_Velocity_time, aes(x = Average_Time_5m_6.0mm, y = Average_Velocity_5m_6.0mm))+
  labs(title = "6.0 mm Chain at 5.0 m: Velocity vs. Time")+
  geom_errorbar(aes(y=Average_Velocity_5m_6.0mm,
                    xmin=Average_Time_5m_6.0mm-0.006507971,
                    xmax=Average_Time_5m_6.0mm+0.006507971,
                    x=Average_Time_5m_6.0mm, ymin = Average_Velocity_5m_6.0mm- 1.035725389,
                    ymax = Average_Velocity_5m_6.0mm + 1.035725389), width=.2, position = position_dodge(.9))+
  geom_point(size = 2, color = "green") +
  geom_smooth(method = "lm")

##
ggplot(data = X6_0mm_0_96m_Velocity_time, aes(x = Average_Time_0_96m_6.0mm, y = Average_Velocity_0_96m_6.0mm))+
  labs(title = "6.0 mm Chain at 0.96 m: Velocity vs. Time")+
  geom_errorbar(aes(y=Average_Velocity_0_96m_6.0mm,
                    xmin=Average_Time_0_96m_6.0mm-0.011653084,
                    xmax=Average_Time_0_96m_6.0mm+0.011653084,
                    x=Average_Time_0_96m_6.0mm, ymin = Average_Velocity_0_96m_6.0mm- 0.0729968071,
                    ymax = Average_Velocity_0_96m_6.0mm + 0.0729968071), width=.2, position = position_dodge(.9))+
  geom_point(size = 2, color = "green") +
  geom_smooth(method = "lm")