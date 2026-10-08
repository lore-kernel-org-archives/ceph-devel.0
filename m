Received: from cvsmtppost23.nm.naver.com (cvsmtppost23.nm.naver.com [114.111.35.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BFB3BFE2D
	for <ceph-devel@vger.kernel.org>; Thu,  8 Oct 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439625; cv=none; b=YEooONjQv/HEWoSMGuxv/ffib4OlNNo8c1qnOUB5Pw5wL1/JMrzSeGPjfzH0Rjqv3uJuhyhkdi2GRYXJfUx5RgTes+DxwtaVgqWAEtVhQWo3En9+rSsvaT1BkVOtGjgB6VlSNiDaJjSIi4s2jgIsHApVRAFkXaG806kxJJ1uS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439625; c=relaxed/simple;
	bh=BWGBvQL1+YS+1en6pVE5wAyTIZtN0DhoAlYDtFbIdYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mkn23Ceimo25kbcTLNkLj9vADtdc/fIT+s9AKn7rw3b8izBa2193WxuHeF7tnIVlP0kgoOSSYO0T+SI9uIq5awS9IRv3AuvF8uej7EIcfWMtI/XRS6H/amh2R4U7rnyZ5zV6Z+0B70k1TlzBR453CTefY8+ue+eX1HT6rIBWj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=atMfQ0VV; arc=none smtp.client-ip=114.111.35.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="atMfQ0VV"
Received: from cvsendbo022.nm ([10.112.20.47])
  by cvsmtppost23.nm.naver.com with ESMTP id XXANI1oyQ+afPT32rokQ-g
  for <ceph-devel@vger.kernel.org>;
  Thu, 08 Oct 2026 06:06:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791439614; bh=BWGBvQL1+YS+1en6pVE5wAyTIZtN0DhoAlYDtFbIdYg=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=atMfQ0VVpEkql+gSlrThdNNamXDUh6CTu+oh4UWSg5Zk6wsV1zzxXC1F6xt4MsqJn
	 CPIqawyQ2pTpv6uGIWzJ0VhNStS17RRaf8L+vzVFPRmheVZIe7MPjEIx54laI5yROK
	 EeLBbLAW+KWJ1Hhc1LCJdYBFnO+qnKv6Oh+Fag+UH0528esMt0dHtSdD+YLYC9nqyT
	 YZfV0S2m3wGBnrZARSPcI+njP1HjX3xYly4jGLhHEQWNdnFfRmcyYe4DJPlZ5efRgv
	 sTM5hVMoqpSK4+AMQ6YblreWjoBm9G00N+RTFyEed8qQSByMTWEILwHczh/AURKELn
	 tnXGHwblJDiDA==
X-Session-ID: 57uSFFlyS7+bDLvSGhApjQ
X-Works-Send-Opt: OPFwpzGdjHmdKHFOMr39Ko3YKHmdjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: rZnmFAulFqJZ+HmdKxUX+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp002.nm.naver.com with ESMTP id 57uSFFlyS7+bDLvSGhApjQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 06:06:54 -0000
From: sung byeongchan <tjdqudcks0424@naver.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: validate fscrypt auth blob length
Date: Thu,  8 Oct 2026 15:06:46 +0900
Message-ID: <20261008060646.181728-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceph_crypt_get_context() trusts cfa_blob_len after checking only that the
inode-owned fscrypt_auth allocation contains the fixed header and one byte.
An MDS can therefore place a larger inner length in a shorter outer object,
causing memcpy() to read beyond the allocation when a caller requests the
encryption nonce.

Require the complete blob to fit in the inode-owned allocation before using
the inner length.

On the tested baseline, the malformed reply produced the same KASAN
slab-out-of-bounds read twice. An ordinary UID obtained sixteen wire-absent
SLUB redzone bytes in two non-KASAN production-path runs. The input was
rejected twice after this change, while a complete context still worked.

Fixes: 2d332d5bc424 ("ceph: fscrypt_auth handling for ceph")
Assisted-by: LLM
Signed-off-by: sung byeongchan <tjdqudcks0424@naver.com>
---
 fs/ceph/crypto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index bc0a097a4cea9..720f34ee8ed42 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -30,6 +30,9 @@ static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
 		return -ENOBUFS;
 
 	ctxlen = le32_to_cpu(cfa->cfa_blob_len);
+	if (ctxlen > ci->fscrypt_auth_len -
+		     offsetof(struct ceph_fscrypt_auth, cfa_blob))
+		return -ENOBUFS;
 	if (len < ctxlen)
 		return -ERANGE;
 
-- 
2.43.0

