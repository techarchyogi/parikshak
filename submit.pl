#!/usr/bin/perl

#
#  Directory hierarchy.
#  /var/.parikshak/ProblemNo/
#  This directory contains following files
#  stmt - problem stmt
#  sample-io - sample input-output
#  input1, output1 
#  input2, output2 ....

$PARIKSHAK_PATH = "/var/.parikshak/" ;


sub usage
{
    print ( "submit problem-number program-name\n");
    exit(1);
}
sub get_input_count
{
   $p_dir = $_[0] ;
   $path = $PARIKSHAK_PATH."/".$p_dir ;
   $cmd = " ls -l $path/input* | wc -l" ;
   $input_count = `$cmd` ;
   return $input_count ; 
}

sub test_c_prog
{
   
   $p_dir =@_[0] ;
   $f = @_[1] ;
   print "compiling $f ... \n";
   $output = `gcc  -o ./a.out $f 2>&1` ; 
   if ( $output =~ /error/ ){
       print "$output \n" ;
       exit(1);
   } else {
       print("Compiled ... \n" );
   }
   $input_count = get_input_count($p_dir);
   $path = "$PARIKSHAK_PATH/$p_dir" ;
   for ( $i = 1 ; $i <= $input_count ; $i++ ){
       $runcmd = "./a.out < $path/input$i > op$i" ;
       #print $runcmd ;
       $out = `$runcmd` ;
       #print $out ;
       $pass = `diff -q op$i $path/output$i` ;
       #print ( "Pass --$pass--\n");
       if ( length($pass) ){
            print (" N ." );
       }else{
            print (" Y ." );
       }
   }
   print ("\n");
}
sub main()
{
    if ( @ARGV != 2 ) {
    	usage();
    }
    $prb_no = $ARGV[0] ;
    $fname = $ARGV[1] ;
    chomp($fname);
    print ( "File name is $fname \n" );
    if ( $fname =~ /c[pp|++]*$/ ){
        print "C/C++ program ... \n" ;
	test_c_prog($prb_no, $fname);
    } elsif ( $fname =~ /.pl$/ ) {
        print "perl it is then ...\n" ;
    } elsif ( $fname =~ /.py$/ ) {
        print "so its python  ...\n" ;
    }else{
        printf("Only C/C++, perl or python are currently supported.");
	printf("Support for algol ada php smalltalk lisp haskell not foreseen\n");
    }

}
main()

