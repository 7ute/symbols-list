package My::Test::Package1;

use strict;
use warnings;
use utf8;
use Test::Module::Usage qw(:all);

my $Version = 0.9;

package My::Test::Package2 {
    $Version = 1.0;
}

package My::Test::::P&auml;ckage3;

# TODO: Heres an important todo entry!

our @ArrayToUse = (
    '1',
    '2',
    '3',
);

# FIXME: A nasty workaround or bug, that needs to be fixed!

our $Test = 1;

our $TestWithoutValue;

=head1 NAME

My::Test::Package - A test package

=cut

=item new()

some descriptions about the constructor

    test test test

=cut

sub new {
    my ( $Type, %Param ) = @_;

    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub _PrivateSubroutine {
    my $Name = shift;

    print "Hello, $Name!\n";
}

sub Full::Namespace::Subroutine {
    my $Name = shift;

    print "Hello, $Name!\n";
}

sub Full::Namespace::_PrivateSubroutine {
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

1;
