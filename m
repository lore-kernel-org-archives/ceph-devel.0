From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 1/4] cconf: Update usage
Date: Sun, 17 Apr 2011 11:32:01 +0200
Message-ID: <1303032724-13456-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:56616 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751629Ab1DQJcQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Apr 2011 05:32:16 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/cconf.cc |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/cconf.cc b/src/cconf.cc
index 2de7899..d5a911d 100644
--- a/src/cconf.cc
+++ b/src/cconf.cc
@@ -50,12 +50,21 @@ FLAGS\n\
 If there is no action given, the action will default to --lookup.\n\
 \n\
 EXAMPLES\n\
-$ cconf --name client.cconf -c /etc/ceph/ceph.conf -t mon -i 0 'mon addr'\n\
-Find out if there is a 'mon addr' defined in /etc/ceph/ceph.conf\n\
+$ cconf 'auth supported'\n\
+Find out which authorization is used.\n\
+\n\
+$ cconf -n osd.0 'osd data'\n\
+Get the osd data directory for osd.0\n\
 \n\
 $ cconf -l mon\n\
 List sections beginning with 'mon'.\n\
 \n\
+$ cconf -l mon|while read s; do cconf -s $s 'mon addr'; done\n\
+Get all 'mon addr' values out of the configuration.\n\
+\n\
+$ cconf -c foo.conf 'keyring'\n\
+Read the 'keyring' value from a non-default configuration file.\n\
+\n\
 RETURN CODE\n\
 Return code will be 0 on success; error code otherwise.\n\
 ";
-- 
1.7.0.4

