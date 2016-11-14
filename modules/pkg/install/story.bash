pkg=$(story_var 'pkg')
version=$(story_var 'version')

echo install $pkg - $version

opkg -f /etc/opkg/opkg.conf install $pkg
