Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6249F30D401;
	Mon,  6 Jul 2026 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783349079; cv=none; b=T0C1BWE5/OvYiqKc0F2Lxm71WHn3g1SFoL3grlyxklxariD1vY489irbOGyDwV4p1dcSqbU24gAK/ihZ3tZWQTbBV6dMlmOXHrXLjjENGQIZkLyP6VS9isCq6QVzvCnVtSdKSM+Jsf8QKmo+IHe/4DdDylV8UgUSrxUjTgkoHgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783349079; c=relaxed/simple;
	bh=BWZmT/jfRnV0Y9Ok5WCEWbrCaS7Mc7LFgxfEPDy1kbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=soeO2zg08XmNv5Bei+Z72KBjTXgARQKGqIKLfZel2tfKXNGxqSba0gTSav8KsQ55jK34oyCvaK5rp7CY8YLbjWeDRi5b8d7GAQxE/4XD/1eNNcl+TsuEOZJcc/UvdbJrkcum0bQEowDWziKRV0liAC4n6DAsl4FhYfBspkHwh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAD3fABOv0tqOnM7Fw--.10581S2;
	Mon, 06 Jul 2026 22:44:30 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: ceph-devel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] ceph: bound encrypted snapshot suffix formatting
Date: Mon,  6 Jul 2026 22:44:23 +0800
Message-ID: <20260706144423.92164-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3fABOv0tqOnM7Fw--.10581S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW3Kw15Kr1fWry3Gr1xZrb_yoW5Ar1kpF
	1fKay5GrZ3ArW7K3sayF1fWryFqa95GFW5C397A3WxCws8XF18t3yayrya9FnrGF4rJFyj
	qan8tw15GF17trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUvXd8UUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

ceph_encode_encrypted_dname() base64-encodes the encrypted snapshot
name into the caller buffer and then, for long snapshot names, appends
_<ino> with sprintf(p + elen, ...).

Some callers only provide NAME_MAX bytes. For long snapshot names, a
large inode suffix can push the final encoded name past NAME_MAX even
though the encrypted prefix stayed within the documented 240-byte
budget.

Format the suffix into a small local buffer first and reject names whose
suffix would exceed the caller's NAME_MAX output buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v4:
- rebase on current linux/master
- keep the inode suffix format as %llu after the treewide i_ino type
  change

Changes since v3:
- reject `elen > 240` explicitly instead of relying only on the earlier
  `WARN_ON()`
- rewrite the NAME_MAX bound check in terms of the final total length
  instead of `NAME_MAX - prefix_len - elen`

 fs/ceph/crypto.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 64d240759277..eb4aef6a42d4 100644
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
-		elen += 1 + sprintf(p + elen, "_%llu", dir->i_ino);
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
+		ret = snprintf(suffix, sizeof(suffix), "_%llu", dir->i_ino);
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
2.43.0

