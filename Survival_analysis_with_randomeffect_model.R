## Survival analysis with random effect models
#install.packages("coxme")
#Fit Cox proportional hazards models containing both fixed and random effects. 
#The random effects can have a general form, of which familial interactions (a "kinship" matrix)
#is a particular special case. Note that the simplest case of a mixed effects Cox model, 
#i.e. a single random per-group intercept, is also called a "frailty" model.
#The approach is based on Ripatti and Palmgren, Biometrics 2002.

library(coxme)
# A non-significant institution effect
fit1 <- coxph(Surv(time, status) ~ ph.ecog + age, data=lung,
              subset=(!is.na(inst)))
fit2 <- coxme(Surv(time, status) ~ ph.ecog + age + (1|inst), lung)
anova(fit1, fit2)

# Shrinkage effects (equivalent to ridge regression)
temp <- with(lung, scale(cbind(age, wt.loss, meal.cal)))
rfit <- coxme(Surv(time, status) ~ ph.ecog + (temp | 1), data=lung)


data(eortc)
coxme(Surv(y, uncens) ~ trt + (trt| center) + strata(center), eortc)


rat1 <- coxme(Surv(time, status) ~ rx + (1|litter), rats)
fixed.effects(rat1)
vcov(rat1)
random.effects(rat1)[[1]] #one value for each of the 50 litters
VarCorr(rat1)