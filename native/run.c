#include "factor.h"

void clear_environment(void)
{
	int i;
	for(i = 0; i < USER_ENV; i++)
		userenv[i] = 0;
	profile_depth = 0;
}

#define EXECUTE(w) ((XT)(w->xt))()

void run(void)
{
	CELL next;

	/* Error handling. */
	sigsetjmp(toplevel, 1);
	
	for(;;)
	{
		if(callframe == F)
		{
			callframe = cpop();
			cpop();
			continue;
		}

		callframe = (CELL)untag_cons(callframe);
		next = get(callframe);
		callframe = get(callframe + CELLS);

		if(TAG(next) == WORD_TYPE)
		{
			executing = (WORD*)UNTAG(next);
			EXECUTE(executing);
		}
		else
			dpush(next);
	}
}

/* XT of deferred words */
void undefined()
{
	general_error(ERROR_UNDEFINED_WORD,tag_word(executing));
}

/* XT of compound definitions */
void docol(void)
{
	call(executing->parameter);
}

/* pushes word parameter */
void dosym(void)
{
	dpush(executing->parameter);
}

void primitive_execute(void)
{
	executing = untag_word(dpop());
	EXECUTE(executing);
}

void primitive_call(void)
{
	call(dpop());
}

void primitive_ifte(void)
{
	CELL f = dpop();
	CELL t = dpop();
	CELL cond = dpop();
	call(untag_boolean(cond) ? t : f);
}

void primitive_getenv(void)
{
	FIXNUM e = to_fixnum(dpeek());
	if(e < 0 || e >= USER_ENV)
		range_error(F,e,USER_ENV);
	drepl(userenv[e]);
}

void primitive_setenv(void)
{
	FIXNUM e = to_fixnum(dpop());
	CELL value = dpop();
	if(e < 0 || e >= USER_ENV)
		range_error(F,e,USER_ENV);
	userenv[e] = value;
}
