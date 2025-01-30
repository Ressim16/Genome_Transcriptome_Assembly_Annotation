# I run it on the command line!

#nb genes
grep -P '\tgene\t' /data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.final.gff3 | wc -l
# 27760 

#nb mRNA
grep -P '\tmRNA\t' /data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.final.gff3 | wc -l
# 30631

#nb annotated genes
grep -P '\tgene\t' /data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.final.gff3 | grep 'InterPro' | wc -l
# 21557

#gene length
grep -P '\tgene\t' /data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.final.gff3 | awk '{diff = $5 - $4; sum += diff; if (NR == 1) {min = max = diff} else {if (diff < min) min = diff; if (diff > max) max = diff}} END {print "Min:", min, "Max:", max, "Mean:", sum / NR}'
# Min: 5 Max: 114055 Mean: 2178.49

# mRNA length
grep -P '\tmRNA\t' /data/users/rzahri/annotation_course/output/AED/filtered.genes.renamed.final.gff3 | awk '{diff = $5 - $4; sum += diff; if (NR == 1) {min = max = diff} else {if (diff < min) min = diff; if (diff > max) max = diff}} END {print "Min:", min, "Max:", max, "Mean:", sum / NR}'
# Min: 5 Max: 193086 Mean: 2444.89