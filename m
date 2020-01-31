From: xiubli@redhat.com
Subject: [PATCH] ceph: fix the comment for ceph_start_io_direct
Date: Fri, 31 Jan 2020 02:27:58 -0500
Message-ID: <20200131072758.7294-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58119 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728027AbgAaH2W (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jan 2020 02:28:22 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

This maybe missed to change after copied from somewhere.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/io.c b/fs/ceph/io.c
index 97602ea92ff4..c456509b31c3 100644
--- a/fs/ceph/io.c
+++ b/fs/ceph/io.c
@@ -118,7 +118,7 @@ static void ceph_block_buffered(struct ceph_inode_inf=
o *ci, struct inode *inode)
 }
=20
 /**
- * ceph_end_io_direct - declare the file is being used for direct i/o
+ * ceph_start_io_direct - declare the file is being used for direct i/o
  * @inode: file inode
  *
  * Declare that a direct I/O operation is about to start, and ensure
--=20
2.21.0
