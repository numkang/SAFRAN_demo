/*
 * algos.cpp
 *
 *  Created on: 9 févr. 2018
 *      Author: Louis
 */

#include "utils/allocation.hpp"
#include "utils/get_func.hpp"
#include "SAT_fc.hpp"
#include <iostream>
#include <fstream>
#include <string.h>
#include <list>

// For time measurement
# include <chrono>
using namespace std;
using  ns = chrono::nanoseconds;
using get_time = chrono::steady_clock ;



// first input from the user, later, will check the NoC and detect the faults itself
Fault get_fault(NOC* NoC){
	std::cout << "Kind of fault to inject (\"cr\" for CR, \"ro\" for router): ";
	char str_type[2];
	std::cin >> str_type;
	
	while( strcmp(str_type, "cr") != 0 && strcmp(str_type, "ro") != 0 ){
		std::cout << "Wrong command. Use \"cr\" to inject a CR fault, \"ro\" for router fault: ";
		std::cin >> str_type;
	}

	std::cout << "Tile number: ";
	int tile_nb;
	std::cin >> tile_nb;
	
	while( !(tile_nb <= NoC->nbCR && tile_nb >= 1) ){
		std::cout << "Wrong number. It must belong to [1, " << NoC->nbCR << "]: ";
		std::cin >> tile_nb;
	}
	
	
	Fault_type type;
	if(strcmp(str_type, "cr") == 0 && std::find( std::begin(NoC->faultyCRs), std::end(NoC->faultyCRs), tile_nb) == std::end(NoC->faultyCRs)){ // new CR fault
		type = CR;
	}
	else if(strcmp(str_type, "ro") == 0 && std::find( std::begin(NoC->faultyRouters), std::end(NoC->faultyRouters), tile_nb) == std::end(NoC->faultyRouters)){ // new Router fault
		type = RO;
	}
	else{
		std::cout << "Element already killed\n";
		type = ERROR;
	}

	Fault fault = Fault(tile_nb, type);

	return fault;
}


void write_alloc(NOC* NoC, FILE *fp){
	rewind(fp);
	int app_node;
	int current_tile;
	for(int i = 1 ; i <= NoC->nMesh ; i++) {
		for(int j = 1 ; j <= NoC->nMesh ; j++) {
			app_node = 1;
			current_tile = (i-1)*NoC->nMesh + j;
			// check if the current tile is affected to an application node
			while( NoC->CRT.get( current_tile, app_node) == 0 && app_node <= NoC->CRT.size_c()) {
				app_node++;
			}
			
			if( app_node <= NoC->CRT.size_c() ) {
				fprintf(fp, "%d", appOfNode(app_node, NoC->startApp) );
			}
			else {
				fprintf(fp, "%d", 0 );
			}
		}
	}
	//std::cout << "File written\n";
}

bool update_status(NOC* NoC, int* faulty_tile_nb){
	
	/*char str[16];
	FILE *fault_file = fopen("faults.txt","r");
	if(fault_file == NULL){
		printf("Error opening file faults.txt");
	}else{
		//memset(str, '\0', sizeof(str_start));
		fgets(str, 16, fault_file);		
	}
	fclose(fault_file);*/
	
	std::string line;
	std::ifstream fault_file("/home/pi/Documents/SAFRAN_demo/full_demo/faults.txt");
	
	bool reconfiguration_needed = false;
	
	std::list<int> trueNodes = getTrueNodes(NoC->apps);
	int sum_true = 0;
	int sum_all = 0;
	
	if (fault_file.is_open()){
	
		getline(fault_file, line);
	
		fault_file.close();
		
		for (int tile_nb = 1 ; tile_nb <= line.length() ; tile_nb++){
			if(line[tile_nb-1] == '1' && std::find( std::begin(NoC->faultyCRs), std::end(NoC->faultyCRs), tile_nb) == std::end(NoC->faultyCRs)){ // new CR fault
				NoC->faultyCRs.push_back(tile_nb);
				*faulty_tile_nb = tile_nb; // !!! will detect only one fault at a time
				
				sum_true = 0; // could use a while get(..., ...) != 1 instead of a for
				for(auto it = trueNodes.cbegin() ; it != trueNodes.cend() ; it++){
					sum_true = sum_true + NoC->CRT.get(tile_nb, *it);
				}
				if(sum_true != 0){
					reconfiguration_needed = true;
				}
			}
			else if(line[tile_nb-1] == '0' && std::find( std::begin(NoC->faultyRouters), std::end(NoC->faultyRouters), tile_nb) == std::end(NoC->faultyRouters)){ // new Router fault
				NoC->faultyRouters.push_back(tile_nb);
				*faulty_tile_nb = tile_nb; // !!! will detect only one fault at a time
				
				sum_all = 0;
				for(int i = 1 ; i <= NoC->CRT.size_c() ; i++){
					sum_all = sum_all + NoC->CRT.get(tile_nb, i);
				}
				if(sum_all != 0){
					reconfiguration_needed = true;
				}
			}
		}	
	}
	else{ std::cout << "Unable to open faults.txt";}
	
	return reconfiguration_needed;
}

void flexible_algo(NOC* NoC){
	
	FILE *fp = fopen("/home/pi/Documents/SAFRAN_demo/full_demo/allocation_mapping.txt","w");
	if(fp == NULL){
		printf("Error opening file");
	}
	
	int appToMove = 1;//
	//Initial config

	int nbTasks = 0;
	int nbTaskPaths = 0;
	int nbDrop = 0;
	
	auto start = get_time::now();
	
	std::list<int> iCanDrop = std::list<int>();
	
	bool first_call = true;
	
	opb_writer(NoC, 
			   appToMove, 
			   &nbTasks, 
			   &nbTaskPaths, 
			   &nbDrop,
			   &iCanDrop,
			   first_call);
			   
	auto end = get_time::now();
	auto diff = end - start;
	cout<<"Time for init opb writer:  "<< chrono::duration_cast<ns>(diff).count()<<" ns "<<endl;

	read_SAT_result(NoC, nbDrop, &iCanDrop);
	// what if infeasible
	
	write_alloc(NoC, fp);
	NoC->disp(); // test

	char str_in[5];

	// if infesasible, stop and exit, "No feasible solution with these initial conditions."
	// str_in = exit;

	// int i = 2; // used only if we use the 'input' variable from the Matlab code to feed the function a serie of fault to execute without having to enter them one by one during the execution


	bool reconfiguration_needed = false;
	int faulty_tile_nb = 0;
		
	/*std::cout << "\nPaused. Type \"next\" to run next iteration, \"exit\" to quit: ";
	std::cin >> str_in;
	while( strcmp(str_in, "exit") != 0 && strcmp(str_in, "next") != 0 ){
		std::cout << "Wrong command. Type \"next\" to run next iteration, \"exit\" to quit: ";
			std::cin >> str_in;
	}

	while(strcmp(str_in, "exit") != 0){*/
	while(1){
		// str_in equals "next" if we reach this line
		reconfiguration_needed = update_status(NoC, &faulty_tile_nb);
		
		
	
		if(!reconfiguration_needed){
			std::cout << "No reconfiguration needed\n";
			NoC->disp();
			write_alloc(NoC, fp);
		}
		else { //if(reconfiguration_needed){
			NoC->oldCRT = NoC->CRT.copy(); // seems work, otherwise change the copy function to modify directly the destination object // should do at the end of read_SAT_result instead
			int appToMove = getToMove(faulty_tile_nb, NoC->CRT, NoC->startApp ); // consider using only NoC as an argument
			std::cout << "App nb. " << appToMove << " must be reconfigured\n";
			
			//////////////////////


			start = get_time::now();
			
			first_call = false;
			
			opb_writer(NoC, 
			   appToMove, 
			   &nbTasks, 
			   &nbTaskPaths, 
			   &nbDrop,
			   &iCanDrop,
			   first_call);

			read_SAT_result(NoC, nbDrop, &iCanDrop);
			
			end = get_time::now();
			diff = end - start;
			cout<<"Total time for reallocation:  "<< chrono::duration_cast<ns>(diff).count()<<" ns "<<endl;
		
			
			write_alloc(NoC, fp);
			NoC->disp(); // test
			

//			 if( not infesasible){
//				std::cout << "\nSolution found\n";
//			}
//			else{
//				std::cout << "\nReconfiguration impossible\n";
//				 str_in = "exit";
//			}
		}

		/*std::cout << "\nPaused. Type \"next\" to run next iteration, \"exit\" to quit: ";
		std::cin >> str_in;
		while( strcmp(str_in, "exit") != 0 && strcmp(str_in, "next") != 0 ){
			std::cout << "Wrong command. Type \"next\" to run next iteration, \"exit\" to quit: ";
			std::cin >> str_in;
		}*/
	}
	fclose(fp);
}
