From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] init: Only check if auto start is disabled when the issued command is "start"
Date: Wed, 15 Feb 2012 16:20:16 +0100
Message-ID: <1329319216-5505-1-git-send-email-wido@widodh.nl>
References: <Pine.LNX.4.64.1202150639050.3836@cobra.newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from amd.ceph.widodh.nl ([31.25.100.162]:41480 "EHLO
	amd.ceph.widodh.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907Ab2BOPdV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2012 10:33:21 -0500
In-Reply-To: <Pine.LNX.4.64.1202150639050.3836@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>

This still makes sure daemons don't start on boot.

When auto start was disabled it would also prevent logrotate from doing it's job.

Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/init-ceph.in |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/src/init-ceph.in b/src/init-ceph.in
index 72249f9..2deed19 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -171,13 +171,6 @@ for name in $what; do
     num=$id
     name="$type.$id"
 
-    get_conf auto_start "" "auto start"
-    if [ -z "$@" ] || [ "$@" = "mds" ]; then
-	if [ "$auto_start" = "no" ] || [ "$auto_start" = "false" ] || [ "$auto_start" = "0" ]; then
-	    continue
-	fi
-    fi
-
     check_host || continue
 
     get_conf pid_file "/var/run/ceph/$type.$id.pid" "pid file"
@@ -188,17 +181,19 @@ for name in $what; do
     [ -n "$log_dir" ] && do_cmd "mkdir -p $log_dir"
     [ -n "$log_sym_dir" ] && do_cmd "mkdir -p $log_sym_dir"
 
-    # start, and already running?  (do this check early to avoid unnecessary work!)
+    binary="$BINDIR/ceph-$type"
     if [ "$command" = "start" ]; then
+        get_conf auto_start "" "auto start"
+        if [ "$auto_start" = "no" ] || [ "$auto_start" = "false" ] || [ "$auto_start" = "0" ]; then
+            echo "Skipping Ceph $name on $host... auto start is disabled"
+            continue
+        fi
+
 	if daemon_is_running $name ceph-$type $id $pid_file; then
 	    echo "Starting Ceph $name on $host...already running"
 	    continue
 	fi
-    fi
 
-    # binary?
-    binary="$BINDIR/ceph-$type"
-    if [ "$command" = "start" ]; then
 	get_conf copy_executable_to "" "copy executable to"
 	if [ -n "$copy_executable_to" ]; then
 	    scp $binary "$host:$copy_executable_to"
-- 
1.7.5.4

