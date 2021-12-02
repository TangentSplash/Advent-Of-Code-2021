#include <iostream>
#include <fstream>
#include <string>
using namespace std;
#include "YellowSubmarine.h"

int main()
{
    ifstream file("input.txt");
    if (!file.is_open())
    {
        cout << "File did not open correctly\n";
        return -1;
    }

    string dir;
    int mag;

    YellowSubmarine yellow_sub;
    while (file.peek() != EOF)
    {
        file >> dir >> mag;
        if (dir=="forward")
            yellow_sub.move_horz(mag);
        else if (dir=="down")
            yellow_sub.change_depth(mag);
        else if (dir=="up")
            yellow_sub.change_depth(-mag);
    }
    file.close();

    cout << "\nThe horizontal position is " << yellow_sub.get_horz() << endl
         << "and the depth is " << yellow_sub.get_depth() << endl << endl
         << "The answer is therefore " << yellow_sub.get_depth()*yellow_sub.get_horz() << endl << endl;

    return 0;
}
