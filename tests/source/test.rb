attr_reader :readonly_attr
attr_writer :writeonly_attr
attr_accessor :attr

class Foo

    include SomeModule

    def self.bar
        puts 'class method'
    end

    def baz
        puts 'instance method'
    end
end

class TestClass
end

module TestModule
end

class TestModule::NestedTestClass
end

module TestModule::NestedTestModule
end

class InheritedClass < ParentClass::Entity
end

def test_method
end

def test_method_with(param)
end
