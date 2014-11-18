From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 196/206] rbd: Fix error recovery in rbd_obj_read_sync()
Date: Tue, 18 Nov 2014 15:09:11 +0100
Message-ID: <7beac9d17eed590fbb8e1217464882c2a2c58b3f.1416319692.git.jslaby@suse.cz>
References: <28f04bcc068a44c5641c727883947960fb8dcbd5.1416319692.git.jslaby@suse.cz>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <28f04bcc068a44c5641c727883947960fb8dcbd5.1416319692.git.jslaby@suse.cz>
In-Reply-To: <cover.1416319692.git.jslaby@suse.cz>
References: <cover.1416319692.git.jslaby@suse.cz>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, Ilya Dryomov <idryomov@redhat.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: ceph-devel.vger.kernel.org

From: Jan Kara <jack@suse.cz>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit a8d4205623ae965e36c68629db306ca0695a2771 upstream.

When we fail to allocate page vector in rbd_obj_read_sync() we just
basically ignore the problem and continue which will result in an oops
later. Fix the problem by returning proper error.

CC: Yehuda Sadeh <yehuda@inktank.com>
CC: Sage Weil <sage@inktank.com>
CC: ceph-devel@vger.kernel.org
Coverity-id: 1226882
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index aeeb62e0981a..a86841886acc 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -3220,7 +3220,7 @@ static int rbd_obj_read_sync(struct rbd_device *rbd_dev,
 	page_count = (u32) calc_pages_for(offset, length);
 	pages = ceph_alloc_page_vector(page_count, GFP_KERNEL);
 	if (IS_ERR(pages))
-		ret = PTR_ERR(pages);
+		return PTR_ERR(pages);
 
 	ret = -ENOMEM;
 	obj_request = rbd_obj_request_create(object_name, offset, length,
-- 
2.1.3
