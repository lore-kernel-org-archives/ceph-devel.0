From: y@vger.kernel.org
Subject: [PATCH 2/2] add comments
Date: Wed, 28 Jul 2010 14:10:36 +0200
Message-ID: <10594.1151189201$1280319559@news.gmane.org>
References: <1280319036-17877-1-git-send-email-y>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.muellerit.ch ([92.51.129.153]:45866 "EHLO
	mail.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754846Ab0G1MTQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jul 2010 08:19:16 -0400
In-Reply-To: <1280319036-17877-1-git-send-email-y>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Thomas Mueller <thomas@chaschperli.ch>

From: Thomas Mueller <thomas@chaschperli.ch>

make the helper script executable and add some comment.

---
 dkms/add-to-dkms-and-build |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 dkms/add-to-dkms-and-build

diff --git a/dkms/add-to-dkms-and-build b/dkms/add-to-dkms-and-build
old mode 100644
new mode 100755
index ffea573..7a68923
--- a/dkms/add-to-dkms-and-build
+++ b/dkms/add-to-dkms-and-build
@@ -1,4 +1,7 @@
 #!/bin/sh
+# 
+# * copies files to /usr/src/ceph-$CEPH_VERSION (dkms fixed location "-c" switch did not work for me)
+# * adds the module to dkms and builds it
 
 if ! [ -f ./upstream_version.h ]
 then
-- 
1.7.1

