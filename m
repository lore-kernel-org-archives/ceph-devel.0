Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC549267AF2;
	Sat,  4 Apr 2026 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775292690; cv=none; b=HXYgDhEFqkUguwCZ98PoECr6o+wKYEf9JzduwrnH0inXeInrvOT8V+b1nBq1orUWzHXN2N252jNQzrALRkmQMNuiwj3vjtGTX+ecCkElZ7VrKyvANKcpJcK2zLBfvoGyL78XOQfc+rEKz7Bhm4/1OgvWH4yETjxNs0vBv32mVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775292690; c=relaxed/simple;
	bh=4UifaLmxQ5P51TnR+hoxOcIam9UOLneCJNLAc2O8s1M=;
	h=From:Date:Message-ID:To:Cc:Subject; b=nl4GLBQvHBamg6fEWoLA3Knx4HKmPFraYdqayySBAe8+35J0fJ1G+vV+3mN2iy1exbmeyVb3+zW+xjpHHZLF1mG0BWgH/TGlvyiJ6wjmnOBXvL8KFZTnuQqhNLwJo4rOlfhhAekDRhIOnGyElaXbP8opdl5KdvCBgKM+XI9uhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0003-ceph.eml (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowADHVAgG0dBpB7VzDA--.7749S2;
	Sat, 04 Apr 2026 16:51:18 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 3 Apr 2026 16:56:27 +0800
Message-ID: <20260404101003.3-ceph-pengpeng@iscas.ac.cn>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] ceph: bound encrypted snapshot suffix formatting
X-CM-TRANSID:zQCowADHVAgG0dBpB7VzDA--.7749S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw48JrWkGr18KryktFWrKrg_yoW8CFW8pF
	1fKa45Kr4kJrs2kr97tFn5Wr95Aa95WF45Ca9rA3WfCws3Zr40q3ySkF1Y9FnrGF4fAFWU
	tan5t34UCF4UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_Grv_XF1l8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUDpnQUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>

`ceph_encode_encrypted_dname()` base64-encodes the encrypted snapshot
name into the caller buffer and then, for long snapshot names, appends
`_<ino>` with `sprintf(p + elen, ...)`.

Some callers only provide `NAME_MAX` bytes. For long snapshot names, the
returned length also includes the leading underscore that stays in place
ahead of the encoded text. On 64-bit kernels, a long inode suffix can
push the final encoded name past `NAME_MAX` even though the encrypted
prefix itself stayed within the documented 240-byte budget.

Format the suffix into a small local buffer first and reject names whose
suffix would exceed the caller's `NAME_MAX` output buffer.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 fs/ceph/crypto.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index f3de43ccb470..eeba8ffb0554 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -208,6 +208,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 	struct ceph_client *cl = ceph_inode_to_client(parent);
 	struct inode *dir = parent;
 	char *p = buf;
+	char suffix[1 + 20 + 1];
 	u32 len;
 	int name_len = elen;
 	int ret;
@@ -271,8 +272,20 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
 	WARN_ON(elen > 240);
-	if (dir != parent) // leading _ is already there; append _<inum>
-		elen += 1 + sprintf(p + elen, "_%ld", dir->i_ino);
+	if (dir != parent) { // leading _ is already there; append _<inum>
+		ret = snprintf(suffix, sizeof(suffix), "_%lu", dir->i_ino);
+		if (ret < 0) {
+			elen = ret;
+			goto out;
+		}
+		if (ret >= NAME_MAX - elen) {
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

