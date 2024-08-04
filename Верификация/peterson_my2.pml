byte	turn[2];
byte	mutex;

active [2] proctype P()
{
	bit i = _pid;
L:
	turn[i] = 1;
	turn[i] = turn[1-i]+1;
		

	(turn[1-i] == 0) || (turn[i] < turn[1-i]) ->
	mutex++;

	assert(mutex == 1);
	mutex--;
	turn[i] = 0;
	goto L;
}
