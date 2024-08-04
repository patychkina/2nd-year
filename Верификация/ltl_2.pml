#define N 5 
#define p0 (P[0]@goto_sec -> ((P[1]@want -> !P[1]@crit U P[0]@exit)&&(P[2]@want -> !P[2]@crit U P[0]@exit)&&(P[3]@want -> !P[3]@crit U P[0]@exit) &&(P[4]@want -> !P[4]@crit U P[0]@exit)))
#define p1 (P[1]@goto_sec -> ((P[0]@want -> !P[0]@crit U P[1]@exit)&&(P[2]@want -> !P[2]@crit U P[1]@exit)&&(P[3]@want -> !P[3]@crit U P[1]@exit) &&(P[4]@want -> !P[4]@crit U P[1]@exit)))
#define p2 (P[2]@goto_sec -> ((P[1]@want -> !P[1]@crit U P[2]@exit)&&(P[0]@want -> !P[0]@crit U P[2]@exit)&&(P[3]@want -> !P[3]@crit U P[2]@exit) &&(P[4]@want -> !P[4]@crit U P[2]@exit)))
#define p3 (P[3]@goto_sec -> ((P[1]@want -> !P[1]@crit U P[3]@exit)&&(P[2]@want -> !P[2]@crit U P[3]@exit)&&(P[0]@want -> !P[0]@crit U P[3]@exit) &&(P[4]@want -> !P[4]@crit U P[3]@exit)))
#define p4 (P[4]@goto_sec -> ((P[1]@want -> !P[1]@crit U P[4]@exit)&&(P[2]@want -> !P[2]@crit U P[4]@exit)&&(P[3]@want -> !P[3]@crit U P[4]@exit) &&(P[0]@want -> !P[0]@crit U P[4]@exit)))

	
	ltl p {[](p0||p1||p2||p3||p4)}
	
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
	want:	                      request_queue!request
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
	

