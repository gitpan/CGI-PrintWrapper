# Emacs, this is -*-perl-*- code.

BEGIN { use Test; plan tests => 3 }

use strict;

use Test;

use Symbol ( );


# Tests 1, 2:
eval "use CGI::PrintWrapper qw(-newstyle_urls);";
ok (not $@);
ok ($CGI::USE_PARAM_SEMICOLONS);
ok (not exists ${CGI::}{header});

# Avoid warning:
$CGI::USE_PARAM_SEMICOLONS = $CGI::USE_PARAM_SEMICOLONS;

# Tests 3, 4:
#Symbol::delete_package ('CGI'); # This fails to clean up %INC!
#delete $INC{$_} for grep m|^CGI[./]|o, keys %INC;
#eval "use CGI::PrintWrapper qw(-compile :all);";
#ok (not $@);
#ok (not $CGI::USE_PARAM_SEMICOLONS);
#ok (exists ${CGI::}{header});
