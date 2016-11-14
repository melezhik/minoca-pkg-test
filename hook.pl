my $list =  config()->{packages};
my $seen;
my @list;

if (config()->{'pkg-list'}){
  @list = split /,/, config()->{'pkg-list'};
} else {
  @list = keys %$list;
}

for my $p (@list){
  if (my $version = $list->{$p} ){
    run_story("pkg/install", { pkg => $p , version => $version })
  } else {
    my ($pkg,$version) = split /-/, $p;
    run_story("pkg/install", { pkg => $pkg , version => $version })
  }
}
