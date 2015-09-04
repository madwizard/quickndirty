#!/usr/bin/perl -w
use strict;

# Call:
# ./query_rpm_for_cves.pl
# Kudos to dosiek for help

my %cves;
my $changelog;
my $command;
my $i = 0;

foreach my $file (glob('*.rpm')) {

    $command = "/bin/rpm -qp --changelog $file";

    open(my $fh, '-|', "$command") or die $!;

    while ($changelog = <$fh>) {
        chomp($changelog);
        if($changelog =~ s/^.*(CVE-(\d+)-(\d+)).*$/$1/i){
            push(@{$cves{$changelog}}, $file);
        }
    $i++;
    }
}

foreach my $group (keys %cves){
    print "Packages in the same CVE: $group \n";
    foreach (@{$cves{$group}}) {
        print "\t$_\n";
    }
}
