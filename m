From: Alexander Graf <agraf@suse.de>
Subject: [PATCH v2] ceph: Fix file open flags on ppc64
Date: Thu, 27 Apr 2017 18:34:00 +0200
Message-ID: <1493310840-201351-1-git-send-email-agraf@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, linux-kernel@vger.kernel.org, Jan.Fajerski@suse.com, Jeff Layton <jlayton@redhat.com>
List-Id: ceph-devel.vger.kernel.org

The file open flags (O_foo) are platform specific and should never go
out to an interface that is not local to the system.

Unfortunately these flags have leaked out onto the wire in the cephfs
implementation. That lead to bogus flags getting transmitted on ppc64.

This patch converts the kernel view of flags to the ceph view of file
open flags.

Fixes: 124e68e74 ("ceph: file operations")
Signed-off-by: Alexander Graf <agraf@suse.de>

---

v1 -> v2:

  - Only convert flags mds knows about
  - Fix le conversion
---
 fs/ceph/file.c               | 35 ++++++++++++++++++++++++++++++++++-
 include/linux/ceph/ceph_fs.h | 12 ++++++++++++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 26cc954..9cac018 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -103,6 +103,39 @@ static size_t dio_get_pagev_size(const struct iov_iter *it)
 	return ERR_PTR(ret);
 }
 
+static __le32 ceph_flags_sys2wire(u32 flags)
+{
+	u32 wire_flags = 0;
+
+	switch (flags & O_ACCMODE) {
+	case O_RDONLY:
+		wire_flags |= CEPH_O_RDONLY;
+		break;
+	case O_WRONLY:
+		wire_flags |= CEPH_O_WRONLY;
+		break;
+	case O_RDWR:
+		wire_flags |= CEPH_O_RDWR;
+		break;
+	}
+	flags &= ~O_ACCMODE;
+
+#define ceph_sys2wire(a) if (flags & a) { wire_flags |= CEPH_##a; flags &= ~a; }
+
+	ceph_sys2wire(O_CREAT);
+	ceph_sys2wire(O_EXCL);
+	ceph_sys2wire(O_TRUNC);
+	ceph_sys2wire(O_DIRECTORY);
+	ceph_sys2wire(O_NOFOLLOW);
+
+#undef ceph_sys2wire
+
+	if (flags)
+		dout("Unused open flags: %x", flags);
+
+	return cpu_to_le32(wire_flags);
+}
+
 /*
  * Prepare an open request.  Preallocate ceph_cap to avoid an
  * inopportune ENOMEM later.
@@ -123,7 +156,7 @@ static size_t dio_get_pagev_size(const struct iov_iter *it)
 	if (IS_ERR(req))
 		goto out;
 	req->r_fmode = ceph_flags_to_mode(flags);
-	req->r_args.open.flags = cpu_to_le32(flags);
+	req->r_args.open.flags = ceph_flags_sys2wire(flags);
 	req->r_args.open.mode = cpu_to_le32(create_mode);
 out:
 	return req;
diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.h
index f4b2ee1..9581c70 100644
--- a/include/linux/ceph/ceph_fs.h
+++ b/include/linux/ceph/ceph_fs.h
@@ -366,6 +366,18 @@ enum {
 #define CEPH_READDIR_FRAG_COMPLETE	(1<<8)
 #define CEPH_READDIR_HASH_ORDER		(1<<9)
 
+/*
+ * open request flags
+ */
+#define CEPH_O_RDONLY		00000000
+#define CEPH_O_WRONLY		00000001
+#define CEPH_O_RDWR		00000002
+#define CEPH_O_CREAT		00000100
+#define CEPH_O_EXCL		00000200
+#define CEPH_O_TRUNC		00001000
+#define CEPH_O_DIRECTORY	00200000
+#define CEPH_O_NOFOLLOW		00400000
+
 union ceph_mds_request_args {
 	struct {
 		__le32 mask;                 /* CEPH_CAP_* */
-- 
1.8.5.6
