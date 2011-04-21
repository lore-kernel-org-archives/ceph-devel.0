From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH] config: Update sample config with more examples
Date: Thu, 21 Apr 2011 22:07:39 +0200
Message-ID: <1303416459-29471-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:41942 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab1DUUHr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 16:07:47 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/sample.ceph.conf |   77 ++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/src/sample.ceph.conf b/src/sample.ceph.conf
index 473114b..67cb5ae 100644
--- a/src/sample.ceph.conf
+++ b/src/sample.ceph.conf
@@ -10,6 +10,22 @@
 ; the current host (e.g., in a setup with a startup.conf on each
 ; node).
 
+; The variables $type, $id and $name are available to use in paths
+; $type = The type of daemon, possible values: mon, mds and osd
+; $id = The ID of the daemon, for mon.alpha, $id will be alpha
+; $name = $type.$id
+
+; For example:
+; osd.0
+;  $type = osd
+;  $id = 0
+;  $name = osd.0
+
+; mon.beta
+;  $type = mon
+;  $id = beta
+;  $name = mon.beta
+
 ; global
 [global]
 	; enable secure authentication
@@ -18,17 +34,42 @@
         ; allow ourselves to open a lot of files
         max open files = 131072
 
-        ; set up logging
-        log file = /var/log/ceph/$name.log
+        ; You can change the default log location if you want to
+        ;log dir = /var/log/ceph	
+        ;log file = $name.log
+
+        ; Logging to syslog is also possible
+        ; If you want to disable logging to files, you should empty log dir and file
+        ;log to syslog = true
+        ;log dir =
+        ;log file = 
+
+        ; This is the default pid file location
+        ;pid file = /var/run/ceph/$name.pid
 
-        ; set up pid files
-        pid file = /var/run/ceph/$name.pid
+        ; If you want to run a IPv6 cluster, set this to true. Dual-stack isn't possible
+        ;ms bind ipv6 = true
 
 ; monitors
 ;  You need at least one.  You need at least three if you want to
 ;  tolerate any node failures.  Always create an odd number.
 [mon]
-	mon data = /data/mon$id
+	mon data = /data/$name
+
+        ; If you are using for example the RADOS Gateway and want to have your newly created
+        ; pools a higher replication level, you can set a default
+        ;osd pool default size = 3
+
+        ; You can also specify a CRUSH rule for new pools
+        ; Wiki: http://ceph.newdream.net/wiki/Custom_data_placement_with_CRUSH
+        ;osd pool default crush rule = 0
+
+        ; Timing is critical for monitors, but if you want to allow the clocks to drift a 
+        ; bit more, you can specify the max drift.
+        ;mon clock drift allowed = 1
+
+        ; Tell the monitor to backoff from this warning for 30 seconds
+        ;mon clock drift warn backoff = 30
 
 	; logging, for debugging monitor crashes, in order of
 	; their likelihood of being helpful :)
@@ -37,15 +78,15 @@
 	;debug paxos = 20
 	;debug auth = 20
 
-[mon.0]
+[mon.alpha]
 	host = alpha
 	mon addr = 192.168.0.10:6789
 
-[mon.1]
+[mon.beta]
 	host = beta
 	mon addr = 192.168.0.11:6789
 
-[mon.2]
+[mon.gamma]
 	host = gamma
 	mon addr = 192.168.0.12:6789
 
@@ -70,17 +111,25 @@
 ;  Define as many as you like.
 [osd]
 	; This is where the btrfs volume will be mounted.
-	osd data = /data/osd$id
+	osd data = /data/$name
 
 	; Ideally, make this a separate disk or partition.  A few
  	; hundred MB should be enough; more if you have fast or many
  	; disks.  You can use a file under the osd data dir if need be
- 	; (e.g. /data/osd$id/journal), but it will be slower than a
+ 	; (e.g. /data/$name/journal), but it will be slower than a
  	; separate disk or partition.
 
         ; This is an example of a file-based journal.
-	osd journal = /data/osd$id/journal
-	osd journal size = 1000 ; journal size, in megabytes
+	osd journal = /data/$name/journal
+        ; Journal size, in megabytes
+	osd journal size = 1000
+
+        ; If you want to run the journal on a tmpfs, disable DirectIO
+        ;journal dio = false
+
+        ; You can change the number of recovery operations to speed up recovery
+        ; or slow it down if your machines can't handle it
+        ;osd recovery max active = 3
 
 	; osd logging to debug osd issues, in order of likelihood of being
 	; helpful
@@ -98,6 +147,10 @@
 	; usually fine for basic testing).
 	btrfs devs = /dev/sdx
 
+        ; If you want to specify some other mount options, you can do so.
+        ; The default values are rw,noatime
+        ;btrfs options = rw,noatime
+
 [osd.1]
 	host = epsilon
 	btrfs devs = /dev/sdy
-- 
1.7.0.4

