From: Florian Haas <florian@hastexo.com>
Subject: [PATCH] doc: fix snapshot creation/deletion syntax in rbd man page (trivial)
Date: Fri, 17 Feb 2012 20:42:43 +0100
Message-ID: <1329507763-20755-1-git-send-email-florian@hastexo.com>
Mime-Version: 1.0
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47844 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493Ab2BQTmw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Feb 2012 14:42:52 -0500
Received: by eekc14 with SMTP id c14so1478028eek.19
        for <ceph-devel@vger.kernel.org>; Fri, 17 Feb 2012 11:42:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Florian Haas <florian@hastexo.com>

Creating a snapshot requires using "rbd snap create",
as opposed to just "rbd create". Also for purposes of
clarification, add note that removing a snapshot similarly
requires "rbd snap rm".

Thanks to Josh Durgin for the explanation on IRC.
---
 man/rbd.8 |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/man/rbd.8 b/man/rbd.8
index 0278137..b59c2f6 100644
--- a/man/rbd.8
+++ b/man/rbd.8
@@ -194,7 +194,15 @@ To create a new snapshot:
 .sp
 .nf
 .ft C
-rbd create mypool/myimage@mysnap
+rbd snap create mypool/myimage@mysnap
+.ft P
+.fi
+.sp
+To delete a snapshot:
+.sp
+.nf
+.ft C
+rbd snap rm mypool/myimage@mysnap
 .ft P
 .fi
 .sp
-- 
1.7.5.4

