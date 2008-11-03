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
    is @menu, 2, 'one menu item';
    is $menu[0][0], 'Run critic on the active document', 'menu item 1';
    is $menu[1][0], 'Run critic on the selected text', 'menu item 2';
    BEGIN { $tests += 3; }
}
