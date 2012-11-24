From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH v2] make mkcephfs and init-ceph osd filesystem handling
 more flexible
Date: Sat, 24 Nov 2012 09:22:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211240921290.23552@cobra.newdream.net>
References: <1353691870-19354-1-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33569 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab2KXRW2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 24 Nov 2012 12:22:28 -0500
In-Reply-To: <1353691870-19354-1-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org

Thanks, Danny!

sage


On Fri, 23 Nov 2012, Danny Al-Gaaf wrote:

> Remove btrfs specific keys and replace them by more generic
> keys to be able to replace btrfs with e.g. xfs or ext4 easily.
> 
> Add new key to define the osd fs type: 'osd mkfs type', which can
> get defined in the [osd] section for all OSDs.
> 
> Replaced config keys:
> - 'btrfs devs' -> 'devs'
> - 'btrfs path' -> 'fs path'
> - 'btrfs options' -> 'osd mount options $fstype'
> 
> New config key:
> - 'osd mkfs options $fstype': file system specific options for mkfs
> - 'osd mkfs type': to define the filesystem for mkfs and also mount
> 
> Replaced in mkcephfs: --mkbtrfs with --mkfs
> 
> Replaced in init-ceph:
> - --btrfs with --fsmount
> - --nobtrfs with --nofsmount
> - --btrfsumount with --fsumount
> 
> NOTE: old options from mkcephfs and init-ceph will still work, but
>       get may removed in the future from the scripts.
> 
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>  doc/man/8/mkcephfs.rst                      | 19 +++----
>  man/mkcephfs.8                              | 15 +++---
>  src/ceph.conf.twoosds                       |  7 +--
>  src/init-ceph.in                            | 78 ++++++++++++++++++++-------
>  src/mkcephfs.in                             | 82 ++++++++++++++++++++---------
>  src/sample.ceph.conf                        | 24 +++++----
>  src/test/cli/osdmaptool/ceph.conf.withracks |  4 +-
>  7 files changed, 150 insertions(+), 79 deletions(-)
> 
> diff --git a/doc/man/8/mkcephfs.rst b/doc/man/8/mkcephfs.rst
> index 5d0c995..05dee95 100644
> --- a/doc/man/8/mkcephfs.rst
> +++ b/doc/man/8/mkcephfs.rst
> @@ -7,7 +7,7 @@
>  Synopsis
>  ========
>  
> -| **mkcephfs** -c *ceph.conf* [ --mkbtrfs ] [ -a, --all-hosts [ -k
> +| **mkcephfs** -c *ceph.conf* [ --mkfs ] [ -a, --all-hosts [ -k
>    */path/to/admin.keyring* ] ]
>  
>  
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
> +   Create and mount the any file systems specified in the
> +   ceph.conf for OSD data storage using mkfs. The "devs" and (if it
> +   differs from "osd data") "fs path" options must be defined.
>  
>     **NOTE** Btrfs is still considered experimental.  This option
> -   can ease some configuration pain, but is the use of btrfs is not
> -   required when ``osd data`` directories are mounted manually by the
> -   adminstrator.
> -
> -   **NOTE** This option is deprecated and will be removed in a future
> -   release.
> +   can ease some configuration pain, but is not required when
> +   ``osd data`` directories are mounted manually by the adminstrator.
>  
>  .. option:: --no-copy-conf
>  
> diff --git a/man/mkcephfs.8 b/man/mkcephfs.8
> index f0ab80d..26276b7 100644
> --- a/man/mkcephfs.8
> +++ b/man/mkcephfs.8
> @@ -32,7 +32,7 @@ level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
>  .
>  .SH SYNOPSIS
>  .nf
> -\fBmkcephfs\fP \-c \fIceph.conf\fP [ \-\-mkbtrfs ] [ \-a, \-\-all\-hosts [ \-k
> +\fBmkcephfs\fP \-c \fIceph.conf\fP [ \-\-mkfs ] [ \-a, \-\-all\-hosts [ \-k
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
> index c0cfc68..3417cf6 100644
> --- a/src/ceph.conf.twoosds
> +++ b/src/ceph.conf.twoosds
> @@ -67,16 +67,17 @@
>  	debug journal = 20
>  	log dir = /data/cosd$id
>  	osd data = /mnt/osd$id
> -	btrfs options = "flushoncommit,usertrans"
>  ;	user = root
>  
>  ;	osd journal = /mnt/osd$id/journal
>  ;	osd journal size = 1000
>  	osd journal = "/dev/disk/by-path/pci-0000:05:02.0-scsi-6:0:0:0"
> +        osd mkfs type = btrfs
> +	osd mount options btrfs = "flushoncommit,usertrans"
>  ;	filestore max sync interval = 1
>  
> -	btrfs devs = "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0"
> -;	btrfs devs = "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0 \
> +	devs = "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0"
> +;	devs = "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0 \
>  ;	      	   /dev/disk/by-path/pci-0000:05:01.0-scsi-3:0:0:0 \
>  ;		   /dev/disk/by-path/pci-0000:05:01.0-scsi-4:0:0:0 \
>  ;		   /dev/disk/by-path/pci-0000:05:01.0-scsi-5:0:0:0 \
> diff --git a/src/init-ceph.in b/src/init-ceph.in
> index 31aeb28..2bafa99 100644
> --- a/src/init-ceph.in
> +++ b/src/init-ceph.in
> @@ -100,8 +100,8 @@ docrun=
>  allhosts=0
>  debug=0
>  monaddr=
> -dobtrfs=1
> -dobtrfsumount=0
> +dofsmount=1
> +dofsumount=0
>  verbose=0
>  
>  while echo $1 | grep -q '^-'; do     # FIXME: why not '^-'?
> @@ -130,14 +130,14 @@ case $1 in
>  	    shift
>  	    MON_ADDR=$1
>  	    ;;
> -    --btrfs)
> -	    dobtrfs=1
> +    --btrfs | --fsmount)
> +	    dofsmount=1
>  	    ;;
> -    --nobtrfs)
> -	    dobtrfs=0
> +    --nobtrfs | --nofsmount)
> +	    dofsmount=0
>  	    ;;
> -    --btrfsumount)
> -	    dobtrfsumount=1
> +    --btrfsumount | --fsumount)
> +	    dofsumount=1
>  	    ;;
>      --conf | -c)
>  	    [ -z "$2" ] && usage_exit
> @@ -222,9 +222,18 @@ for name in $what; do
>  
>      if echo $name | grep -q ^osd; then
>  	get_conf osd_data "" "osd data"
> -	get_conf btrfs_path "$osd_data" "btrfs path"  # mount point defaults so osd data
> -	get_conf btrfs_devs "" "btrfs devs"
> -	first_dev=`echo $btrfs_devs | cut '-d ' -f 1`
> +	get_conf fs_path "$osd_data" "fs path"  # mount point defaults so osd data
> +        get_conf fs_devs "" "devs"
> +	if [ -z "$fs_devs" ]; then
> +	    # try to fallback to old keys
> +	    get_conf tmp_btrfs_devs "" "btrfs devs"
> +	    if [ -n "$tmp_btrfs_devs" ]; then
> +		fs_devs="$tmp_btrfs_devs"
> +	    else
> +		echo No osd devs defined!
> +	    fi
> +	fi
> +        first_dev=`echo $fs_devs | cut '-d ' -f 1`
>      fi
>  
>      # do lockfile, if RH
> @@ -262,13 +271,44 @@ for name in $what; do
>  
>  	    cmd="$wrap $cmd $runmode"
>  	    
> -	    if [ $dobtrfs -eq 1 ] && [ -n "$btrfs_devs" ]; then
> +	    if [ $dofsmount -eq 1 ] && [ -n "$fs_devs" ]; then
>  		get_conf pre_mount "true" "pre mount command"
> -		get_conf btrfs_opt "noatime" "btrfs options"
> -		[ -n "$btrfs_opt" ] && btrfs_opt="-o $btrfs_opt"
> +		get_conf fs_type "" "osd mkfs type"
> +
> +		if [ -z "$fs_type" ]; then
> +		    # try to fallback to to old keys
> +		    get_conf tmp_devs "" "btrfs devs"
> +		    if [ -n "$tmp_devs" ]; then
> +			fs_type = "btrfs"
> +		    else
> +		        echo No filesystem type defined!
> +		        exit 0
> +                    fi
> +		fi
> +
> +		get_conf fs_opt "" "osd mount options $fs_type"
> +		if [ -z "$fs_opt" ]; then
> +		    if [ "$fs_type" = "btrfs" ]; then
> +		        #try to fallback to old keys
> +			get_conf fs_opt "" "btrfs options"
> +		    fi
> +
> +		    if [ -z "$fs_opt" ]; then
> +		        #fallback to use at least noatime
> +		        fs_opt="rw,noatime"
> +		    fi
> +		fi
> +
> +		[ -n "$fs_opt" ] && fs_opt="-o $fs_opt"
>  		[ -n "$pre_mount" ] && do_cmd "$pre_mount"
> -		echo Mounting Btrfs on $host:$btrfs_path
> -		do_root_cmd "modprobe btrfs ; btrfs device scan || btrfsctl -a ; egrep -q '^[^ ]+ $btrfs_path' /proc/mounts || mount -t btrfs $btrfs_opt $first_dev $btrfs_path"
> +
> +		if [ "$fs_type" == "btrfs" ]; then
> +		    echo Mounting Btrfs on $host:$fs_path
> +		    do_root_cmd "modprobe btrfs ; btrfs device scan || btrfsctl -a ; egrep -q '^[^ ]+ $fs_path' /proc/mounts || mount -t btrfs $fs_opt $first_dev $fs_path"
> +		else
> +		    echo Mounting $fs_type on $host:$fs_path
> +		    do_root_cmd "modprobe $fs_type ; egrep -q '^[^ ]+ $fs_path' /proc/mounts || mount -t $fs_type $fs_opt $first_dev $fs_path"
> +		fi
>  	    fi
>  	    echo Starting Ceph $name on $host...
>  	    mkdir -p $RUN_DIR
> @@ -289,9 +329,9 @@ for name in $what; do
>  	    stop_daemon $name ceph-$type $pid_file
>  	    [ -n "$post_stop" ] && do_cmd "$post_stop"
>  	    [ -n "$lockfile" ] && [ "$?" -eq 0 ] && rm -f $lockfile
> -	    if [ $dobtrfsumount -eq 1 ] && [ -n "$btrfs_devs" ]; then
> -		echo Unmounting Btrfs on $host:$btrfs_path
> -		do_root_cmd "umount $btrfs_path || true"
> +	    if [ $dofsumount -eq 1 ] && [ -n "$fs_devs" ]; then
> +		echo Unmounting OSD volume on $host:$fs_path
> +		do_root_cmd "umount $fs_path || true"
>  	    fi
>  	    ;;
>  
> diff --git a/src/mkcephfs.in b/src/mkcephfs.in
> index aae616c..1cb135e 100644
> --- a/src/mkcephfs.in
> +++ b/src/mkcephfs.in
> @@ -60,7 +60,7 @@ else
>  fi
>  
>  usage_exit() {
> -    echo "usage: $0 -a -c ceph.conf [-k adminkeyring] [--mkbtrfs]"
> +    echo "usage: $0 -a -c ceph.conf [-k adminkeyring] [--mkfs]"
>      echo "   to generate a new ceph cluster on all nodes; for advanced usage see man page"
>      echo "   ** be careful, this WILL clobber old data; check your ceph.conf carefully **"
>      exit
> @@ -70,7 +70,7 @@ usage_exit() {
>  
>  
>  allhosts=0
> -mkbtrfs=0
> +mkfs=0
>  preparemonmap=0
>  prepareosdfs=""
>  initdaemon=""
> @@ -130,8 +130,8 @@ case $1 in
>  	    preparemon=1
>              manual_action=1
>  	    ;;
> -    --mkbtrfs)
> -	    mkbtrfs=1
> +    --mkbtrfs | --mkfs)
> +	    mkfs=1
>  	    ;;
>      --no-copy-conf)
>  	    nocopyconf=1
> @@ -307,21 +307,48 @@ if [ -n "$prepareosdfs" ]; then
>  
>      get_conf osd_data "/var/lib/ceph/osd/ceph-$id" "osd data"
>      get_conf osd_journal "$osd_data/journal" "osd journal"
> -    get_conf btrfs_path "$osd_data" "btrfs path"  # mount point defaults so osd data
> -    get_conf btrfs_devs "" "btrfs devs"
> -
> -    if [ -z "$btrfs_devs" ]; then
> -	echo "no btrfs devs defined for $name"
> -	exit 0
> +    get_conf fs_path "$osd_data" "fs path"  # mount point defaults so osd data
> +    get_conf fs_devs "" "devs"
> +    get_conf fs_type "" "osd mkfs type"
> +
> +    if [ -z "$fs_devs" ]; then
> +	# try to fallback to old keys
> +        get_conf tmp_btrfs_devs "" "btrfs devs"
> +        if [ -n "$tmp_btrfs_devs" ]; then
> +            fs_devs="$tmp_btrfs_devs"
> +        else
> +            echo "no devs defined for $name"
> +            exit 0
> +        fi
> +    fi
> +    if [ -z "$fs_type" ]; then
> +        # try to fallback to to old keys
> +        get_conf tmp_devs "" "btrfs devs"
> +        if [ -n "$tmp_devs" ]; then
> +            fs_type = "btrfs"
> +        else
> +            echo No filesystem type defined!
> +            exit 0
> +        fi
>      fi
>  
> -    first_dev=`echo $btrfs_devs | cut '-d ' -f 1`
> -    get_conf btrfs_opt "noatime" "btrfs options"
> -    [ -n "$btrfs_opt" ] && btrfs_opt="-o $btrfs_opt"
> +    first_dev=`echo $fs_devs | cut '-d ' -f 1`
> +    get_conf fs_opt "" "osd mount options $fs_type"
> +    if [ -z "$fs_opt" ]; then
> +        if [ "$fs_type" = "btrfs" ]; then
> +            #try to fallback to old keys
> +            get_conf fs_opt "" "btrfs options"
> +        fi
> +        if [ -z "$fs_opt" ]; then
> +            #fallback to use at least rw,noatime
> +            fs_opt="rw,noatime"
> +        fi
> +    fi
> +    [ -n "$fs_opt" ] && fs_opt="-o $fs_opt"
>      get_conf osd_user "root" "user"
>      
> -    if [ -n "$osd_journal" ] && echo "$btrfs_devs" | grep -q -w "$osd_journal" ; then
> -	echo "ERROR: osd journal device ($osd_journal) also used by btrfs devs ($btrfs_devs)"
> +    if [ -n "$osd_journal" ] && echo "fs_devs" | grep -q -w "$osd_journal" ; then
> +        echo "ERROR: osd journal device ($osd_journal) also used by devs ($fs_devs)"
>  	exit 1
>      fi
>      
> @@ -331,19 +358,22 @@ if [ -n "$prepareosdfs" ]; then
>  	test -d $osd_journal || mkdir -p `dirname $osd_journal`
>      fi
>  
> -    umount $btrfs_path || true
> -    for f in $btrfs_devs ; do
> +    umount $fs_path || true
> +    for f in $fs_devs ; do
>  	umount $f || true
>      done
>  
> -    modprobe btrfs || true
> -    mkfs.btrfs $btrfs_devs
> -    btrfs device scan || btrfsctl -a
> -    sync   # seems to fix problems for some people...
> -    mount -t btrfs $btrfs_opt $first_dev $btrfs_path
> -    chown $osd_user $btrfs_path
> -    chmod +w $btrfs_path
> -    
> +    get_conf mkfs_opt "" "osd mkfs options $fs_type"
> +    if [ "$fs_type" == "xfs" ] && [ -z "$mkfs_opt" ]; then
> +        echo Xfs filesystem found add missing -f mkfs option!
> +	mkfs_opt="-f"
> +    fi
> +    modprobe $fs_type || true
> +    mkfs.$fs_type $mkfs_opt $fs_devs
> +    mount -t $fs_type $fs_opt $first_dev $fs_path
> +    chown $osd_user $fs_path
> +    chmod +w $fs_path
> +
>      exit 0
>  fi
>  
> @@ -460,7 +490,7 @@ if [ $allhosts -eq 1 ]; then
>  	    fi
>  	fi
>  	
> -	if [ $mkbtrfs -eq 1 ] && [ "$type" = "osd" ]; then
> +	if [ $mkfs -eq 1 ] && [ "$type" = "osd" ]; then
>  	    do_root_cmd "$0 -d $rdir --prepare-osdfs $name"
>  	fi
>  
> diff --git a/src/sample.ceph.conf b/src/sample.ceph.conf
> index 88f7f02..dd121f2 100644
> --- a/src/sample.ceph.conf
> +++ b/src/sample.ceph.conf
> @@ -131,27 +131,33 @@
>  	;debug filestore = 20
>  	;debug journal = 20
>  
> +        ; The filesystem used on the volumes
> +        osd mkfs type = btrfs
> +        ; If you want to specify some other mount options, you can do so.
> +        ; for other filesystems use 'osd mount options $fstype'
> +	osd mount options btrfs = rw,noatime
> +	; The options used to format the filesystem via mkfs.$fstype
> +        ; for other filesystems use 'osd mkfs options $fstype'
> +	; osd mkfs options btrfs =
> +
> +
>  [osd.0]
>  	host = delta
>  
> -	; if 'btrfs devs' is not specified, you're responsible for
> +	; if 'devs' is not specified, you're responsible for
>  	; setting up the 'osd data' dir.  if it is not btrfs, things
>  	; will behave up until you try to recover from a crash (which
>  	; usually fine for basic testing).
> -	btrfs devs = /dev/sdx
> -
> -        ; If you want to specify some other mount options, you can do so.
> -        ; The default values are rw,noatime
> -        ;btrfs options = rw,noatime
> +	devs = /dev/sdx
>  
>  [osd.1]
>  	host = epsilon
> -	btrfs devs = /dev/sdy
> +	devs = /dev/sdy
>  
>  [osd.2]
>  	host = zeta
> -	btrfs devs = /dev/sdx
> +	devs = /dev/sdx
>  
>  [osd.3]
>  	host = eta
> -	btrfs devs = /dev/sdy
> +	devs = /dev/sdy
> diff --git a/src/test/cli/osdmaptool/ceph.conf.withracks b/src/test/cli/osdmaptool/ceph.conf.withracks
> index 1e14411..09399e9 100644
> --- a/src/test/cli/osdmaptool/ceph.conf.withracks
> +++ b/src/test/cli/osdmaptool/ceph.conf.withracks
> @@ -42,7 +42,9 @@
>    keyring = /mnt/osd.$id/keyring
>    osd data = /mnt/osd.$id
>    osd journal = /dev/disk/by-label/osd.$id.journal
> -  btrfs devs = /dev/disk/by-label/osd.$id.data
> +  osd mkfs type = btrfs
> +  osd mount options btrfs = rw,noatime
> +  devs = /dev/disk/by-label/osd.$id.data
>  ; temp sage
>    debug osd = 20
>    debug ms = 1
> -- 
> 1.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
