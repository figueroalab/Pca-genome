#setwd to wherever your files are
library(ggplot2)
library(ggjoy)
library(RColorBrewer)

#Read in files
cov_12nc29_bubble = read.csv("12nc29.p.bubble.cov", sep="\t", header=FALSE)
cov_12sd80_bubble = read.csv("12sd80.p.bubble.cov", sep="\t", header=FALSE)
cov_12nc29_collapsed = read.csv("12nc29.p.collapsed.cov", sep="\t", header=FALSE)
cov_12sd80_collapsed = read.csv("12sd80.p.collapsed.cov", sep="\t", header=FALSE)
cov_12nc29_pwithouth = read.csv("nc29_pwithouth.cov", sep="\t", header=FALSE)
cov_12sd80_pwithouth = read.csv("sd80_pwithouth.cov", sep="\t", header=FALSE)
cov_12nc29_h = read.csv("12nc29.h.bubble.cov", sep="\t", header=FALSE)
cov_12sd80_h = read.csv("12sd80.h.bubble.cov", sep="\t", header=FALSE)

#Now, combine dataframes into one. First make a new column in each so they can be combined.
cov_12nc29_bubble$id <- "12NC29 Haplotig Regions of Primary Contigs"
cov_12sd80_bubble$id <- "12SD80 Haplotig Regions of Primary Contigs"
cov_12nc29_collapsed$id <- "12NC29 Collapsed Regions of Primary Contigs"
cov_12sd80_collapsed$id <- "12SD80 Collapsed Regions of Primary Contigs"
cov_12nc29_pwithouth$id <- "12NC29 Primary Contigs without Haplotigs"
cov_12sd80_pwithouth$id <- "12SD80 Primary Contigs without Haplotigs"
cov_12nc29_h$id <- "12NC29 Haplotigs"
cov_12sd80_h$id <- "12SD80 Haplotigs"

#Combine into new dataframes for plotting and rename columns
covDist_nc29 <- rbind(cov_12nc29_pwithouth, cov_12nc29_collapsed, cov_12nc29_bubble, cov_12nc29_h)
covDist_sd80 <- rbind(cov_12sd80_pwithouth, cov_12sd80_collapsed, cov_12sd80_bubble, cov_12sd80_h)
names(covDist_nc29) <- c("contig","start", "stop", "coverage", "id")
names(covDist_sd80) <- c("contig","start", "stop", "coverage", "id")
covDist_nc29$id <- factor(covDist_nc29$id, levels=c("12NC29 Primary Contigs without Haplotigs", "12NC29 Collapsed Regions of Primary Contigs", "12NC29 Haplotig Regions of Primary Contigs", "12NC29 Haplotigs"))
covDist_sd80$id <- factor(covDist_sd80$id, levels=c("12SD80 Primary Contigs without Haplotigs", "12SD80 Collapsed Regions of Primary Contigs", "12SD80 Haplotig Regions of Primary Contigs", "12SD80 Haplotigs"))

#now make plots
theme_set(theme_classic() + 
            theme(
              legend.text=element_text(size=11),
              axis.text=element_text(size=13),
              axis.title = element_text(size=15),
              axis.line = element_line(size=0.5),
              strip.text.y = element_blank()
              )
          )

#Joyplots
plot_nc29 <- (ggplot(covDist_nc29, aes(x=coverage, y=id, height=..density.., fill=id)) + 
           geom_joy(scale=5) + 
           scale_y_discrete(expand=c(1, 0)) + 
           xlim(0, 150) + 
           scale_fill_brewer(palette="Spectral") + 
           labs(fill="") +
           labs(x = "Average Depth Per Region", y="Fraction of Regions") +
           theme_joy())

plot_sd80 <- (ggplot(covDist_sd80, aes(x=coverage, y=id, height=..density.., fill=id)) + 
                geom_joy(scale=5) + 
                scale_y_discrete(expand=c(1, 0)) + 
                xlim(0, 150) + 
                scale_fill_brewer(palette="Spectral") + 
                labs(fill="") +
                labs(x = "Average Depth Per Region", y="Fraction of Regions") +
                theme_joy())


# Save the plots
png("coverage_plot_nc29_joy.png", units="in", width=15, height=10, res=300)
plot_nc29
dev.off()

png("coverage_plot_sd80_joy.png", units="in", width=15, height=10, res=300)
plot_sd80
dev.off()
