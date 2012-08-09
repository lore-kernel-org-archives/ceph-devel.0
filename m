From: Tommi Virtanen <tv@inktank.com>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more flexible
Date: Thu, 9 Aug 2012 09:26:20 -0700
Message-ID: <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:34969 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756080Ab2HIQ0n convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 12:26:43 -0400
Received: by vcbfk26 with SMTP id fk26so550133vcb.19
        for <ceph-devel@vger.kernel.org>; Thu, 09 Aug 2012 09:26:40 -0700 (PDT)
In-Reply-To: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

On Thu, Aug 9, 2012 at 8:42 AM, Danny Kukawka <danny.kukawka@bisect.de>=
 wrote:
> Remove btrfs specific keys and replace them by more generic
> keys to be able to replace btrfs with e.g. xfs or ext4 easily.
>
> Add new key to define the osd fs type: 'fstype', which can get
> defined in the [osd] section for all OSDs.

I'm going to say let's not do this. In fact, I've wanted to remove the
"btrfs devs" option for a while now, as it keeps leading people down
the wrong path:
https://github.com/ceph/ceph/commits/kill-btrfs-devs

mkcephfs is not a viable route forward. For example, it is unable to
expand a pre-existing cluster.

The new "OSD hotplugging" style init is much, much nicer. And does
more than just mkfs & mount.

>
> Replace:
> - 'btrfs devs' -> 'devs'
> - 'btrfs path' -> 'fs path'
> - 'btrfs options' -> 'fs options'
> - mkcephfs: replace --mkbtrfs with --mkfs
> - init-ceph: replace --btrfs with --fsmount, --nobtrfs
> with --nofsmount, --btrfsumount with --fsumount
>
> Update documentation, manpage and example config files.
>
> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
> ---
>  doc/man/8/mkcephfs.rst                      |   17 +++-----
>  man/mkcephfs.8                              |   15 +++----
>  src/ceph.conf.twoosds                       |    7 ++--
>  src/init-ceph.in                            |   50 +++++++++++++----=
-----
>  src/mkcephfs.in                             |   60 +++++++++++++++++=
----------
>  src/sample.ceph.conf                        |   15 ++++---
>  src/test/cli/osdmaptool/ceph.conf.withracks |    3 +-
>  7 Dateien ge=C3=A4ndert, 95 Zeilen hinzugef=C3=BCgt(+), 72 Zeilen en=
tfernt(-)
>
> diff --git a/doc/man/8/mkcephfs.rst b/doc/man/8/mkcephfs.rst
> index ddc378a..dd3fbd5 100644
> --- a/doc/man/8/mkcephfs.rst
> +++ b/doc/man/8/mkcephfs.rst
> @@ -70,20 +70,15 @@ Options
>     default is ``/etc/ceph/keyring`` (or whatever is specified in the
>     config file).
>
> -.. option:: --mkbtrfs
> +.. option:: --mkfs
>
> -   Create and mount the any btrfs file systems specified in the
> -   ceph.conf for OSD data storage using mkfs.btrfs. The "btrfs devs"
> -   and (if it differs from "osd data") "btrfs path" options must be
> -   defined.
> +   Create and mount any file system specified in the ceph.conf for
> +   OSD data storage using mkfs. The "devs" and (if it differs from
> +   "osd data") "fs path" options must be defined.
>
>     **NOTE** Btrfs is still considered experimental.  This option
> -   can ease some configuration pain, but is the use of btrfs is not
> -   required when ``osd data`` directories are mounted manually by th=
e
> -   adminstrator.
> -
> -   **NOTE** This option is deprecated and will be removed in a futur=
e
> -   release.
> +   can ease some configuration pain, but is not required when
> +   ``osd data`` directories are mounted manually by the adminstrator=
=2E
>
>  .. option:: --no-copy-conf
>
> diff --git a/man/mkcephfs.8 b/man/mkcephfs.8
> index 8544a01..22a5335 100644
> --- a/man/mkcephfs.8
> +++ b/man/mkcephfs.8
> @@ -32,7 +32,7 @@ level margin: \\n[rst2man-indent\\n[rst2man-indent-=
level]]
>  .
>  .SH SYNOPSIS
>  .nf
> -\fBmkcephfs\fP [ \-c \fIceph.conf\fP ] [ \-\-mkbtrfs ] [ \-a, \-\-al=
l\-hosts [ \-k
> +\fBmkcephfs\fP [ \-c \fIceph.conf\fP ] [ \-\-mkfs ] [ \-a, \-\-all\-=
hosts [ \-k
>  \fI/path/to/admin.keyring\fP ] ]
>  .fi
>  .sp
> @@ -111,19 +111,16 @@ config file).
>  .UNINDENT
>  .INDENT 0.0
>  .TP
> -.B \-\-mkbtrfs
> -Create and mount the any btrfs file systems specified in the
> -ceph.conf for OSD data storage using mkfs.btrfs. The "btrfs devs"
> -and (if it differs from "osd data") "btrfs path" options must be
> +.B \-\-mkfs
> +Create and mount any file systems specified in the
> +ceph.conf for OSD data storage using mkfs.*. The "devs"
> +and (if it differs from "osd data") "fs path" options must be
>  defined.
>  .sp
>  \fBNOTE\fP Btrfs is still considered experimental.  This option
> -can ease some configuration pain, but is the use of btrfs is not
> +can ease some configuration pain, but the use of this option is not
>  required when \fBosd data\fP directories are mounted manually by the
>  adminstrator.
> -.sp
> -\fBNOTE\fP This option is deprecated and will be removed in a future
> -release.
>  .UNINDENT
>  .INDENT 0.0
>  .TP
> diff --git a/src/ceph.conf.twoosds b/src/ceph.conf.twoosds
> index c0cfc68..05ca754 100644
> --- a/src/ceph.conf.twoosds
> +++ b/src/ceph.conf.twoosds
> @@ -67,7 +67,8 @@
>         debug journal =3D 20
>         log dir =3D /data/cosd$id
>         osd data =3D /mnt/osd$id
> -       btrfs options =3D "flushoncommit,usertrans"
> +       fs options =3D "flushoncommit,usertrans"
> +       fstype =3D btrfs
>  ;      user =3D root
>
>  ;      osd journal =3D /mnt/osd$id/journal
> @@ -75,8 +76,8 @@
>         osd journal =3D "/dev/disk/by-path/pci-0000:05:02.0-scsi-6:0:=
0:0"
>  ;      filestore max sync interval =3D 1
>
> -       btrfs devs =3D "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0=
:0"
> -;      btrfs devs =3D "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0=
:0 \
> +       devs =3D "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0"
> +;      devs =3D "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0 \
>  ;                 /dev/disk/by-path/pci-0000:05:01.0-scsi-3:0:0:0 \
>  ;                 /dev/disk/by-path/pci-0000:05:01.0-scsi-4:0:0:0 \
>  ;                 /dev/disk/by-path/pci-0000:05:01.0-scsi-5:0:0:0 \
> diff --git a/src/init-ceph.in b/src/init-ceph.in
> index a8c5a29..32bcc9a 100644
> --- a/src/init-ceph.in
> +++ b/src/init-ceph.in
> @@ -100,8 +100,8 @@ docrun=3D
>  allhosts=3D0
>  debug=3D0
>  monaddr=3D
> -dobtrfs=3D1
> -dobtrfsumount=3D0
> +dofsmount=3D1
> +dofsumount=3D0
>  verbose=3D0
>
>  while echo $1 | grep -q '^-'; do     # FIXME: why not '^-'?
> @@ -130,14 +130,14 @@ case $1 in
>             shift
>             MON_ADDR=3D$1
>             ;;
> -    --btrfs)
> -           dobtrfs=3D1
> +    --fsmount)
> +           dofsmount=3D1
>             ;;
> -    --nobtrfs)
> -           dobtrfs=3D0
> +    --nofsmount)
> +           dofsmount=3D0
>             ;;
> -    --btrfsumount)
> -           dobtrfsumount=3D1
> +    --fsumount)
> +           dofsumount=3D1
>             ;;
>      --conf | -c)
>             [ -z "$2" ] && usage_exit
> @@ -222,9 +222,9 @@ for name in $what; do
>
>      if echo $name | grep -q ^osd; then
>         get_conf osd_data "" "osd data"
> -       get_conf btrfs_path "$osd_data" "btrfs path"  # mount point d=
efaults so osd data
> -       get_conf btrfs_devs "" "btrfs devs"
> -       first_dev=3D`echo $btrfs_devs | cut '-d ' -f 1`
> +       get_conf fs_path "$osd_data" "fs path"  # mount point default=
s so osd data
> +       get_conf fs_devs "" "devs"
> +       first_dev=3D`echo $fs_devs | cut '-d ' -f 1`
>      fi
>
>      # do lockfile, if RH
> @@ -262,13 +262,25 @@ for name in $what; do
>
>             cmd=3D"$wrap $cmd $runmode"
>
> -           if [ $dobtrfs -eq 1 ] && [ -n "$btrfs_devs" ]; then
> +           if [ $dofsmount -eq 1 ] && [ -n "$fs_devs" ]; then
>                 get_conf pre_mount "true" "pre mount command"
> -               get_conf btrfs_opt "noatime" "btrfs options"
> -               [ -n "$btrfs_opt" ] && btrfs_opt=3D"-o $btrfs_opt"
> +               get_conf fs_opt "noatime" "fs options"
> +               get_conf fs_type "" "fstype"
> +
> +               if [ -z "$fs_type" ]; then
> +                   echo No filesystem type defined!
> +                   exit 0
> +                fi
> +
> +               [ -n "$fs_opt" ] && fs_opt=3D"-o $fs_opt"
>                 [ -n "$pre_mount" ] && do_cmd "$pre_mount"
> -               echo Mounting Btrfs on $host:$btrfs_path
> -               do_root_cmd "modprobe btrfs ; btrfs device scan || bt=
rfsctl -a ; egrep -q '^[^ ]+ $btrfs_path' /proc/mounts || mount -t btrf=
s $btrfs_opt $first_dev $btrfs_path"
> +
> +               if [ "$fs_type" =3D=3D "btrfs" ]; then
> +                   echo Mounting Btrfs on $host:$fs_path
> +                   do_root_cmd "modprobe btrfs ; btrfs device scan |=
| btrfsctl -a ; egrep -q '^[^ ]+ $fs_path' /proc/mounts || mount -t btr=
fs $fs_opt $first_dev $fs_path"
> +               else
> +                   do_root_cmd "modprobe $fs_type ; egrep -q '^[^ ]+=
 $fs_path' /proc/mounts || mount -t $fs_type $fs_opt $first_dev $fs_pat=
h"
> +               fi
>             fi
>             echo Starting Ceph $name on $host...
>             mkdir -p $RUN_DIR
> @@ -289,9 +301,9 @@ for name in $what; do
>             stop_daemon $name ceph-$type $pid_file
>             [ -n "$post_stop" ] && do_cmd "$post_stop"
>             [ -n "$lockfile" ] && [ "$?" -eq 0 ] && rm -f $lockfile
> -           if [ $dobtrfsumount -eq 1 ] && [ -n "$btrfs_devs" ]; then
> -               echo Unmounting Btrfs on $host:$btrfs_path
> -               do_root_cmd "umount $btrfs_path || true"
> +           if [ $dofsumount -eq 1 ] && [ -n "$fs_devs" ]; then
> +               echo Unmounting OSD volume on $host:$fs_path
> +               do_root_cmd "umount $fs_path || true"
>             fi
>             ;;
>
> diff --git a/src/mkcephfs.in b/src/mkcephfs.in
> index c507709..492d4b6 100644
> --- a/src/mkcephfs.in
> +++ b/src/mkcephfs.in
> @@ -60,7 +60,7 @@ else
>  fi
>
>  usage_exit() {
> -    echo "usage: $0 -a -c ceph.conf [-k adminkeyring] [--mkbtrfs]"
> +    echo "usage: $0 -a -c ceph.conf [-k adminkeyring] [--mkfs]"
>      echo "   to generate a new ceph cluster on all nodes; for advanc=
ed usage see man page"
>      echo "   ** be careful, this WILL clobber old data; check your c=
eph.conf carefully **"
>      exit
> @@ -70,7 +70,7 @@ usage_exit() {
>
>
>  allhosts=3D0
> -mkbtrfs=3D0
> +mkfs=3D0
>  preparemonmap=3D0
>  prepareosdfs=3D""
>  initdaemon=3D""
> @@ -130,8 +130,8 @@ case $1 in
>             preparemon=3D1
>              manual_action=3D1
>             ;;
> -    --mkbtrfs)
> -           mkbtrfs=3D1
> +    --mkfs)
> +           mkfs=3D1
>             ;;
>      --no-copy-conf)
>             nocopyconf=3D1
> @@ -306,21 +306,26 @@ if [ -n "$prepareosdfs" ]; then
>
>      get_conf osd_data "/var/lib/ceph/osd/ceph-$id" "osd data"
>      get_conf osd_journal "$osd_data/journal" "osd journal"
> -    get_conf btrfs_path "$osd_data" "btrfs path"  # mount point defa=
ults so osd data
> -    get_conf btrfs_devs "" "btrfs devs"
> +    get_conf fs_path "$osd_data" "fs path"  # mount point defaults s=
o osd data
> +    get_conf fs_devs "" "devs"
> +    get_conf fs_type "" "fstype"
>
> -    if [ -z "$btrfs_devs" ]; then
> -       echo "no btrfs devs defined for $name"
> +    if [ -z "$fs_devs" ]; then
> +       echo "no devs defined for $name"
> +       exit 0
> +    fi
> +    if [ -z "$fs_type" ]; then
> +       echo "no filesystem type defined for $name"
>         exit 0
>      fi
>
> -    first_dev=3D`echo $btrfs_devs | cut '-d ' -f 1`
> -    get_conf btrfs_opt "noatime" "btrfs options"
> -    [ -n "$btrfs_opt" ] && btrfs_opt=3D"-o $btrfs_opt"
> +    first_dev=3D`echo $fs_devs | cut '-d ' -f 1`
> +    get_conf fs_opt "noatime" "fs options"
> +    [ -n "$fs_opt" ] && fs_opt=3D"-o $fs_opt"
>      get_conf osd_user "root" "user"
>
> -    if [ -n "$osd_journal" ] && echo "$btrfs_devs" | grep -q -w "$os=
d_journal" ; then
> -       echo "ERROR: osd journal device ($osd_journal) also used by b=
trfs devs ($btrfs_devs)"
> +    if [ -n "$osd_journal" ] && echo "fs_devs" | grep -q -w "$osd_jo=
urnal" ; then
> +       echo "ERROR: osd journal device ($osd_journal) also used by d=
evs ($fs_devs)"
>         exit 1
>      fi
>
> @@ -330,18 +335,27 @@ if [ -n "$prepareosdfs" ]; then
>         test -d $osd_journal || mkdir -p `dirname $osd_journal`
>      fi
>
> -    umount $btrfs_path || true
> -    for f in $btrfs_devs ; do
> +    umount $fs_path || true
> +    for f in $fs_devs ; do
>         umount $f || true
>      done
>
> -    modprobe btrfs || true
> -    mkfs.btrfs $btrfs_devs
> -    btrfs device scan || btrfsctl -a
> -    sync   # seems to fix problems for some people...
> -    mount -t btrfs $btrfs_opt $first_dev $btrfs_path
> -    chown $osd_user $btrfs_path
> -    chmod +w $btrfs_path
> +    if [ "$fs_type" =3D=3D "btrfs" ]; then
> +        modprobe btrfs || true
> +        mkfs.btrfs $fs_devs
> +        btrfs device scan || btrfsctl -a
> +       sync # seems to fix problems for some people...
> +    elif [ "$fs_type" =3D=3D "xfs" ]; then
> +        modprobe xfs || true
> +       mkfs.xfs -f $fs_devs
> +    else
> +       modprobe $fs_type || true
> +       mkfs.$fs_type $fs_devs
> +    fi
> +
> +    mount -t $fs_type $fs_opt $first_dev $fs_path
> +    chown $osd_user $fs_path
> +    chmod +w $fs_path
>
>      exit 0
>  fi
> @@ -459,7 +473,7 @@ if [ $allhosts -eq 1 ]; then
>             fi
>         fi
>
> -       if [ $mkbtrfs -eq 1 ] && [ "$type" =3D "osd" ]; then
> +       if [ $mkfs -eq 1 ] && [ "$type" =3D "osd" ]; then
>             do_root_cmd "$0 -d $rdir --prepare-osdfs $name"
>         fi
>
> diff --git a/src/sample.ceph.conf b/src/sample.ceph.conf
> index 88f7f02..147777d 100644
> --- a/src/sample.ceph.conf
> +++ b/src/sample.ceph.conf
> @@ -131,27 +131,30 @@
>         ;debug filestore =3D 20
>         ;debug journal =3D 20
>
> +       ; The filesystem used on the volumes
> +       fstype =3D btrfs
> +
>  [osd.0]
>         host =3D delta
>
> -       ; if 'btrfs devs' is not specified, you're responsible for
> +       ; if 'devs' is not specified, you're responsible for
>         ; setting up the 'osd data' dir.  if it is not btrfs, things
>         ; will behave up until you try to recover from a crash (which
>         ; usually fine for basic testing).
> -       btrfs devs =3D /dev/sdx
> +       devs =3D /dev/sdx
>
>          ; If you want to specify some other mount options, you can d=
o so.
>          ; The default values are rw,noatime
> -        ;btrfs options =3D rw,noatime
> +        ; options =3D rw,noatime
>
>  [osd.1]
>         host =3D epsilon
> -       btrfs devs =3D /dev/sdy
> +       devs =3D /dev/sdy
>
>  [osd.2]
>         host =3D zeta
> -       btrfs devs =3D /dev/sdx
> +       devs =3D /dev/sdx
>
>  [osd.3]
>         host =3D eta
> -       btrfs devs =3D /dev/sdy
> +       devs =3D /dev/sdy
> diff --git a/src/test/cli/osdmaptool/ceph.conf.withracks b/src/test/c=
li/osdmaptool/ceph.conf.withracks
> index 1e14411..87b0716 100644
> --- a/src/test/cli/osdmaptool/ceph.conf.withracks
> +++ b/src/test/cli/osdmaptool/ceph.conf.withracks
> @@ -42,7 +42,8 @@
>    keyring =3D /mnt/osd.$id/keyring
>    osd data =3D /mnt/osd.$id
>    osd journal =3D /dev/disk/by-label/osd.$id.journal
> -  btrfs devs =3D /dev/disk/by-label/osd.$id.data
> +  devs =3D /dev/disk/by-label/osd.$id.data
> +  fstype =3D btrfs
>  ; temp sage
>    debug osd =3D 20
>    debug ms =3D 1
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
