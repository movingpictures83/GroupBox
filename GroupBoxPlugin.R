library(ggpubr)
library(gplots)
library(viridis)
library(hrbrthemes)
library(ggsci)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")


input <- function(inputfile) {
 print("HI")
  pfix = prefix()
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
  print(parameters)
   # Need to get the three files
   assay <<- read.table(paste(pfix, parameters["abundance", 2], sep="/"), header = TRUE, sep=',')
   #x <<- textConnection(paste(pfix, parameters["taxa", 2], sep="/"))
   #x <<- readLines(con="pipelines/GulfWar/taxa.diet.txt")#textConnection(con="pipelines/GulfWar/taxa.diet.txt"))
   #print(x)
   species_combined_list <<- readLines(paste(pfix, parameters["taxa", 2], sep="/"))
   print("SP COMB")
   print(species_combined_list)
}

run <- function() {}

output <- function(outputfile) {
	# Distinct colors:
library(RColorBrewer)
colourCount = 4
getPalette = colorRampPalette(brewer.pal(4, "Paired"))
write.csv(assay, paste(outputfile, "csv", sep="."))
for(species in species_combined_list) {
#  print(species)
#
  but_plot <- ggboxplot(assay, x="Group" , y = species,
                        color = "black",  fill="Group") +
    theme(axis.title.x = element_text(size=0, face="bold"), axis.text.x =element_text(size=12, face="bold")) +
    scale_fill_manual(values = getPalette(colourCount)) +
    theme_gray() #+ ylim(0,150) #+ coord_flip()
  but_plot
  ggsave(paste(outputfile, species, "png", sep='.'), plot=but_plot, device = "png", dpi = 300)
}
#

}
