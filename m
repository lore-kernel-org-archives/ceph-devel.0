From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mkcephfs.in: Use $user when copying files using scp
Date: Thu, 21 Oct 2010 18:54:24 -0400
Message-ID: <1287701664-6945-1-git-send-email-tytso@mit.edu>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from thunk.org ([69.25.196.29]:52474 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758569Ab0JUWy0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Oct 2010 18:54:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Theodore Ts'o <tytso@google.com>

From: Theodore Ts'o <tytso@google.com>

The use of $user was missing in a few places.  This was needed so I
could run as a different userid than the userid than is used to install
and run the Ceph daemons.

Signed-off-by: "Theodore Ts'o" <tytso@google.com>
---
 src/mkcephfs.in |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/src/mkcephfs.in b/src/mkcephfs.in
index 9359118..6bb3b3c 100644
--- a/src/mkcephfs.in
+++ b/src/mkcephfs.in
@@ -185,9 +185,15 @@ for name in $what; do
     check_host || continue
 
     if [ -n "$ssh" ] && ( echo $pushed_to | grep -v -q " $host " ); then
-	scp -q $conf $host:$conf
-	scp -q $osdmap $host:$osdmap
-	scp -q $monmap $host:$monmap
+	if [ -n "$user" ]; then
+	  scp -q $conf $user@$host:$conf
+	  scp -q $osdmap $user@$host:$osdmap
+	  scp -q $monmap $user@$host:$monmap
+        else
+	  scp -q $conf $host:$conf
+	  scp -q $osdmap $host:$osdmap
+	  scp -q $monmap $host:$monmap
+        fi
 	pushed_to="$pushed_to $host "
     fi
 
@@ -239,7 +245,13 @@ for name in $what; do
 	    do_root_cmd "umount $btrfs_path ; for f in $btrfs_devs ; do umount \$f ; done ; modprobe btrfs ; mkfs.btrfs $btrfs_devs ; modprobe btrfs ; btrfsctl -a ; mount -t btrfs $btrfs_opt $first_dev $btrfs_path ; chown $osd_user $btrfs_path ; chmod +w $btrfs_path "
 	fi
 
-	[ -n "$ssh" ] && scp $monmap $host:$monmap
+	if [ -n "$ssh" ]; then
+          if [ -n "$user" ]; then
+            scp $monmap $user@$host:$monmap
+          else
+            scp $monmap $host:$monmap
+          fi
+        fi
 	do_cmd "$BINDIR/cosd -c $conf --monmap $monmap -i $num --mkfs --osd-data $osd_data"
 
 	if [ -n "$keyring" ]; then
-- 
1.7.1

