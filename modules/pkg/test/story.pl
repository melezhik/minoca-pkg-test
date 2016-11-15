my $cmd = story_var('command');
if ($cmd){
  print "running test command: bash -c '$cmd' ...\n";
  system("bash -c '$cmd'");
}

