From: Li Wang <liwang@ubuntukylin.com>
Subject: [PATCH] Fix some little/big endian issues
Date: Wed, 15 May 2013 22:56:04 +0800
Message-ID: <1368629764-10838-1-git-send-email-liwang@ubuntukylin.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m53-178.qiye.163.com ([123.58.178.53]:52623 "EHLO
	m53-178.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197Ab3EOO5a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 May 2013 10:57:30 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, Yehuda Sadeh <yehuda@inktank.com>, Li Wang <liwang@ubuntukylin.com>, Yunchuan Wen <yunchuanwen@ubuntukylin.com>

Ceph uses little endian, this patch fixes some endian issues
while Ceph running on big endian machine.

Signed-off-by: Yunchuan Wen <yunchuanwen@ubuntukylin.com>
Signed-off-by: Li Wang <liwang@ubuntukylin.com>
---
 src/include/encoding.h |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/include/encoding.h b/src/include/encoding.h
index eb445e3..67c9af5 100644
--- a/src/include/encoding.h
+++ b/src/include/encoding.h
@@ -88,11 +88,12 @@ inline void decode(bool &v, bufferlist::iterator& p) {
 
 #define WRITE_INTTYPE_ENCODER(type, etype)				\
   inline void encode(type v, bufferlist& bl, uint64_t features=0) {	\
-    __##etype e = init_##etype(v);					\
+    ceph_##etype e;					                \
+    e = v;                                                              \
     encode_raw(e, bl);							\
   }									\
   inline void decode(type &v, bufferlist::iterator& p) {		\
-    __##etype e;							\
+    ceph_##etype e;							\
     decode_raw(e, p);							\
     v = e;								\
   }
@@ -338,7 +339,7 @@ inline void encode(const std::list<T>& ls, bufferlist& bl)
       n++;
       encode(*p, bl);
     }
-    __le32 en;
+    ceph_le32 en;
     en = n;
     bl.copy_in(pos, sizeof(en), (char*)&en);
   } else {
@@ -373,7 +374,7 @@ inline void encode(const std::list<std::tr1::shared_ptr<T> >& ls, bufferlist& bl
       n++;
       encode(**p, bl);
     }
-    __le32 en;
+    ceph_le32 en;
     en = n;
     bl.copy_in(pos, sizeof(en), (char*)&en);
   } else {
@@ -696,7 +697,8 @@ inline void decode(std::deque<T>& ls, bufferlist::iterator& p)
   __u8 struct_v = v, struct_compat = compat;		     \
   ::encode(struct_v, bl);				     \
   ::encode(struct_compat, bl);				     \
-  __le32 struct_len = 0;				     \
+  ceph_le32 struct_len;				             \
+  struct_len = 0;                                            \
   ::encode(struct_len, bl);				     \
   buffer::list::iterator struct_len_it = bl.end();	     \
   struct_len_it.advance(-4);				     \
-- 
1.7.9.5


