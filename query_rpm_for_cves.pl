#!/usr/bin/perl -w
use strict;

my %cves;
my $changelog;
my $command;
my $i = 0;

foreach my $line (<STDIN>) {
    chomp($line);
    if( $line =~ /.rpm$/) {

    $command = "/bin/rpm -qp --changelog $line";

    open(my $fh, '-|', "$command") or die $!;

    while ($changelog = <$fh>) {

        chomp($changelog);
        if($changelog =~ s/^.*(CVE-(\d+)-(\d+)).*$/$1/i){
        push(@{$cves{$changelog}}, $line);
     
    }
    $i++;
    }
}
}

foreach my $group (keys %cves){
    print "Packages in the same CVE: $group \n";
    foreach (@{$cves{$group}}) {
        print "\t$_\n";
    }
}
