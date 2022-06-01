#!/usr/bin/perl
use warnings;
use strict;

# path and src strings removed
my $path = "/???/???/???/"; 
my $src = "???.???";
my $des = "ExtractHomeworkReport.txt";

my @info = split('/', $path);
my (undef, undef, $site, undef, $job, undef, $run) = @info;

my $border = "-" x 140;

#ex: Fri Nov 15 07:21:05 2019
my @myTime = split(' ', localtime());
my ($day, $month, $date, $time, $year) = @myTime;

# open source file for reading
open(SRC,'<', $path.$src) or die $!;

# open destination file for writing
open(DES,'>', $path.$des) or die $!;

print("copying selected content\n from: $src\n to: $des\n");

#print general report info
print DES "\n$border\nSPECIFIED CLIENT CUSTOMER REPORT\n$border\n\n";
print DES "Print Site: $site\t\t\t";
print DES "Job Name: $job\t\t";
print DES "Job Run: $run\n";
print DES "Run Date: $day, $month $date\t\t";
print DES "Run Time: $time\t\t";
print DES "Source File: $src\n\n";

#print client customer data
print("copying specified entries\n");
my $myCounter = 1;
my $spacer = " " x 17;
my $header = "Line  | Customer Name".$spacer."| CoSigner Name".$spacer."| Street Address".$spacer."| City, State ZIP\n";
print DES $header;
print DES $border;
print DES "\n";
#loop through input file line by line
while (my $currLine = <SRC>){
    #only print every 100th line
    if ( $myCounter % 100 == 0){
        #create substrings for output
        my $currName = substr $currLine, 612, 30;
        my $currCoName = substr $currLine, 662, 30;
        my $currStreet = substr $currLine, 712, 31;
        my $currCityStateZip = substr $currLine, 762, 30;
        my $currInfo = $myCounter."   | ".$currName."| ".$currCoName."| ".$currStreet."| ".$currCityStateZip."\n";

        #print DES $_;
        print DES $currInfo;
        print("Entry $myCounter printed\n");
    }
    $myCounter++
}

#close the filehandles
close(SRC);
close(DES);

print ("File content copied successfully!\n");
