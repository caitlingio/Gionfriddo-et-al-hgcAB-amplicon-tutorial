#R script for hgcAB tutorial by CM Gionfriddo
#data from Gionfriddo, C.M., Wymore, A.M., Jones, D.S., Wilpiszeski, R.L., Lynes, M.M., Christensen, G.A.,  Soren, A., Gilmour, C.C., Podar, M. and Elias, D., 2020. An improved hgcAB primer set and direct high throughput sequencing expand Hg-methylator diversity in nature. BioRxiv. 
#set working directory to folder with pplacer outputs
setwd("~/Desktop/Gionfriddo-et-al-hgcAB-amplicon-tutorial/")
#load programs BoSSA, phyloseq, ggplot2, and RColorBrewer
library(BoSSA)
library(phyloseq)
library(ggplot2)
library(RColorBrewer)

#edit OTU Ids in "taxo_table.csv" to match OTU Ids in OTU table ("all_forward_nonchimeras_cluster90_otu") - manually remove "_1/1-67" part of ID that was added during the hmm alignment steps. Save new taxonomy table: "taxo_table_edited.csv"

#Then filter the OTU table for only OTUs that passed quality filtering steps and were classified as hgcA. In Excel I copy OTU Ids from taxonomy table into #OTUId column, then use "highlight duplicate cells", and filtering to show only OTUIds that have been classified. Then copy to new document, and save as "otu_table_filtered.csv". 

#order OTU Ids in both "otu_table_filtered.csv" and "taxo_table_edited.csv" so that the order matches in both

#import the OTU table and taxonomy table into R then convert to matrix
otu_table <- read.csv("otu_table_filtered.csv",header=TRUE,row.names=1, sep=",")
tax_table <- read.csv("taxo_table.csv",header=TRUE,row.names=1, sep=",")
otu_matrix <- as.matrix(otu_table)
tax_matrix <- as.matrix(tax_table)

#import table with metadata, including mock community names
metadata <- read.csv("metadata.csv",header=TRUE,row.names=1, sep=",")


#make phyloseq object with OTU table and taxonomy (i.e. TAX) table
OTU = otu_table(otu_matrix, taxa_are_rows=TRUE)
TAX = tax_table(tax_matrix)
phyloseq_obj = phyloseq(OTU,TAX)

#add sample metadata and create new phyloseq object
community = metadata[1:5,1]
sampledata = sample_data(data.frame(community, row.names=sample_names(phyloseq_obj)))
phyloseq_obj_meta = merge_phyloseq(phyloseq_obj, sampledata)

#transform OTU counts by calculating relative abundance
phyloseq_object_meta_RA = transform_sample_counts(phyloseq_obj_meta, function(x)x/sum(x))

#combine phyla and class taxonomy into one object: Phylum_Class
myranks = c("phylum", "class")
phyloseq_object_meta_RA_tax = prune_taxa(tail(names(sort(taxa_sums(phyloseq_object_meta_RA))), 299), phyloseq_object_meta_RA)
tax_table(phyloseq_object_meta_RA_tax) <- cbind(tax_table(phyloseq_object_meta_RA_tax), Strain=taxa_names(phyloseq_object_meta_RA_tax))
mylabels = apply(tax_table(phyloseq_object_meta_RA_tax)[, myranks], 1, paste, sep="", collapse="_")
tax_table(phyloseq_object_meta_RA_tax) <- cbind(tax_table(phyloseq_object_meta_RA_tax), Phylum_Class=mylabels)
phyloseq_object_meta_RA_tax_merge = tax_glom(phyloseq_object_meta_RA_tax, "Phylum_Class")

#plot community composition as bar chart, set color palette for 20 different variables (colorCount = 20) with RColorBrewer and getPalette function. Save plot as pdf
getPalette = colorRampPalette(brewer.pal(12,"Set3"))
colourCount=20
pdf("mock_community_bar_plot_RA.pdf")
print(plot_bar(phyloseq_object_meta_RA_tax_merge,"community",fill="Phylum_Class") + geom_bar(aes(color=Phylum_Class,fill=Phylum_Class), stat="identity", position="stack") + scale_fill_manual(values = getPalette(colourCount)) + scale_color_manual(values = getPalette(colourCount)))
dev.off()

#end of script