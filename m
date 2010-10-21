From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [PATCH] init-ceph: Make sure daemon_is_running() checks the
 correct instance
Date: Thu, 21 Oct 2010 10:32:09 -0600
Message-ID: <1287678729-14132-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:51878 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011Ab0JUQce (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Oct 2010 12:32:34 -0400
Received: from sentry.sandia.gov (sentry.sandia.gov [132.175.109.21])
	by sentry-three.sandia.gov (Postfix) with ESMTP id 15B864DB9D3
	for <ceph-devel@vger.kernel.org>; Thu, 21 Oct 2010 10:32:30 -0600 (MDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

When starting multiple instances of a daemon on a single host,
for unknown reasons /var/run/ceph/$type.$id.pid can hold a pid
for which /proc/$pid/cmdline identifies the right type of daemon,
but the wrong instance.  When this happens, all the configured
instances of a daemon are not running, but repeated invocations
of "init-ceph start" do not start the missing instances.

So, check for the correct daemon instance id as well as type when
testing if the daemon is up.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/init-ceph.in |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/init-ceph.in b/src/init-ceph.in
index 52891c0..d42a806 100644
--- a/src/init-ceph.in
+++ b/src/init-ceph.in
@@ -69,10 +69,11 @@ signal_daemon() {
 daemon_is_running() {
     name=$1
     daemon=$2
-    pidfile=$3
+    daemon_id=$3
+    pidfile=$4
     do_cmd "[ -e $pidfile ] || exit 1   # no pid, presumably not running
 	pid=\`cat $pidfile\`
-	[ -e /proc/\$pid ] && grep -q $daemon /proc/\$pid/cmdline && exit 0 # running
+	[ -e /proc/\$pid ] && grep -q $daemon /proc/\$pid/cmdline && grep -qwe -i.$daemon_id /proc/\$pid/cmdline && exit 0 # running
         exit 1  # pid is something else" "" "okfail"
 }
 
@@ -195,7 +196,7 @@ for name in $what; do
 
     # start, and already running?  (do this check early to avoid unnecessary work!)
     if [ "$command" = "start" ]; then
-	if daemon_is_running $name c$type $pid_file; then
+	if daemon_is_running $name c$type $id $pid_file; then
 	    echo "Starting Ceph $name on $host...already running"
 	    continue
 	fi
-- 
1.6.6


