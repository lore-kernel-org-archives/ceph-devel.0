From: Laszlo Boszormenyi <gcs@debian.hu>
Subject: ceph v0.42 sync
Date: Sun, 26 Feb 2012 10:54:18 +0100
Message-ID: <1330250058.3834.46.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-hrD3eS0nbKtJPEyiX41b"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.barcikacomp.hu ([94.248.160.10]:39637 "EHLO
	mail.barcikacomp.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab2BZKAp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 26 Feb 2012 05:00:45 -0500
Received: from [192.168.0.100] (kabelnet-248-67.parisat.hu [91.147.248.67])
	by mail.barcikacomp.hu (Postfix) with ESMTPA id E5C4C97CA8
	for <ceph-devel@vger.kernel.org>; Sun, 26 Feb 2012 10:54:19 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--=-hrD3eS0nbKtJPEyiX41b
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

I send some patches to make the packaging difference smaller between us.
The first, create_run_dir.patch to make /run/ceph created on every
start. Yes, it's /run as /var/run is now a symbolic link to the former.
The next is an update to control to reflect the new Standards-Version
and to make hdparm optional to sdparm, which is for sATA discs.
Then an update to rules. Adding build-arch and build-indep targets.

I ask for a clarification of version numbers. Homepage shows v0.42 as
the latest downloadable as git contains v0.42.1 and v0.42.2 tags. Are
they official and/or should I wait for v0.43 which is due to yesterday
as I know?

Regards,
Laszlo/GCS

--=-hrD3eS0nbKtJPEyiX41b
Content-Disposition: attachment; filename="ceph-control.patch"
Content-Type: text/x-patch; name="ceph-control.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

--- ceph/debian/control	2012-02-26 10:08:52.229291209 +0100
+++ ceph/debian/control	2012-02-26 10:10:04.277294925 +0100
@@ -7,11 +7,11 @@
 Maintainer: Laszlo Boszormenyi (GCS) <gcs@debian.hu>
 Uploaders: Sage Weil <sage@newdream.net>
 Build-Depends: debhelper (>= 6.0.7~), autotools-dev, autoconf, automake, libfuse-dev, libboost-dev (>= 1.34), libedit-dev, libcrypto++-dev, libtool, libexpat1-dev, libfcgi-dev, libatomic-ops-dev, libgoogle-perftools-dev [i386 amd64], pkg-config, libgtkmm-2.4-dev, python, python-support, libcurl4-gnutls-dev, libkeyutils-dev, uuid-dev, libaio-dev
-Standards-Version: 3.9.1
+Standards-Version: 3.9.3
 
 Package: ceph
 Architecture: linux-any
-Depends: ${shlibs:Depends}, ${misc:Depends}, hdparm, binutils, ceph-common
+Depends: ${shlibs:Depends}, ${misc:Depends}, sdparm | hdparm, binutils, ceph-common
 Recommends: ceph-fuse, libcephfs1, librados2, librbd1, btrfs-tools
 Description: distributed storage and file system
  Ceph is a distributed storage and network file system designed to provide

--=-hrD3eS0nbKtJPEyiX41b
Content-Disposition: attachment; filename="ceph-rules.patch"
Content-Type: text/x-patch; name="ceph-rules.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

--- ceph/debian/rules	2012-02-26 08:54:09.293059993 +0100
+++ ceph/debian/rules	2012-01-14 16:02:08.000000000 +0100
@@ -42,20 +42,23 @@
   extraopts += --without-tcmalloc
 endif
 
-
 configure: configure-stamp
 configure-stamp:
 	dh_testdir
 	touch $@
 
+build-arch: build
+build-indep: build
+
 build: build-stamp
 build-stamp: configure-stamp  
 	dh_testdir
 
 	./autogen.sh
 	./configure --prefix=/usr --sbindir=/sbin --localstatedir=/var \
-		--sysconfdir=/etc $(extraopts) $(confflags)
+	  --sysconfdir=/etc $(extraopts) $(confflags)
 	$(MAKE)
+
 	cp src/init-ceph debian/ceph.init
 	cp src/init-radosgw debian/radosgw.init
 	cp src/logrotate.conf debian/ceph.logrotate

--=-hrD3eS0nbKtJPEyiX41b
Content-Disposition: attachment; filename="create_run_dir.patch"
Content-Type: text/x-patch; name="create_run_dir.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Description: /run/ceph should exists for creating UNIX domain sockets
 ceph uses UNIX domain sockets for internal communication. Create their
 directory on startup as /run is on a virtual filesystem.
 .
Author: Laszlo Boszormenyi (GCS) <gcs@debian.hu>

Bug-Debian: http://bugs.debian.org/660238
Forwarded: <ceph-devel@vger.kernel.org>
Last-Update: <2012-02-26>

--- ceph-0.42.orig/src/init-ceph.in
+++ ceph-0.42/src/init-ceph.in
@@ -12,6 +12,8 @@
 # Description:       Enable Ceph distributed file system services.
 ### END INIT INFO
 
+RUN_DIR=/run/ceph
+
 # if we start up as ./mkcephfs, assume everything else is in the
 # current directory too.
 if [ `dirname $0` = "." ] && [ $PWD != "/etc/init.d" ]; then
@@ -173,7 +175,7 @@ for name in $what; do
 
     check_host || continue
 
-    get_conf pid_file "/var/run/ceph/$type.$id.pid" "pid file"
+    get_conf pid_file "$RUN_DIR/$type.$id.pid" "pid file"
     [ -n "$pid_file" ] && do_cmd "mkdir -p "`dirname $pid_file`
 
     get_conf log_dir "" "log dir"
@@ -266,6 +268,7 @@ for name in $what; do
 		do_root_cmd "modprobe btrfs ; btrfs device scan || btrfsctl -a ; egrep -q '^[^ ]+ $btrfs_path' /proc/mounts || mount -t btrfs $btrfs_opt $first_dev $btrfs_path"
 	    fi
 	    echo Starting Ceph $name on $host...
+	    mkdir -p $RUN_DIR
 	    get_conf pre_start_eval "" "pre start eval"
 	    [ -n "$pre_start_eval" ] && $pre_start_eval
 	    get_conf pre_start "" "pre start command"

--=-hrD3eS0nbKtJPEyiX41b--

