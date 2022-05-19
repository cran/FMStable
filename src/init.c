#include <stdlib.h>
#include <R_ext/Rdynload.h>

/* .C calls */
extern void RtailslogMSS(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);
extern void RtailsMSS(void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *, void *);

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
