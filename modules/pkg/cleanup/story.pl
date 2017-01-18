use strict;

open(my $fh, '-|', 'opkg list-installed') or die "can't open `opkg list-installed` for read: $!";
while ( my $l = <$fh>){
  print $l;	
}
close $fh;
