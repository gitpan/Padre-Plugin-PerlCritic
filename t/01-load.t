use strict;
use warnings;

use Test::More;
my $tests;

plan tests => $tests;

use Padre::Plugin::PerlCritic;
use Padre;
diag "Padre::Plugin::PerlCritic: $Padre::Plugin::PerlCritic::VERSION";
diag "Padre: $Padre::VERSION";
diag "Wx Version: $Wx::VERSION " . Wx::wxVERSION_STRING();
 
{
    my @menu = Padre::Plugin::PerlCritic->menu;
    is @menu, 1, 'one menu item';
    is $menu[0][0], 'Run Perl::Critic', 'menu item 1';
    BEGIN { $tests += 2; }
}
