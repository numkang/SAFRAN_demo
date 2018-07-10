#ifndef MATRIX_HPP
#define MATRIX_HPP

/***
 * Simple integer Matrix implementation.
 *
 * WARNING!
 * Indices start from 1, contrary to C++ convention, in order to follow Matlab one and prevent typos when copying Matlab code
 *
 * The maximum size is given below.
 */
const int MAX_MATR_SIZE = 30;

class Matrix{
	int dimensions[2];
	int elements[MAX_MATR_SIZE][MAX_MATR_SIZE];

	void set_size(int row, int col);

public:
	Matrix(int row, int col);
	
	Matrix();

	/**
	 * Builds a row x col matrix with "value" entry everywhere
	 */
	Matrix(int row, int col, int val);

	/**
	 * Sets the (i, j)-th element of the matrix
	 */
	void set(int i, int j, int val);

	int get(int i, int j);

	/**
	 * Number of rows
	 */
	int size_r();

	/**
	 * Number of columns
	 */
	int size_c();

	/**
	 * Dot product
	 */
	Matrix dot(Matrix M);

	void disp();

	/**
	 * Returns the j-th column
	 */
	Matrix get_col(int j);

	/**
	 * Returns the i-th row
	 */
	Matrix get_row(int i);

	/**
	 * Returns the sub-matrix between row[/column] start_row[/column] and end_row[/column], both included
	 */
	Matrix slicing(int start_row, int end_row, int start_col, int end_col);

	/**
	 * Horizontally merges two matrices
	 */
	void merge(Matrix M);

	/**
	 * Merges two matrices into a block diagonal matrix.
	 */
	void merge_diag(Matrix M);
	
	/**
	 * Copy a matrix into a new matrix
	 */
	Matrix copy(void);
};

#endif
