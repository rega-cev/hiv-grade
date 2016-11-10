#!/usr/bin/perl -w
use strict;
use warnings;
use Parallel::ForkManager;

my @files = <./output/*>;
my $pm = Parallel::ForkManager->new($MAX_PROCESSES);

foreach my $file (@files) {

  # Forks and returns the pid for the child:
  my $pid = $pm->start and next;
  
  # we are now in the child process
  my $newfile;
  ($newfile = $file) =~ s/\D//g;
  print "Working on: " . $file . "\n";
  my $output = qx/perl hiv-grade.pl $file/;

  open(my $fh, '>', "./output/" . $newfile . ".json") or die "Could not open file $!";
  print $fh $output;
  close $fh;
  print "done\n";

  $pm->finish; # Terminates the child process
}
