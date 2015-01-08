From: Jeff Layton <jlayton@primarydata.com>
Subject: [PATCH v2 07/10] locks: remove i_flock field from struct inode
Date: Thu,  8 Jan 2015 10:34:22 -0800
Message-ID: <1420742065-28423-8-git-send-email-jlayton@primarydata.com>
References: <1420742065-28423-1-git-send-email-jlayton@primarydata.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:34110 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932476AbbAHSe6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Jan 2015 13:34:58 -0500
Received: by mail-qg0-f51.google.com with SMTP id i50so3846944qgf.10
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jan 2015 10:34:58 -0800 (PST)
In-Reply-To: <1420742065-28423-1-git-send-email-jlayton@primarydata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, hch@infradead.org

Nothing uses it anymore. Also add a forward declaration for struct
file_lock to silence some compiler warnings that the removal triggers.

Signed-off-by: Jeff Layton <jlayton@primarydata.com>
---
 include/linux/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 380717828ba1..7da02cb90b30 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -625,7 +625,6 @@ struct inode {
 	atomic_t		i_readcount; /* struct files open RO */
 #endif
 	const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
-	struct file_lock	*i_flock;
 	struct file_lock_context	*i_flctx;
 	struct address_space	i_data;
 	struct list_head	i_devices;
@@ -886,6 +885,8 @@ static inline struct file *get_file(struct file *f)
 /* legacy typedef, should eventually be removed */
 typedef void *fl_owner_t;
 
+struct file_lock;
+
 struct file_lock_operations {
 	void (*fl_copy_lock)(struct file_lock *, struct file_lock *);
 	void (*fl_release_private)(struct file_lock *);
-- 
2.1.0

