#!/usr/bin/perl

use strict;
use warnings;

use Test::Module1;
use Test::Module2::Usage qw(:all);

our @ArrayToUse = (
    '1',
    '2',
    '3',
);

# TODO: Heres an important todo entry!

our $Test = 1;

our $TestWithoutValue;

# FIXME: A nasty workaround or bug, that needs to be fixed!

# HACK: An even more nasty, quick and dirty code

sub _PrivateSubroutine {
    my $Name = shift;

    my $Message = <<'END_MESSAGE';
Dear $Name,

this is a message I plan to send to you.
END_MESSAGE

    return $Message;
}

sub ExperimentalButPossible($Name = 'Test') {
    print "Hello, $Name!\n";
}

sub ExperimentalButPossibleEmptyParameters() {
    print "Hello!\n";
}

sub OneLineSubroutine { return "Hello!\n"; }

sub ReturningAnonymousSubroutine {

    # some code

    return sub {
        print "Hello!\n";
    }
}

sub SubroutineWithAttribute :TestAttribute { return "Hello!\n"; }

sub SubroutineWithAttributeAndParams :TestAttribute(TestParam) { return "Hello!\n"; }

{
    package My::Test::Package4;

    my $Test123;

    use Test::Module test => 1;

    sub SubroutineInInnerScope {
        print "Hello!\n";
    }
}

exit 0;
