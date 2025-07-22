# Freenit Framework

Prerequisites:

* tmux
* python
* pip
* node
* npm

If you don't user FreeBSD/jails:

```
# bin/devel.sh
```

Otherwise, you should only run:

```
# echo 'DEVEL_MODE=YES' >vars.mk
# make devel
```

It will download backend and frontend repos for you and do the rest of the magic.
