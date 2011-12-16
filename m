From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 1/2] man: It is capital -C instead of -c when for creating a new keyring
Date: Fri, 16 Dec 2011 22:00:46 +0100
Message-ID: <1324069246-18961-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from amd.ceph.widodh.nl ([31.25.100.162]:43411 "EHLO
	amd.ceph.widodh.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760550Ab1LPVKW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Dec 2011 16:10:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 man/ceph-authtool.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/man/ceph-authtool.8 b/man/ceph-authtool.8
index c9182ea..d630bef 100644
--- a/man/ceph-authtool.8
+++ b/man/ceph-authtool.8
@@ -144,7 +144,7 @@ To create a new keyring containing a key for client.foo:
 .sp
 .nf
 .ft C
-ceph\-authtool \-c \-n client.foo \-\-gen\-key keyring
+ceph\-authtool \-C \-n client.foo \-\-gen\-key keyring
 .ft P
 .fi
 .sp
-- 
1.7.5.4

