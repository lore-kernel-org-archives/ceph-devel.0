From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/5] ceph: remove a few bogus declarations
Date: Fri, 08 Feb 2013 10:32:19 -0600
Message-ID: <51152893.4090108@inktank.com>
References: <51152847.2030305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:48889 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759956Ab3BHQcY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Feb 2013 11:32:24 -0500
Received: by mail-ie0-f172.google.com with SMTP id c10so5198096ieb.17
        for <ceph-devel@vger.kernel.org>; Fri, 08 Feb 2013 08:32:24 -0800 (PST)
In-Reply-To: <51152847.2030305@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There are three ceph page vector functions declared in
"fs/ceph/super.h" that don't belong there.  They're
probably left over from some long-ago code reorganization.

They're properly declared in "include/linux/ceph/libceph.h"
so just delete the ones in "super.h".

Signed-off-by: Alex Elder <elder@inktank.com>
---
 fs/ceph/super.h |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 66ebe72..9861cce 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -798,13 +798,7 @@ extern int ceph_mmap(struct file *file, struct
vm_area_struct *vma);
 /* file.c */
 extern const struct file_operations ceph_file_fops;
 extern const struct address_space_operations ceph_aops;
-extern int ceph_copy_to_page_vector(struct page **pages,
-				    const char *data,
-				    loff_t off, size_t len);
-extern int ceph_copy_from_page_vector(struct page **pages,
-				    char *data,
-				    loff_t off, size_t len);
-extern struct page **ceph_alloc_page_vector(int num_pages, gfp_t flags);
+
 extern int ceph_open(struct inode *inode, struct file *file);
 extern int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 			    struct file *file, unsigned flags, umode_t mode,
-- 
1.7.9.5

