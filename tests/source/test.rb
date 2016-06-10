attr_reader :readonly_attr
attr_writer :writeonly_attr
attr_accessor :attr

class TestClass
end

module TestModule
end

class TestModule::NestedTestClass
end

module TestModule::NestedTestModule
end

def test_method
end

def test_method_with(param)
end
