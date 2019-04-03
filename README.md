# Quickbox autodl irssi plex extension

dashboard index.php location [/srv/rutorrent/home]

install script location [/usr/local/bin/quickbox/package/install/]


## How to install

1. Update the current index.php located within dashboard location with the new autodl widget.
2. Update package_data.php located within dashboard location with the new shell exec code for addtoplex.
3. copy the installpackage script within the install script location.
4. Restart apache 2 server
```console
foo@bar:~$/etc/init.d/apache2 restart
```

## Todo

1. Add tv automove option
2. Add install script
