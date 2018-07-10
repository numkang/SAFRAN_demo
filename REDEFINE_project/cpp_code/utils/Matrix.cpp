/*
 * Matrix.cpp
 *
 *  Created on: 16 janv. 2018
 *      Author: Louis
 */

#include "Matrix.hpp"
#include <iostream>

Matrix::Matrix(int row, int col){
	dimensions[0] = row;
	dimensions[1] = col;
}

Matrix::Matrix(){
	dimensions[0] = 0;
	dimensions[1] = 0;
}

Matrix::Matrix(int row, int col, int val){
	dimensions[0] = row;
	dimensions[1] = col;
	for(int i = 1 ; i <= row ; i++){
		for(int j = 1 ; j <= col ; j++){
			this->set(i, j, val);
		}
	}
}


void Matrix::set_size(int row, int col){
	dimensions[0] = row;
	dimensions[1] = col;
}

/**
 * 1 <= i <= row
 * 1 <= j <= col
 *
 * BE CAREFUL: different from usual c++ convention
 */
void Matrix::set(int i, int j, int val){
	/*if( i <= 0 || j <= 0 || i > row || j > col){
	 * 		//TODO message error and stop
	 * }
	 */
	elements[i-1][j-1] = val;
}

/**
 * 1 <= i <= row
 * 1 <= j <= col
 *
 * BE CAREFUL: different from usual c++ convention
 */
int Matrix::get(int i, int j){
	/*if( i <= 0 || j <= 0 || i > row || j > col){
	 * 		//TODO message error and stop
	 * }
	 */
	return elements[i-1][j-1];
}

int Matrix::size_r(){
	return dimensions[0];
}

int Matrix::size_c(){
	return dimensions[1];
}

Matrix Matrix::dot(Matrix B){
	Matrix C = Matrix(dimensions[0], B.size_c());
	if(dimensions[1] != B.size_r()){
		C.set_size(0,0); // TODO stop here and display error message
	}
	int row = C.size_r();
	int col = C.size_c();
	int val;

	for(int i = 1 ; i <= row ; i++){
		for(int j = 1 ; j <= col ; j++){
			val = 0;
			for(int k = 1 ; k <= dimensions[1] ; k++){
					val += this->get(i, k) * B.get(k, j);
			}
			C.set(i, j, val);
		}
	}
	return C;

}

void Matrix::disp(){
	for(int i = 1 ; i <= this->size_r() ; i++){
		std::cout << "[  ";
		for(int j = 1 ; j <= this->size_c() ; j++){
			if(this->get(i, j) >= 0){
				std::cout << " ";
			}
			std::cout << this->get(i, j) << "  ";
		}
		std::cout << "]\n";
	}
}

Matrix Matrix::get_col(int j){
	Matrix col = Matrix(this->size_r(), 1);
	for(int i = 1 ; i <= this->size_r() ; i++){
		col.set(i, 1, this->get(i, j) );
	}
	return col;
}

Matrix Matrix::get_row(int i){
	Matrix row = Matrix(1, this->size_c());
	for(int j = 1 ; j <= this->size_c() ; j++){
		row.set(1, j, this->get(i, j) );
	}
	return row;
}

Matrix Matrix::slicing(int start_row, int end_row, int start_col, int end_col){
	Matrix sliced = Matrix(end_row - start_row + 1, end_col - start_col + 1);
	for(int i = 1 ; i <= end_row - start_row + 1 ; i++){
		for(int j = 1 ; j <= end_col - start_col + 1 ; j++){
			sliced.set(i, j, this->get(start_row - 1 + i, start_col - 1 + j));
		}
	}
	return sliced;
}

void Matrix::merge(Matrix M){
	int size_c_old = this->size_c();
	if(this->size_r() == 0 || size_c_old == 0){
		this->set_size(M.size_r(), M.size_c());
		for(int i = 1 ; i <= M.size_r() ; i++){
			for(int j = 1 ; j <= M.size_c() ; j++){
				this->set(i, j, M.get(i, j));
			}
		}
		return;
	}
	if(this->size_r() == M.size_r()){
		this->set_size(this->size_r(), size_c_old + M.size_c());
		for(int i = 1 ; i <= this->size_r() ; i++){
			for(int j = 1 ; j <= M.size_c() ; j++){
				this->set(i, size_c_old + j, M.get(i, j));
			}
		}
	}
}

void Matrix::merge_diag(Matrix M){
	int size_r_old = this->size_r();
	int size_c_old = this->size_c();
	if(this->size_r() == 0 || size_c_old == 0){
		this->set_size(M.size_r(), M.size_c());
		for(int i = 1 ; i <= M.size_r() ; i++){
			for(int j = 1 ; j <= M.size_c() ; j++){
				this->set(i, j, M.get(i, j));
			}
		}
		return;
	}
	this->set_size(size_r_old + M.size_r(), size_c_old + M.size_c());
	for(int i = 1 ; i <= M.size_r() ; i++){
		for(int j = 1 ; j <= M.size_c() ; j++){
			this->set(size_r_old + i, size_c_old + j, M.get(i, j));
		}
	}
	for(int i = 1 ; i <= size_r_old ; i++){
		for(int j = 1 ; j <= M.size_c() ; j++){
			this->set(i, size_c_old + j, 0);
		}
	}

	for(int i = 1 ; i <= M.size_r() ; i++){
			for(int j = 1 ; j <= size_c_old ; j++){
				this->set(size_c_old + i, j, 0);
			}
		}
}

Matrix Matrix::copy(void){
	Matrix copied = Matrix(this->size_r(), this->size_c(), 0);
	for(int i = 1 ; i <= this->size_r() ; i++){
		for(int j = 1 ; j <= this->size_c() ; j++){
			copied.set(i, j, this->get(i, j));
		}
	}
	return copied;
}
