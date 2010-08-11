use strict;
use warnings;
use Test::More 'no_plan';
use URI;
use Data::Dumper;
use XML::Feed::Aggregator;
use Try::Tiny;

# test construction from a mixed list
my $slashdot = URI->new('http://rss.slashdot.org/Slashdot/slashdot');
my $slashdot2 = URI->new('http://rss.slashdot.org/Slashdot/slashdot');

my $sources = [$slashdot, $slashdot2] ;

my $agg  = XML::Feed::Aggregator->new({sources=>$sources});

isa_ok($agg, 'XML::Feed::Aggregator');

ok(scalar($agg->errors) == 0, "no errors");

$agg->sort;

ok(scalar($agg->entries) > 0, 'entry count');

ok($agg->deduplicate > 0, 'removed some duplicates');

ok(scalar($agg->errors) == 0);
diag "error:\n$_" for $agg->errors;
