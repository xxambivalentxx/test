extern int do_nothing(unsigned int none);
int more_nothing(int nothing);

int do_something(unsigned int some) {
	int ret = 0;
	
	if (do_nothing(some) < 0) {
		ret = more_nothing(some);
	} else {
		ret = 1;
	}
	
	return ret;
}

int more_nothing(int nothing) {
	int ret = 0;
	
	if (nothing < 0) {
		ret = 1;
	} else if (nothing > 0){
		ret = 2;
	} else {
		ret = do_something(nothing);
	}
	
	return ret;
}
