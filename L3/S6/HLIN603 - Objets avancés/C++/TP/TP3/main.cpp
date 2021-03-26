class Bx {
protected:
    void x();

    friend class A;
};

class By {
protected:
    void y();
};

class B : public Bx, public By {
public:
    void test()
    {
        B b;
        b.x();
        b.y();
    }
};

class A {
public:
    void test()
    {
        B b;
        b.x();
        // b.y();
    }
};

class C {
public:
    void test()
    {
        B b;
        // b.x();
        // b.y();
    }
};

int main() {}
