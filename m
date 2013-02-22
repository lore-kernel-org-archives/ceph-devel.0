From: Alex Elder <elder@inktank.com>
Subject: [PATCH, v2] ceph: eliminate sparse warnings in fs code
Date: Fri, 22 Feb 2013 11:21:24 -0600
Message-ID: <5127A914.2030002@inktank.com>
References: <5127A85D.1070000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:51578 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758022Ab3BVRV2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 12:21:28 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so968109iea.40
        for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 09:21:27 -0800 (PST)
In-Reply-To: <5127A85D.1070000@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org >> ceph-devel" <ceph-devel@vger.kernel.org>

Fix the causes for sparse warnings reported in the ceph file system
code.  Here there are only two (and they're sort of silly but
they're easy to fix).

This partially resolves:
    http://tracker.ceph.com/issues/4184

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Alex Elder <elder@inktank.com>
---
v2: rebased

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

