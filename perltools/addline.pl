#!/usr/bin/perl

use strict;
use File::Find;



my $dir = '.';

find(\&addLine, $dir);

sub addLine{

  my $file = $_;
  if($file eq "file.txt"){
    open my $fh, "<", $file;
    my @lines = <$fh>;
    close $fh;
    chomp @lines;

    # Don't edit files that already have the setting.
    if (grep { / - SomeText/ } @lines ){}
      else {
        foreach my $line (@lines){
          if($line =~ m/- WantedLine/){
            open my $fh, ">>", $file;
            say $fh "      - SomeText";
            close $fh;

          }
        }
      }
  }

}

