From: Alex Elder <elder@inktank.com>
Subject: [PATCH] ceph: eliminate sparse warnings in fs code
Date: Tue, 19 Feb 2013 18:45:34 -0600
Message-ID: <51241CAE.3020201@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:35682 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932691Ab3BTAph (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 19:45:37 -0500
Received: by mail-ia0-f182.google.com with SMTP id k38so56219iah.41
        for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 16:45:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Fix the causes for sparse warnings reported in the ceph file system
code.  Here there are only two (and they're sort of silly but
they're easy to fix).

This partially resolves:
    http://tracker.ceph.com/issues/4184

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/xattr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 2135817..9b6b2b6 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -213,7 +213,7 @@ static struct ceph_vxattr ceph_dir_vxattrs[] = {
 	XATTR_NAME_CEPH(dir, rsubdirs),
 	XATTR_NAME_CEPH(dir, rbytes),
 	XATTR_NAME_CEPH(dir, rctime),
-	{ 0 }	/* Required table terminator */
+	{ .name = NULL, 0 }	/* Required table terminator */
 };
 static size_t ceph_dir_vxattrs_name_size;	/* total size of all names */

@@ -232,7 +232,7 @@ static struct ceph_vxattr ceph_file_vxattrs[] = {
 	XATTR_LAYOUT_FIELD(file, layout, stripe_count),
 	XATTR_LAYOUT_FIELD(file, layout, object_size),
 	XATTR_LAYOUT_FIELD(file, layout, pool),
-	{ 0 }	/* Required table terminator */
+	{ .name = NULL, 0 }	/* Required table terminator */
 };
 static size_t ceph_file_vxattrs_name_size;	/* total size of all names */

-- 
1.7.9.5

