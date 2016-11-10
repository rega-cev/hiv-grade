#! /usr/bin/perl -w
use LWP;
use JSON qw( decode_json encode_json );
use Data::Dumper;
use File::Slurp;

my $browser = LWP::UserAgent->new;
my $url     = 'http://www.hiv-grade.de/grade/deployed/grade.pl';

# (1) quit unless we have the correct number of command-line args
$num_args = $#ARGV + 1;
if ($num_args != 1) {
    print "\nUsage: hiv-grade.pl fasta_file\n";
    exit;
}

my $fastasequence = read_file($ARGV[0]);

my $response = $browser->post(
    $url,
    [
        'IntType'   => 'JSON',
        'Algorithms'   => ['GRADE', 'ANRS', 'HIVDB', 'Rega'],
        'program'      => 'hivalg',
        'action'    =>    'ANALYZE',
        'previousState' => 'showSequenceForm',
        'sequence_data'       => $fastasequence
    ]
);
die "$url error: ", $response->status_line
  unless $response->is_success;
die "Weird content type at $url -- ", $response->content_type
  unless $response->content_type eq 'application/json';

print $response->content;
#my $gradehtml = $response->content;
#my $graderesults = JSON->new->utf8->decode($gradehtml);

#print Dumper($graderesults);
