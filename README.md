# Gionfriddo-et-al-hgcAB-amplicon-tutorial
This repository contains files for a step-by-step tutorial for processing and classifying mercury methylation genes (hgcAB) from a mock community dataset (Gionfriddo et al. 2020). The full-set of paired-end fastq files from the published study can be downloaded from the NCBI SRA database under BioProject: PRJNA608965. The tutorial dataset contains hgcAB amplicon sequencing of two mock communities. Each community is a mix of three cultured Hg-methylator isolates from the Deltaproteobacteria, Methanomicrobia (Euryarchaeota), and Firmicutes. The dataset also includes a salt marsh sediment sample (ID: 1064), and the marsh sample spiked with the two mock communities (1064 + mock community 1, 1064 + mock community 2). The hgcAB genes were amplified with primers ORNL-HgcAB-uni-F, ORNL-HgcAB-uni-32R (Gionfriddo et al. 2020) and sequenced on Illumina Miseq 2x300 bp. The hgcAB amplicon is ~980 nt bp long, and therefore with short-read sequencing employed in this study, the forward and reverse reads do not overlap. Only the forward reads are used for downstream analyses. Please see the paper for a more detailed explanation of the methods. The trimmed (201 nt bp) forward read hgcA sequences are classified using the ORNL compiled Hg-methylator database reference package for short sequences, ‘ORNL_HgcA_201.refpkg’.

The contents of the repository include:

<b>Gionfriddo-et-al-hgcAB-amplicon-tutorial-directions.pdf: step-by-step instructions </b>
•	The raw paired-end sequencing files for five samples:
  o	1064_Alt35_S186_R1_001.fastq.zip
  o	1064_Alt35_S186_R2_001.fastq.zip
  o	m1combo1_Alt30_S69_R1_001.fastq.zip
  o	m1combo1_Alt30_S69_R2_001.fastq.zip
  o	m2combo2_Alt30_S103_R1_001.fastq.zip
  o	m2combo2_Alt30_S103_R2_001.fastq.zip
  o	m1064_1combo1_Alt35_S73_R1_001.fastq.zip
  o	m1064_1combo1_Alt35_S73_R2_001.fastq.zip
  o	m1064_2combo1_Alt35_S84_R1_001.fastq.zip
  o	m1064_2combo1_Alt35_S84_R2_001.fastq.zip
•	sample_ids.txt: text file of sample information/IDs for fastq sequencing files
•	ORNL_HgcA_201.refpkg: the ORNL compiled Hg-methylator database reference package
•	HgcA_201_hmm: hidden markov model of HgcA homology from ORNL_HgcA_201.refpkg
•	metadata.csv: table of metadata for sample IDs to be used with R scripts
•	Gionfriddo-HgcA-tutorial-make-taxonomy-table.R: custom R script for assigning taxonomy classifications from pplacer to OTUs
•	Gionfriddo-HgcA-tutorial-make-bar-plot.R: custom R script for making a bar plot of relative abundances of OTUs

Reference:

Gionfriddo, C.M., Wymore, A.M., Jones, D.S., Wilpiszeski, R.L., Lynes, M.M., Christensen, G.A., Soren, A., Gilmour, C.C., Podar, M. and Elias, D., 2020. An improved hgcAB primer set and direct high throughput sequencing expand Hg-methylator diversity in nature. BioRxiv.

