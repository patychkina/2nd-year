#define N 5 
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
	                	request?true -> 
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
	do 
        ::       
                request_queue?common_request
               CS?true -> common_request!true
        od;
}
	


