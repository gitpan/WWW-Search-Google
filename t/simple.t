#!/usr/bin/perl -w

use strict;
use lib 'lib';
use Test::More qw(no_plan);
use_ok("WWW::Search");

# unfortunately we can't test anything without a Google API license
# key, oh well

# If you do have a key, comment out the "__END__" and put your key
# where it says "XXXX". Then run "make test"

__END__

my $key = "XXXX";
my $search = WWW::Search->new('Google', key => $key);
ok($search, "have WWW::Search::Google object");

$search->native_query("leon brocard");

my $result = $search->next_result;
ok($result);
like($result->title, qr/astray/);
is($result->url, 'http://www.astray.com/');
ok(defined $result->description)
