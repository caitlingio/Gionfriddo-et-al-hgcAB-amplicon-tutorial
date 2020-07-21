#R script for hgcAB tutorial by CM Gionfriddo
#data from Gionfriddo, C.M., Wymore, A.M., Jones, D.S., Wilpiszeski, R.L., Lynes, M.M., Christensen, G.A.,  Soren, A., Gilmour, C.C., Podar, M. and Elias, D., 2020. An improved hgcAB primer set and direct high throughput sequencing expand Hg-methylator diversity in nature. BioRxiv. 
#set working directory to folder with pplacer outputs
setwd("~/Desktop/Gionfriddo-et-al-hgcAB-amplicon-tutorial/")
#load programs BoSSA, phyloseq, ggplot2, and RColorBrewer
library(BoSSA)
library(phyloseq)
library(ggplot2)
library(RColorBrewer)
#set path to ORNL HgcA reference package that has tax IDs for taxonomy assigned to hgcA OTUs by pplacer
refpkg_path <- file.path("ORNL_HgcA_201.refpkg/")
taxo <- refpkg(refpkg_path,type="taxonomy")
#input classification database (sqlite formatted file, pplacer object: "all_forward_nonchimeric_90_201_classify") and jplace file with phylogenetic placements of hgcA OTUs ("all.denovo.nonchimeras_cluster90_aa_filtered_hmm_alignment.jplace")  
sqlite_file <- file.path("all_forward_nonchimeric_90_201_classify")
jplace_file <- file.path("all.denovo.nonchimeras_cluster90_aa_filtered_hmm_alignment.jplace")
pplace_object <- read_sqlite(sqlite_file,jplace_file)
taxo_table <- pplace_to_taxonomy(pplace_object,taxo,tax_name=TRUE,rank=c("phylum","class","order","family","genus","species"))
write.csv(taxo_table,"taxo_table.csv")