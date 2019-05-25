From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] ceph: fix  warning PTR_ERR_OR_ZERO can be used
Date: Sat, 25 May 2019 14:45:59 +0530
Message-ID: <20190525091559.GA14633@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

change1: fix below warning  reported by coccicheck

/fs/ceph/export.c:371:33-39: WARNING: PTR_ERR_OR_ZERO can be used

change2: typecasted PTR_ERR_OR_ZERO to long as dout expecting long

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 fs/ceph/export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index d3ef7ee42..15ff1b0 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -368,7 +368,7 @@ static struct dentry *ceph_get_parent(struct dentry *child)
 	}
 out:
 	dout("get_parent %p ino %llx.%llx err=%ld\n",
-	     child, ceph_vinop(inode), (IS_ERR(dn) ? PTR_ERR(dn) : 0));
+	     child, ceph_vinop(inode), (long)PTR_ERR_OR_ZERO(dn));
 	return dn;
 }
 
-- 
2.7.4
