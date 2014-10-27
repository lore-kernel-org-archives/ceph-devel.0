From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: do not crash on large auth tickets
Date: Mon, 27 Oct 2014 19:05:29 +0300
Message-ID: <1414425929-10625-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34584 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753336AbaJ0QFk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 12:05:40 -0400
Received: by mail-la0-f41.google.com with SMTP id pn19so6188787lab.28
        for <ceph-devel@vger.kernel.org>; Mon, 27 Oct 2014 09:05:39 -0700 (PDT)
Received: from localhost ([109.110.67.111])
        by mx.google.com with ESMTPSA id eg2sm5112235lbb.29.2014.10.27.09.05.37
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Oct 2014 09:05:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Large (greater than 32k, the value of PAGE_ALLOC_COSTLY_ORDER) auth
tickets will have their buffers vmalloc'ed, which leads to the
following crash in crypto:

[   28.685082] BUG: unable to handle kernel paging request at ffffeb04000032c0
[   28.686032] IP: [<ffffffff81392b42>] scatterwalk_pagedone+0x22/0x80
[   28.686032] PGD 0
[   28.688088] Oops: 0000 [#1] PREEMPT SMP
[   28.688088] Modules linked in:
[   28.688088] CPU: 0 PID: 878 Comm: kworker/0:2 Not tainted 3.17.0-vm+ #305
[   28.688088] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[   28.688088] Workqueue: ceph-msgr con_work
[   28.688088] task: ffff88011a7f9030 ti: ffff8800d903c000 task.ti: ffff8800d903c000
[   28.688088] RIP: 0010:[<ffffffff81392b42>]  [<ffffffff81392b42>] scatterwalk_pagedone+0x22/0x80
[   28.688088] RSP: 0018:ffff8800d903f688  EFLAGS: 00010286
[   28.688088] RAX: ffffeb04000032c0 RBX: ffff8800d903f718 RCX: ffffeb04000032c0
[   28.688088] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8800d903f750
[   28.688088] RBP: ffff8800d903f688 R08: 00000000000007de R09: ffff8800d903f880
[   28.688088] R10: 18df467c72d6257b R11: 0000000000000000 R12: 0000000000000010
[   28.688088] R13: ffff8800d903f750 R14: ffff8800d903f8a0 R15: 0000000000000000
[   28.688088] FS:  00007f50a41c7700(0000) GS:ffff88011fc00000(0000) knlGS:0000000000000000
[   28.688088] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[   28.688088] CR2: ffffeb04000032c0 CR3: 00000000da3f3000 CR4: 00000000000006b0
[   28.688088] Stack:
[   28.688088]  ffff8800d903f698 ffffffff81392ca8 ffff8800d903f6e8 ffffffff81395d32
[   28.688088]  ffff8800dac96000 ffff880000000000 ffff8800d903f980 ffff880119b7e020
[   28.688088]  ffff880119b7e010 0000000000000000 0000000000000010 0000000000000010
[   28.688088] Call Trace:
[   28.688088]  [<ffffffff81392ca8>] scatterwalk_done+0x38/0x40
[   28.688088]  [<ffffffff81392ca8>] scatterwalk_done+0x38/0x40
[   28.688088]  [<ffffffff81395d32>] blkcipher_walk_done+0x182/0x220
[   28.688088]  [<ffffffff813990bf>] crypto_cbc_encrypt+0x15f/0x180
[   28.688088]  [<ffffffff81399780>] ? crypto_aes_set_key+0x30/0x30
[   28.688088]  [<ffffffff8156c40c>] ceph_aes_encrypt2+0x29c/0x2e0
[   28.688088]  [<ffffffff8156d2a3>] ceph_encrypt2+0x93/0xb0
[   28.688088]  [<ffffffff8156d7da>] ceph_x_encrypt+0x4a/0x60
[   28.688088]  [<ffffffff8155b39d>] ? ceph_buffer_new+0x5d/0xf0
[   28.688088]  [<ffffffff8156e837>] ceph_x_build_authorizer.isra.6+0x297/0x360
[   28.688088]  [<ffffffff8112089b>] ? kmem_cache_alloc_trace+0x11b/0x1c0
[   28.688088]  [<ffffffff8156b496>] ? ceph_auth_create_authorizer+0x36/0x80
[   28.688088]  [<ffffffff8156ed83>] ceph_x_create_authorizer+0x63/0xd0
[   28.688088]  [<ffffffff8156b4b4>] ceph_auth_create_authorizer+0x54/0x80
[   28.688088]  [<ffffffff8155f7c0>] get_authorizer+0x80/0xd0
[   28.688088]  [<ffffffff81555a8b>] prepare_write_connect+0x18b/0x2b0
[   28.688088]  [<ffffffff81559289>] try_read+0x1e59/0x1f10

This is because we set up crypto scatterlists as if all buffers were
kmalloc'ed.  Fix it.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
---
 net/ceph/crypto.c |   33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/net/ceph/crypto.c b/net/ceph/crypto.c
index 62fc5e7a9acf..37a9b5eea3c3 100644
--- a/net/ceph/crypto.c
+++ b/net/ceph/crypto.c
@@ -90,6 +90,27 @@ static struct crypto_blkcipher *ceph_crypto_alloc_cipher(void)
 
 static const u8 *aes_iv = (u8 *)CEPH_AES_IV;
 
+/*
+ * Should be used for buffers allocated with ceph_kvmalloc().
+ * Currently these are encrypt out-buffer (ceph_buffer) and decrypt
+ * in-buffer (msg front).  @buf has to fit in a single page.
+ */
+static void set_kvmalloc_buf(struct scatterlist *sg, const void *buf,
+			     size_t len)
+{
+	const void *sg_buf;
+	unsigned long off = offset_in_page(buf);
+
+	BUG_ON(off + len > PAGE_SIZE);
+
+	if (is_vmalloc_addr(buf))
+		sg_buf = page_address(vmalloc_to_page(buf)) + off;
+	else
+		sg_buf = buf;
+
+	sg_init_one(sg, sg_buf, len);
+}
+
 static int ceph_aes_encrypt(const void *key, int key_len,
 			    void *dst, size_t *dst_len,
 			    const void *src, size_t src_len)
@@ -114,8 +135,7 @@ static int ceph_aes_encrypt(const void *key, int key_len,
 	sg_init_table(sg_in, 2);
 	sg_set_buf(&sg_in[0], src, src_len);
 	sg_set_buf(&sg_in[1], pad, zero_padding);
-	sg_init_table(sg_out, 1);
-	sg_set_buf(sg_out, dst, *dst_len);
+	set_kvmalloc_buf(sg_out, dst, *dst_len);
 	iv = crypto_blkcipher_crt(tfm)->iv;
 	ivsize = crypto_blkcipher_ivsize(tfm);
 
@@ -166,8 +186,7 @@ static int ceph_aes_encrypt2(const void *key, int key_len, void *dst,
 	sg_set_buf(&sg_in[0], src1, src1_len);
 	sg_set_buf(&sg_in[1], src2, src2_len);
 	sg_set_buf(&sg_in[2], pad, zero_padding);
-	sg_init_table(sg_out, 1);
-	sg_set_buf(sg_out, dst, *dst_len);
+	set_kvmalloc_buf(sg_out, dst, *dst_len);
 	iv = crypto_blkcipher_crt(tfm)->iv;
 	ivsize = crypto_blkcipher_ivsize(tfm);
 
@@ -211,9 +230,8 @@ static int ceph_aes_decrypt(const void *key, int key_len,
 		return PTR_ERR(tfm);
 
 	crypto_blkcipher_setkey((void *)tfm, key, key_len);
-	sg_init_table(sg_in, 1);
+	set_kvmalloc_buf(sg_in, src, src_len);
 	sg_init_table(sg_out, 2);
-	sg_set_buf(sg_in, src, src_len);
 	sg_set_buf(&sg_out[0], dst, *dst_len);
 	sg_set_buf(&sg_out[1], pad, sizeof(pad));
 
@@ -271,8 +289,7 @@ static int ceph_aes_decrypt2(const void *key, int key_len,
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
-	sg_init_table(sg_in, 1);
-	sg_set_buf(sg_in, src, src_len);
+	set_kvmalloc_buf(sg_in, src, src_len);
 	sg_init_table(sg_out, 3);
 	sg_set_buf(&sg_out[0], dst1, *dst1_len);
 	sg_set_buf(&sg_out[1], dst2, *dst2_len);
-- 
1.7.10.4

