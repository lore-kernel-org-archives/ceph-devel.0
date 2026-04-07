Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D7274B37;
	Tue,  7 Apr 2026 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527832; cv=none; b=ufRFprqrY50R9Qga1o5mxSABW1QWB04rHOP0sQZ783S0O+j5pST/efXYSnS+SZUVpmBAi8Jswo44TppbgoOVtALDB1FZIYVf2lpnuGbqz7SsK3I/dzpE6uHjkG80v2tKr+XjfQvMBcrh8ymvpp5JMynjf8/di2AOWSwzoTjB1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527832; c=relaxed/simple;
	bh=7tTCSW6ehEL02HYUFc2vgAoikHHBgKOp8uijnZDG+a8=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=m8T2egJYOWVSLerF2FmctfEyMmJW/Jhbz5u3ylHW6ianio2cpXJsESSWt9erF7Gup3Giw2sYLUqgSj02B+U7SLMjgWAVH4v4vkIX4IpyvDmGdbj8TC8RcO38I8A5hJeUN/refmCUWKqzpjNGQYhNgmjTi/EE6Vg+9CzvdwqME/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0003-ceph-v2.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowADHbGiRZ9RpwbR2DA--.27284S2;
	Tue, 07 Apr 2026 10:10:26 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Tue, 7 Apr 2026 09:57:13 +0800
Message-ID: <20260407120003.3-ceph-v2-pengpeng@iscas.ac.cn>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
References: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
Subject: [PATCH v2] ceph: bound encrypted snapshot suffix formatting
X-CM-TRANSID:qwCowADHbGiRZ9RpwbR2DA--.27284S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw48Jry5XFWrKrWfCF48WFg_yoW8Zw18pF
	13Ka4DGrs3Ar47Kr93tFyrZr95Ja95WF13C397A3WUCws8ZF18t3ySkry5uFnrGF4fJFWj
	yF4kta45WF17AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjiID7UUUU
	U==
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
Changes since v1:
- replace the raw suffix-size constants with a named maximum
- drop the impossible negative snprintf() check
- keep the NAME_MAX bound check local to the formatted suffix length

fs/ceph/crypto.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index f3de43ccb470..7712557660c3 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -15,6 +15,8 @@
 #include "mds_client.h"
 #include "crypto.h"
 
+#define CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX	sizeof("_18446744073709551615")
+
 static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -271,8 +273,19 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
 	WARN_ON(elen > 240);
-	if (dir != parent) // leading _ is already there; append _<inum>
-		elen += 1 + sprintf(p + elen, "_%ld", dir->i_ino);
+	if (dir != parent) {
+		/* leading '_' is already there; append _<inum> */
+		char suffix[CEPH_ENCRYPTED_SNAP_INO_SUFFIX_MAX];
+
+		ret = snprintf(suffix, sizeof(suffix), "_%lu", dir->i_ino);
+		if (ret >= sizeof(suffix) || ret >= NAME_MAX - elen) {
+			elen = -ENAMETOOLONG;
+			goto out;
+		}
+
+		memcpy(p + elen, suffix, ret);
+		elen += ret + 1;
+	}
 
 out:
 	kfree(cryptbuf);
-- 
2.50.1 (Apple Git-155)

