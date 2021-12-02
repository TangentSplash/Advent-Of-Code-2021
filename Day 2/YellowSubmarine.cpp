#include "YellowSubmarine.h"

YellowSubmarine::YellowSubmarine()
{
    depth=0;
    horizontal=0;
}

YellowSubmarine::YellowSubmarine(int d, int h)
{
    depth=d;
    horizontal=h;
}

void YellowSubmarine::change_depth(int d)
{
    depth+=d;
}

void YellowSubmarine::move_horz(int h)
{
    horizontal+=h;
}

int YellowSubmarine::get_depth()
{
    return depth;
}

int YellowSubmarine::get_horz()
{
    return horizontal;
}