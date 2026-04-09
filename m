Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65104366810;
	Thu,  9 Apr 2026 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702555; cv=none; b=u00f8aHZ6xjfJKqmEaFrKvCyXZP6E0PIo6YThKUHJ9Z44NXEnR7r98KEDGDZhmIbItWjZE7gflRh+wwVcsNJz+hRlBzlkgtfQfUbd8DrxSxaDUWbaaJACBp2bK0+4qoQ2Zw2BAkvtbnNiTk8tksBAu2RdT9ETJqfMc9SpifXbwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702555; c=relaxed/simple;
	bh=DfT5jGeAhOMDSeolLpBZoA1mOcnAJEhhTfwQ5Co3Fsw=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=GC9wJsTsDMl/dRswp1sNQG5OPrF/acKmWJKmvOA0qUbqyOEf4wC7+eWjQTaIwcM4x8TGh66hIQIJNjYnuHodvNIotQTlqmph7z7PJV+c3Sjrdf54L/ngB/KzI7Aboo2J3QCyny+Q4xYtBO9rJFSDzq4pHpHzdF3P3ROGvFrrEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-ceph-v4.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowADX9dwVEtdpxqRwDQ--.9582S2;
	Thu, 09 Apr 2026 10:42:29 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Thu, 9 Apr 2026 10:39:25 +0800
Message-ID: <20260409110001.1-ceph-v4-pengpeng@iscas.ac.cn>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn> <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn> <20260408093001.1-ceph-v3-pengpeng@iscas.ac.cn>
Subject: [PATCH v4] ceph: bound encrypted snapshot suffix formatting
X-CM-TRANSID:rQCowADX9dwVEtdpxqRwDQ--.9582S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3Kw15Kr1fWry3Gr1xZrb_yoW5Wr43pF
	1fKa45Grs3JrW7K3sayF1fWryFqa95WFW5C397A3WxCws8Xr18t34ayFyagFnrGF4rJryj
	qan8tw15GF17trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBmhwUUUUU=
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
Changes since v3:
- reject `elen > 240` explicitly instead of relying only on the earlier
  `WARN_ON()`
- rewrite the NAME_MAX bound check in terms of the final total length
  instead of `NAME_MAX - prefix_len - elen`

 fs/ceph/crypto.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index f3de43ccb470..42e3fff34697 100644
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
@@ -271,8 +279,27 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
 	WARN_ON(elen > 240);
-	if (dir != parent) // leading _ is already there; append _<inum>
-		elen += 1 + sprintf(p + elen, "_%ld", dir->i_ino);
+	if (elen > 240) {
+		elen = -ENAMETOOLONG;
+		goto out;
+	}
+
+	if (dir != parent) {
+		int total_len;
+		/* leading '_' is already there; append _<inum> */
+		char suffix[CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX];
+
+		ret = snprintf(suffix, sizeof(suffix), "_%lu", dir->i_ino);
+		total_len = prefix_len + elen + ret;
+		if (total_len > NAME_MAX) {
+			elen = -ENAMETOOLONG;
+			goto out;
+		}
+
+		memcpy(p + elen, suffix, ret);
+		/* Include the leading '_' skipped by p. */
+		elen = total_len;
+	}
 
 out:
 	kfree(cryptbuf);
-- 
2.50.1 (Apple Git-155)

