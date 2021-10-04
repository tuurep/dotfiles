// user and group to drop privileges to
static const char *user  = "tuure";
static const char *group = "tuure";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#000000",   // after initialization
	[INPUT] =  "#313438",   // during input
	[FAILED] = "#872a2a",   // wrong password
};

// treat a cleared input like a wrong password (color)
static const int failonclear = 0;
