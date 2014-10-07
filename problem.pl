#!  /usr/bin/perl
#  Directory hierarchy.
#  /var/.parikshak/ProblemNo/
#  This directory contains following files
#  stmt - problem stmt
#  sample-io - sample input-output
#  input1, output1 
#  input2, output2 ....

$PARIKSHAK_PATH = "/var/.parikshak/" ;

sub usage{
    print " problem problem_no \n" ;
    exit(1);
}
sub main {

  print "arguments = @ARGV  \n" ;
  if ( @ARGV != 1 ) {
      usage();
  }
  $p = "$PARIKSHAK_PATH/$ARGV[0]/" ; 
  chdir $p or die "No such problem " ;
  $o=`cat stmt  sample-io 2>&1 ` ;
  print $o ;

}
main()

