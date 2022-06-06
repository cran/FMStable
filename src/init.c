#include <stdlib.h>
#include <R_ext/Rdynload.h>

/* .C calls */
extern void RtailslogMSS(double *Ralpha,double *Roneminusalpha,
	double *Rtwominusalpha,double *Rlocation,double *Rlogscale,
	double *Rn,double *x,double *d, double *logd,double *F,double *logF,
	double *cF,double *logcF);
extern void RtailsMSS(double *Ralpha,double *Roneminusalpha,
	double *Rtwominusalpha,double *Rlocation,double *Rlogscale,
	double *Rn,double *x,double *d,double *logd,double *F,
	double *logF,double *cF,double *logcF);

static const R_CMethodDef CEntries[] = {
    {"RtailslogMSS", (DL_FUNC) &RtailslogMSS, 14},
    {"RtailsMSS",    (DL_FUNC) &RtailsMSS,    14},
    {NULL, NULL, 0}
};

void R_init_FMStable(DllInfo *dll)
{
    R_registerRoutines(dll, CEntries, NULL, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
