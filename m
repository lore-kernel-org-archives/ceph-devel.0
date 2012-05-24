From: Amon Ott <a.ott@m-privacy.de>
Subject: Re: Multiple named clusters on same nodes
Date: Thu, 24 May 2012 09:59:46 +0200
Message-ID: <201205240959.46764.a.ott@m-privacy.de>
References: <201205231100.28327.a.ott@m-privacy.de> <CADvuQRHFR8_6EPy-02Xm9Zx-vUnPg3ngiTEr5hLZkKgaLNA--A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ypevP3w/ce1dygr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.237.71]:37896 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115Ab2EXH76 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 24 May 2012 03:59:58 -0400
In-Reply-To: <CADvuQRHFR8_6EPy-02Xm9Zx-vUnPg3ngiTEr5hLZkKgaLNA--A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: ceph-devel@vger.kernel.org

--Boundary-00=_ypevP3w/ce1dygr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 23 May 2012 wrote Tommi Virtanen:
> On Wed, May 23, 2012 at 2:00 AM, Amon Ott <a.ott@m-privacy.de> wrote:
> > So I started experimenting with the new "cluster" variable, but it does
> > not seem to be well supported so far. mkcephfs does not even know about
> > it and always uses "ceph" as cluster name. Setting a value for "cluster"
> > in global section of ceph.conf (homeuser.conf, backup.conf, ...) does n=
ot
> > work, it is not even used in the same config file, instead it has the
> > fixed value "ceph".
> [...]
> I don't think anyone is likely to fix mkcephfs to work with it -- I'm
> personally trying to get mkcephfs declared obsolete. It's
> fundamentally the wrong tool; for example, it cannot expand or
> reconfigure an existing cluster.

Attached is a patch based on current git stable that makes mkcephfs work fi=
ne=20
for me with --cluster name. ceph-mon uses the wrong mkfs path for "mon data=
"=20
(default "ceph" instead of supplied cluster name), so I put in a workaround.

Please have a look and consider inclusion as well as fixing mon data path.=
=20
Thanks.

Amon Ott
=2D-=20
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Am K=C3=B6llnischen Park 1    Fax: +49 30 24342336
10179 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Gesch=C3=A4ftsf=C3=BChrer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649

--Boundary-00=_ypevP3w/ce1dygr
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="mkcephfs-with-cluster-names.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mkcephfs-with-cluster-names.diff"

commit fc394c63b9fd4f5fea4bc3a430f57164a96dc543
Author: Amon Ott <ao@rsbac.org>
Date:   Thu May 24 09:48:29 2012 +0200

    mkcephfs: Support "--cluster name" for cluster naming
    
    Current mkcephs can only create clusters with name "ceph".
    This patch allows to specify the cluster name and fixes some default paths
    to the new $cluster based locations.
    Parameter --conf is now optional and defaults to /etc/ceph/$cluster.conf.
    
    Signed-off-by: Amon Ott <a.ott@m-privacy.de>

diff --git a/src/mkcephfs.in b/src/mkcephfs.in
index 17b6014..e1c061e 100644
--- a/src/mkcephfs.in
+++ b/src/mkcephfs.in
@@ -60,7 +60,7 @@ else
 fi
 
 usage_exit() {
-    echo "usage: $0 -a -c ceph.conf [-k adminkeyring] [--mkbtrfs]"
+    echo "usage: $0 [--cluster name] -a [-c ceph.conf] [-k adminkeyring] [--mkbtrfs]"
     echo "   to generate a new ceph cluster on all nodes; for advanced usage see man page"
     echo "   ** be careful, this WILL clobber old data; check your ceph.conf carefully **"
     exit
@@ -89,6 +89,7 @@ moreargs=""
 auto_action=0
 manual_action=0
 nocopyconf=0
+cluster="ceph"
 
 while [ $# -ge 1 ]; do
 case $1 in
@@ -141,6 +142,11 @@ case $1 in
 	    shift
 	    conf=$1
 	    ;;
+    --cluster | -C)
+	    [ -z "$2" ] && usage_exit
+	    shift
+	    cluster=$1
+	    ;;
     --numosd)
 	    [ -z "$2" ] && usage_exit
 	    shift
@@ -181,6 +187,8 @@ done
 
 [ -z "$conf" ] && [ -n "$dir" ] && conf="$dir/conf"
 
+[ -z "$conf" ] && conf="/etc/ceph/$cluster.conf"
+
 if [ $manual_action -eq 0 ]; then
     if [ $auto_action -eq 0 ]; then
         echo "You must specify an action. See man page."
@@ -245,19 +253,19 @@ if [ -n "$initdaemon" ]; then
     name="$type.$id"
     
     # create /var/run/ceph (or wherever pid file and/or admin socket live)
-    get_conf pid_file "/var/run/ceph/$name.pid" "pid file"
+    get_conf pid_file "/var/run/ceph/$type/$cluster-$id.pid" "pid file"
     rundir=`dirname $pid_file`
     if [ "$rundir" != "." ] && [ ! -d "$rundir" ]; then
 	mkdir -p $rundir
     fi
-    get_conf asok_file "/var/run/ceph/$name.asok" "admin socket"
+    get_conf asok_file "/var/run/ceph/$type/$cluster-$id.asok" "admin socket"
     rundir=`dirname $asok_file`
     if [ "$rundir" != "." ] && [ ! -d "$rundir" ]; then
 	mkdir -p $rundir
     fi
 
     if [ $type = "osd" ]; then
-	$BINDIR/ceph-osd -c $conf --monmap $dir/monmap -i $id --mkfs
+	$BINDIR/ceph-osd --cluster $cluster -c $conf --monmap $dir/monmap -i $id --mkfs
 	create_private_key
     fi
     
@@ -266,7 +274,9 @@ if [ -n "$initdaemon" ]; then
     fi
 
     if [ $type = "mon" ]; then
-	$BINDIR/ceph-mon -c $conf --mkfs -i $id --monmap $dir/monmap --osdmap $dir/osdmap -k $dir/keyring.mon
+        get_conf mondata "" "mon data"
+        test -z "$mondata" && mondata="/var/lib/ceph/mon/$cluster-$id"
+	$BINDIR/ceph-mon --cluster $cluster -c $conf --mon-data=$mondata --mkfs -i $id --monmap $dir/monmap --osdmap $dir/osdmap -k $dir/keyring.mon
     fi
     
     exit 0
@@ -442,14 +452,14 @@ if [ $allhosts -eq 1 ]; then
 
 	    if [ $nocopyconf -eq 0 ]; then
 		# also put conf at /etc/ceph/ceph.conf
-		scp -q $dir/conf $host:/etc/ceph/ceph.conf
+		scp -q $dir/conf $host:/etc/ceph/$cluster.conf
 	    fi
 	else
 	    rdir=$dir
 
 	    if [ $nocopyconf -eq 0 ]; then
 		# also put conf at /etc/ceph/ceph.conf
-		cp $dir/conf /etc/ceph/ceph.conf
+		cp $dir/conf /etc/ceph/$cluster.conf
 	    fi
 	fi
 	
@@ -486,15 +496,15 @@ if [ $allhosts -eq 1 ]; then
 	    scp -q $dir/* $host:$rdir
 
 	    if [ $nocopyconf -eq 0 ]; then
-		# also put conf at /etc/ceph/ceph.conf
-		scp -q $dir/conf $host:/etc/ceph/ceph.conf
+		# also put conf at /etc/ceph/$cluster.conf
+		scp -q $dir/conf $host:/etc/ceph/$cluster.conf
 	    fi
 	else
 	    rdir=$dir
 
 	    if [ $nocopyconf -eq 0 ]; then
 	        # also put conf at /etc/ceph/ceph.conf
-		cp $dir/conf /etc/ceph/ceph.conf
+		cp $dir/conf /etc/ceph/$cluster.conf
 	    fi
 	fi
 	
@@ -503,7 +513,7 @@ if [ $allhosts -eq 1 ]; then
 
     # admin keyring
     if [ -z "$adminkeyring" ]; then
-	get_conf adminkeyring "/etc/ceph/keyring" "keyring" global
+	get_conf adminkeyring "/etc/ceph/$cluster.keyring" "keyring" global
     fi
     echo "placing client.admin keyring in $adminkeyring"
     cp $dir/keyring.admin $adminkeyring

--Boundary-00=_ypevP3w/ce1dygr--
