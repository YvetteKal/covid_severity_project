library(survival)
library(survminer)
library(Cairo)
CairoSVG(file = "./static/tmp/8b08fe5b80bd7795.svg", width=6, height=5, family="ArialMT")
svData<-read.table(file="8b08fe5b80bd7795.txt", header=T, sep="\t",check.names=FALSE, quote="")
fit<- survfit(Surv(Time, State) ~ gene1a2b3c4d5e6f, data = svData)
ggsurvplot(fit,
censor.shape="+", censor.size = 4,
pval = TRUE, 
xlab="Time",
legend.title="Risk",
legend.labs=levels(factor(svData[,"gene1a2b3c4d5e6f"])),
palette =c("#E04145","#426CB2"),
conf.int = T,
conf.int.style="ribbon",
conf.int.alpha=0.1,
risk.table=T,
risk.table.height=0.250000,
risk.table.fontsize=4.000000,
font.x = 14.000000,
font.y = 14.000000,
font.tickslab = 12.000000)
dev.off()
pdf(file = "./static/tmp/8b08fe5b80bd7795.pdf", width=6, height=5, family="ArialMT",onefile = FALSE)
svData<-read.table(file="8b08fe5b80bd7795.txt", header=T, sep="\t",check.names=FALSE, quote="")
fit<- survfit(Surv(Time, State) ~ gene1a2b3c4d5e6f, data = svData)
ggsurvplot(fit,
censor.shape="+", censor.size = 4,
pval = TRUE, 
xlab="Time",
legend.title="Risk",
legend.labs=levels(factor(svData[,"gene1a2b3c4d5e6f"])),
palette =c("#E04145","#426CB2"),
conf.int = T,
conf.int.style="ribbon",
conf.int.alpha=0.1,
risk.table=T,
risk.table.height=0.250000,
risk.table.fontsize=4.000000,
font.x = 14.000000,
font.y = 14.000000,
font.tickslab = 12.000000)
dev.off()
