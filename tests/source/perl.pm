# --
# Copyright (C) 2001-2017 OTRS AG, http://otrs.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package My::Test::Package;

use strict;
use warnings;
use Test::Module::Usage qw(:all);

our @ArrayToUse = (
    '1',
    '2',
    '3',
);

our $Test = 1;

=head1 NAME

My::Test::Package - A test package

=cut

=item new()

some descriptions about the constructor

    test test test

=cut

sub new {
    my ( $Type, %Param ) = @_;

    # allocate new hash for object
    my $Self = {};
    bless( $Self, $Type );

    return $Self;
}

sub Very::Special::Subroutine {

}
