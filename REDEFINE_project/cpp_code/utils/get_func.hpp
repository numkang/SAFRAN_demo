#ifndef GET_FUNC_HPP
#define GET_FUNC_HPP

#include <list>
#include "Matrix.hpp"

/**
 * Returns the Application to which the application node app_node belongs to.
 */
int appOfNode(int app_node, std::list<int> startApp) ;

/**
 * Returns the abs_persoolute value of the integer n
 */
int abs_perso(int n);

/**
 * To comment
 */
std::list<int> getAllNodes(Matrix apps);

/**
 * Returns the list from 1 to #ApplicationNode without the indices corresponding to ghost nodes
 */
std::list<int> getTrueNodes(Matrix apps);

int find_non_zero(Matrix M);

/**
 * Returns which app must move if a router or a CR was killed and a reconfiguration is needed
 */
int getToMove(int toKill, Matrix CRT, std::list<int> startApp);

/**
 * To comment
 */
std::list<int> getAllLinks(Matrix apps, Matrix linkMap);

#endif
