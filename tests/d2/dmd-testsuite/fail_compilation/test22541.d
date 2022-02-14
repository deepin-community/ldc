/* REQUIRED_ARGS: -preview=dip1000
TEST_OUTPUT:
---
fail_compilation/test22541.d(104): Error: returning `i` escapes a reference to parameter `i`
fail_compilation/test22541.d(104):        perhaps annotate the parameter with `return`
---
 */

/* https://issues.dlang.org/show_bug.cgi?id=22541
 */

#line 100

@safe
ref int newe(ref return scope int i) // ref, error
{
    return i;
}
