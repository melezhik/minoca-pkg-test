use strict;

my %installed;

open( my $fh, test_root_dir().'/installed.txt') or die "can't open file with installed packages list to read: $!";

while( my $l = <$fh>) {
  chomp $l;
  $installed{$l}=1;
  print "basic package: $l ... \n";	
}

open(my $fh, '-|', 'opkg list-installed') or die "can't open `opkg list-installed` for read: $!";
my $status = "ok";
while ( my $p = <$fh>){
  chomp $p;
  next if $installed{$p};
  print "removing $p ... \n";	
  $status = "failed" unless system("opkg --force-depends $p") == 0;
  
}

close $fh;

print "status: $status";

