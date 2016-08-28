From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH 1/1] ceph: do not modify fi->frag in need_reset_readdir()
Date: Sun, 28 Aug 2016 18:47:12 +0200
Message-ID: <20160828164712.24840-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Nicolas Iooss <nicolas.iooss_linux@m4x.org>
List-Id: ceph-devel.vger.kernel.org

Commit f3c4ebe65ea1 ("ceph: using hash value to compose dentry offset")
modified "if (fpos_frag(new_pos) != fi->frag)" to "if (fi->frag |=
fpos_frag(new_pos))" in need_reset_readdir(), thus replacing a
comparison operator with an assignment one.

This looks like a typo which is reported by clang when building the
kernel with some warning flags:

    fs/ceph/dir.c:600:22: error: using the result of an assignment as a
    condition without parentheses [-Werror,-Wparentheses]
            } else if (fi->frag |= fpos_frag(new_pos)) {
                       ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~
    fs/ceph/dir.c:600:22: note: place parentheses around the assignment
    to silence this warning
            } else if (fi->frag |= fpos_frag(new_pos)) {
                                ^
                       (                             )
    fs/ceph/dir.c:600:22: note: use '!=' to turn this compound
    assignment into an inequality comparison
            } else if (fi->frag |= fpos_frag(new_pos)) {
                                ^~
                                !=

Fixes: f3c4ebe65ea1 ("ceph: using hash value to compose dentry offset")
Cc: stable@vger.kernel.org # 4.7.x
Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 fs/ceph/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index c64a0b794d49..df4b3e6fa563 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -597,7 +597,7 @@ static bool need_reset_readdir(struct ceph_file_info *fi, loff_t new_pos)
 	if (is_hash_order(new_pos)) {
 		/* no need to reset last_name for a forward seek when
 		 * dentries are sotred in hash order */
-	} else if (fi->frag |= fpos_frag(new_pos)) {
+	} else if (fi->frag != fpos_frag(new_pos)) {
 		return true;
 	}
 	rinfo = fi->last_readdir ? &fi->last_readdir->r_reply_info : NULL;
-- 
2.9.3
