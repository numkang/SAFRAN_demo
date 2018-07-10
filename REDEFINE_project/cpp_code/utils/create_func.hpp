/*
 * create_func.hpp
 *
 *  Created on: 18 janv. 2018
 *      Author: Louis
 */

#ifndef CREATE_FUNC_HPP_
#define CREATE_FUNC_HPP_

#include <list>
#include "Matrix.hpp"
//#include "get_func.hpp"

enum Topology{
	SQUARE_MESH = 0,
	TOROIDAL_MESH = 1
};

/**
 * G matrix of incidence == link between nodes and paths
 */
Matrix createNoc(int* nbPaths, Matrix linkmap, int nMesh);

/**
 * compute L(i,j) = 1 if link between node i and node j exists in the structure (only the upper triangular part since the matrix should be symmetric)
 * == link between nodes
 */
Matrix createLinkMap(int nMesh, Topology topo);

/**
 * Seems OK
 */
Matrix createGraph(Matrix apps, Matrix linkMap);

/**
 * OK (?)
 */
std::list<int> createGeomConst(Matrix* A, Matrix* b, Matrix apps, Matrix linkMap);

/**
 * Initialize the variable starApp containing the starting and ending application node of each app
 */
std::list<int> setStartApp(int nbApps, Matrix apps);

/**
 * Initialize the variable linksApp
 */
std::list<int> setLinksApp(int nbApps, Matrix apps, Matrix linkMap);



#endif /* CREATE_FUNC_HPP_ */
