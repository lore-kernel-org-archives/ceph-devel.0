From: xiubli@redhat.com
Subject: [PATCH v6 7/9] ceph: add CEPH_DEFINE_RW_FUNC helper support
Date: Mon, 10 Feb 2020 00:34:05 -0500
Message-ID: <20200210053407.37237-8-xiubli@redhat.com>
References: <20200210053407.37237-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22583 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbgBJFet (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:34:49 -0500
In-Reply-To: <20200210053407.37237-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This will support the string store.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 include/linux/ceph/debugfs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/ceph/debugfs.h b/include/linux/ceph/debugfs.h
index 8b3a1a7a953a..b9100712f87f 100644
--- a/include/linux/ceph/debugfs.h
+++ b/include/linux/ceph/debugfs.h
@@ -4,6 +4,20 @@
=20
 #include <linux/ceph/types.h>
=20
+#define CEPH_DEFINE_RW_FUNC(name)					\
+static int name##_open(struct inode *inode, struct file *file)		\
+{									\
+	return single_open(file, name##_show, inode->i_private);	\
+}									\
+									\
+static const struct file_operations name##_fops =3D {			\
+	.open		=3D name##_open,					\
+	.read		=3D seq_read,					\
+	.write		=3D name##_store,					\
+	.llseek		=3D seq_lseek,					\
+	.release	=3D single_release,				\
+}
+
 /* debugfs.c */
 extern void ceph_debugfs_init(void);
 extern void ceph_debugfs_cleanup(void);
--=20
2.21.0
