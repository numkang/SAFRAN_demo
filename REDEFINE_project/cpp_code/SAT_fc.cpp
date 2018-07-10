#include "SAT_fc.hpp"
#include "get_func.hpp"
#include <iostream>
#include <fstream>
#include <string>

int find(int i, Matrix M){
	int ind = 1;
	for(int j = 1 ; j <= M.size_c() ; j++){
		for(int i = 1 ; i <= M.size_r() ; i++){
			if(M.get(i, j) > 0){
				return ind;
			}
			else{
				ind++;
			}
		}
	}
	return -1;
}

// assume matrix is row
int max(Matrix l){
	int n = l.size_c();
	int temp_max = l.get(1,1);
	for(int i = 2 ; i <= n ; i++){
		if(l.get(1,i) > temp_max){
			temp_max = l.get(1,i);
		}
	}
	return temp_max;
}

// assume matrix is row
int min(Matrix l){
	int n = l.size_c();
	int temp_min = l.get(1,1);
	for(int i = 2 ; i <= n ; i++){
		if(l.get(1,i) < temp_min){
			temp_min = l.get(1,i);
		}
	}
	return temp_min;
}

////////////////////////////////////////////////////////////////////////
//      TEMPORARY SOLUTION: WRITING AN OPB FILE TO CALL MINISAT       //
////////////////////////////////////////////////////////////////////////

/**
 * Writes the OPB file, same begining as set_constr.
 */

void opb_writer(NOC* NoC,
				int appToMove,  
				int* nbTasks, 
				int* nbTasksPaths, 
				int* nbDrop,
				std::list<int>* iCanDrop,
				bool first_call
				){
	
	// init part
	
	Matrix T = createGraph(NoC->apps, NoC->linkMap);
	
	*nbTasks = T.size_r();
	*nbTasksPaths = T.size_c();
	NoC->nbApps = NoC->priority.size_c();
	std::list<int> trueNodes = getTrueNodes(NoC->apps);
	
	// frozen tasks created later
	
	// only move the affected app
	std::list<int> appsToKeep = std::list<int>();
	for(int i = 1 ; i <= NoC->nbApps ; i++){
		if(i != appToMove){
			appsToKeep.push_back(i);
		}
	}
	
	int movePriority = min(NoC->priority) + 1;
	
	for(int i = 1 ; i <= NoC->priority.size_c() ; i++){
		if(NoC->priority.get(1, i) >= movePriority){
			iCanDrop->push_back(i);// possible improvement: we can store priority(iCanDrop) in this loop
		}
	}
	*nbDrop = iCanDrop->size();
	
	std::list<int> sorted = std::list<int>();
	std::list<int> unsorted = std::list<int>();
	for(auto it = iCanDrop->cbegin() ; it != iCanDrop->cend() ; it++){
		sorted.push_back( NoC->priority.get( 1,*it ) );
		unsorted.push_back( NoC->priority.get( 1,*it ) );
	}
	sorted.sort();
	
	std::list<int> iP = std::list<int>();
	int i;
	for(auto it_sorted = sorted.cbegin() ; it_sorted != sorted.cend() ; it_sorted++){
		i = 1;
		for(auto it = unsorted.cbegin() ; it != unsorted.cend() ; it++){
			if(*it == *it_sorted){
				iP.push_back(i);
				break;
			}
			i++;
		}
	}
	
	NoC->startApp = setStartApp(NoC->nbApps, NoC->apps);
	std::list<int> linksApp = setLinksApp(NoC->nbApps, NoC->apps, NoC->linkMap);
	
	std::list<int> frozenTasks = std::list<int>();
	for(auto it_appsToKeep = appsToKeep.cbegin() ; it_appsToKeep != appsToKeep.cend() ; it_appsToKeep++){
		auto it_startApp = NoC->startApp.cbegin();
		for(int i = 2 ; i <= *it_appsToKeep ; i++){
			it_startApp++;
		}
		std::list<int> l = getAllNodes( NoC->apps.get_col(*it_appsToKeep) );
		for(auto it_l = l.cbegin() ; it_l != l.cend() ; it_l++){
			frozenTasks.push_back( *it_startApp + *it_l );
		}
	}
	
	Matrix A_geom = Matrix(1,1); // Be careful, nothing to do with the A matrix inside NoC
	Matrix b_geom = Matrix(1,1);
	Matrix b_tor = Matrix(0,0);
	std::list<int> dec = createGeomConst(&A_geom, &b_geom, NoC->apps, NoC->linkMap);
	
	if(NoC->topo == TOROIDAL_MESH){
		b_tor = Matrix(b_geom.size_r(), b_geom.size_c());
		for(int i = 1 ; i <= b_geom.size_r() ; i++){
			for(int j = 1 ; j <= b_geom.size_c() ; j++){
				b_tor.set(i, j, b_geom.get(i, j) * -1 *( NoC->nMesh - 1) );
			}

		}
	}
	
	///////////////////////////////////////////////////////////////////

	int val;
	
	// String variables
	std::string CRT_str[NoC->nbCR   ][*nbTasks     ];
	std::string  CD_str[NoC->nbPaths][*nbTasksPaths];
	std::string  DN_str[1           ][*nbDrop      ];
	std::string   M_str[1           ][NoC->nbApps  ];
	std::string   A_str[1           ][*nbDrop      ];
	std::string   Y_str[2           ][*nbTasksPaths];
	
	
	
	for(int i = 0 ; i < NoC->nbCR ; i++){
		for(int j = 0 ; j < *nbTasks ; j++){
			CRT_str[i][j] = "CRT_" + std::to_string(i+1) + "_" + std::to_string(j+1);
		}
	}
	
	for(int i = 0 ; i < NoC->nbPaths ; i++){
		for(int j = 0 ; j < *nbTasksPaths ; j++){
			CD_str[i][j] = "CD_" + std::to_string(i+1) + "_" + std::to_string(j+1);
		}
	}
	
	for(int i = 0 ; i < *nbDrop ; i++){
		DN_str[0][i] = "DN_1_" + std::to_string(i+1);
	}
	
	for(int j = 0 ; j < NoC->nbApps ; j++){
		M_str[0][j] = "M_1_" + std::to_string(j+1);
	}
	
	for(int j = 0 ; j < *nbDrop ; j++){
		A_str[0][j] = "A_1_" + std::to_string(j+1);
	}
	
	if(NoC->topo == TOROIDAL_MESH){
		for(int i = 0 ; i < 2 ; i++){
			for(int j = 0 ; j < *nbTasksPaths ; j++){
				Y_str[i][j] = "Y_" + std::to_string(i+1) + "_" + std::to_string(j+1);
			}
		}
	}
	
	
	// WRITING IN THE OPB FILE
	std::ofstream opb_file;
	opb_file.open("sat_pblm.opb");
	
	
	// OBJECTIVE FUNCTION
	opb_file << "* OBJECTIVE FUNCTION\n";
	opb_file << "min:"; 
	
	for(int j = 0 ; j < *nbDrop ; j++){
		opb_file << " -" + std::to_string(NoC->nbApps) + "*" + A_str[0][j]; // nbApps in writer_init version, otherwise nbTasks
	}

	for(int j = 0 ; j < NoC->nbApps ; j++){
		opb_file << " +1*" + M_str[0][j];
	}

	opb_file << " ;\n";
	
	
	// CONSTRAINTS 
	opb_file << "* CONSTRAINTS\n";
	
	/*objective bounds ? */
	opb_file << "* OBJECTIVE BOUND\n";
	for(int j = 0 ; j < *nbDrop ; j++){
		opb_file << " -" + std::to_string(NoC->nbApps) + "*" + A_str[0][j]; // nbApps in writer_init version, otherwise nbTasks
	}
	for(int j = 0 ; j < NoC->nbApps ; j++){
		opb_file << " +1*" + M_str[0][j];
	}

	opb_file << "<= 0;\n";
	
	
	// define which variables can be modified if it's not the first execution
	opb_file << "* DEFINE WHICH VARIABLES CAN BE MODIFIED IF IT IS NOT THE FIRST EXECUTION\n";
	// Warning
	// To change if we use the SAT solver to compute the initial configuration with any application set
	// need a reliable test for it (in matlab, it was the emptiness of oldCRT, but here, it is always at least full of zero
	// UPDATE: in the Matlab code, oldCRT is never empty either, leave the following line uncommented
	first_call = false;//
	if( !first_call){
		for(auto it_l = frozenTasks.cbegin() ; it_l != frozenTasks.cend() ; it_l++){/////////////////////////////////////////
			//k = find(startApp...
			int k = 0; // k will be compared to elements of iCanDrop that are application number beginning at 1
			int i = 1; // StartApp index
			int stApp_k = 0;
			for(auto stApp = NoC->startApp.cbegin() ; stApp != NoC->startApp.cend() ; stApp++ ) {
				if(*stApp <= *it_l){
					k = i;
					stApp_k = *stApp;
				}
				i++;
			}
			
			if(*it_l == stApp_k){
				k = k - 1; // !! stApp_k does not correspond to startApp(k) anymore (not used afterwars anyway) !!
			}
			
			//[dropMe,kd] = ismember(k,*iCanDrop);//
			bool dropMe = false;
			int kd = 0; // be very careful, define what is the index for a list such as iCanDrop, start at 0 like C++ arrays or at 1 like the Matrix we created?
			// kd is used with arrays afterwards, we choose to start at 0
			auto it = iCanDrop->cbegin() ;
			while(it != iCanDrop->cend() && dropMe == false){
				if(*it == k){
					dropMe = true;
				}
				else {
					kd++;
					it++;
				}
			}
			
			int j = find_non_zero(NoC->oldCRT.get_col(*it_l));
			if(j!=-1){
				if( dropMe){
					opb_file << "+1*" + CRT_str[j-1][*it_l-1] + " +1*" + DN_str[0][kd] + " +1*" + M_str[0][k-1] + " >= " + std::to_string(NoC->oldCRT.get(j,*it_l)) + ";\n"; 
				}
				else{
					opb_file << "+1*" + CRT_str[j-1][*it_l-1] + " +1*" + M_str[0][k-1] + " >= " + std::to_string(NoC->oldCRT.get(j,*it_l)) + ";\n";
				}
			}
		}
	}
	
	
	// failure
	
	// there are faulty routers - do not use the corresponding node at all
	if( NoC->faultyRouters.size() != 0 ){
		for(auto it = NoC->faultyRouters.cbegin() ; it != NoC->faultyRouters.cend() ; it++){
			for(int j=0 ; j < *nbTasks ; j++){
				opb_file << " +1*" + CRT_str[*it-1][j];
			}
			opb_file << " = 0;\n";
		}
	}
	
	
	// there are faulty CRs - we can still use the corresponding router for
	// ghost tasks
	if( NoC->faultyCRs.size() != 0){
		for(auto it=NoC->faultyCRs.cbegin() ; it != NoC->faultyCRs.cend() ; it++){
			for(auto it_l = trueNodes.cbegin() ; it_l != trueNodes.cend() ; it_l++){
				opb_file << " +1*" + CRT_str[*it-1][*it_l-1];
			}
			opb_file << " = 0;\n";
		}
	}
	
	
	// one CR can execute one task maximum
	opb_file << "* ONE CR CAN EXECUTE ONE TASK MAXIMUM\n";
	for(int i=0 ; i < NoC->nbCR ; i++){
		for(int j=0 ; j < *nbTasks ; j++){
			opb_file << " +1*" + CRT_str[i][j];
		}
		opb_file << " <= 1;\n";
	}
	
	
	// every task must be executed by one CR
	opb_file << "* EVERY TASK MUST BE EXECUTED BY ONE CR\n";
	auto stApp_next = NoC->startApp.cbegin();
	stApp_next++;
	auto stApp = NoC->startApp.cbegin();
	for(int k = 1 ; k <= NoC->nbApps ; k++){
		//[dropMe,kd] = ismember(k,*iCanDrop);//
		bool dropMe = false;
		int kd = 0; // be very careful, define what is the index for a list such as iCanDrop, start at 0 like C++ arrays or at 1 like the Matrix we created?
		// kd is used with arrays afterwards, we choose to start at 0
		auto it = iCanDrop->cbegin() ;
		while(it != iCanDrop->cend() && dropMe == false){
			if(*it == k){
				dropMe = true;
			}
			else {
				kd++;
				it++;
			}
		}
		for(int i=*stApp+1-1 ; i < *stApp_next ; i++){
			if( dropMe){
				for(int j=0 ; j < NoC->nbCR ; j++){
					opb_file << " +1*" + CRT_str[j][i];
				}
				opb_file << "+1*" + DN_str[0][kd] + " = 1;\n";
			}
			else{
				for(int j=0 ; j < NoC->nbCR ; j++){
					opb_file << " +1*" + CRT_str[j][i];
				}
				opb_file << " = 1;\n";
			}
		}
		stApp++;
		stApp_next++;
	}
	
	
	// one NoC path can be mapped to one app link maximum
	opb_file << "* ONE NOC PATH CAN BE MAPPED TO ONE APP LINK MAXIMUM\n";
	for(int i=0 ; i < NoC->nbPaths ; i++){
		for(int j=0 ; j < *nbTasksPaths ; j++){
			opb_file << " +1*" + CD_str[i][j];
		}
		opb_file << " <= 1;\n";
	}
	
	
	// every app link must be mapped to one NoC path
	opb_file << "* EVERY APP LINK MUST BE MAPPED TO ONE NOC PATH\n";
	auto lkApp_next = linksApp.cbegin();
	lkApp_next++;
	auto lkApp = linksApp.cbegin();
	for(int k=1 ; k <= NoC->nbApps ; k++){
		//[dropMe,kd] = ismember(k,*iCanDrop);//
		bool dropMe = false;
		int kd = 0; // be very careful, define what is the index for a list such as iCanDrop, start at 0 like C++ arrays or at 1 like the Matrix we created?
		// kd is used with arrays afterwards, we choose to start at 0
		auto it = iCanDrop->cbegin() ;
		while(it != iCanDrop->cend() && dropMe == false){
			if(*it == k){
				dropMe = true;
			}
			else {
				kd++;
				it++;
			}
		}
		for(int i=*lkApp+1-1 ; i < *lkApp_next ; i++){//0000
			if( dropMe){
				for(int j=0 ; j < NoC->nbPaths ; j++){
					opb_file << " +1*" + CD_str[j][i];
				}
				opb_file << "+1*" + DN_str[0][kd] + " = 1;\n";
			}
			else{
				for(int j=0 ; j < NoC->nbPaths ; j++){
					opb_file << " +1*" + CD_str[j][i];
				}
				opb_file << " = 1;\n";
			}
		}
		lkApp++;
		lkApp_next++;
	}
	
	
	// link between CRs and paths / apps and links
	opb_file << "* LINK BETWEEN CRS AND PATH / APPS AND LINKS\n";
	for(int i=0 ; i < NoC->nbCR ; i++){
		for(int j=0 ; j < *nbTasksPaths ; j++){
			for(int k=0 ; k < *nbTasks ; k++){
				if (T.get(k+1,j+1) != 0){
					opb_file << " +" + std::to_string(T.get(k+1,j+1)) + "*" + CRT_str[i][k];
				}
			}
			for(int m=0 ; m < NoC->nbPaths ; m++){
				if (NoC->G.get(i+1,m+1) != 0) {
					opb_file << " -" + std::to_string(NoC->G.get(i+1,m+1)) + "*" + CD_str[m][j];
				}
			}
			opb_file << " = 0;\n";
		}
	}
	// On a mathematical point of view, this is equivalent to opb_writer_init.m
	// we are just writing a lot of 0*XXX that may be a waste of time
	// can use a find_non_zero function instead
	

	// Geometry constraints
	opb_file << "* GEOMETRY CONSTRAINTS\n";
	if( NoC->topo == SQUARE_MESH){
		auto dec_it_next = dec.cbegin();
		dec_it_next++;
		auto dec_it = dec.cbegin();
		
		auto stApp_next = NoC->startApp.cbegin();
		stApp_next++;
		auto stApp = NoC->startApp.cbegin();
		
		for(int k = 1 ; k <= NoC->nbApps ; k++){
			//[dropMe,kd] = ismember(k,*iCanDrop);//
			bool dropMe = false;
			int kd = 0; // be very careful, define what is the index for a list such as iCanDrop, start at 0 like C++ arrays or at 1 like the Matrix we created?
			// kd is used with arrays afterwards, we choose to start at 0
			auto it = iCanDrop->cbegin() ;
			while(it != iCanDrop->cend() && dropMe == false){
				if(*it == k){
					dropMe = true;
				}
				else {
					kd++;
					it++;
				}
			}
			
			if( dropMe){
				for(int j=*dec_it+1-1 ; j < *dec_it_next ; j++){
					for(int n=1 ; n <= NoC->nbCR ; n++){
						for(int m=*stApp+1-1 ; m < *stApp_next ; m++){//111//
							val = n*A_geom.get(m+1,j+1);/////////////////////
							if( val > 0){
								opb_file << " +" + std::to_string(val) + "*" + CRT_str[n-1][m];
							}
							else if (val < 0) {
								opb_file << " " + std::to_string(val) + "*" + CRT_str[n-1][m];
							}
						}
					}
					val = b_geom.get(j+1, 1);
					if( val > 0){
						opb_file << " +" + std::to_string(val) + "*" + DN_str[0][kd] + " = " + std::to_string(val) + ";\n";
					}
					else if (val < 0){
						opb_file << " " + std::to_string(val) + "*" + DN_str[0][kd] + " = " + std::to_string(val) + ";\n";
					}
				}
				// listCRs*CRT_str(:,startApp(k)+1:startApp(k+1))*A.get(startApp(k)+1:startApp(k+1),dec(k)+1:dec(k+1)) == b(dec(k)+1:dec(k+1))"*(1-DN_str(kd));
			}
			else{
				for(int j=*dec_it+1-1 ; j < *dec_it_next ; j++){
					for(int n=1 ; n <= NoC->nbCR ; n++){
						for(int m=*stApp+1-1 ; m < *stApp_next ; m++){//111//
							//val = listCRs(1,n)*A.get(m,j);//0000
							val = n*A_geom.get(m+1,j+1);
							if( val > 0){
								opb_file << " +" + std::to_string(val) + "*" + CRT_str[n-1][m];
							}
							else if (val < 0) {
								opb_file << " " + std::to_string(val) + "*" + CRT_str[n-1][m];
							}
						}
					}
					opb_file << " = " + std::to_string(b_geom.get(j+1,1)) + ";\n";
				}
				// listCRs*CRT_str(:,startApp(k)+1:startApp(k+1))*A.get(startApp(k)+1:startApp(k+1),dec(k)+1:dec(k+1)) == b(dec(k)+1:dec(k+1))";
			}
			dec_it++;
			dec_it_next++;
			stApp++;
			stApp_next++;
		}
	}
	else{
		//listCRs*CRT_str*A == b".*Y(1,:)+b".*Y(2,:);
		auto dec_it_next = dec.cbegin();
		dec_it_next++;
		auto dec_it = dec.cbegin();
		
		auto stApp_next = NoC->startApp.cbegin();
		stApp_next++;
		auto stApp = NoC->startApp.cbegin();
		
		for(int k = 0 ; k < NoC->nbApps ; k++){
			for(int j=*dec_it+1-1 ; j < *dec_it_next ; j++){
				for(int n=1 ; n <= NoC->nbCR ; n++){
					for(int m=*stApp+1-1 ; m < *stApp_next ; m++){
						val = n*A_geom.get(m+1,j+1);//0000
						if( val > 0){
							opb_file << " +" + std::to_string(val) + "*" + CRT_str[n-1][m];
						}
						else if( val < 0){
							opb_file << std::to_string(val) + "*" + CRT_str[n-1][m];
						}
					}
				}
				
				val = b_geom.get(j+1,1);
				if( val > 0){
					opb_file << " -" + std::to_string(val) + "*" + Y_str[0][j];
				}
				else if( val < 0){
					opb_file << " +" + std::to_string(-val) + "*" + Y_str[0][j];
				}
				
				val = b_tor.get(j+1,1);
				if( val > 0){
					opb_file << " -" + std::to_string(val) + "*" + Y_str[1][j];
				}
				else if( val < 0){
					opb_file << " +" + std::to_string(-val) + "*" + Y_str[1][j];
				}
				
				opb_file << " = 0;\n";
			}
			//listCRs*CRT_str(:,startApp(k)+1:startApp(k+1))*A.get(startApp(k)+1:startApp(k+1),dec(k)+1:dec(k+1)) == b(dec(k)+1:dec(k+1))".*Y(1,(dec(k)+1:dec(k+1)))+b(dec(k)+1:dec(k+1))".*Y(2,(dec(k)+1:dec(k+1)));
			
			//[dropMe,kd] = ismember(k,*iCanDrop);//
			bool dropMe = false;
			int kd = 0; // be very careful, define what is the index for a list such as iCanDrop, start at 0 like C++ arrays or at 1 like the Matrix we created?
			// kd is used with arrays afterwards, we choose to start at 0
			auto it = iCanDrop->cbegin() ;
			while(it != iCanDrop->cend() && dropMe == false){
				if(*it == k){
					dropMe = true;
				}
				else {
					kd++;
					it++;
				}
			}
			if( dropMe){
				for(int j=*dec_it+1-1 ; j < *dec_it_next ; j++){//0000
					opb_file << "+1*" + Y_str[0][j] + " +1*" + Y_str[1][j] + "-1*" + A_str[0][kd] + " = 0;\n";
				}
			}
			else{
				for(int j=*dec_it+1-1 ; j < *dec_it_next ; j++){//0000
					opb_file << "+1*" + Y_str[0][j] + " +1*" + Y_str[1][j] + " = 1;\n";
				}
			}
		dec_it++;
		dec_it_next++;
		stApp++;
		stApp_next++;
		}
	}

	//Priority constraints
	opb_file << "* PRIORITY CONSTRAINTS\n";
	auto iP_it = iP.cbegin();
	iP_it++;
	auto iP_it_prev = iP.cbegin();
	for(int k = 2-1 ; k < *nbDrop ; k++){
		opb_file << "+1*" + A_str[0][*iP_it-1] + "-1*" + A_str[0][*iP_it_prev-1] + " <= 0;\n"; //////////iP ? 
		iP_it++;
		iP_it_prev++;
	}

	for(int k = 0 ; k < *nbDrop ; k++){
		opb_file << "+1*" + A_str[0][k] + "+1*" + DN_str[0][k] + " = 1;\n";
	}
	////
	
	
	
	opb_file.close();

}


void read_SAT_result(NOC* NoC, int nbDrop, std::list<int>* iCanDrop){

	// RIGHT COMMAND
	system("/home/pi/Documents/supermini/build/minisatp/minisatp -of sat_pblm.opb > SAT_result.txt");
	
	// USING FILE COMPUTED BY MATLAB TO ESTIMATE SOLVING TIME
	//system("~/Documents/supermini/build/minisatp/minisatp -of MATLAB_written_pblm.opb > SAT_result.txt");

	
	// assume CRT has alead been initialized to the good size (issue if one application is dropped?)	
	
	std::string line;
	std::ifstream res_file ("SAT_result.txt");
	
	while(line.front() != 's'){
		getline(res_file, line);
	}
	
	std::string status = std::string();
	status.clear();
	for( int i = 2 ; i < line.length() ; i++){
		status.push_back(line[i]);
	}
	
	if( status.compare("OPTIMUM FOUND")==0 || status.compare("SATISFIABLE")==0){
		status = "Solved";
	}
	else {
		status = "Infeasible";
	}
	
	//test
	std::cout << status << std::endl;
	
	if ( status.compare("Solved")==0 ){
		getline(res_file, line);
	}
	else {
		line.clear();
	}
	
	NoC->CRT = Matrix(NoC->CRT.size_r(), NoC->CRT.size_c(), 0);
	Matrix A_temp = Matrix(1, nbDrop, 0);
	NoC->A = Matrix(1, nbDrop, 0); // A has never been set to the correct size
	
	int c1;
	std::string subline_s;
	const char * subline_c;
	
	int i, j;
	
	for( int c = 2 ; c < line.length() ; c++){
		if (line[c] == 'A'){
			c1 = c+10 < line.length() ? c+10 : line.length(); 
			subline_s = line.substr(c+2, c1); // !
			subline_c = subline_s.c_str();
			sscanf (subline_c, "%d_%d", &i, &j);
			if(line[c-1]!='-'){A_temp.set(i, j, 1);} // A is already full of zeros, just replace the ones where needed
		}
		else if(line[c] == 'C' && line[c+1] == 'R' && line[c+2] == 'T'){
				c1 = c+10 < line.length() ? c+12 : line.length(); 
				subline_s = line.substr(c+4, c1); // !
				subline_c = subline_s.c_str();
				sscanf (subline_c, "%d_%d", &i, &j);
				if(line[c-1]!='-'){NoC->CRT.set(i, j, 1);} // A is already full of zeros, just replace the ones where needed
		}
	}
	
	if ( status.compare("Solved")==0 ){
		NoC->A = Matrix(1, NoC->nbApps, 1);
		int i = 1;
		for(auto it = iCanDrop->cbegin() ; it != iCanDrop->cend() ; it++){
			NoC->A.set( 1,*it, A_temp.get(1, i) );
			i++;
		}
	}
	else {
		NoC->A = Matrix(1, NoC->nbApps, 0);
	}
	
	//if (res_file.is_open()){
		/*while ( getline(res_file, line) ){
			
		}*/
		/*res_file.close();
	}
	else std::cout << "Unable to open file";*/
}
