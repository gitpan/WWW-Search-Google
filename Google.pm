package WWW::Search::Google;

use strict;
use Carp;
use SOAP::Lite;
use WWW::Search qw(generic_option);
use WWW::SearchResult;
use vars qw(@ISA $VERSION);
no warnings qw(redefine);

@ISA = qw(WWW::Search);
$VERSION = 0.19;

=head1 NAME

WWW::Search::Google - search Google via SOAP

=head1 SYNOPSIS

  use WWW::Search;
  my $search = WWW::Search->new('Google', key => $key);
  $search->native_query("leon brocard");
  while (my $result = $search->next_result()) {
    print $result->title, "\n";
    print $result->url, "\n";
    print $result->description, "\n";
    print "\n";
  }

=head1 DESCRIPTION

This class is a Google specialization of WWW::Search. It handles
searching Google F<http://www.google.com/> using its new SOAP API
F<http://www.google.com/apis/>.

All interaction should be done through WWW::Search objects.

Note that you must register for a Google Web API account and have a
valid Google API license key before using this module.

This module reports errors via croak().

=cut

# Redefine how the default deserializer handles booleans.
# Workaround because the 1999 schema implementation incorrectly doesn't
# accept "true" and "false" for boolean values.
# See http://groups.yahoo.com/group/soaplite/message/895
*SOAP::XMLSchema1999::Deserializer::as_boolean =
    *SOAP::XMLSchemaSOAP1_1::Deserializer::as_boolean = 
    \&SOAP::XMLSchema2001::Deserializer::as_boolean;

sub native_setup_search {
  my($self, $query) = @_;
  my $key = $self->{key};

  croak("No license key given to WWW::Search::Google!") unless defined $key;

  $self->{_query} = $query;
  $self->{_offset} = 0;
}

sub native_retrieve_some {
  my $self = shift;
  my $key = $self->{key};
  my $query = $self->{_query};
  my $offset = $self->{_offset};

  my $google = SOAP::Lite->service("http://api.google.com/GoogleSearch.wsdl");
  my $result = $google->doGoogleSearch(
    $key,     # key
    $query,   # search query
    $offset,  # start results
    10,       # max results
    0,        # filter: boolean
    "",       # restrict (string)
    0,        # safeSearch: boolean
    "",       # lr
    "latin1", # ie
    "latin1"  # oe
  );

  croak($google->call->faultstring) if $google->call->fault;

  $self->approximate_result_count($result->{estimatedTotalResultsCount});

  if (defined $result->{resultElements} && @{$result->{resultElements}}) {
    foreach my $element (@{$result->{resultElements}}) {
      my $hit = WWW::SearchResult->new();
      $hit->title($element->{title} || "");
      $hit->url($element->{URL} || "");
      $hit->description($element->{summary} || $element->{snippit} || "");
      push @{$self->{cache}}, $hit;
    }
  } else {
    return;
  }

  $self->{_offset} += 10;
  return 1;
}

1;

=head1 AUTHOR

Leon Brocard E<lt>F<acme@astray.com>E<gt>

=head1 COPYRIGHT

Copyright (C) 2002, Leon Brocard

This module is free software; you can redistribute it or modify it
under the same terms as Perl itself.

=cut
