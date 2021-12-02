#include "YellowSubmarine.h"
#include <iostream>
using namespace std;

YellowSubmarine::YellowSubmarine()
{
    depth=0;
    horizontal=0;
    aim=0;
}

YellowSubmarine::YellowSubmarine(int d, int h)
{
    depth=d;
    horizontal=h;
    aim=0;
}

void YellowSubmarine::change_depth(int d)
{
    aim+=d;
    print_depth();
}

void YellowSubmarine::move_horz(int h)
{
    horizontal+=h;
    depth+=h*aim;
    print_horiz();
}

int YellowSubmarine::get_depth()
{
    return depth;
}

int YellowSubmarine::get_horz()
{
    return horizontal;
}

void YellowSubmarine::print_depth()
{
    cout << "Depth is now: " << depth << endl;
}

void YellowSubmarine::print_horiz()
{
    cout << "Horizontal is now: " << horizontal << endl;
}
