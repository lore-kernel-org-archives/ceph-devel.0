Received: from cvsmtppost13.nm.naver.com (cvsmtppost13.nm.naver.com [114.111.35.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A803BFADD
	for <ceph-devel@vger.kernel.org>; Thu,  8 Oct 2026 06:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439657; cv=none; b=YCYDszA/L30IHv0EadxJuJeCxdP0ywjt2Tws+Pyi4+0e2JvIPeSv4Uv0e9ihjWkb9ZHPOL2oE+rGZSKqUUCuQMMT8T+Cyy5gYGEMw50CuovcgRF4u3Yhd1AJDUNH5I4N77t/yGPOUBHdWCfcf+vb4nmeoJ2u/BnuUgpjYPraW+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439657; c=relaxed/simple;
	bh=em9zlcc8UdOo05z0rJJFWKYtzvE476eodHLFRegvDsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mdzelq0PpriKtv1pSZQUTm3Ujcsk4tPtnj3QyQiYMTYcYXe8jcABTc5zi/nhVckItfNmm8wGdntBE8gi8XZiEkAWcKAPNTki0HL1y6WUO3FA0BbOwZ9zgqCsvFkYvJLd1m9JdV61JfsROGX892ankSABJnxHpgb/89lKwlMdjk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=Nd249LSx; arc=none smtp.client-ip=114.111.35.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="Nd249LSx"
Received: from cvsendbo006.nm ([10.112.20.43])
  by cvsmtppost13.nm.naver.com with ESMTP id q0kDFid+SLiAiC3ib4zyTA
  for <ceph-devel@vger.kernel.org>;
  Thu, 08 Oct 2026 06:07:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791439653; bh=em9zlcc8UdOo05z0rJJFWKYtzvE476eodHLFRegvDsE=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=Nd249LSxmmWVylbLt6fBWmjwCB29ixUJDGGfXlyn3MYpzwIMRHekJiIMdjkETaCCP
	 vTT93u6bBK4bvwbVtxQQOiOz6xPbQnsqI1PlyD+MEJ52GgR6rv++S6t2+SXQfjrJgQ
	 g29kIKXN95Q7+fIBBq2p5ABQX6bzdG/T6m8ddCw1tEQilLuIz273976uu7w3N0aTSa
	 UY+gC15vkS3YapJ8nmt5uh2/P3V3WYWEYDt917mqTelMyxingsdG+pa5VCL+gcKHJu
	 aqvrxYYg8TSNJM6FqcmTri4t1vwxnHBLN+X+SPAwTB9GjCvVubyDGM3zkJxZrxIEgx
	 NXSyggcunDfPw==
X-Session-ID: hZVCuNx2TgOPxskaftATaw
X-Works-Send-Opt: OPFwpzGdjHmdKHFOMr39Ko3YKHmdjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: rqKmFAulFqJZ+HmZFxUX+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp008.nm.naver.com with ESMTP id hZVCuNx2TgOPxskaftATaw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 06:07:32 -0000
From: sung byeongchan <tjdqudcks0424@naver.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: validate MDS reply fragtree split array length
Date: Thu,  8 Oct 2026 15:07:25 +0900
Message-ID: <20261008060725.183008-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

parse_reply_info_in() advances over the fragtree split array using an
unchecked count multiplication.  On a 32-bit client, nsplits=0x20000000
wraps the byte length to zero, so the reply is accepted and
ceph_fill_fragtree() sorts far beyond the message front.

Compute the split length with size_mul() and require the complete array to
remain in the inode record before advancing the cursor.

The malformed reply faulted in frag_tree_split_cmp() twice on the tested
i386 baseline.  It was rejected without a fault twice after this change,
while a normal reply and a one-split control remained functional.

Fixes: 2f2dc053404f ("ceph: MDS client")
Assisted-by: LLM
Signed-off-by: sung byeongchan <tjdqudcks0424@naver.com>
---
 fs/ceph/mds_client.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 085ae0cfb5f7f..6c2b08dcfa422 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -15,6 +15,7 @@
 #include <linux/ktime.h>
 #include <linux/bitmap.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/overflow.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -120,6 +121,7 @@ static int parse_reply_info_in(void **p, void *end,
 			       struct ceph_mds_client *mdsc)
 {
 	int err = 0;
+	size_t splits_len;
 	u8 struct_v = 0;
 	u8 struct_compat = 0;
 	u32 struct_len = 0;
@@ -140,9 +142,11 @@ static int parse_reply_info_in(void **p, void *end,
 
 	ceph_decode_need(p, end, sizeof(struct ceph_mds_reply_inode), bad);
 	info->in = *p;
-	*p += sizeof(struct ceph_mds_reply_inode) +
-		sizeof(*info->in->fragtree.splits) *
-		le32_to_cpu(info->in->fragtree.nsplits);
+	splits_len = size_mul(sizeof(*info->in->fragtree.splits),
+			      le32_to_cpu(info->in->fragtree.nsplits));
+	*p += sizeof(struct ceph_mds_reply_inode);
+	ceph_decode_need(p, end, splits_len, bad);
+	*p += splits_len;
 
 	ceph_decode_32_safe(p, end, info->symlink_len, bad);
 	ceph_decode_need(p, end, info->symlink_len, bad);
-- 
2.43.0

