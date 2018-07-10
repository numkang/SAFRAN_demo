/*
 * allocation.hpp
 *
 *  Created on: 23 févr. 2018
 *      Author: Louis
 */

#ifndef ALLOCATION_HPP_
#define ALLOCATION_HPP_

#include "Matrix.hpp"
#include "create_func.hpp"
#include "get_func.hpp"
#include <list>
#include <iostream>
#include <algorithm> // for find

// si utile ailleurs, a mettre dans un fichier plus accessible


enum Fault_type{
	CR, RO, ERROR
};

class Fault{
public:
	int tile_nb;
	Fault_type type;
	Fault(int tile_nb, Fault_type type) { this->tile_nb = tile_nb ; this->type = type ; };
};


class NOC{
public: // should make it private and use accessor instead
	Topology topo;
	int nMesh;
	int nbCR;
	int nbPaths;
	Matrix G;
	Matrix linkMap;
	int nbApps;
	std::list<int> startApp;

	std::list<int> listCRs;
	std::list<int> faultyCRs;
	std::list<int> faultyRouters;
	Matrix apps;
	Matrix priority;
	Matrix oldCRT;
	
	Matrix CRT; // watch out for the initialisation !!!
	Matrix CD;
	Matrix DN;
	Matrix M;
	Matrix A;
	Matrix Y;
	
	NOC(Topology topo, int nMesh) { 
		this->topo = topo ; 
		this->nMesh = nMesh ; 
		this->nbCR = nMesh*nMesh; 
		for (int i = 1 ; i <= this->nbCR ; i++){ // choosing to start at 1
			this->listCRs.push_back(i);
		}
		this->linkMap = createLinkMap(nMesh, topo);
		this->nbPaths = 0;
		this->G = createNoc(&(this->nbPaths), this->linkMap, nMesh);
		this->faultyCRs = std::list<int>();
		this->faultyRouters = std::list<int>();
		this->apps = Matrix(0, 0, 0);
		this->priority = Matrix(0, 0, 0);
		this->oldCRT = Matrix(0, 0, 0);
	};
	
	void disp() {
		std::cout << "NoC:\n";
		int app_node;
		int current_tile;
		for(int i = 1 ; i <= nMesh ; i++) {
			for(int j = 1 ; j <= nMesh ; j++) {
				app_node = 1;
				current_tile = (i-1)*nMesh + j;
				// check if the current tile is affected to an application node
				while( CRT.get( current_tile, app_node) == 0 && app_node <= CRT.size_c()) {
					app_node++;
				}
				
				//else if( (i-1)*nMesh + j is_in this->faultyCRs || is_in this->faultyRouters)
				if( std::find( std::begin(this->faultyRouters), std::end(this->faultyRouters), current_tile) != std::end(this->faultyRouters) ){
					std::cout << "X  ";
				}
				else if( std::find( std::begin(this->faultyCRs), std::end(this->faultyCRs), current_tile) != std::end(this->faultyCRs) ){
					std::cout << "-";
					if( app_node <= CRT.size_c() ) {
						std::cout << appOfNode(app_node, startApp) << " ";
					}
					else{
						std::cout << "  ";
					}	
				}
				else if( app_node <= CRT.size_c() ) {
					std::cout << appOfNode(app_node, startApp) << "  ";
				}
				else {
					std::cout << "0  ";
				}
			}
			std::cout << std::endl;
		}
	}
	
};

#endif /* ALLOC_HPP_ */
