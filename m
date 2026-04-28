Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3F32206A7
	for <ceph-devel@vger.kernel.org>; Tue, 28 Apr 2026 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364357; cv=none; b=B0IcSk7YnM46LQcf94bi4hAbXZ1sZODrIm2E+zi/3R1OiUrVENuUB4YbUiRXuGMA97qjj8jG3dcg0OiN/6dTKTHYXMsYpC5GV3pQKFa0w7kcHdBAM29z367dkhZJYaWfXvovZptUBuaaXRaBAHdOQQy/D+u7bMzBS7whDCj54pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364357; c=relaxed/simple;
	bh=fHz6gc2gKV/RCni4YPJu4UyGCOsBEToPqX/4jGkn074=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eD9HPaTP8Ft7aWCvpkC7U9+R5s0QRJEUvr8kIVQpx1HAtGtCJkHuMYT+BGLGzqNXPa+yS7SBaR2uyCmLJCDzMiaz8nxUv363ShPXcK9L83NpvsQSWklWcsaywiPBmG6yH84R1c0+1EfLuG8mOw9+NFMKBv8aThTrEVpxfzize1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=nUeJxSa0; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="nUeJxSa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1777364347; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=fHz6gc2gKV/RCni4YPJu4UyGCOsBEToPqX/4jGkn074=;
 b=nUeJxSa0B/W8+m1/3OwDRVZ42MJ47nv/wk2ieLfe9UF9BZtcN/9f1c7cv5SlQSRD82Fz5
 iu6UI5gZ8M9OEQ0izJlOXrpx2bPVMclyulnqXShCLZHoD1l2jVTa8KPAhL9kqrGdkpKdaXy
 FA21RT2Ml6rMnau8iwwKOACqMmkBBEvEj/FGGStkQK/dF6XU4OmUaJvqywGKl7B4iGwZYJq
 h+GHkKL1DBLhIZT7Cwf+H+sd5QclV6VvoNaAx+ULLDXCDjQE9Ga58xAeom1/lBknH62OwGC
 4b/cCXAaungb8W1FujaH+bolrBxkiC0nhNmNN1f5eO4wBMipsXXzD0W3yhaQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 15CDD5FB4D;
	Tue, 28 Apr 2026 10:19:06 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id E36405FC52;
	Tue, 28 Apr 2026 10:19:04 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: Fix potential out-of-bounds access in __ceph_x_decrypt()
Date: Tue, 28 Apr 2026 10:18:49 +0200
Message-ID: <20260428081849.131286-1-raphael.zimmer@tu-ilmenau.de>
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
ciphertext buffer is large enough to hold the ceph_x_encrypt_header.

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/auth_x.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 692e0b868822..bb65d5d52b6d 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -109,12 +109,14 @@ static int __ceph_x_decrypt(const struct ceph_crypto_key *key, int usage_slot,
 	struct ceph_x_encrypt_header *hdr;
 	int plaintext_len;
 	int ret;
+	void *end = p + ciphertext_len;
 
 	ret = ceph_crypt(key, usage_slot, false, p, ciphertext_len,
 			 ciphertext_len, &plaintext_len);
 	if (ret)
 		return ret;
 
+	ceph_decode_need(&p, end, ceph_crypt_data_offset(key) + sizeof(*hdr), bad);
 	hdr = p + ceph_crypt_data_offset(key);
 	if (le64_to_cpu(hdr->magic) != CEPHX_ENC_MAGIC) {
 		pr_err("%s bad magic\n", __func__);
@@ -122,6 +124,9 @@ static int __ceph_x_decrypt(const struct ceph_crypto_key *key, int usage_slot,
 	}
 
 	return plaintext_len - sizeof(*hdr);
+
+bad:
+	return -EINVAL;
 }
 
 static int ceph_x_decrypt(const struct ceph_crypto_key *key, int usage_slot,
-- 
2.47.3

