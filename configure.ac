AC_INIT([sugar-docs], [0.1], [dwnarvaez@gmail.com])
AM_INIT_AUTOMAKE([foreign])

AC_PATH_PROG([JEKYLL], jekyll)
AM_CONDITIONAL(BUILD_HTML, test x$JEKYLL != x)

AC_CONFIG_FILES([Makefile])
AC_OUTPUT
