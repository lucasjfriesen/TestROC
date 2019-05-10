#read data
dep<-foreign::read.spss(file="Gail Thesis Data.sav")
dep<-data.frame(dep)
head(dep)
View(dep)

#install.packages("cutpointr")
#install.packages("magrittr")
#install.packages("dplyr")
library(cutpointr)
library(magrittr)
library(dplyr)

#Cutpointr is used to determine and evaluate optimal cutpoints
#x = predictions, class = class membership, pos_class = positive class, neg_class = negative class
#All cutpoints will be returned that lead to a metric value in the interval 
#[m_max - tol_metric, m_max + tol_metric] where m_max is the maximum achievable metric value.
#Set na.rm to TRUE to keep only complete cases of x

#Category 1: BDI for MDD
bdi <- cutpointr(data = dep, x = bditot, class = scidmdd, direction = ">=", pos_class = "MDD", 
               neg_class = "not MDD", tol_metric = 0.5, na.rm = TRUE)
summary(bdi)

#delete incomplete cases
dep2 <- dep %>% filter(!is.na(bditot))
View(dep2)

#roc returns a data.frame that includes all elements of the confusion matrix, including true positives,
#false positives, true negatives and false negatives for every unique value of the predictor variable.
tpfp<-roc(data = dep2, x = "bditot", class = "scidmdd", pos_class = "MDD",
    neg_class = "not MDD", direction = ">=") %>% 
  select(x.sorted,tp, fp, tn, fn)
tpfp

ppvalue<-tpfp$tp/(tpfp$tp+tpfp$fp)
data.frame(tpfp$x.sorted,ppvalue)
npvalue<-tpfp$tn/(tpfp$fn+tpfp$tn)
data.frame(tpfp$x.sorted,npvalue)

plot_roc(bdi, display_cutpoint = FALSE)

#Category 1: GDS for MDD
gds<-cutpointr(data = dep, x = gdstot, class = scidmdd, direction = ">=", pos_class = "MDD", 
               neg_class = "not MDD", tol_metric = 0.5, na.rm = TRUE)
summary(gds)

dep3 <- dep %>% filter(!is.na(gdstot))
View(dep3)
tpfp2<-roc(data = dep3, x = "gdstot", class = "scidmdd", pos_class = "MDD",
            neg_class = "not MDD", direction = ">=") %>% 
  select(x.sorted,tp, fp, tn, fn)
tpfp2

ppvalue2<-tpfp2$tp/(tpfp2$tp+tpfp2$fp)
data.frame(tpfp2$x.sorted,ppvalue2)
npvalue2<-tpfp2$tn/(tpfp2$fn+tpfp2$tn)
data.frame(tpfp2$x.sorted,npvalue2)

plot_roc(gds, display_cutpoint = FALSE)

#Category 1: HDS for MDD
hds<-cutpointr(data = dep, x = hdstot, class = scidmdd, direction = ">=", pos_class = "MDD", 
               neg_class = "not MDD", tol_metric = 0.5, na.rm = TRUE)
summary(hds)

dep4 <- dep %>% filter(!is.na(hdstot))
View(dep4)
tpfp3<-roc(data = dep4, x = "hdstot", class = "scidmdd", pos_class = "MDD",
           neg_class = "not MDD", direction = ">=") %>% 
  select(x.sorted,tp, fp, tn, fn)
tpfp3

ppvalue3<-tpfp3$tp/(tpfp3$tp+tpfp3$fp)
data.frame(tpfp3$x.sorted,ppvalue3)
npvalue3<-tpfp3$tn/(tpfp3$fn+tpfp3$tn)
data.frame(tpfp3$x.sorted,npvalue3)

plot_roc(hds, display_cutpoint = FALSE)

#Category 2: BDI for MDD or DD
bdi <- cutpointr(data = dep, x = bditot, class = scidmddd, direction = ">=", pos_class = "MDD or DD", 
                 neg_class = "not MDD or DD", tol_metric = 0.5, na.rm = TRUE)
summary(bdi)

dep2 <- dep %>% filter(!is.na(bditot))
View(dep2)
tpfp<-roc(data = dep2, x = "bditot", class = "scidmddd", pos_class = "MDD or DD",
          neg_class = "not MDD or DD", direction = ">=") %>% 
  select(x.sorted,tp, fp, tn, fn)
tpfp

ppvalue<-tpfp$tp/(tpfp$tp+tpfp$fp)
data.frame(tpfp$x.sorted,ppvalue)
npvalue<-tpfp$tn/(tpfp$fn+tpfp$tn)
data.frame(tpfp$x.sorted,npvalue)

plot_roc(bdi, display_cutpoint = FALSE)

#Category 2: GDS for MDD or DD
gds<-cutpointr(data = dep, x = gdstot, class = scidmddd, direction = ">=", pos_class = "MDD or DD", 
               neg_class = "not MDD or DD", tol_metric = 0.5, na.rm = TRUE)
summary(gds)

dep3 <- dep %>% filter(!is.na(gdstot))
View(dep3)
tpfp2<-roc(data = dep3, x = "gdstot", class = "scidmddd", pos_class = "MDD or DD",
           neg_class = "not MDD or DD", direction = ">=") %>% 
  select(x.sorted,tp, fp, tn, fn)
tpfp2

ppvalue2<-tpfp2$tp/(tpfp2$tp+tpfp2$fp)
data.frame(tpfp2$x.sorted,ppvalue2)
npvalue2<-tpfp2$tn/(tpfp2$fn+tpfp2$tn)
data.frame(tpfp2$x.sorted,npvalue2)

plot_roc(gds, display_cutpoint = FALSE)

#Category 2: HDS for MDD or DD
hds<-cutpointr(data = dep, x = hdstot, class = scidmddd, direction = ">=", pos_class = "MDD or DD", 
               neg_class = "not MDD or DD", tol_metric = 0.5, na.rm = TRUE)
summary(hds)

dep4 <- dep %>% filter(!is.na(hdstot))
View(dep4)
tpfp3<-roc(data = dep4, x = "hdstot", class = "scidmddd", pos_class = "MDD or DD",
           neg_class = "not MDD or DD", direction = ">=") %>% 
  select(x.sorted,tp, fp, tn, fn)
tpfp3

ppvalue3<-tpfp3$tp/(tpfp3$tp+tpfp3$fp)
data.frame(tpfp3$x.sorted,ppvalue3)
npvalue3<-tpfp3$tn/(tpfp3$fn+tpfp3$tn)
data.frame(tpfp3$x.sorted,npvalue3)

plot_roc(hds, display_cutpoint = FALSE)

#Category 3: BDI for MDD, DD, minor depressive disorder, partial remission of MDD, or dysthymic disorder
bdi <- cutpointr(data = dep, x = bditot, class = scidany, direction = ">=", pos_class = "any form of depression", 
                 neg_class = "no depression", tol_metric = 0.5, na.rm = TRUE)
summary(bdi)

dep2 <- dep %>% filter(!is.na(bditot))
View(dep2)
tpfp<-roc(data = dep2, x = "bditot", class = "scidany", pos_class = "any form of depression",
          neg_class = "no depression", direction = ">=") %>% 
  select(x.sorted,tp, fp, tn, fn)
tpfp

ppvalue<-tpfp$tp/(tpfp$tp+tpfp$fp)
data.frame(tpfp$x.sorted,ppvalue)
npvalue<-tpfp$tn/(tpfp$fn+tpfp$tn)
data.frame(tpfp$x.sorted,npvalue)

plot_roc(bdi, display_cutpoint = FALSE)

#Category 3: GDS for MDD, DD, minor depressive disorder, partial remission of MDD, or dysthymic disorder
gds<-cutpointr(data = dep, x = gdstot, class = scidany, direction = ">=", pos_class = "any form of depression", 
               neg_class = "no depression", tol_metric = 0.5, na.rm = TRUE)
summary(gds)

dep3 <- dep %>% filter(!is.na(gdstot))
View(dep3)
tpfp2<-roc(data = dep3, x = "gdstot", class = "scidany", pos_class = "any form of depression",
           neg_class = "no depression", direction = ">=") %>% 
  select(x.sorted,tp, fp, tn, fn)
tpfp2

ppvalue2<-tpfp2$tp/(tpfp2$tp+tpfp2$fp)
data.frame(tpfp2$x.sorted,ppvalue2)
npvalue2<-tpfp2$tn/(tpfp2$fn+tpfp2$tn)
data.frame(tpfp2$x.sorted,npvalue2)

plot_roc(gds, display_cutpoint = FALSE)

#Category 3: HDS for MDD, DD, minor depressive disorder, partial remission of MDD, or dysthymic disorder
hds<-cutpointr(data = dep, x = hdstot, class = scidany, direction = ">=", pos_class = "any form of depression", 
               neg_class = "no depression", tol_metric = 0.5, na.rm = TRUE)
summary(hds)

dep4 <- dep %>% filter(!is.na(hdstot))
View(dep4)
tpfp3<-roc(data = dep4, x = "hdstot", class = "scidany", pos_class = "any form of depression",
           neg_class = "no depression", direction = ">=") %>% 
  select(x.sorted,tp, fp, tn, fn)
tpfp3

ppvalue3<-tpfp3$tp/(tpfp3$tp+tpfp3$fp)
data.frame(tpfp3$x.sorted,ppvalue3)
npvalue3<-tpfp3$tn/(tpfp3$fn+tpfp3$tn)
data.frame(tpfp3$x.sorted,npvalue3)

plot_roc(hds, display_cutpoint = FALSE)
