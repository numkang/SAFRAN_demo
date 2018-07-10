/*
 * algos.hpp
 *
 *  Created on: 9 févr. 2018
 *      Author: Louis
 */

#ifndef ALGOS_HPP_
#define ALGOS_HPP_

#include "allocation.hpp"

void write_alloc(NOC* NoC, FILE *fp);

void update_status(NOC* NoC, int* faulty_tile_nb);

void flexible_algo(NOC* NoC);

#endif /* ALGOS_HPP_ */
