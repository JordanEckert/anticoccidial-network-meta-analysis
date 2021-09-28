# Network meta-analysis comparing the effectiveness of anticoccidial drugs and anticoccidial vaccination in broiler chickens

This repository contains the imputation code for the paper, **Network meta-analysis comparing the effectiveness of anticoccidial drugs and anticoccidial vaccination in broiler chickens.** The paper was a joint effort between myself, and Dr. Rüdiger Hauck and his graduate student Miranda Carrisosa of the Poultry Science department at Auburn. Highlights of the paper include:

- Network meta-analysis of 63 trials testing anticoccidials and coccidia vaccines.

- Vaccinated groups had similar results as groups given anticoccidials.

- Analysis of subsets confirmed results of the full set.


## Imputation

In addition to the main results, more papers were able to be synthesized for analysis by imputing their missing standard errors.  Standard errors for FCR and BWG were calculated using random forests in R. The data was imported from the original Excel sheet found in the [original article.](https://www.sciencedirect.com/science/article/pii/S0304401721000479?via%3Dihub). This was accomplished using read_excel(). Next, the data was cleaned. This consisted of correctly changing variable types. Imputating missing values using random forests using missForest(). Further documentation on the function used can be found [here.](https://cran.r-project.org/web/packages/missForest/missForest.pdf) Not shown is the network meta-analysis code, which can be found in the original paper.
 
## Citation
Eckert J, Carrisosa M, Hauck R. Network meta-analysis comparing the effectiveness of anticoccidial drugs and anticoccidial vaccination in broiler chickens. Vet Parasitol. 2021 Mar;291:109387. doi: 10.1016/j.vetpar.2021.109387. Epub 2021 Feb 15. PMID: 33667988.
