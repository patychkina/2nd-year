#define N 5 
chan request_queue = [N] of {chan};
chan CS = [1] of {bool};
chan common_request;
byte Crit_Sec=0;

active proctype Check_assert()
{
	(Crit_Sec>1) -> assert(!(Crit_Sec>1));
}

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
	Crit_Sec = Crit_Sec + 1;
	Crit_Sec = Crit_Sec - 1;
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
