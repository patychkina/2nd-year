#define N 5   
	bool enter[N];  
	bool ok[N];  
	bool CS ;
	
	active [N] proctype P() 
	{ 
	        do 
	        ::       
	                skip; 
	entry:   
	                enter[_pid] = true;
		ok[_pid] ->
	crit:         
	                skip; 
	                ok[_pid] = false;
	                CS = false;
	exit:         
		 if :: skip :: break fi 
	        od; 
	} 
	
	active proctype Coordinator() 
	{ 
	        int i = 0;
	        do 
	        ::       
	                if
	                :: (enter[i]) -> enter[i] = false && (!CS) -> CS = true; 
		   ok[i] = true
	                :: else -> skip
	                fi
	
	                i = i + 1;
	        od;
	}

