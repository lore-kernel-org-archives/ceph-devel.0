From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] rbd: avoid clang -Wuninitialized warning
Date: Fri, 22 Mar 2019 15:36:37 +0100
Message-ID: <20190322143643.1317312-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jason Dillaman <dillaman@redhat.com>, ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

clang fails to see that rbd_assert(0) ends in an unreachable code
path and warns about a subsequent use of an uninitialized variable
when CONFIG_PROFILE_ANNOTATED_BRANCHES is set:

drivers/block/rbd.c:2402:4: error: variable 'ret' is used uninitialized whenever 'if' condition is false
      [-Werror,-Wsometimes-uninitialized]
                        rbd_assert(0);
                        ^~~~~~~~~~~~~
drivers/block/rbd.c:563:7: note: expanded from macro 'rbd_assert'
                if (unlikely(!(expr))) {                                \
                    ^~~~~~~~~~~~~~~~~
include/linux/compiler.h:48:23: note: expanded from macro 'unlikely'
 #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/block/rbd.c:2410:6: note: uninitialized use occurs here
        if (ret) {
            ^~~
drivers/block/rbd.c:2402:4: note: remove the 'if' if its condition is always true
                        rbd_assert(0);
                        ^
drivers/block/rbd.c:563:3: note: expanded from macro 'rbd_assert'
                if (unlikely(!(expr))) {                                \
                ^
drivers/block/rbd.c:2376:9: note: initialize the variable 'ret' to silence this warning
        int ret;
               ^
                = 0
1 error generated.

This seems to be a bug in clang, but is easy to work around by using
an unconditional BUG().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 4ba967d65cf9..cbcc3baf3807 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2399,7 +2399,7 @@ static int rbd_obj_read_from_parent(struct rbd_obj_request *obj_req)
 						      &obj_req->bvec_pos);
 			break;
 		default:
-			rbd_assert(0);
+			BUG();
 		}
 	} else {
 		ret = rbd_img_fill_from_bvecs(child_img_req,
-- 
2.20.0
