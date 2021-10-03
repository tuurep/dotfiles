// user and group to drop privileges to
static const char *user  = "tuure";
static const char *group = "tuure";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#000000",   // after initialization
	[INPUT] =  "#81a2be",   // during input
	[FAILED] = "#cc6666",   // wrong password
};

// treat a cleared input like a wrong password (color)
static const int failonclear = 0;
