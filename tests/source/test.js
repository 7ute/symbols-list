
// ! commentaire
/* ! commentaire_multi */
class Class

function Function1() {

}

function Function2( arg1, arg2 ) {

}

function Function2Multiline( arg1,
  arg2 ) {

}

private function Function3() {

}

.controller('controller', function() {

});

$scope.method = function() {

};

.filter('filter', function() {

});

.config(function() {

});

.run(function() {

});

class SomeClass {
    async longfn(a,
      b
    ) {

    }

    static longfn2(a,
      b
    ) {

    }

    longfn3(a,
      b
    ) {

    }

    set foo(value) {

    }

    get foo() {

    }

    set bar( value ) {

    }

    get bar() {

    }
}

module.exports = class Named {}
var a = class NamedExt extends Other {}
var ClassExt = class extends Other {}

jQuery('<input>').on('click', function(){});

// TODO: A todo item
// FIXME: a bug to fix
// HACK: Some hack to make it work
/* HACK: the closed version */ var = test;

describe('Our magnificent test', function() {
	it('does something', function(done) {
		// some random stuff
        assert.equal('two', 2);
		done();
	});

	it('does something else, with arrow fn', (done) => {
		// some random stuff
		done();
	});
});
