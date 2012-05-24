From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Multiple named clusters on same nodes
Date: Thu, 24 May 2012 10:58:00 +0200
Message-ID: <201205241058.02262.a.ott@m-privacy.de>
References: <201205231100.28327.a.ott@m-privacy.de> <CADvuQRHFR8_6EPy-02Xm9Zx-vUnPg3ngiTEr5hLZkKgaLNA--A@mail.gmail.com> <201205240959.46764.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_agfvPw5r5s5QTYm"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:56915 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368Ab2EXI6O (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 May 2012 04:58:14 -0400
In-Reply-To: <201205240959.46764.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

--Boundary-00=_agfvPw5r5s5QTYm
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 24 May 2012 wrote Amon Ott:
> Attached is a patch based on current git stable that makes mkcephfs work
> fine for me with --cluster name. ceph-mon uses the wrong mkfs path for "m=
on
> data" (default "ceph" instead of supplied cluster name), so I put in a
> workaround.
>
> Please have a look and consider inclusion as well as fixing mon data path.
> Thanks.

And another patch for the init script to handle multiple clusters.

Amon Ott
=2D-=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=F6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=E4ftsf=FChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--Boundary-00=_agfvPw5r5s5QTYm
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="init-ceph-with-cluster-names.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="init-ceph-with-cluster-names.diff"

commit d446077dc93894784348f7560ee29eaf6e3ce272
Author: Amon Ott <ao@rsbac.org>
Date:   Thu May 24 10:55:27 2012 +0200

    Make init script init-ceph.in cluster name aware.
    
    Add "--cluster clustername" parameter to start/stop/etc. specific cluster
    with default config file /etc/ceph/cluster.conf.
    If no clustername is given, walk through /etc/ceph/*.conf and try to
    start/stop/etc. them all with clustername taken from conf basename.
    
    Signed-off-by: Amon Ott <a.ott@m-privacy.de>

diff --git a/src/init-ceph.in b/src/init-ceph.in
index f2702e3..6efe7f0 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -28,6 +28,7 @@ fi
 
 usage_exit() {
     echo "usage: $0 [options] {start|stop|restart} [mon|osd|mds]..."
+    printf "\t--cluster clustername\n"
     printf "\t-c ceph.conf\n"
     printf "\t--valgrind\trun via valgrind\n"
     printf "\t--hostname [hostname]\toverride hostname lookup\n"
@@ -36,6 +37,8 @@ usage_exit() {
 
 . $LIBDIR/ceph_common.sh
 
+conf=""
+
 EXIT_STATUS=0
 
 signal_daemon() {
@@ -45,7 +48,7 @@ signal_daemon() {
     signal=$4
     action=$5
     [ -z "$action" ] && action="Stopping"
-    echo -n "$action Ceph $name on $host..."
+    echo -n "$action Ceph $cluster $name on $host..."
     do_cmd "if [ -e $pidfile ]; then
         pid=`cat $pidfile`
         if [ -e /proc/\$pid ] && grep -q $daemon /proc/\$pid/cmdline ; then
@@ -75,7 +78,7 @@ stop_daemon() {
     signal=$4
     action=$5
     [ -z "$action" ] && action="Stopping"
-    echo -n "$action Ceph $name on $host..."
+    echo -n "$action Ceph $cluster $name on $host..."
     do_cmd "while [ 1 ]; do 
 	[ -e $pidfile ] || break
 	pid=\`cat $pidfile\`
@@ -103,6 +106,7 @@ monaddr=
 dobtrfs=1
 dobtrfsumount=0
 verbose=0
+cluster=""
 
 while echo $1 | grep -q '^-'; do     # FIXME: why not '^-'?
 case $1 in
@@ -151,6 +155,12 @@ case $1 in
 	    shift
 	    hostname=$1
             ;;
+    --cluster )
+	    [ -z "$2" ] && usage_exit
+	    options="$options $1"
+	    shift
+	    cluster=$1
+            ;;
     *)
 	    echo unrecognized option \'$1\'
 	    usage_exit
@@ -160,11 +170,25 @@ options="$options $1"
 shift
 done
 
-verify_conf
-
 command=$1
 [ -n "$*" ] && shift
 
+if test -z "$cluster"
+then
+    for c in /etc/ceph/*.conf
+    do
+        test -f $c && $0 --cluster "$(basename $c .conf)" "$command" "$@"
+    done
+    exit 0
+fi
+
+if test -z "$conf"
+then
+    conf="/etc/ceph/$cluster.conf"
+fi
+
+verify_conf
+
 get_name_list "$@"
 
 for name in $what; do
@@ -176,9 +200,9 @@ for name in $what; do
     check_host || continue
 
     binary="$BINDIR/ceph-$type"
-    cmd="$binary -i $id"
+    cmd="$binary --cluster $cluster -i $id"
 
-    get_conf pid_file "$RUN_DIR/$type.$id.pid" "pid file"
+    get_conf pid_file "$RUN_DIR/$type/$cluster-$id.pid" "pid file"
     if [ -n "$pid_file" ]; then
 	do_cmd "mkdir -p "`dirname $pid_file`
 	cmd="$cmd --pid-file $pid_file"
@@ -191,13 +215,13 @@ for name in $what; do
         get_conf auto_start "" "auto start"
         if [ "$auto_start" = "no" ] || [ "$auto_start" = "false" ] || [ "$auto_start" = "0" ]; then
             if [ -z "$@" ]; then
-                echo "Skipping Ceph $name on $host... auto start is disabled"
+                echo "Skipping Ceph $cluster $name on $host... auto start is disabled"
                 continue
             fi
         fi
 
 	if daemon_is_running $name ceph-$type $id $pid_file; then
-	    echo "Starting Ceph $name on $host...already running"
+	    echo "Starting Ceph $cluster $name on $host...already running"
 	    continue
 	fi
 
@@ -228,7 +252,7 @@ for name in $what; do
     fi
 
     # do lockfile, if RH
-    get_conf lockfile "/var/lock/subsys/ceph" "lock file"
+    get_conf lockfile "/var/lock/subsys/ceph/$cluster" "lock file"
     lockdir=`dirname $lockfile`
     if [ ! -d "$lockdir" ]; then
 	lockfile=""
@@ -270,7 +294,7 @@ for name in $what; do
 		echo Mounting Btrfs on $host:$btrfs_path
 		do_root_cmd "modprobe btrfs ; btrfs device scan || btrfsctl -a ; egrep -q '^[^ ]+ $btrfs_path' /proc/mounts || mount -t btrfs $btrfs_opt $first_dev $btrfs_path"
 	    fi
-	    echo Starting Ceph $name on $host...
+	    echo Starting Ceph $cluster $name on $host...
 	    mkdir -p $RUN_DIR
 	    get_conf pre_start_eval "" "pre start eval"
 	    [ -n "$pre_start_eval" ] && $pre_start_eval
@@ -297,14 +321,14 @@ for name in $what; do
 
 	status)
 	    if daemon_is_running $name ceph-$type $id $pid_file; then
-                echo "$name: running..."
+                echo "$cluster $name: running..."
             elif [ -e "$pid_file" ]; then
                 # daemon is dead, but pid file still exists
-                echo "$name: dead."
+                echo "$cluster $name: dead."
                 EXIT_STATUS=1
             else
                 # daemon is dead, and pid file is gone
-                echo "$name: not running."
+                echo "$cluster $name: not running."
                 EXIT_STATUS=3
             fi
 	    ;;
@@ -329,7 +353,7 @@ for name in $what; do
 	    ;;
 	
 	force-reload | reload)
-	    signal_daemon $name ceph-$type $pid_file -1 "Reloading"
+	    signal_daemon $name ceph-$type $pid_file -1 "$cluster Reloading"
 	    ;;
 
 	restart)
@@ -339,7 +363,7 @@ for name in $what; do
 
 	cleanlogs)
 	    echo removing logs
-	    [ -n "$log_dir" ] && do_cmd "rm -f $log_dir/$type.$id.*"
+	    [ -n "$log_dir" ] && do_cmd "rm -f $log_dir/$cluster-$type.$id.*"
 	    ;;
 
 	cleanalllogs)

--Boundary-00=_agfvPw5r5s5QTYm--
