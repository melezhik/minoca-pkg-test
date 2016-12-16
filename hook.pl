if (config()->{action} eq 'list-installed'){
  run_story('list-installed');
  exit;
}

my $list =  config()->{packages};
my $seen;
my @list;

if (config()->{'pkg-list'}){
  @list = split /,/, config()->{'pkg-list'};
} else {
  @list = keys %$list;
}


my $smoke_test    = config()->{'smoke_test'};
my %bad_packages  = map { $_ => 1 } keys %{config()->{bad_packages}};

for my $p (sort @list){
  if (my $version = $list->{$p} ){
    if ($bad_packages{$p}){
      run_story("pkg/install-fail", { pkg => $p , version => $version  });
    } else {
      run_story("pkg/install", { pkg => $p , version => $version  });
      run_story("pkg/test", { pkg => $p , command => $smoke_test->{$p}->{command}});
    }
  } else {
    my ($pkg,$version) = split /-/, $p;
    if ($bad_packages{$pkg}){
      run_story("pkg/install-fail", { pkg => $pkg , version => $version });
    } else{
      run_story("pkg/install", { pkg => $pkg , version => $version });
      run_story("pkg/test", { pkg => $pkg , command => $smoke_test->{$pkg}->{command}});
    }
  }
}


