	#define N 5 
#define p0 ((P[0]@goto_cs && [](!P[1]@goto_cs && !P[2]@goto_cs && !P[3]@goto_cs && !P[4]@goto_cs)) -> <>P[0]@crit)
#define p1 ((P[1]@goto_cs && [](!P[0]@goto_cs && !P[2]@goto_cs && !P[3]@goto_cs && !P[4]@goto_cs)) -> <>P[1]@crit)
#define p2 ((P[2]@goto_cs && [](!P[1]@goto_cs && !P[0]@goto_cs && !P[3]@goto_cs && !P[4]@goto_cs)) -> <>P[2]@crit)
#define p3 ((P[3]@goto_cs && [](!P[1]@goto_cs && !P[2]@goto_cs && !P[0]@goto_cs && !P[4]@goto_cs)) -> <>P[3]@crit)
#define p4 ((P[4]@goto_cs && [](!P[1]@goto_cs && !P[2]@goto_cs && !P[3]@goto_cs && !P[0]@goto_cs)) -> <>P[4]@crit)
	
	ltl p {[](p0&&p1&&p2&&p3&&p4)}
	
	chan request_queue = [N] of {chan};
	chan CS = [1] of {bool};
	chan common_request;
	
	active [N] proctype P() 
	{ 
	        chan request = [1] of {bool};
	        do 
	        ::       
	                skip; 
	entry:   
		                      request_queue!request
	goto_cs:	                	request?true -> 
	crit:        
	                skip; 
	               	CS!true
	 exit:   
		if :: skip :: break fi 
	        od; 
	} 
	active proctype Coordinator() 
	{ 
	         CS!true
	end:	do 
	        ::       
	                request_queue?common_request
	               CS?true -> common_request!true
	        od;
	}
