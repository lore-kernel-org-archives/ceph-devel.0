From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] rbd: work around -Wuninitialized warning
Date: Tue,  7 Jan 2020 22:01:04 +0100
Message-ID: <20200107210256.2426176-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Dongsheng Yang <dongsheng.yang@easystack.cn>, Jason Dillaman <dillaman@redhat.com>, David Howells <dhowells@redhat.com>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

gcc -O3 warns about a dummy variable that is passed
down into rbd_img_fill_nodata without being initialized:

drivers/block/rbd.c: In function 'rbd_img_fill_nodata':
drivers/block/rbd.c:2573:13: error: 'dummy' is used uninitialized in this function [-Werror=uninitialized]
  fctx->iter = *fctx->pos;

Since this is a dummy, I assume the warning is harmless, but
it's better to initialize it anyway and avoid the warning.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 29be02838b67..070edc5983df 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2664,7 +2664,7 @@ static int rbd_img_fill_nodata(struct rbd_img_request *img_req,
 			       u64 off, u64 len)
 {
 	struct ceph_file_extent ex = { off, len };
-	union rbd_img_fill_iter dummy;
+	union rbd_img_fill_iter dummy = {};
 	struct rbd_img_fill_ctx fctx = {
 		.pos_type = OBJ_REQUEST_NODATA,
 		.pos = &dummy,
-- 
2.20.0
