/*
 * get_func.cpp
 *
 *  Created on: 12 janv. 2018
 *      Author: Louis
 */

#include <iostream>
#include "get_func.hpp"
#include "Matrix.hpp"
#include <list>

int appOfNode(int app_node, std::list<int> startApp) {
	int app = 0;
	auto it_prev = startApp.cbegin() ;
	auto it_next = startApp.cbegin();
	it_next++;
	for(int k = 0 ; k < startApp.size() -1 ; k++){
		app++;
		if(*it_prev < app_node && app_node <= *it_next){ 
			return app;
		}
		it_prev++;
		it_next++;
	}
	return -1;
			
}


int abs_perso(int n){
	return (n >= 0) ? n : -n;
}


std::list<int> getAllNodes(Matrix apps){
	std::list<int> t = std::list<int>();
	int previous = 0;
	int i = 1;

	for(int k = 1 ; k<= apps.size_c() ; k++){ // for each column
		i = 1;
		while(apps.get(i, k) != 0){
			t.push_back(i + previous);
			i++;
		}
		previous = previous + i - 1;
	}

	return t;
}


std::list<int> getTrueNodes(Matrix apps){
	std::list<int> trueNodes = std::list<int>();
	int previous = 0;
	int i = 1;

	for(int k = 1 ; k<= apps.size_c() ; k++){ // for each column
		i = 1;
		while(apps.get(i,k) != 0){
			if(apps.get(i,k) > 0){
				trueNodes.push_back(i + previous);
			}
			i++;
		}
		previous = previous + i - 1;
	}

	return trueNodes;
}

// returns the first indice (count column by column) corresponding to a non zero element of M (-1 if not found)
int find_non_zero(Matrix M){
	int ind = 1;
	for(int j = 1 ; j <= M.size_c() ; j++){
		for(int i = 1 ; i <= M.size_r() ; i++){
			if(M.get(i, j) > 0){
				return ind;
			}
			else{
				//std::cout << "ind " << ind << '\n'; // debug
				ind++;
			}
		}
	}
	return -1;
}

// returns the application number corresponding to the affected node, 0 if the node is not used by an app
int getToMove(int toKill, Matrix CRT, std::list<int> startApp){

	int affectedNode = find_non_zero(CRT.get_row(toKill));

	int appToMove = 0;
	int endNode;
	// /*startNode = startApp.front();*/ startApp.pop_front();
	endNode = startApp.front(); startApp.pop_front();

	while(endNode < affectedNode){
		appToMove++;
		endNode = startApp.front(); startApp.pop_front();
	}

	return appToMove;

}


std::list<int> getAllLinks(Matrix apps, Matrix linkMap){
	std::list<int> t = std::list<int>();
	int previous = 0;
	int i = 1;
	int n = 1;
	int j = i + 1;

	for(int k = 1 ; k<= apps.size_c() ; k++){ // for each column
		i = 1;
		n = 1;
		while(apps.get(i+1, k) != 0){
			j = i+1;
			while( apps.get(j, k) != 0){
				if( linkMap.get( abs_perso( apps.get(i,k) ), abs_perso( apps.get(j, k) ) ) ){
					t.push_back(n + previous);
					n++;
				}
				j++;
			}

			i++;
		}
		previous = previous + n;
	}

	return t;
}
