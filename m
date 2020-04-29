From: Wu Bo <wubo40@huawei.com>
Subject: [PATCH] fs/ceph:fix speical error code in ceph_try_get_caps()
Date: Wed, 29 Apr 2020 10:01:55 +0800
Message-ID: <1588125715-188363-1-git-send-email-wubo40@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jlayton@kernel.org, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com, linfeilong@huawei.com, wubo40@huawei.com
List-Id: ceph-devel.vger.kernel.org

There are 3 speical error codes: -EAGAIN/-EFBIG/-ESTALE.
After call try_get_cap_refs function, judge the same 
error code -EAGAIN twice. So corrected the error code of judgment 
from -EAGAIN to -ESTAE.

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 185db76..1a8e20e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2749,7 +2749,7 @@ int ceph_try_get_caps(struct inode *inode, int need, int want,
 
 	ret = try_get_cap_refs(inode, need, want, 0, flags, got);
 	/* three special error codes */
-	if (ret == -EAGAIN || ret == -EFBIG || ret == -EAGAIN)
+	if (ret == -EAGAIN || ret == -EFBIG || ret == -ESTALE)
 		ret = 0;
 	return ret;
 }
-- 
1.8.3.1
