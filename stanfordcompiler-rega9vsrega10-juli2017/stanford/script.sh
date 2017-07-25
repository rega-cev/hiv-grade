ktheys0@caipirinha:~/stanford$ cat script.txt 
ktheys0@caipirinha:~/stanford$ cat script.txt 
IN.v1000.csv  IN.v910.csv  result.PR.v1000.csv  result.PR.v910.csv  result.RT.v1000.csv  result.RT.v910.csv




pr9<-read.csv('result.PR.v1000.csv')
pr10<-read.csv('result.PR.v910.csv')


prmismatch<-NULL
for(k in 2:24)
{
print(names(pr9)[k])
#print(table(paste(pr9[,k],pr10[,k],sep='_')))  # all vgl 
#print(table(pr9[,k],pr10[,k])) 

#print((table(paste(pr9[pr9[,k]!=pr10[,k],k],pr10[pr9[,k]!=pr10[,k],k],sep='-'))))



pr910<-merge(pr9,pr10,by='id')
col<-grep(names(pr9)[k],names(pr910))
print(pr910[pr910[,col[1]]!=pr910[,col[2]],c(1,col)])  # print the id and the scores 
print(table(pr910[,col[1]]!=pr910[,col[2]]))   #print the numbers of mismatches


if(nrow(pr910[pr910[,col[1]]!=pr910[,col[2]],c(1,col)]) > 0){
drugnow<-cbind(pr910[pr910[,col[1]]!=pr910[,col[2]],c(1,col)],names(pr9)[k])

names(drugnow) <-c('id','drug9','drug10','drug') 
prmismatch<-rbind(prmismatch,drugnow)
names(prmismatch) <-c('id','drug9','drug10','drug') 

}

}

DRV 5000
TPV



########################################################################


pr10<-read.csv('result.RT.v1000.csv')
pr9<-read.csv('result.RT.v910.csv')

rtmismatch<-NULL
for(k in 2:24)
{
print(names(pr9)[k])
#print(table(paste(pr9[,k],pr10[,k],sep='_')))  # all vgl 
#print(table(pr9[,k],pr10[,k])) 

#print((table(paste(pr9[pr9[,k]!=pr10[,k],k],pr10[pr9[,k]!=pr10[,k],k],sep='-'))))



pr910<-merge(pr9,pr10,by='id')
col<-grep(names(pr9)[k],names(pr910))
#print(pr910[pr910[,col[1]]!=pr910[,col[2]],c(1,col)])
print(table(pr910[,col[1]]!=pr910[,col[2]]))

if(nrow(pr910[pr910[,col[1]]!=pr910[,col[2]],c(1,col)]) > 0){
drugnow<-cbind(pr910[pr910[,col[1]]!=pr910[,col[2]],c(1,col)],names(pr9)[k])

names(drugnow) <-c('id','drug9','drug10','drug') 
rtmismatch<-rbind(rtmismatch,drugnow)
names(rtmismatch) <-c('id','drug9','drug10','drug') 
}
}


D4T   1716
TDF_SIR"   4888

####################################################################

pr10<-read.csv('IN.v1000.csv')
pr9<-read.csv('IN.v910.csv')

inmismatch <- NULL


for(k in 2:24)
{
print(names(pr9)[k])
#print(table(paste(pr9[,k],pr10[,k],sep='_')))  # all vgl 
#print(table(pr9[,k],pr10[,k])) 

#print((table(paste(pr9[pr9[,k]!=pr10[,k],k],pr10[pr9[,k]!=pr10[,k],k],sep='-'))))



pr910<-merge(pr9,pr10,by='id')
col<-grep(names(pr9)[k],names(pr910))
#print(pr910[pr910[,col[1]]!=pr910[,col[2]],c(1,col)])
print(table(pr910[,col[1]]!=pr910[,col[2]]))


if(nrow(pr910[pr910[,col[1]]!=pr910[,col[2]],c(1,col)]) > 0){
drugnow<-cbind(pr910[pr910[,col[1]]!=pr910[,col[2]],c(1,col)],names(pr9)[k])

names(drugnow) <-c('id','drug9','drug10','drug') 
inmismatch<-rbind(inmismatch,drugnow)
names(inmismatch) <-c('id','drug9','drug10','drug') 
}
}

DTG 244
EVG_SIR 3
RAL 296





#prmismatch
nrow(prmismatch)
table(prmismatch$drug)
length(unique(prmismatch$id))

#inmismatch
nrow(inmismatch)
table(inmismatch$drug)
length(unique(inmismatch$id))

#rtmismatch
nrow(rtmismatch)
table(rtmismatch$drug)
length(unique(rtmismatch$id))

write.table(rtmismatch,file='rtmismatch.csv',sep=',',quote=F,row.names=F)
write.table(inmismatch,file='inmismatch.csv',sep=',',quote=F,row.names=F)
write.table(prmismatch,file='prmismatch.csv',sep=',',quote=F,row.names=F)


grep -v ',,' inmismatch.csv  > inmismatch2.csv




 nrow(prmismatch)
[1] 5040
> table(prmismatch$drug)

DRV.r_SIR TPV.r_SIR 
     4994        46 
> length(unique(prmismatch$id))

[1] 5000
> 
> #inmismatch
> nrow(inmismatch)
[1] 543
> table(inmismatch$drug)

DTG_SIR EVG_SIR RAL_SIR 
    244       3     296 
> length(unique(inmismatch$id))
[1] 520
> 
> #rtmismatch
> nrow(rtmismatch)
[1] 6625
> table(rtmismatch$drug)

 X3TC_SIR   ABC_SIR ATV.r_SIR   AZT_SIR   D4T_SIR   DDI_SIR DRV.r_SIR   DTG_SIR 
        1         1         1         1      1716         1         1         1 
  EFV_SIR   ETR_SIR   EVG_SIR FPV.r_SIR   FTC_SIR IDV.r_SIR LPV.r_SIR   NFV_SIR 
        1         1         1         1         1         1         1         1 
  NVP_SIR   RAL_SIR   RPV_SIR SQV.r_SIR   T20_SIR   TDF_SIR TPV.r_SIR 
        1         1         1         1         1      4888         1 
> length(unique(rtmismatch$id))
[1] 6603





cut -f1 -d , prmismatch.csv  > headerpr
cut -f1 -d , rtmismatch.csv  > headerrt
cut -f1 -d , inmismatch.csv  > headerin




# 
cp /home/pridt00403/stanford/new/IN.txt . 


## combine headers seq + SIR discordan  + drug + treatment

cut -f2,3,296,297 /home/pridt00403/stanford/new/IN.txt 
PtID    IsolateName     AccessionID     NASeq

PR is cut -f 2,3,107,108 PR.txt
en RT is cut -f 2,3,568,569 RT.txt



cut -f2,3,107,7 /home/pridt00403/stanford/new/PR.txt > pr-treatment.txt
cut -f1,2,4 pr-treatment.txt > pr-treatment-temp1.txt
%s/\t/|/g
cut -f3 pr-treatment.txt > pr-treatment-temp2.txt
paste  -d ,  pr-treatment-temp1.txt pr-treatment-temp2.txt > pr-treatment2.txt

cut -f2,3,568,7 /home/pridt00403/stanford/new/RT.txt > rt-treatment.txt
cut -f1,2,4 rt-treatment.txt > rt-treatment-temp1.txt
%s/\t/|/g
cut -f3 rt-treatment.txt > rt-treatment-temp2.txt
paste  -d ,  rt-treatment-temp1.txt rt-treatment-temp2.txt > rt-treatment2.txt

cut -f2,3,296,7 /home/pridt00403/stanford/new/IN.txt > in-treatment.txt
cut -f1,2,4 in-treatment.txt > in-treatment-temp1.txt
%s/\t/|/g
cut -f3 in-treatment.txt > in-treatment-temp2.txt
paste  -d ,  in-treatment-temp1.txt in-treatment-temp2.txt > in-treatment2.txt


## select the seqs uit de grote fasta file 
# copy headers file to crunchie
# /home/ktheys0/stanford-compiler-2017/ewoutjuly2017

perl ../../selectSeqs.pl -f headerpr /home/pridt00403/stanford/new/PR-seq.aligned.nodoubles.fasta > PR-seq.aligned.nodoubles-discordant.fasta
perl ../../selectSeqs.pl -f headerrt /home/pridt00403/stanford/new/RT-seq.aligned.nodoubles.fasta > RT-seq.aligned.nodoubles-discordant.fasta
perl ../../selectSeqs.pl -f headerin /home/pridt00403/stanford/new/IN-seq.aligned.nodoubles.fasta > IN-seq.aligned.nodoubles-discordant.fasta


python newlines.py  PR-seq.aligned.nodoubles-discordant.fasta > PR-seq.aligned.nodoubles-discordant.csv
python newlines.py RT-seq.aligned.nodoubles-discordant.fasta > RT-seq.aligned.nodoubles-discordant.csv
python newlines.py IN-seq.aligned.nodoubles-discordant.fasta  > IN-seq.aligned.nodoubles-discordant.csv

%s/\(>.*\)\n/\1,/g

RT te groot for vi 
python newlines2.py RT-seq.aligned.nodoubles-discordant.csv  > z
mv z RT-seq.aligned.nodoubles-discordant2.csv 


# terug van crunchie naar cai
scp -r ktheys0@10.33.21.53:/home/ktheys0/stanford-compiler-2017/ewoutjuly2017/ . 


#R 

a <-read.csv('prmismatch.csv',sep=',')
b <-read.csv('./ewoutjuly2017/pr-treatment2.txt',sep=',')
c<-merge(a,b,by.x='id',by.y='PtID.IsolateName.AccessionID')

d <- read.csv('./ewoutjuly2017/PR-seq.aligned.nodoubles-discordant.csv',sep=',',header=F)
names(d)<-c('id','seq')
e <- merge(c,d,by='id')
nrow(a);nrow(b);nrow(c);nrow(d);nrow(e)

e$SIR<-paste(e$drug9,e$drug10,sep='')
sort(table(e$SIR))
sort(table(e$PIList!='None'))
table(e$SIR,e$PIList!='None')

#unique(e$SIR) #[1] "SI" "IR" "SR"
f<-e[e$PIList=='None' & e$SIR==unique(e$SIR)[1],]
write.table(file='pr-none-SI.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$PIList=='None' & e$SIR==unique(e$SIR)[2],]
write.table(file='pr-none-IR.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$PIList=='None' & e$SIR==unique(e$SIR)[3],]
write.table(file='pr-none-SR.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

g<-e[e$PIList!='None' & e$SIR==unique(e$SIR)[1],]
write.table(file='pr-treat-SI.csv',paste(paste(g$id,g$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

g<-e[e$PIList!='None' & e$SIR==unique(e$SIR)[2],]
write.table(file='pr-treat-IR.csv',paste(paste(g$id,g$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

g<-e[e$PIList!='None' & e$SIR==unique(e$SIR)[3],]
write.table(file='pr-treat-SR.csv',paste(paste(g$id,g$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)




write.table(e,file='prmismatch-treat.csv',sep=',', quote=F, row.names=F)






grep -v ',,' rtmismatch.csv  > rtmismatch2.csv


a <-read.csv('rtmismatch2.csv',sep=',')
b <-read.csv('./ewoutjuly2017/rt-treatment2.txt',sep=',')
c<-merge(a,b,by.x='id',by.y='PtID.IsolateName.AccessionID')

d <- read.csv('./ewoutjuly2017/RT-seq.aligned.nodoubles-discordant2.csv',sep=',',header=F)
names(d)<-c('id','seq')
e <- merge(c,d,by='id')
nrow(a);nrow(b);nrow(c);nrow(d);nrow(e)


e$SIR<-paste(e$drug9,e$drug10,sep='')
sort(table(e$SIR))
sort(table(e$RTIList!='None'))
table(e$SIR,e$RTIList!='None')


#unique(e$SIR) #[1] "SI" "IR" "SR" "IS"
f<-e[e$RTIList=='None' & e$SIR==unique(e$SIR)[1],]
write.table(file='rt-none-SI.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$RTIList=='None' & e$SIR==unique(e$SIR)[2],]
write.table(file='rt-none-IR.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$RTIList=='None' & e$SIR==unique(e$SIR)[3],]
write.table(file='rt-none-SR.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$RTIList=='None' & e$SIR==unique(e$SIR)[4],]
write.table(file='rt-none-IS.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)


g<-e[e$RTIList!='None' & e$SIR==unique(e$SIR)[1],]
nrow(g)
write.table(file='rt-treat-SI.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)

g<-e[e$RTIList!='None' & e$SIR==unique(e$SIR)[2],]
nrow(g)

write.table(file='rt-treat-IR.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)

g<-e[e$RTIList!='None' & e$SIR==unique(e$SIR)[3],]
nrow(g)

write.table(file='rt-treat-SR.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)

g<-e[e$RTIList!='None' & e$SIR==unique(e$SIR)[4],]
nrow(g)

write.table(file='rt-treat-IS.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)



write.table(c,file='rtmismatch-treat.csv',sep=',', quote=F, row.names=F)






a <-read.csv('inmismatch2.csv',sep=',')
b <-read.csv('./ewoutjuly2017/in-treatment2.txt',sep=',')
c<-merge(a,b,by.x='id',by.y='PtID.IsolateName.AccessionID') #all.x = TRUE)

d <- read.csv('./ewoutjuly2017/IN-seq.aligned.nodoubles-discordant.csv',sep=',',header=F)
names(d)<-c('id','seq')
e <- merge(c,d,by='id')
nrow(a);nrow(b);nrow(c);nrow(d);nrow(e)


e$SIR<-paste(e$drug9,e$drug10,sep='')
sort(table(e$SIR))
sort(table(e$INIList!='None'))
table(e$SIR,e$INIList!='None')


#unique(e$SIR) #[1] "SI" "RI" "IS" "RS" "IR" "SR"
f<-e[e$INIList=='None' & e$SIR==unique(e$SIR)[1],]
write.table(file='in-none-SI.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$INIList=='None' & e$SIR==unique(e$SIR)[2],]
write.table(file='in-none-RI.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$INIList=='None' & e$SIR==unique(e$SIR)[3],]
write.table(file='in-none-IS.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$INIList=='None' & e$SIR==unique(e$SIR)[4],]
write.table(file='in-none-RS.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$INIList=='None' & e$SIR==unique(e$SIR)[5],]
write.table(file='in-none-IR.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)

f<-e[e$INIList=='None' & e$SIR==unique(e$SIR)[6],]
write.table(file='in-none-SR.csv',paste(paste(f$id,f$SIR,sep='-'),f$seq),sep=',', quote=F, row.names=F)


g<-e[e$INIList!='None' & e$SIR==unique(e$SIR)[1],]
write.table(file='in-treat-SI.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)

g<-e[e$INIList!='None' & e$SIR==unique(e$SIR)[2],]
write.table(file='in-treat-RI.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)

g<-e[e$INIList!='None' & e$SIR==unique(e$SIR)[3],]
write.table(file='in-treat-IS.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)

g<-e[e$INIList!='None' & e$SIR==unique(e$SIR)[4],]
write.table(file='in-treat-RS.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)

g<-e[e$INIList!='None' & e$SIR==unique(e$SIR)[5],]
write.table(file='in-treat-IR.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)

g<-e[e$INIList!='None' & e$SIR==unique(e$SIR)[6],]
write.table(file='in-treat-SR.csv',paste(paste(g$id,g$SIR,sep='-'),g$seq),sep=',', quote=F, row.names=F)








write.table(c,file='inmismatch-treat.csv',sep=',', quote=F, row.names=F)


 wc *none*
wc *treat* | grep -v 'match'


ktheys0@caipirinha:~/stanford$  wc *none*
      7      13    5362 in-none-IR.csv
    242     483  214498 in-none-IS.csv
      1       1       2 in-none-RI.csv
     10      19    8062 in-none-RS.csv
     18      35   15191 in-none-SI.csv
      2       3     898 in-none-SR.csv
      
     18      35    4841 pr-none-IR.csv
    117     233   25590 pr-none-SI.csv
     13      25    2327 pr-none-SR.csv
   
   1772    3543 1131890 rt-none-IR.csv
   1545    3089 1398984 rt-none-IS.csv
    658    1315  456109 rt-none-SI.csv
   1059    2117  605531 rt-none-SR.csv


ktheys0@caipirinha:~/stanford$ wc *treat* | grep -v 'match'
     71     141   62210 in-treat-IR.csv
     97     193   84431 in-treat-IS.csv
    102     203   89680 in-treat-RI.csv
     39      77   33784 in-treat-RS.csv
      5       9    3569 in-treat-SI.csv
      8      15    6243 in-treat-SR.csv

    816    1631  165110 pr-treat-IR.csv
   3256    6511  657683 pr-treat-SI.csv
    956    1911  194229 pr-treat-SR.csv
   
   1672    3343 1584357 rt-treat-IR.csv
   1545    3089 1390917 rt-treat-IS.csv
   1545    3089 1388779 rt-treat-SI.csv
   1545    3089 1393683 rt-treat-SR.csv
   
   
 rm wegprnone;  for i in pr-none*csv; do echo $i ;  grep NA-NA $i >> wegprnone ; done
 rm wegprtreat;  for i in pr-treat*csv; do echo $i ;  grep NA-NA $i >> wegprtreat ; done

   for i in pr-*csv; do echo $i ;  grep NA-NA $i >> wegpr ; done

   for i in rt-*csv; do echo $i ;  grep NA-NA $i >> wegrt ; done
   for i in in-*csv; do echo $i ;  grep NA-NA $i >> wegin ; done
   


for file in *treat-*; do grep -v 'x' $file  | tr ' ' ',' > tet ; mv tet $file; done 
for file in *none-*; do grep -v 'x' $file  | tr ' ' ',' > tet ; mv tet $file; done 


## upload to stanford gui

/home/ktheys0/stanford


rm in-none-RI.csv   # only ix as id 

#linux 
shuf -n 50 rt-treat-IR.csv  | wc





# mac 
for file in *treat-*; do jot -r "$(wc -l $file)" 1 | paste - $file | sort -n | cut -f 2- | head -n 1000  > "shuf.${file}" ; done
for file in *none-*; do jot -r "$(wc -l $file)" 1 | paste - $file | sort -n | cut -f 2- | head -n 1000  > "shuf.${file}" ; done


#make fasta
for shuffie in shuf*; do gsed 's/^/>/g' $shuffie | gsed 's/,/\n/g' > "${shuffie}.fasta"; done 







#################################################################


https://github.com/rega-cev/Rega-ASI/blob/master/rega-algorithm-rules-document.md


#######Tenofovir#########

Rules are for both TDF and TAF. (from Kristel conversation 21 July 2015 01:30 PM: "DRV/c should be interpreted in a similar way as DRV/r, and TAF as TDF, until evidence to the contrary.")

High level resistance:

69X-XX or (65NR and not 184IV) or (41L+210W+215Y and no 184I/V) or [at least 3 mutations of [(67N, 70R, 215ACDEGHILNSVYF, 219EHNQR) + at least one mutation (41L, 210W)]

Intermediate resistance:

70EG or [65NR and 184IV] or [41L+210W+215Y+184IV]  or [at least 2 mutations of (67N,70R, 215ACDEGHILNSVYF,219EHNQR) + at least one mutation (41L, 210W)] or [151M and at least 3 mutations of (75I,77L,116Y)]

***Comments: increased the weight of TAM 1 mutations, and the predictive value of 41L and 210W, according to the paper from Michael Miller (2004, JID) on intensification studies with TDF ***






#######Tipranavir/r#######

High level resistance: score at least 3,5

Intermediate resistance: score at least 2

Score 2: I47V, T74P, L82T;

Score 1,5: Q58E, V82L/S, N83D;

Score 1: 41T, K43T, I54A/M/V, I84A/C/V; 

Score 0,5: L33F , I47A, M46L, I54S/T, gagV128I, gagA431V, gagL449F, gagR452S, gagP453L;

Score 0,25: V32I, 38W, 45I, A71L, G73T, I82A/F/M, L89T/V, L90M;

Score -0,25: 50L/V

Comment: gag mutations added; I50V added as a negative score mutation



###### Darunavir/r ####### 

High level resistance: score at least 3,5

Intermediate resistance: score at least 2,5

Score 1,5: I50V, L76V, I84A/C/V;

Score 1: V32I, I47A/V, I54L/M, gagV128I;

Score 0,5: V11I, L33F, T74P, L89V, gagS451T, gagR452T, gagA431V;

Score 0,25: M46I, L89I;

Score -0,25: I50L, N88S, V82A/S/T

Comments: completely new set of rules





#######Proposal of rules for interpretation of Elvitegravir resistance#######

High level resistance: score at least 2

Intermediate resistance: score at least 1

Score 2: T66A/I/K, E92Q/G, P145S, Q146ILPR, S147G, Q148HKR, N155H/S/T

Score 1: F121Y, G140A/C/S, V151A/L

SCORE 0,5: H51Y, T97A, H114Y, Q146K, S153F/Y, R263K

***** Comments: not much, the last review was not so long ago. Only mutations V151A/L were added


#######Dolutegravir Rules#######

High level resistance: score at least 2

Intermediate resistance: score at least 1,5

Score 2: (A49G+S230R+R263K)

Score 1,5: (Q148H/K/R+L74I)

Score 1: Q148H/K/R, G118R, R263K;

Score 0,5: T66K, L74M, E92Q, G140A/C/S, I151L, S153F/Y, N155H/S/T,

Score 0,25: A49G/P, T97A, F121Y, S147G, S230G/R

***** Completely new set of rules


#######Raltegravir#######

High level resistance: score at least 2

Intermediate resistance: score at least 1

Score 2: Y143C/H/K/R/S, Q148H/K/R, N155H/S/T

Score 1: T66K, E92Q/V, G118R, F121Y, G140A/C/S, V151L;

Score 0,5: L74M, T97A, E138A, G163K

Score 0,25: E138K, G163R, S119R, V151I, E157Q, S230N/R, R263K

***** Comments: correction of typing error in score 2 (it was 20 in the previous version of the algorithm); added mutations 143/K/S, N155T, T66K, E92V, G118R, F121Y, V151L, G140C, E157Q, S230N/R, R263K.

***** All mutations at codon 143 are now scored 2; L74M, T97A, E138A and G163K are now scored 0,5

 ***** Positions 206 and 232 are highly polymorphic; mutations at these positions were now excluded.



