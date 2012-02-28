From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] init: Actually do start the daemons when 'service ceph start <type>' is specified
Date: Tue, 28 Feb 2012 12:41:42 +0100
Message-ID: <1330429302-8986-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:49227 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab2B1Llt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 06:41:49 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>

A bug in my previous patch prevented any daemon with auto_start set to false from starting.

This patch allows:
* /etc/init.d/ceph start osd|mds|mon
* service ceph start osd|mds|mon

It however does not start daemons if auto_start is disabled when you invoke:
* /etc/init.d/ceph start
* service ceph start

Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/init-ceph.in |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/init-ceph.in b/src/init-ceph.in
index 80d3784..e2bd569 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -187,8 +187,10 @@ for name in $what; do
     if [ "$command" = "start" ]; then
         get_conf auto_start "" "auto start"
         if [ "$auto_start" = "no" ] || [ "$auto_start" = "false" ] || [ "$auto_start" = "0" ]; then
-            echo "Skipping Ceph $name on $host... auto start is disabled"
-            continue
+            if [ -z "$@" ]; then
+                echo "Skipping Ceph $name on $host... auto start is disabled"
+                continue
+            fi
         fi
 
 	if daemon_is_running $name ceph-$type $id $pid_file; then
-- 
1.7.5.4

