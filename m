From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] ceph: return error code directly.
Date: Wed,  8 Oct 2014 22:27:27 +0200
Message-ID: <1412800047-19818-1-git-send-email-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Testing err before returning value is not needed.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/ceph/ioctl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index a822a6e..b2d777a 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -54,10 +54,7 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
 			break;
 		}
 	mutex_unlock(&mdsc->mutex);
-	if (err)
-		return err;
-
-	return 0;
+	return err;
 }
 
 static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
-- 
1.9.1
