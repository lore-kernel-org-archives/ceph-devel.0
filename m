Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF4B652;
	Wed,  8 Apr 2026 00:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775609940; cv=none; b=GlrSfirjCmX4ey9dvn2yiahq/eQHTRH9Kj5FkzMmoGnzANbhwwpjqW1Ts0y/q8HcsISPDb6mv719NBFN5Qy+4FJBBvIjIHWx/MJfvDlq8mnX00tElKM2TTeATt7FtLRKKNLwa/2RC68xjMPCVcUroXCETkKtPpE0VNX9mfnlba0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775609940; c=relaxed/simple;
	bh=RYxaKJmQyWNsYVrZP4LqKaRGLVNZmOVxio9eT2sfT9U=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=eBSIBAeqosTpOrt11kt0Hy0SekpshevqDjANkFEu7iTkhJm6z4vrJneoZo+eFKrZk2rq2k94NX1JtisAVOKE4856VZbDJYA8+lnLbJ3MCn1VkhcB/RX3udRkV2DT7rfDIYImN4AL8/xUdm/WqetiuEkvx4br5KiawcRNlXj3b0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-ceph-v3.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowACXQm5OqNVpRVKTDA--.30291S2;
	Wed, 08 Apr 2026 08:58:54 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Wed, 8 Apr 2026 08:57:33 +0800
Message-ID: <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
References: <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
Subject: [PATCH v3] ceph: bound encrypted snapshot suffix formatting
X-CM-TRANSID:qwCowACXQm5OqNVpRVKTDA--.30291S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3Kw15Kr1fWw48tFW7CFg_yoW5Xr1UpF
	1Sya45Grs5Aw4xK3s2yF1fWryFqa95WFW5Ca97A3W8Cwn8Zr18t34Syrya9F9rGF4rJFyj
	yFs0kw15GF17tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYNVyDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

ceph_encode_encrypted_dname() base64-encodes the encrypted snapshot
name into the caller buffer and then, for long snapshot names, appends
_<ino> with sprintf(p + elen, ...).

Some callers only provide NAME_MAX bytes. For long snapshot names, a
large inode suffix can push the final encoded name past NAME_MAX even
though the encrypted prefix stayed within the documented 240-byte
budget.

Format the suffix into a small local buffer first and reject names
whose suffix would exceed the caller's NAME_MAX output buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

---
Changes since v2:
- document the suffix buffer size with a comment
- drop the dead ret >= sizeof(suffix) check
- track the skipped leading '_' explicitly via prefix_len
---
 fs/ceph/crypto.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index f3de43ccb470..7989056a463c 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -15,6 +15,12 @@
 #include "mds_client.h"
 #include "crypto.h"
 
+/*
+ * Reserve room for '_' + decimal 64-bit inode number + trailing NUL.
+ * ceph_encode_encrypted_dname() copies only the visible suffix bytes.
+ */
+#define CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX	sizeof("_18446744073709551615")
+
 static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -209,6 +215,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 	struct inode *dir = parent;
 	char *p = buf;
 	u32 len;
+	int prefix_len = 0;
 	int name_len = elen;
 	int ret;
 	u8 *cryptbuf = NULL;
@@ -219,6 +226,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 		if (IS_ERR(dir))
 			return PTR_ERR(dir);
 		p++; /* skip initial '_' */
+		prefix_len = 1;
 	}
 
 	if (!fscrypt_has_encryption_key(dir))
@@ -271,8 +279,20 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
 	WARN_ON(elen > 240);
-	if (dir != parent) // leading _ is already there; append _<inum>
-		elen += 1 + sprintf(p + elen, "_%ld", dir->i_ino);
+	if (dir != parent) {
+		/* leading '_' is already there; append _<inum> */
+		char suffix[CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX];
+
+		ret = snprintf(suffix, sizeof(suffix), "_%lu", dir->i_ino);
+		if (ret > NAME_MAX - prefix_len - elen) {
+			elen = -ENAMETOOLONG;
+			goto out;
+		}
+
+		memcpy(p + elen, suffix, ret);
+		/* Include the leading '_' skipped by p. */
+		elen += ret + prefix_len;
+	}
 
 out:
 	kfree(cryptbuf);
-- 
2.50.1 (Apple Git-155)


