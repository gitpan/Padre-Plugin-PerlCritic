#!perl

use strict;
use warnings;

use Test::NeedsDisplay ':skip_all';
use Test::More;

plan tests => 1;

use_ok('Padre::Plugin::PerlCritic');
diag("Testing Padre::Plugin::PerlCritic $Padre::Plugin::PerlCritic::VERSION, Perl $], $^X");
