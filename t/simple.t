use Test::Simple tests => 2;

use lib 'lib';
use WWW::Search;
ok(1, "loaded WWW::Search");

my $key = "XXXXXXX";
my $search = WWW::Search->new('Google', key => $key);
ok($search, "have WWW::Search::Google object");

# unfortunately we can't test anything without a Google API license
# key, oh well

__END__
$search->native_query("leon brocard");

while (my $result = $search->next_result()) {
  print $result->title, "\n";
  print $result->url, "\n";
  print $result->description, "\n";
  print "\n";
}

