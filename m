From: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
Subject: [PATCH 1/2] fs/ceph: remove unused functions in ceph_frag.h
Date: Tue, 17 Nov 2015 14:52:18 +0800
Message-ID: <1447743139-8190-1-git-send-email-baiyaowei@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

These functions were introduced in commit 3d14c5d2b ("ceph: factor
out libceph from Ceph file system"). Howover, there's no user of
these functions since then, so remove them for simplicity.

Signed-off-by: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
---
 include/linux/ceph/ceph_frag.h | 35 -----------------------------------
 1 file changed, 35 deletions(-)

diff --git a/include/linux/ceph/ceph_frag.h b/include/linux/ceph/ceph_frag.h
index 5babb8e..970ba5c 100644
--- a/include/linux/ceph/ceph_frag.h
+++ b/include/linux/ceph/ceph_frag.h
@@ -44,42 +44,7 @@ static inline int ceph_frag_contains_value(__u32 f, __u32 v)
 {
 	return (v & ceph_frag_mask(f)) == ceph_frag_value(f);
 }
-static inline int ceph_frag_contains_frag(__u32 f, __u32 sub)
-{
-	/* is sub as specific as us, and contained by us? */
-	return ceph_frag_bits(sub) >= ceph_frag_bits(f) &&
-	       (ceph_frag_value(sub) & ceph_frag_mask(f)) == ceph_frag_value(f);
-}
 
-static inline __u32 ceph_frag_parent(__u32 f)
-{
-	return ceph_frag_make(ceph_frag_bits(f) - 1,
-			 ceph_frag_value(f) & (ceph_frag_mask(f) << 1));
-}
-static inline int ceph_frag_is_left_child(__u32 f)
-{
-	return ceph_frag_bits(f) > 0 &&
-		(ceph_frag_value(f) & (0x1000000 >> ceph_frag_bits(f))) == 0;
-}
-static inline int ceph_frag_is_right_child(__u32 f)
-{
-	return ceph_frag_bits(f) > 0 &&
-		(ceph_frag_value(f) & (0x1000000 >> ceph_frag_bits(f))) == 1;
-}
-static inline __u32 ceph_frag_sibling(__u32 f)
-{
-	return ceph_frag_make(ceph_frag_bits(f),
-		      ceph_frag_value(f) ^ (0x1000000 >> ceph_frag_bits(f)));
-}
-static inline __u32 ceph_frag_left_child(__u32 f)
-{
-	return ceph_frag_make(ceph_frag_bits(f)+1, ceph_frag_value(f));
-}
-static inline __u32 ceph_frag_right_child(__u32 f)
-{
-	return ceph_frag_make(ceph_frag_bits(f)+1,
-	      ceph_frag_value(f) | (0x1000000 >> (1+ceph_frag_bits(f))));
-}
 static inline __u32 ceph_frag_make_child(__u32 f, int by, int i)
 {
 	int newbits = ceph_frag_bits(f) + by;
-- 
1.9.1
