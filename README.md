# Quickbox autodl irssi plex extension

<img src="images/image1.png" class="inline"/>

dashboard index.php location [/srv/rutorrent/home]

install script location [/usr/local/bin/quickbox/package/install/]

extension data location [/usr/local/bin/quickbox/package/extensions]

## How to install

1. Update the current index.php located within dashboard location with the new autodl widget.
2. Update package_data.php located within dashboard location with the new shell exec code for addtoplex.
3. copy the installpackage script within the install script location.
4. create a new folder called extensions within [/usr/local/bin/quickbox/package/],create a text file called tvshowdata.txt with your tv show titles within.
5. Restart apache 2 server
```console
foo@bar:~$/etc/init.d/apache2 restart
```

## Todo

1. Add install script
