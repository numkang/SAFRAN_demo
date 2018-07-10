/*
 * SAT_fc.hpp
 *
 *  Created on: 23 févr. 2018
 *      Author: Louis
 */

#ifndef SAT_FC_HPP_
#define SAT_FC_HPP_

#include <string>
#include "Matrix.hpp"
#include "create_func.hpp"
#include "get_func.hpp"
#include "allocation.hpp"

// To use Minisat code
/*#include "PbSolver.h"
#include "PbParser.h"
#include "Global.h"
#include "Int.h"*/


void opb_writer(NOC* NoC,
				int appToMove, 
				/*std::list<int> linksApp,*/ 
				int* nbTasks, 
				int* nbTasksPaths, 
				int* nbDrop,
				std::list<int>* iCanDrop,
				bool first_call);
				
// je pourrai ne faire qu'un appel par valeur pour iCanDrop, mais avec les structures un peu complexes, je ne sais pas si c'est efficace
void read_SAT_result(NOC* NoC, int nbDrop,std::list<int>* iCanDrop /*Matrix* CRT, Matrix* A, Matrix apps*/ /*add an output pointer in the previous function to get it*/);

/*
bool get_allocation(PbSolver* S, Matrix* CRT, Matrix* CD, Matrix* DN, Matrix* M, Matrix* A, Matrix* Y, int nbCR, int nbTasks, int nbPaths, int nbTaskPaths, int nbDrop);

PbSolver* set_constr(Topology topo, int nMesh, int nbPaths, std::list<int> faultyCRs, std::list<int> faultyRouters, Matrix apps, Matrix priority, Matrix oldCRT, int appToMove, Matrix linkMap, std::list<int> startApp, std::list<int> linksApp, int* nbTasks, int* nbTasksPaths, int* nbApps, int* nbDrop);
*/

#endif /* SAT_FC_HPP_ */
