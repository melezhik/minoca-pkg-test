my $cmd = story_var('command');
print "running test command: bash -c '$cmd' ...\n";
system("bash -c '$cmd'");

