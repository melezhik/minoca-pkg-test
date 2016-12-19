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


my @s;
my @chk_list;

select(STDERR);

for my $s (Outthentic::Story::Stat->failures){
    @s = (
      $s->{path},
      ( join ' ', map { "$_: $s->{vars}->{$_}" } keys %{$s->{vars}} ),
      ( $s->{scenario_status} ? "OK" : "FAILED" ),
      ( join "\n", (split "\n", $s->{stdout})[ -3 .. -1 ] )
    );

    for my $c (@{$s->{check_stat}}) {
      push @chk_list, ( $c->{status} ? "ok" : "not ok" ). " - $c->{message}";
    }

  write;

}

format STDERR_TOP =

//////////////////////////////////
/// Custom Report ( Failures ) ///
//////////////////////////////////

.

format STDERR =
@*
"story: $s[0]"
@*
"variables: $s[1]"
@*
"scenario status: $s[2]"
stdout: ( last 3 lines )
@*
$s[3]

check list:
@* ~~
shift @chk_list
---------------------------------------------------------------------------
.

