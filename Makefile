CC = gcc-4.9
CFLAGS = -g -l stdc++

all: clean optims  
#-c is compile and assemble but do not link

optims: # add dependencies here to stop recompilation  
	$(CC) pres.cpp -o optimO2 $(CFLAGS) -O2   
	$(CC) pres.cpp -o optimO3 $(CFLAGS) -O3
	$(CC) -S pres.cpp -o optimO2.s $(CFLAGS) -O2
	$(CC) -S pres.cpp -o optimO3.s $(CFLAGS) -O3
	objdump -d optimO2 > optimO2dmp.txt
	objdump -d optimO3 > optimO3dmp.txt
	$(CC) -c -O2 -Q --help=optimizers > otwo.txt
	$(CC) -c -O3 -Q --help=optimizers > othree.txt

test: 
	./optimO2
	./optimO3

# rm -f flag ignores nonexistant files
# >> can redirect and concat in bash
clean:
	rm -f optimO2 optimO3 optimO2dmp.txt optimO3dmp.txt otwo.txt othree.txt
	rm -f optimO2.s optimO3.s 
