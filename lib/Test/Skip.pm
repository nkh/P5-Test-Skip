
package Test::Skip ;
#use base ;

use strict;
use warnings ;

BEGIN 
{
#~ use Exporter ;
#~ use vars qw ($VERSION @ISA @EXPORT_OK @EXPORT_OK %EXPORT_TAGS);
#~ @ISA = qw(Exporter);
#~ @EXPORT_OK   = qw ();
#~ %EXPORT_TAGS = (all => [@EXPORT_OK]);

use Sub::Exporter -setup => 
	{
	exports => [ qw() ],
	groups  => 
		{
		all  => [ qw(:skip_all_tests :skip_tests) ],
		skip_tests => [qw(skip_tests skip_tests_unless skip_tests_if)],
		skip_all_tests => [qw(skip_all_tests skip_all_tests_unless skip_all_tests_if)],
		}
	};
	
use vars qw ($VERSION);
$VERSION     = '0.01_2';
}

#-------------------------------------------------------------------------------

use English qw( -no_match_vars ) ;

use Readonly ;
Readonly my $EMPTY_STRING => q{} ;

use Carp qw(carp croak confess) ;

#-------------------------------------------------------------------------------

=head1 NAME

Test::Skip - Framework to skip tests unless conditions are met

=head1 SYNOPSIS

  # load time decision, all the tests in the file will be skipped
  # unless all the conditions are met

  use Test::Skip
  	{
	description => 'pre-requisits to test XXX',
	 
	# dump all the condition and their state unless all conditions are met 
	verbose => 1,

	unless_has =>
		{
		executables => [ '/usr/bin/rsync', 'git' ],
		modules => ['IPC::Run', ['Data::TreeDumper' => 0.36 ]] ,
		os => [ 'linux', ['Win32' => 'XP']]
		},

	if_has => 
		{
		modules => 
			{
			error_text => 'module "Safe" is too old!',
			modules => ['Safe' => '<2.26'] 
			},

		user_check =>
			{
			'command ps(1) does not supply VSIZE' => \&check_ps_for_VSIZE_field,
			},
		}

	# use existing modules that implement Skip functionality
	plugins => {executables => 'Test::Skip::UnlessExistsExecutable'},
	} ;

  #---------------------------------------------------
  
  # run time decision
  use Test::Skip qw(:skip_all_test) ;

  # single pre-requisits
  #
  skip_all_tests_unless 'modules' => 'IPC::Run, 'no IPC::Run, needed for test xxx' ;
  skip_all_tests_if 'modules' => ['Safe' => '<2.26'], 'tests need modern versions of Safe'

  # many pre-requisits

  skip_all_tests \%prerequisites, 'text displayed if tests are skipped' ;

  #---------------------------------------------------

  # run time decision, Test::Block style
  use Test::Skip qw(:skip_test) ;  
  
  skip_tests_if 'modules' => ['Safe' => '<2.26'] 
  	{
	# many tests using a moder Safe in this block 
	}, 'tests need modern versions of Safe' ;

  my %prerequisites =
  	{
        unless_has => { executables => '/usr/bin/rsync', ...},
	if_has => { ... }, 
	} ;

  skip_tests \%prerequisites
	{
	# many tests in this block
	}, 'prerequistes missing for test XXX' ;


=head1 DESCRIPTION

* This is a placeholder with no implementation yet. Please give feedback on the API *

This module implements a framework that skips tests unless the specified pre-requisits are met.


See Module::Load::Conditional

=head1 DOCUMENTATION

=head1 SUBROUTINES/METHODS

=cut


#-------------------------------------------------------------------------------

1 ;

=head1 BUGS AND LIMITATIONS

None so far.

=head1 AUTHOR

	Nadim ibn hamouda el Khemir
	CPAN ID: NKH
	mailto: nadim@cpan.org

=head1 COPYRIGHT AND LICENSE

Copyright 2010 Nadim Khemir.

This program is free software; you can redistribute it and/or
modify it under the terms of either:

=over 4

=item * the GNU General Public License as published by the Free
Software Foundation; either version 1, or (at your option) any
later version, or

=item * the Artistic License version 2.0.

=back

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::Skip

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Skip>

=item * RT: CPAN's request tracker

Please report any bugs or feature requests to  L <bug-test-skip@rt.cpan.org>.

We will be notified, and then you'll automatically be notified of progress on
your bug as we make changes.

=item * Search CPAN

L<http://search.cpan.org/dist/Test-Skip>

=back

=head1 SEE ALSO

L<Test::Skip::UnlessExistsExecutable>, L<Test::Requires>

=cut

