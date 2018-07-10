
#include "allocation.hpp"
#include "create_func.hpp"
#include "Matrix.hpp"
#include "algos.hpp"
#include "SAT_fc.hpp"

#include <stdio.h>
#include <iostream>

void first_alloc(NOC* NoC, bool default_alloc = false){
	if (default_alloc){
		NoC->priority = Matrix(1, 3, 0);
		NoC->priority.set(1, 1, 1);
		NoC->priority.set(1, 2, 2);
		NoC->priority.set(1, 3, 3);

		NoC->apps = Matrix(NoC->nbCR, 3, 0);
		NoC->apps.set(1, 1,  1      );
		NoC->apps.set(2, 1,  2      );
		NoC->apps.set(3, 1, -3      );
		NoC->apps.set(4, 1,  1 + NoC->nMesh);
		NoC->apps.set(5, 1,  2 + NoC->nMesh);
		NoC->apps.set(6, 1,  3 + NoC->nMesh);

		NoC->apps.set(1, 2,  1        );
		NoC->apps.set(2, 2, -2        );
		NoC->apps.set(3, 2,  1 + NoC->nMesh);
		NoC->apps.set(4, 2,  2 + NoC->nMesh);

		NoC->apps.set(1, 3,  1        );
		NoC->apps.set(2, 3,  1 + NoC->nMesh);

		printf("Default apps loaded\n");

		NoC->oldCRT = Matrix(NoC->nbCR, 12, 0);
		NoC->oldCRT.set(1          ,  1, 1);
		NoC->oldCRT.set(2          ,  2, 1);
		NoC->oldCRT.set(3          ,  3, 1);
		NoC->oldCRT.set(1 +   NoC->nMesh,  4, 1);

		NoC->oldCRT.set(2 +   NoC->nMesh,  5, 1);
		NoC->oldCRT.set(3 +   NoC->nMesh,  6, 1);
		NoC->oldCRT.set(1 + 2*NoC->nMesh,  7, 1);
		NoC->oldCRT.set(2 + 2*NoC->nMesh,  8, 1);

		NoC->oldCRT.set(1 + 3*NoC->nMesh,  9, 1);
		NoC->oldCRT.set(2 + 3*NoC->nMesh, 10, 1);
		NoC->oldCRT.set(      NoC->nMesh, 11, 1);
		NoC->oldCRT.set(    2*NoC->nMesh, 12, 1);
	}
	else{
		// UI to choose the topology, the size, the apps and their priority. The first call to the solver to have the inital alloc is made later, in flex_algo
		NoC->oldCRT = Matrix(NoC->nbCR, NoC->apps.size_r(), 0);
	}
}

int main(void){
	NOC NoC = NOC(SQUARE_MESH, 4);

	first_alloc(&NoC, true);
	
	NoC.nbApps = NoC.apps.size_c();


	NoC.CRT = Matrix(NoC.oldCRT.size_r(), NoC.oldCRT.size_r(), 0);
	NoC.startApp = setStartApp(NoC.nbApps, NoC.apps); // should be done at each call of ILP instead

	/*FILE *fp = fopen("/home/pi/Documents/SAFRAN_demo/full_demo/allocation_mapping.txt","w");
	if(fp == NULL){
		printf("Error opening file");
	}*/

	flexible_algo(&NoC); 
	
	//fclose(fp);
	
	return 0;

}

