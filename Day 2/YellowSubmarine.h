class YellowSubmarine
{
    private:
        int depth;
        int horizontal;

    public:
        YellowSubmarine();
        YellowSubmarine(int d, int h);
        void change_depth(int d);
        void move_horz(int h);
        int get_depth();
        int get_horz();
};