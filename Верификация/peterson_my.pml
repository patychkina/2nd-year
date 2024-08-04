bool flag[2]
bool turn


active [2] proctype user()
{
	int cnt
	flag[_pid] = true
	turn = _pid
	(flag[1-_pid] == false || turn == 1-_pid)

	cnt++ 
	crit: assert(cnt == 1) 
	cnt--

  	flag[_pid] = false
}
