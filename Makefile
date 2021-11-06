CC = gcc-4.9
CC_C = gcc-9
CFLAGS = -g -l stdc++
O3NOTVEC = -fgcse-after-reload -finline-functions -fipa-cp-clone -fpredictive-commoning -ftree-loop-distribute-patterns -funswitch-loops  

all: clean optims assembly fenabled  o2optimizations

optims:    
	$(CC) pres.cpp -o optimO2 $(CFLAGS) -O2   
	$(CC) pres.cpp -o optimO3 $(CFLAGS) -O3
	$(CC) pres.cpp -o optimO2_vec $(CFLAGS) -O2 -ftree-vectorize -fopt-info-vec-missed=vectorize.txt
	$(CC) pres.cpp -o optimO2_others $(CFLAGS) -O2 $(O3NOTVEC)
	# Optimizations Compiled on GCC 9
	$(CC_C) pres.cpp -o optimO2_gcc9 $(CFLAGS) -O2   
	$(CC_C) pres.cpp -o optimO3_gcc9 $(CFLAGS) -O3 

assembly:
	objdump -d optimO2 > optimO2dmp.txt
	objdump -d optimO3 > optimO3dmp.txt
	objdump -d optimO2_vec > optimO2vec_dmp.txt
	objdump -d optimO2_others > optimO2others_dmp.txt

	#$(CC) -S pres.cpp -o optimO2.s $(CFLAGS) -O2
	#$(CC) -S pres.cpp -o optimO3.s $(CFLAGS) -O3

fenabled: 
	$(CC) -c -O2 -Q --help=optimizers > otwo.txt
	$(CC) -c -O3 -Q --help=optimizers > othree.txt

test: 
	./optimO2
	./optimO3
	./optimO2_vec
	./optimO2_others

gcc9:
	./optimO2_gcc9
	./optimO3_gcc9

o2optimizations:
	$(CC) pres.cpp -o fgcse-after-reload -fgcse-after-reload $(CFLAGS) -O2
	$(CC) pres.cpp -o finline-functions -finline-functions $(CFLAGS) -O2
	$(CC) pres.cpp -o fipa-cp-clone -fipa-cp-clone $(CFLAGS) -O2
	$(CC) pres.cpp -o fpredictive-commoning -fpredictive-commoning $(CFLAGS) -O2
	$(CC) pres.cpp -o ftree-loop-distribute-patterns -ftree-loop-distribute-patterns $(CFLAGS) -O2
	$(CC) pres.cpp -o ftree-vectorize -ftree-vectorize $(CFLAGS) -O2
	$(CC) pres.cpp -o funswitch-loops -funswitch-loops $(CFLAGS) -O2

o2withflags:
	./optimO2
	./optimO3
	./fgcse-after-reload
	./finline-functions
	./fipa-cp-clone
	./fpredictive-commoning
	./ftree-loop-distribute-patterns
	./ftree-vectorize
	./funswitch-loops

clean:
	# rm -rf subdir
	rm -f optimO2 optimO3 optimO2_vec optimO2_others
	#rm -f optimO2.s optimO3.s
	rm -f optimO2dmp.txt optimO3dmp.txt optimO2vec_dmp.txt optimO2others_dmp.txt
	rm -f otwo.txt othree.txt vectorize.txt
	rm -f fgcse-after-reload finline-functions fipa-cp-clone fpredictive-commoning ftree-loop-distribute-patterns ftree-vectorize funswitch-loops
