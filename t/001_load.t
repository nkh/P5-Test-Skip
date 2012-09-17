
use strict ;
use warnings ;

use Test::NoWarnings ;

use Test::More qw(no_plan);
use Test::Exception ;
#use Test::UniqueTestNames ;

BEGIN { use_ok( 'Test::Skip' ) or BAIL_OUT("Can't load module"); } ;

__END__

my $object = new Test::Skip ;

is(defined $object, 1, 'default constructor') ;
isa_ok($object, 'Test::Skip');

my $new_config = $object->new() ;
is(defined $new_config, 1, 'constructed from object') ;
isa_ok($new_config , 'Test::Skip');

dies_ok
	{
	Test::Skip::new () ;
	} "invalid constructor" ;
