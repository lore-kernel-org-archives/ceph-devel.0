From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v3 20/24] block: Replace CURRENT_TIME with ktime_get_real_ts
Date: Sat, 25 Jun 2016 14:37:44 -0700
Message-ID: <1466890668-23400-21-git-send-email-deepa.kernel@gmail.com>
References: <1466890668-23400-1-git-send-email-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466890668-23400-1-git-send-email-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, tglx@linutronix.de, torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, y2038@lists.linaro.org, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

CURRENT_TIME is not y2038 safe.
The macro will be deleted and all the references to it
will be replaced by ktime_get_* apis.

struct timespec is also not y2038 safe.
Retain timespec for timestamp representation here as ceph
uses it internally everywhere.
These references will be changed to use struct timespec64
in a separate patch.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Alex Elder <elder@kernel.org>
Cc: ceph-devel@vger.kernel.org
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4506620..14867ab 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -1888,7 +1888,7 @@ static void rbd_osd_req_format_write(struct rbd_obj_request *obj_request)
 {
 	struct ceph_osd_request *osd_req = obj_request->osd_req;
 
-	osd_req->r_mtime = CURRENT_TIME;
+	ktime_get_real_ts(&osd_req->r_mtime);
 	osd_req->r_data_offset = obj_request->offset;
 }
 
-- 
1.9.1
