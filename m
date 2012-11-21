From: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Wed, 21 Nov 2012 11:20:01 +0100
Message-ID: <50ACAAD1.50306@bisect.de>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <alpine.DEB.2.00.1211201623030.15874@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:44584 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752691Ab2KUKkC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Nov 2012 05:40:02 -0500
In-Reply-To: <alpine.DEB.2.00.1211201623030.15874@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, Danny Kukawka <dkukawka@suse.de>

Hi,

no, I have it basically ready but I have to run some tests before.
You'll have it in the next days!

Danny

Am 21.11.2012 01:23, schrieb Sage Weil:
> If you haven't gotten to this yet, I'll go ahead and jump on it..
> let me know!
> 
> Thanks- sage
> 
> 
> On Thu, 9 Aug 2012, Danny Kukawka wrote:
> 
>> Remove btrfs specific keys and replace them by more generic keys
>> to be able to replace btrfs with e.g. xfs or ext4 easily.
>> 
>> Add new key to define the osd fs type: 'fstype', which can get 
>> defined in the [osd] section for all OSDs.
>> 
>> Replace: - 'btrfs devs' -> 'devs' - 'btrfs path' -> 'fs path' -
>> 'btrfs options' -> 'fs options' - mkcephfs: replace --mkbtrfs
>> with --mkfs - init-ceph: replace --btrfs with --fsmount,
>> --nobtrfs with --nofsmount, --btrfsumount with --fsumount
>> 
>> Update documentation, manpage and example config files.
>> 
>> Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de> --- 
>> doc/man/8/mkcephfs.rst                      |   17 +++----- 
>> man/mkcephfs.8                              |   15 +++---- 
>> src/ceph.conf.twoosds                       |    7 ++-- 
>> src/init-ceph.in                            |   50
>> +++++++++++++--------- src/mkcephfs.in
>> |   60 +++++++++++++++++---------- src/sample.ceph.conf
>> |   15 ++++--- src/test/cli/osdmaptool/ceph.conf.withracks |    3
>> +- 7 Dateien ge?ndert, 95 Zeilen hinzugef?gt(+), 72 Zeilen
>> entfernt(-)
>> 
>> diff --git a/doc/man/8/mkcephfs.rst b/doc/man/8/mkcephfs.rst 
>> index ddc378a..dd3fbd5 100644 --- a/doc/man/8/mkcephfs.rst +++
>> b/doc/man/8/mkcephfs.rst @@ -70,20 +70,15 @@ Options default is
>> ``/etc/ceph/keyring`` (or whatever is specified in the config
>> file).
>> 
>> -.. option:: --mkbtrfs +.. option:: --mkfs
>> 
>> -   Create and mount the any btrfs file systems specified in the 
>> -   ceph.conf for OSD data storage using mkfs.btrfs. The "btrfs
>> devs" -   and (if it differs from "osd data") "btrfs path"
>> options must be -   defined. +   Create and mount any file system
>> specified in the ceph.conf for +   OSD data storage using mkfs.
>> The "devs" and (if it differs from +   "osd data") "fs path"
>> options must be defined.
>> 
>> **NOTE** Btrfs is still considered experimental.  This option -
>> can ease some configuration pain, but is the use of btrfs is not 
>> -   required when ``osd data`` directories are mounted manually
>> by the -   adminstrator. - -   **NOTE** This option is deprecated
>> and will be removed in a future -   release. +   can ease some
>> configuration pain, but is not required when +   ``osd data``
>> directories are mounted manually by the adminstrator.
>> 
>> .. option:: --no-copy-conf
>> 
>> diff --git a/man/mkcephfs.8 b/man/mkcephfs.8 index
>> 8544a01..22a5335 100644 --- a/man/mkcephfs.8 +++
>> b/man/mkcephfs.8 @@ -32,7 +32,7 @@ level margin:
>> \\n[rst2man-indent\\n[rst2man-indent-level]] . .SH SYNOPSIS .nf 
>> -\fBmkcephfs\fP [ \-c \fIceph.conf\fP ] [ \-\-mkbtrfs ] [ \-a,
>> \-\-all\-hosts [ \-k +\fBmkcephfs\fP [ \-c \fIceph.conf\fP ] [
>> \-\-mkfs ] [ \-a, \-\-all\-hosts [ \-k 
>> \fI/path/to/admin.keyring\fP ] ] .fi .sp @@ -111,19 +111,16 @@
>> config file). .UNINDENT .INDENT 0.0 .TP -.B \-\-mkbtrfs -Create
>> and mount the any btrfs file systems specified in the -ceph.conf
>> for OSD data storage using mkfs.btrfs. The "btrfs devs" -and (if
>> it differs from "osd data") "btrfs path" options must be +.B
>> \-\-mkfs +Create and mount any file systems specified in the 
>> +ceph.conf for OSD data storage using mkfs.*. The "devs" +and (if
>> it differs from "osd data") "fs path" options must be defined. 
>> .sp \fBNOTE\fP Btrfs is still considered experimental.  This
>> option -can ease some configuration pain, but is the use of btrfs
>> is not +can ease some configuration pain, but the use of this
>> option is not required when \fBosd data\fP directories are
>> mounted manually by the adminstrator. -.sp -\fBNOTE\fP This
>> option is deprecated and will be removed in a future -release. 
>> .UNINDENT .INDENT 0.0 .TP diff --git a/src/ceph.conf.twoosds
>> b/src/ceph.conf.twoosds index c0cfc68..05ca754 100644 ---
>> a/src/ceph.conf.twoosds +++ b/src/ceph.conf.twoosds @@ -67,7
>> +67,8 @@ debug journal = 20 log dir = /data/cosd$id osd data =
>> /mnt/osd$id -	btrfs options = "flushoncommit,usertrans" +	fs
>> options = "flushoncommit,usertrans" +	fstype = btrfs ;	user =
>> root
>> 
>> ;	osd journal = /mnt/osd$id/journal @@ -75,8 +76,8 @@ osd journal
>> = "/dev/disk/by-path/pci-0000:05:02.0-scsi-6:0:0:0" ;	filestore
>> max sync interval = 1
>> 
>> -	btrfs devs = "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0" 
>> -;	btrfs devs = "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0
>> \ +	devs = "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0" +;
>> devs = "/dev/disk/by-path/pci-0000:05:01.0-scsi-2:0:0:0 \ ;
>> /dev/disk/by-path/pci-0000:05:01.0-scsi-3:0:0:0 \ ;
>> /dev/disk/by-path/pci-0000:05:01.0-scsi-4:0:0:0 \ ;
>> /dev/disk/by-path/pci-0000:05:01.0-scsi-5:0:0:0 \ diff --git
>> a/src/init-ceph.in b/src/init-ceph.in index a8c5a29..32bcc9a
>> 100644 --- a/src/init-ceph.in +++ b/src/init-ceph.in @@ -100,8
>> +100,8 @@ docrun= allhosts=0 debug=0 monaddr= -dobtrfs=1 
>> -dobtrfsumount=0 +dofsmount=1 +dofsumount=0 verbose=0
>> 
>> while echo $1 | grep -q '^-'; do     # FIXME: why not '^-'? @@
>> -130,14 +130,14 @@ case $1 in shift MON_ADDR=$1 ;; -    --btrfs) 
>> -	    dobtrfs=1 +    --fsmount) +	    dofsmount=1 ;; -
>> --nobtrfs) -	    dobtrfs=0 +    --nofsmount) +	    dofsmount=0 
>> ;; -    --btrfsumount) -	    dobtrfsumount=1 +    --fsumount) +
>> dofsumount=1 ;; --conf | -c) [ -z "$2" ] && usage_exit @@ -222,9
>> +222,9 @@ for name in $what; do
>> 
>> if echo $name | grep -q ^osd; then get_conf osd_data "" "osd
>> data" -	get_conf btrfs_path "$osd_data" "btrfs path"  # mount
>> point defaults so osd data -	get_conf btrfs_devs "" "btrfs devs" 
>> -	first_dev=`echo $btrfs_devs | cut '-d ' -f 1` +	get_conf
>> fs_path "$osd_data" "fs path"  # mount point defaults so osd
>> data +	get_conf fs_devs "" "devs" +	first_dev=`echo $fs_devs |
>> cut '-d ' -f 1` fi
>> 
>> # do lockfile, if RH @@ -262,13 +262,25 @@ for name in $what; do
>> 
>> cmd="$wrap $cmd $runmode"  -	    if [ $dobtrfs -eq 1 ] && [ -n
>> "$btrfs_devs" ]; then +	    if [ $dofsmount -eq 1 ] && [ -n
>> "$fs_devs" ]; then get_conf pre_mount "true" "pre mount command" 
>> -		get_conf btrfs_opt "noatime" "btrfs options" -		[ -n
>> "$btrfs_opt" ] && btrfs_opt="-o $btrfs_opt" +		get_conf fs_opt
>> "noatime" "fs options" +		get_conf fs_type "" "fstype" + +		if [
>> -z "$fs_type" ]; then +		    echo No filesystem type defined! +
>> exit 0 +                fi + +		[ -n "$fs_opt" ] && fs_opt="-o
>> $fs_opt" [ -n "$pre_mount" ] && do_cmd "$pre_mount" -		echo
>> Mounting Btrfs on $host:$btrfs_path -		do_root_cmd "modprobe
>> btrfs ; btrfs device scan || btrfsctl -a ; egrep -q '^[^ ]+
>> $btrfs_path' /proc/mounts || mount -t btrfs $btrfs_opt $first_dev
>> $btrfs_path" + +		if [ "$fs_type" == "btrfs" ]; then +		    echo
>> Mounting Btrfs on $host:$fs_path +		    do_root_cmd "modprobe
>> btrfs ; btrfs device scan || btrfsctl -a ; egrep -q '^[^ ]+
>> $fs_path' /proc/mounts || mount -t btrfs $fs_opt $first_dev
>> $fs_path" +		else +		    do_root_cmd "modprobe $fs_type ; egrep
>> -q '^[^ ]+ $fs_path' /proc/mounts || mount -t $fs_type $fs_opt
>> $first_dev $fs_path" +		fi fi echo Starting Ceph $name on
>> $host... mkdir -p $RUN_DIR @@ -289,9 +301,9 @@ for name in $what;
>> do stop_daemon $name ceph-$type $pid_file [ -n "$post_stop" ] &&
>> do_cmd "$post_stop" [ -n "$lockfile" ] && [ "$?" -eq 0 ] && rm -f
>> $lockfile -	    if [ $dobtrfsumount -eq 1 ] && [ -n "$btrfs_devs"
>> ]; then -		echo Unmounting Btrfs on $host:$btrfs_path -
>> do_root_cmd "umount $btrfs_path || true" +	    if [ $dofsumount
>> -eq 1 ] && [ -n "$fs_devs" ]; then +		echo Unmounting OSD volume
>> on $host:$fs_path +		do_root_cmd "umount $fs_path || true" fi ;;
>> 
>> diff --git a/src/mkcephfs.in b/src/mkcephfs.in index
>> c507709..492d4b6 100644 --- a/src/mkcephfs.in +++
>> b/src/mkcephfs.in @@ -60,7 +60,7 @@ else fi
>> 
>> usage_exit() { -    echo "usage: $0 -a -c ceph.conf [-k
>> adminkeyring] [--mkbtrfs]" +    echo "usage: $0 -a -c ceph.conf
>> [-k adminkeyring] [--mkfs]" echo "   to generate a new ceph
>> cluster on all nodes; for advanced usage see man page" echo "
>> ** be careful, this WILL clobber old data; check your ceph.conf
>> carefully **" exit @@ -70,7 +70,7 @@ usage_exit() {
>> 
>> 
>> allhosts=0 -mkbtrfs=0 +mkfs=0 preparemonmap=0 prepareosdfs="" 
>> initdaemon="" @@ -130,8 +130,8 @@ case $1 in preparemon=1 
>> manual_action=1 ;; -    --mkbtrfs) -	    mkbtrfs=1 +    --mkfs) +
>> mkfs=1 ;; --no-copy-conf) nocopyconf=1 @@ -306,21 +306,26 @@ if [
>> -n "$prepareosdfs" ]; then
>> 
>> get_conf osd_data "/var/lib/ceph/osd/ceph-$id" "osd data" 
>> get_conf osd_journal "$osd_data/journal" "osd journal" -
>> get_conf btrfs_path "$osd_data" "btrfs path"  # mount point
>> defaults so osd data -    get_conf btrfs_devs "" "btrfs devs" +
>> get_conf fs_path "$osd_data" "fs path"  # mount point defaults so
>> osd data +    get_conf fs_devs "" "devs" +    get_conf fs_type ""
>> "fstype"
>> 
>> -    if [ -z "$btrfs_devs" ]; then -	echo "no btrfs devs defined
>> for $name" +    if [ -z "$fs_devs" ]; then +	echo "no devs
>> defined for $name" +	exit 0 +    fi +    if [ -z "$fs_type" ];
>> then +	echo "no filesystem type defined for $name" exit 0 fi
>> 
>> -    first_dev=`echo $btrfs_devs | cut '-d ' -f 1` -    get_conf
>> btrfs_opt "noatime" "btrfs options" -    [ -n "$btrfs_opt" ] &&
>> btrfs_opt="-o $btrfs_opt" +    first_dev=`echo $fs_devs | cut '-d
>> ' -f 1` +    get_conf fs_opt "noatime" "fs options" +    [ -n
>> "$fs_opt" ] && fs_opt="-o $fs_opt" get_conf osd_user "root"
>> "user"
>> 
>> -    if [ -n "$osd_journal" ] && echo "$btrfs_devs" | grep -q -w
>> "$osd_journal" ; then -	echo "ERROR: osd journal device
>> ($osd_journal) also used by btrfs devs ($btrfs_devs)" +    if [
>> -n "$osd_journal" ] && echo "fs_devs" | grep -q -w "$osd_journal"
>> ; then +	echo "ERROR: osd journal device ($osd_journal) also used
>> by devs ($fs_devs)" exit 1 fi
>> 
>> @@ -330,18 +335,27 @@ if [ -n "$prepareosdfs" ]; then test -d
>> $osd_journal || mkdir -p `dirname $osd_journal` fi
>> 
>> -    umount $btrfs_path || true -    for f in $btrfs_devs ; do +
>> umount $fs_path || true +    for f in $fs_devs ; do umount $f ||
>> true done
>> 
>> -    modprobe btrfs || true -    mkfs.btrfs $btrfs_devs -
>> btrfs device scan || btrfsctl -a -    sync   # seems to fix
>> problems for some people... -    mount -t btrfs $btrfs_opt
>> $first_dev $btrfs_path -    chown $osd_user $btrfs_path -
>> chmod +w $btrfs_path +    if [ "$fs_type" == "btrfs" ]; then +
>> modprobe btrfs || true +        mkfs.btrfs $fs_devs +
>> btrfs device scan || btrfsctl -a +	sync # seems to fix problems
>> for some people... +    elif [ "$fs_type" == "xfs" ]; then +
>> modprobe xfs || true +	mkfs.xfs -f $fs_devs +    else +	modprobe
>> $fs_type || true +	mkfs.$fs_type $fs_devs +    fi + +    mount -t
>> $fs_type $fs_opt $first_dev $fs_path +    chown $osd_user
>> $fs_path +    chmod +w $fs_path
>> 
>> exit 0 fi @@ -459,7 +473,7 @@ if [ $allhosts -eq 1 ]; then fi fi 
>> 

>> -	if [ $mkbtrfs -eq 1 ] && [ "$type" = "osd" ]; then +	if [ $mkfs
>> -eq 1 ] && [ "$type" = "osd" ]; then do_root_cmd "$0 -d $rdir
>> --prepare-osdfs $name" fi
>> 
>> diff --git a/src/sample.ceph.conf b/src/sample.ceph.conf index
>> 88f7f02..147777d 100644 --- a/src/sample.ceph.conf +++
>> b/src/sample.ceph.conf @@ -131,27 +131,30 @@ ;debug filestore =
>> 20 ;debug journal = 20
>> 
>> +	; The filesystem used on the volumes +	fstype = btrfs + 
>> [osd.0] host = delta
>> 
>> -	; if 'btrfs devs' is not specified, you're responsible for +	;
>> if 'devs' is not specified, you're responsible for ; setting up
>> the 'osd data' dir.  if it is not btrfs, things ; will behave up
>> until you try to recover from a crash (which ; usually fine for
>> basic testing). -	btrfs devs = /dev/sdx +	devs = /dev/sdx
>> 
>> ; If you want to specify some other mount options, you can do
>> so. ; The default values are rw,noatime -        ;btrfs options =
>> rw,noatime +        ; options = rw,noatime
>> 
>> [osd.1] host = epsilon -	btrfs devs = /dev/sdy +	devs = /dev/sdy
>> 
>> [osd.2] host = zeta -	btrfs devs = /dev/sdx +	devs = /dev/sdx
>> 
>> [osd.3] host = eta -	btrfs devs = /dev/sdy +	devs = /dev/sdy diff
>> --git a/src/test/cli/osdmaptool/ceph.conf.withracks
>> b/src/test/cli/osdmaptool/ceph.conf.withracks index
>> 1e14411..87b0716 100644 ---
>> a/src/test/cli/osdmaptool/ceph.conf.withracks +++
>> b/src/test/cli/osdmaptool/ceph.conf.withracks @@ -42,7 +42,8 @@ 
>> keyring = /mnt/osd.$id/keyring osd data = /mnt/osd.$id osd
>> journal = /dev/disk/by-label/osd.$id.journal -  btrfs devs =
>> /dev/disk/by-label/osd.$id.data +  devs =
>> /dev/disk/by-label/osd.$id.data +  fstype = btrfs ; temp sage 
>> debug osd = 20 debug ms = 1 -- 1.7.10.4
>> 
>> -- To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel" in the body of a message to
>> majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
>> 
>> 
> 

