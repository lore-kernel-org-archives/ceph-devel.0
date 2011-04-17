From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 3/4] cconf: Update manpage with correct examples
Date: Sun, 17 Apr 2011 11:32:03 +0200
Message-ID: <1303032724-13456-3-git-send-email-wido@widodh.nl>
References: <1303032724-13456-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:56621 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab1DQJcX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 05:32:23 -0400
In-Reply-To: <1303032724-13456-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 man/cconf.8 |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/man/cconf.8 b/man/cconf.8
index a6c7b02..0f678d2 100644
--- a/man/cconf.8
+++ b/man/cconf.8
@@ -25,14 +25,14 @@ of type \fItype\fR.
 \fIconffile\fP, an optional \fIdefault\fP value may be output instead.
 .PP
 .SH EXAMPLES
-To extract the value of the "osd data" option for the \fIosd0\fP daemon,
+To extract the value of the "osd data" option for the \fIosd.0\fP daemon,
 .IP
-cconf -c foo.conf "osd data" -i 0 -t osd
+cconf -c foo.conf -n osd.0 "osd data"
 .PP
-This is equivalent to doing specifying sections \fI[osd0]\fP, \fI[osd.0]\fP,
+This is equivalent to doing specifying sections \fI[osd.0]\fP,
 \fI[osd]\fP, or \fI[global]\fP, in that order of preference:
 .IP
-cconf -c foo.conf "osd data" -s osd0 -s osd.0 -s osd -s global
+cconf -c foo.conf -n osd.0 "osd data" -s osd.0 -s osd -s global
 .PP
 To list all sections that begin with \fIosd\fP:
 .IP
-- 
1.7.0.4

