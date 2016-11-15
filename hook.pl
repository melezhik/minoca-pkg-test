my $list =  config()->{packages};
my $seen;
my @list;

if (config()->{'pkg-list'}){
  @list = split /,/, config()->{'pkg-list'};
} else {
  @list = keys %$list;
}


my $smoke_test = config()->{'smoke_test'};

for my $p (sort @list){
  if (my $version = $list->{$p} ){
    run_story("pkg/install", { pkg => $p , version => $version  });
    run_story("pkg/test", { pkg => $p , command => $smoke_test->{$p}->{command}});
  } else {
    my ($pkg,$version) = split /-/, $p;
    run_story("pkg/install", { pkg => $pkg , version => $version });
    run_story("pkg/test", { pkg => $pkg , command => $smoke_test->{$pkg}->{command}});
  }
}


