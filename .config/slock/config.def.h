/* user and group to drop privileges to */
static const char *user  = "long";
static const char *group = "long";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#272822",     /* after initialization */
	[INPUT] =  "#66D9EF",   /* during input */
	[FAILED] = "#F92672",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 0;

/* Background image path, should be available to the user above */
static const char* background_image = "/home/long/Pictures/wallpapers/fragmented_sunset.png";

/* default message */
static const char * message = "Welcome back ylpoonlg";

/* text color */
static const char * text_color = "#ffffff";

/* text size (must be a valid size) */
static const char * font_name = "-adobe-utopia-bold-i-normal--12-120-75-75-p-70-iso8859-10";
