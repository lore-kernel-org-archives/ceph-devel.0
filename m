From: Marc Koderer <marc@koderer.com>
Subject: [PATCH] net/ceph replace ceph_kvmalloc with kvmalloc
Date: Mon, 12 Aug 2019 11:42:42 +0200
Message-ID: <20190812094242.44735-1-marc@koderer.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: idryomov@gmail.com, jlayton@kernel.org, sage@redhat.com, davem@davemloft.net
Cc: ceph-devel@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Koderer <marc@koderer.com>
List-Id: ceph-devel.vger.kernel.org

There is nearly no difference between both implemenations.
ceph_kvmalloc existed before kvmalloc which makes me think it's
a leftover.

Signed-off-by: Marc Koderer <marc@koderer.com>
---
 net/ceph/buffer.c      |  3 +--
 net/ceph/ceph_common.c | 11 -----------
 net/ceph/crypto.c      |  2 +-
 net/ceph/messenger.c   |  2 +-
 4 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/net/ceph/buffer.c b/net/ceph/buffer.c
index 5622763ad402..6ca273d2246a 100644
--- a/net/ceph/buffer.c
+++ b/net/ceph/buffer.c
@@ -7,7 +7,6 @@
 
 #include <linux/ceph/buffer.h>
 #include <linux/ceph/decode.h>
-#include <linux/ceph/libceph.h> /* for ceph_kvmalloc */
 
 struct ceph_buffer *ceph_buffer_new(size_t len, gfp_t gfp)
 {
@@ -17,7 +16,7 @@ struct ceph_buffer *ceph_buffer_new(size_t len, gfp_t gfp)
 	if (!b)
 		return NULL;
 
-	b->vec.iov_base = ceph_kvmalloc(len, gfp);
+	b->vec.iov_base = kvmalloc(len, gfp);
 	if (!b->vec.iov_base) {
 		kfree(b);
 		return NULL;
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 4eeea4d5c3ef..6c1769a815af 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -185,17 +185,6 @@ int ceph_compare_options(struct ceph_options *new_opt,
 }
 EXPORT_SYMBOL(ceph_compare_options);
 
-void *ceph_kvmalloc(size_t size, gfp_t flags)
-{
-	if (size <= (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER)) {
-		void *ptr = kmalloc(size, flags | __GFP_NOWARN);
-		if (ptr)
-			return ptr;
-	}
-
-	return __vmalloc(size, flags, PAGE_KERNEL);
-}
-
 
 static int parse_fsid(const char *str, struct ceph_fsid *fsid)
 {
diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 5d6724cee38f..a9deead1e4ff 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -144,7 +144,7 @@ void ceph_crypto_key_destroy(struct ceph_crypto_key *key)
 static const u8 *aes_iv = (u8 *)CEPH_AES_IV;
 
 /*
- * Should be used for buffers allocated with ceph_kvmalloc().
+ * Should be used for buffers allocated with kvmalloc().
  * Currently these are encrypt out-buffer (ceph_buffer) and decrypt
  * in-buffer (msg front).
  *
diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 962f521c863e..f1f2fcc6f780 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3334,7 +3334,7 @@ struct ceph_msg *ceph_msg_new2(int type, int front_len, int max_data_items,
 
 	/* front */
 	if (front_len) {
-		m->front.iov_base = ceph_kvmalloc(front_len, flags);
+		m->front.iov_base = kvmalloc(front_len, flags);
 		if (m->front.iov_base == NULL) {
 			dout("ceph_msg_new can't allocate %d bytes\n",
 			     front_len);
-- 
2.22.0
