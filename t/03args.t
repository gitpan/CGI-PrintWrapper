# Emacs, this is -*-perl-*- code.

BEGIN { use Test; plan tests => 2 }

use strict;

use Test;

use CGI::PrintWrapper;
eval join '', <DATA>;
my $cgi = CGI::PrintWrapper->new (CGI::PrintWrapper::IO->new);

# WARNING: this will break if/when CGI changes the output format for
# as_string!

# Test 1, 2:
eval { $cgi->cgi->param (barney => qw(a b c));
       $cgi->as_string; };
ok (not $@);
ok ($cgi->io->string, <<EOS);
<UL>
<LI><STRONG>barney</STRONG>
<UL>
<LI>a
<LI>b
<LI>c
</UL>
</UL>
EOS

__DATA__


# Roll our own simplified IO::Scalar so we don't depend on the user
# having this package installed:

package CGI::PrintWrapper::IO;

sub new ( ) {
  my $s = '';
  bless \$s;
}

sub print (@) {
  my $self = shift;
  $$self .= join ('', @_);
  return scalar @_;
}

sub string ($) {
  ${(shift)};
}

1;
