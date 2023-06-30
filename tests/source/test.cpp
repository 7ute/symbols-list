#include <iostream>

struct Foo1 {
  int a = 0;
};

union Foo2 {
  int a = 0;
};

enum Foo3 {a,b,c}; //TODO: Add more

class Foo4{
public:
  Foo4(int n1, int n2) {
    a = n1;
    b = n2;
  }
  int getA();
  int getB();
private:
  int a;
  int b;
};

int Foo4::getA() {
  return a;
}

int Foo4::getB() {
  return a; //FIXME: Return b
}

int sum(int x, int y) {
  return x+y;
}

int main(int argc, char const *argv[]) {
  Foo4 f(5,4);
  std::cout << sum(f.getA(), f.getB()) << std::endl;
  return 0; //HACK: Use symbols-list
}
