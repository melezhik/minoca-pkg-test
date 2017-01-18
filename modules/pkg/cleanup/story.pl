use strict;

open(my $fh, '-|', 'opkg list-installed') or die "can't open `opkg list-installed` for read: $!";
while ( my $l = <$fh>){
  print $l;	
}
close $fh;

open( my $fh, test_root_dir().'/installed.txt') or die "can't open file with installed packages list to read: $!";

while( my $l = ){

}
