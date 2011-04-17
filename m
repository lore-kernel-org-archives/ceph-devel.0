From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 2/4] config: Update sample configuration to new naming scheme
Date: Sun, 17 Apr 2011 11:32:02 +0200
Message-ID: <1303032724-13456-2-git-send-email-wido@widodh.nl>
References: <1303032724-13456-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:56619 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751641Ab1DQJcW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 05:32:22 -0400
In-Reply-To: <1303032724-13456-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/sample.ceph.conf |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/src/sample.ceph.conf b/src/sample.ceph.conf
index bb874e7..31674f6 100644
--- a/src/sample.ceph.conf
+++ b/src/sample.ceph.conf
@@ -24,6 +24,9 @@
         ; set up pid files
         pid file = /var/run/ceph/$name.pid
 
+        ; Also log to syslog
+        log to syslog = true
+
 ; monitors
 ;  You need at least one.  You need at least three if you want to
 ;  tolerate any node failures.  Always create an odd number.
@@ -37,15 +40,15 @@
 	;debug paxos = 20
 	;debug auth = 20
 
-[mon0]
+[mon.alpha]
 	host = alpha
 	mon addr = 192.168.0.10:6789
 
-[mon1]
+[mon.beta]
 	host = beta
 	mon addr = 192.168.0.11:6789
 
-[mon2]
+[mon.gamma]
 	host = gamma
 	mon addr = 192.168.0.12:6789
 
@@ -70,16 +73,16 @@
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
+	osd journal = /data/$name/journal
 	osd journal size = 1000 ; journal size, in megabytes
 
 	; osd logging to debug osd issues, in order of likelihood of being
@@ -89,7 +92,7 @@
 	;debug filestore = 20
 	;debug journal = 20
 
-[osd0]
+[osd.0]
 	host = delta
 
 	; if 'btrfs devs' is not specified, you're responsible for
@@ -98,14 +101,14 @@
 	; usually fine for basic testing).
 	btrfs devs = /dev/sdx
 
-[osd1]
+[osd.1]
 	host = epsilon
 	btrfs devs = /dev/sdy
 
-[osd2]
+[osd.2]
 	host = zeta
 	btrfs devs = /dev/sdx
 
-[osd3]
+[osd.3]
 	host = eta
 	btrfs devs = /dev/sdy
-- 
1.7.0.4

