/*
 * create_func.cpp
 *
 *  Created on: 18 janv. 2018
 *      Author: Louis
 */

#include "Matrix.hpp"
#include "get_func.hpp"
#include "create_func.hpp"
//#include "allocation.hpp"
#include <list>

Matrix createNoc(int* nbPaths, Matrix linkmap, int nMesh){
	// seems OK
	// rechoisir les variables utilisees dans les tailles de matrices pour faciliter la comprehension
	*nbPaths = 0;
	Matrix col2add = Matrix(nMesh*nMesh, 1, 0);
	Matrix G = Matrix(0, 0, 0);
	for(int i = 1 ; i <= linkmap.size_r() ; i++){
		for(int j = 1 ; j <= linkmap.size_c() ; j++){
			if(linkmap.get(i, j) == 1){
				*nbPaths = *nbPaths + 1;
				col2add.set(i, 1, 1);
				col2add.set(j, 1, 1);
				G.merge(col2add);
				col2add = Matrix(nMesh*nMesh, 1, 0);
			}
		}
	}

	//TODO handle toroidal case

	return G;
}

Matrix createLinkMap(int nMesh, Topology topo){
	Matrix L = Matrix(nMesh * nMesh, nMesh * nMesh, 0);

	for(int i = 1 ; i <= nMesh * nMesh ; i++){
		if( i % nMesh != 0){ // not on last column
			L.set(i, i+1, 1);
		}
		else if(topo == TOROIDAL_MESH){
			L.set(i, 1, 1);
		}

		if(i <= nMesh * (nMesh - 1) ){ // not on last row
			L.set(i, i + nMesh, 1);
		}
		else if(topo == TOROIDAL_MESH){
			if(i % nMesh != 0){
				L.set(i, i % nMesh, 1);
			}
			else{
				L.set(i, nMesh, 1);
			}
		}
	}
	return L;
}

Matrix createGraph(Matrix apps, Matrix linkMap){
	int i;
	int j;
	int max = 0;
	int len;
	Matrix T1 = Matrix(0, 0, 0);
	Matrix T = Matrix(0, 0, 0);
	std::list<int> c = std::list<int>();
	std::list<int> d = std::list<int>();
	for(int k = 1 ; k <= apps.size_c() ; k++){
		i = 1;
		c.clear(); // may be useless since c and d are emptied at the end of the for loop
		d.clear();
		while(apps.get(i+1, k) != 0){
			j = i + 1;
			while( apps.get(j, k) != 0){
				if(linkMap.get(abs_perso(apps.get(i, k)), abs_perso(apps.get(j, k))) != 0){
					c.push_back(i);
					d.push_back(j);
					if(j > max){
						max = j;
					}
				}
				j++;
			}
			i++;
		}
		T1 = Matrix(max, c.size(), 0);
		max = 0;
		len = c.size();
		for(int n = 1 ; n <= len ; n++){
			i = c.front(); // i and j no longer represent subscripts from apps
			j = d.front();
			c.pop_front();
			d.pop_front();
			T1.set(i, n, 1);
			T1.set(j, n, 1);
		}
		T.merge_diag(T1);
	}
	return T;
}

//int abs_perso(int n){ // why can't I use the same function that I already defined in get_func.[c/h]pp
//	return (n >= 0) ? n : -n;
//}

std::list<int> createGeomConst(Matrix* A, Matrix* b, Matrix apps, Matrix linkMap){
	int nApp = apps.size_c();

	std::list<int> allNodes = getAllNodes(apps);
	int nNodes = allNodes.size();

	*A = Matrix(nNodes, nNodes, 0);
	*b = Matrix(nNodes, 1, 0);
	int prev = 0;
	int a = 1;
	std::list<int> dec = std::list<int>();
	dec.push_back(0);
	int i = 1;
	int j = 0;

	for(int k = 1 ; k <= nApp ; k++){
		i = 1;
		while(apps.get(i+1, k) != 0){
			j = i + 1;
			while( apps.get(j, k) != 0){
				if( linkMap.get( abs_perso( apps.get(i, k) ), abs_perso( apps.get(j, k) ) ) != 0){ // if node i and j in app k are linked / next to each other
					A->set(prev + i, a, -1); // avoid transposing A at the end
					A->set(prev + j, a, 1);
					b->set(a, 1, abs_perso( apps.get(j, k) ) - abs_perso( apps.get(i, k) ) );
					a++;
				}
				j++;
			}
			i++;
		}
		dec.push_back(a-1);
		prev = prev + i;
	}
	dec.push_back(a-1);

	A->slicing(1, A->size_r(), 1, a-1);
	b->slicing(1, a-1, 1, b->size_c());

	return dec;
}


std::list<int> setStartApp(int nbApps, Matrix apps){
	std::list<int> startApp = std::list<int>();
	startApp.push_back(0);
	for(int k = 2 ; k <= nbApps + 1 ; k++){
		startApp.push_back( startApp.back() + getAllNodes( apps.get_col(k-1) ).size() );
	}
	return startApp;
}

std::list<int> setLinksApp(int nbApps, Matrix apps, Matrix linkMap){
	std::list<int> linksApp = std::list<int>();
	linksApp.push_back(0);
	for(int k = 2 ; k <= nbApps + 1 ; k++){
		linksApp.push_back( linksApp.back() + getAllLinks( apps.get_col(k-1) , linkMap).size() );
	}
	return linksApp;
}
