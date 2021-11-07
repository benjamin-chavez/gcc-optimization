CC = gcc-4.9
CC_C = gcc-9
CFLAGS = -g -l stdc++
O3NOTVEC = -fgcse-after-reload -finline-functions -fipa-cp-clone -fpredictive-commoning -ftree-loop-distribute-patterns -funswitch-loops  



all: clean optims assembly fenabled

optims:    
	$(CC) src/pres.cpp -o optimO2 $(CFLAGS) -O2   
	$(CC) src/pres.cpp -o optimO3 $(CFLAGS) -O3
	$(CC) src/pres.cpp -o optimO2_vec $(CFLAGS) -O2 -ftree-vectorize -fopt-info-vec-missed=vectorize.txt
	$(CC) src/pres.cpp -o optimO2_others $(CFLAGS) -O2 $(O3NOTVEC)
	
	# Optimizations Compiled on GCC 9
	$(CC_C) src/pres.cpp -o optimO2_gcc9 $(CFLAGS) -O2   
	$(CC_C) src/pres.cpp -o optimO3_gcc9 $(CFLAGS) -O3 

	# -O2 Optimization with individual runs for each flag added in -O3
	$(CC) src/pres.cpp -o fgcse-after-reload -fgcse-after-reload $(CFLAGS) -O2
	$(CC) src/pres.cpp -o finline-functions -finline-functions $(CFLAGS) -O2
	$(CC) src/pres.cpp -o fipa-cp-clone -fipa-cp-clone $(CFLAGS) -O2
	$(CC) src/pres.cpp -o fpredictive-commoning -fpredictive-commoning $(CFLAGS) -O2
	$(CC) src/pres.cpp -o ftree-loop-distribute-patterns -ftree-loop-distribute-patterns $(CFLAGS) -O2
	$(CC) src/pres.cpp -o ftree-vectorize -ftree-vectorize $(CFLAGS) -O2
	$(CC) src/pres.cpp -o funswitch-loops -funswitch-loops $(CFLAGS) -O2

	# -O2 Optimization with array differentiation (sorted, unsorted, reverse sorted, traverse)
	$(CC) src/pres_unsorted.cpp -o optimO2_unsorted $(CFLAGS) -O2
	$(CC) src/pres_reverse_sort.cpp -o optimO2_reverse_sort $(CFLAGS) -O2
	$(CC) src/pres_traverse_sorted.cpp -o optimO2_traverse_sorted $(CFLAGS) -O2
	$(CC) src/pres_unsorted.cpp -o optimO2_vec_unsorted -ftree-vectorize $(CFLAGS) -O2
	$(CC) src/pres_reverse_sort.cpp -o optimO2_vec_reverse_sort -ftree-vectorize $(CFLAGS) -O2
	$(CC) src/pres_traverse_sorted.cpp -o optimO2_vec_traverse_sorted -ftree-vectorize $(CFLAGS) -O2

	# Secondary example with embeded assembler instructions
	$(CC) src/cmov_example/cmov_test.c -o with_cmov -DCMOV -Wall -O2
	$(CC) src/cmov_example/cmov_test.c -o without_cmov -Wall -O2

	# Optimization with Loop differentiation
	$(CC) src/pres_sum_ternary.cpp -o optimO2_vec_sum_ternary -ftree-vectorize $(CFLAGS) -O2
	$(CC) src/pres_sum_global.cpp -o optimO2_vec_sum_global -ftree-vectorize $(CFLAGS) -O2
	

assembly:
	objdump -d optimO2 > optimO2dmp.txt
	objdump -d optimO3 > optimO3dmp.txt
	objdump -d optimO2_vec > optimO2vec_dmp.txt
	objdump -d optimO2_others > optimO2others_dmp.txt

	#$(CC) -S src/pres.cpp -o optimO2.s $(CFLAGS) -O2
	#$(CC) -S src/pres.cpp -o optimO3.s $(CFLAGS) -O3

fenabled: 
	$(CC) -c -O2 -Q --help=optimizers > otwo.txt
	$(CC) -c -O3 -Q --help=optimizers > othree.txt

test: 
	./optimO2
	./optimO3
	./optimO2_vec
	./optimO2_others

gcc4.9:
	./optimO2
	./optimO3

gcc9:
	./optimO2_gcc9
	./optimO3_gcc9

code-variations:
	./optimO2
	./optimO2_vec
	./optimO2_unsorted
	./optimO2_vec_unsorted
	./optimO2_reverse_sort
	./optimO2_vec_reverse_sort
	./optimO2_traverse_sorted
	./optimO2_vec_traverse_sorted 

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

cmov-example:
	time -f 'FORMAT' -p ./with_cmov
	@printf "\n"
	time -f 'FORMAT' -p ./without_cmov

vectorize-output: 
	$(CC) src/pres.cpp -ftree-vectorize -fopt-info-vec-all  $(CFLAGS) -O2

loop-variations:
	./optimO2
	./optimO2_vec
	./optimO2_vec_sum_ternary
	./optimO2_vec_sum_global
	
clean:
	rm -rf subdir
	rm -f optimO2 optimO3 optimO2_vec optimO2_others optimO2_gcc9 optimO3_gcc9 optimO2_unsorted optimO2_vec_unsorted optimO2_reverse_sort optimO2_vec_reverse_sort optimO2_traverse_sorted optimO2_vec_traverse_sorted with_cmov without_cmov optimO2_vec_sum_ternary optimO2_vec_sum_global
	rm -f optimO2.s optimO3.s
	rm -f optimO2dmp.txt optimO3dmp.txt optimO2vec_dmp.txt optimO2others_dmp.txt
	rm -f otwo.txt othree.txt vectorize.txt
	rm -f fgcse-after-reload finline-functions fipa-cp-clone fpredictive-commoning ftree-loop-distribute-patterns ftree-vectorize funswitch-loops

