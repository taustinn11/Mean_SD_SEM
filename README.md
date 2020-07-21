## A visual exploration of the differences between standard deviation and standard error of the mean as they relate to sample size


### Premise
I wrote this small report after completing a challenge issued by one of my professors and mentors, Dr. TJ Murphy (https://github.com/TJMurphy). The challenge, briefly, is to generate a plot illustrating the change in estimated mean, standard deviation (SD), and standard error of the mean (SEM) over several sample sizes. After first failing to solve this problem on my own, I came back to it later when he re-issued it to folks in the department of pharmacology. It serves as a straightforward exercise in R programming as well as an example of how differently SD and SEM behave. Moreover, it shows how ineffective using the “n = 3” approach, an unfortunate staple of biological research, truly is.

### Introduction
Standard deviation (SD) and standard error of the mean (SEM) are two statistical measures that are used to describe variation in data but for two different qualities of the data. The SD measures the dispersion of points around an estimated mean (Dawson et al., 2004) while the SEM measures the dispersion of multiple sampled means around the estimated mean of the true population (Barde and Barde, 2012). In other words, SEM measures how accurately the mean was estimated. They are related but distinct metrics. Importantly, they are meant to be used differently. SD is meant to be used as a descriptive statistic concerning the raw data while SEM can be used to determine confidence intervals within which the true mean of the population is likely to be (Barde and Barde, 2012).

The SEM can be derived from the SD. Consider a sample S made of up several observations of continuous data. The estimated standard deviation of the population based on S is:

SD = ![formula](https://render.githubusercontent.com/render/math?math=\sqrt{\frac{1}{N-1}\sum_{i=1}^n%20(x_i%20-%20\bar{x})^2})

The SEM for the same sample S is:

SEM = ![formula](https://render.githubusercontent.com/render/math?math=\frac{SD}{\sqrt{N}})

The SD and SEM are related by the inverse of the square root of the number of observations N. While both the SD will be come more accurate and the SEM will approach zero as N increases, SEM will approach zero much more quickly than the SD will approach its true value. This is apparent in **Figure 1** below.

![.](Mean_sd_sem.png)
**Fig 1: Random parameter estimates over different sample sizes from 2-50**

True mean = 100, true SD = 25

### Problem

Despite independent definitions and prescribed applications, these two measures are often put at odds due to misuse. Frequently, researchers will present charts using mean ± SEM when 1) the data would be more aptly charted using mean ± SD and 2) when it would be more appropriate to describe the data in terms of its standard deviation (Jaykaran 2010; Barde and Barde, 2012). This misuse has been identified in several fields of biological research including cardiovascular biology (Wullschleger et al., 2014), anesthesia (Avram et al., 1985; Nagele et al., 2003), tropical medicine and hygiene (Cruess and David, 1989), arthritis and rheumatism (Felson et al., 1984), infectious disease (MacArthur et al, 1984), and psychiatry (White 1979).

This is likely due to the fact that errorbars drawn from SEM are much smaller than those of SD. This is evident in **figure 1** which demonstrates how quickly the value of SEM decreases compared to SD. Rigorous and reproducible science requires that statistical methods are correctly and appropriately applied. Moreover, Jaykaran has proposed a change in the syntax of reporting mean and SD vs. mean and SEM to mean (SD) and mean ±SEM to further prevent confusion [@Jaykaran2010]. 

### Challenge

As mentioned in the premise, I was inspired to write this brief report after being challenged by my mentor Dr. TJ Murphy to generate **Figure 1** above. Now, I challenge you, the reader, to generate this same plot. 

These data are random samples drawn from a normal distribution that has a mean of 100 and sd of 25. For each sample size, calculate the mean, SD and SEM. For all sample sizes, there are 75 replicates. The sample sizes vary from 2 to 50.

I have solved this problem using a tidyr/dplyr heavy method in Mean_SD_SEM_solved.R. There are, however, many different ways to accomplish this. I look forward to hearing about the different methods everyone employs!

### Citations

Avram, M. J., Shanks, C. A., Dykes, M., Ronai, A. K., & Stiers, W. M. (1985). Statistical methods in anesthesia articles: an evaluation of two American journals during two six-month periods. *Anesthesia and Analgesia*, 64(6), 607-611. 

Barde, M. P., & Barde, P. J. (2012). What to use to express the variability of data: Standard deviation or standard error of mean? *Perspect Clin Res*, 3(3), 113-116. doi:10.4103/2229-3485.100662

Cruess, D. F. (1989). Review of use of statistics in the American Journal of Tropical Medicine and Hygiene for January–December 1988. *The American journal of tropical medicine and hygiene*, 41(6), 619-626. 

Curran-Everett, D., Taylor, S., & Kafadar, K. (1998). Fundamental concepts in statistics: elucidation and illustration. *Journal of Applied Physiology*, 85(3), 775-786. doi:10.1152/jappl.1998.85.3.775

Dawson, B., & Trapp, R. G. (2004). *Basic and clinical biostatistics*. Singapore, 2001, 141-142. 

Felson, D. T., Adrienne Cupples, L., & Meenan, R. F. (1984). Misuse of statistical methods in arthritis and rheumatism. *Arthritis & Rheumatism: Official Journal of the American College of Rheumatology*, 27(9), 1018-1022. 

Jaykaran. (2010). "Mean ± SEM" or "Mean (SD)"? *Indian J Pharmacol*, 42(5), 329. doi:10.4103/0253-7613.70402

Lang, T. (2004). Twenty statistical errors even you can find in biomedical research articles. In: MEDICINSKA NAKLADA VLASKA 69, HR-10000 ZAGREB, CROATIA.

MacArthur, R. D., & Jackson, G. G. (1984). An evaluation of the use of statistical methodology in the Journal of Infectious Diseases. *Journal of Infectious Diseases*, 149(3), 349-354. Retrieved from https://academic.oup.com/jid/article-abstract/149/3/349/913856?redirectedFrom=fulltext

Nagele, P. (2003). Misuse of standard error of the mean (SEM) when reporting variability of a sample. A critical evaluation of four anaesthesia journals. *British Journal of Anaesthesia*, 90(4), 514-516. Retrieved from https://bjanaesthesia.org/article/S0007-0912(17)38467-2/pdf

White, S. J. (1979). Statistical errors in papers in the British Journal of Psychiatry. *The British Journal of Psychiatry*, 135(4), 336-342. 

Wullschleger, M., Aghlmandi, S., Egger, M., & Zwahlen, M. (2014). High Incorrect Use of the Standard Error of the Mean (SEM) in Original Articles in Three Cardiovascular Journals Evaluated for 2012. *PLOS ONE*, 9(10), e110364. doi:10.1371/journal.pone.0110364
