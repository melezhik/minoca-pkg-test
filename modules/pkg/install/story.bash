pkg=$(story_var 'pkg')
version=$(story_var 'version')

echo install $pkg - $version
echo "gonna do this: opkg -f /etc/opkg/opkg.conf install $pkg"
opkg -f /etc/opkg/opkg.conf install $pkg
