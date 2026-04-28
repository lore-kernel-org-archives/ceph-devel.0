Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA063F54B7
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777378581; cv=none; b=XDbtnA1pYosFJ2XdRx6QYGZOBY2krXdN4gb94aQVFYwnpGRPnhljhWrAOhLqNdLfGlL3BOmbu5BkRHEj/UzbYs3mEegQiYXFccB36Z1jE8V9QJNudG1d88XTe9EL1GwraSICeVNm9tAqsAlkyKFKC02iLGv2DRzHSeYzFCrg2Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777378581; c=relaxed/simple;
	bh=O8XHAT3dWQ0z8jq5u398ag3ZtEdW/cIKFUsiBgEAozQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fh6atxpAZbqlmSY8kVX84N+hq1eQBu0yAQBWsWrxv4DRoeD4vmfHYSPmH1t3M9goGeEcgyipTbYLl3vc1wIaDzfvczGBdDb59JoKcEnIVMUCPc6B7nRggLb+ktDbDdE0DNOnapp83GGS35gV0vKP5v1iZdUKfcPgUQMoxSUCJig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=YuZSuy5k; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="YuZSuy5k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1777378574; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=O8XHAT3dWQ0z8jq5u398ag3ZtEdW/cIKFUsiBgEAozQ=;
 b=YuZSuy5kC/Y8Pm7NEhH+8mPiANyhXr5HkvZ0MRknThB/HsqtgZmZ0MCZtOzoiH7WGQnoV
 VlFj6f7J1p5XkWI5Lh1zwBeW0zwIEIiDFaLElIV9aItEyFcoBmOzLLfyLj3auIly5pH8vRp
 Ok3n9Yp3gFQgubKgARALIJcE/n4Bs2UDsOdRKfuHVcH19n0n5nFpllxkg3WY1J55B5G1zLC
 pvYHro/Ymuslqm0ypbH1U6MaXVa8Ei2/eyXeCOyUbA1Ix3+g48q7fm7gE5kBq27NJUV/W6Y
 MvvmjDRcdrzflJt4qHZxRSKgfzKuyqG9cM/C4w3pt46BWDrh38yrkcnrvdcg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 359525FCDF;
	Tue, 28 Apr 2026 14:16:14 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 1295B5FA9C;
	Tue, 28 Apr 2026 14:16:14 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v2] libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()
Date: Tue, 28 Apr 2026 14:15:46 +0200
Message-ID: <20260428121546.148369-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __ceph_x_decrypt(), a part of the buffer p is interpreted as a
ceph_x_encrypt_header, and the magic field of this struct is accessed.
This happens without any guarantee that the buffer is large enough to
hold this struct. The function parameter ciphertext_len represents the
length of the ciphertext to decrypt and is guaranteed to be at most the
remaining size of the allocated buffer p. However, this value is not
necessarily greater than sizeof(ceph_x_encrypt_header). E.g., a message
frame of type FRAME_TAG_AUTH_REPLY_MORE, that is just as long to hold
the ciphertext at its end with a ciphertext_len of 8 or less, can
trigger an out-of-bounds memory access when accessing hdr->magic.

This patch fixes the issue by adding a check to ensure that the
decrypted plaintext in the buffer is large enough to represent at least
the ceph_x_encrypt_header.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/auth_x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 692e0b868822..9e64e82d0b63 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -115,6 +115,11 @@ static int __ceph_x_decrypt(const struct ceph_crypto_key *key, int usage_slot,
 	if (ret)
 		return ret;
 
+	if (plaintext_len < sizeof(*hdr)) {
+		pr_err("%s plaintext too small %d\n", __func__, plaintext_len);
+		return -EINVAL;
+	}
+
 	hdr = p + ceph_crypt_data_offset(key);
 	if (le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC) {
 		pr_err("%s bad magic\n", __func__);
-- 
2.47.3

