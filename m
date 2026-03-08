Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC9617993
	for <ceph-devel@vger.kernel.org>; Sun,  8 Mar 2026 22:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773007919; cv=none; b=qp5PgLR06bNV6qpbpX7UVwxN3lmy8cqJImw+Jac4qjzcGurYQ9js46uIHgEJIqXS8HXhx9YW9cNX2RjzyraRFF5lo4XIzSobbMgZDunBzc/ANxEe34p4XsOyV0BCgpwgpz7MpFdCuL5e+FtnARQUY081RD3cHOoeWdgYB/xA3IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773007919; c=relaxed/simple;
	bh=65RWCDrjxL1QWtvOX44b5MvIAHf84CwdH9p9ozo5OxU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+D0PJBOX0DJF5K5GkLH7/+2Y4j1thcuHbYzXhTtagRYpn2NYLi4SiN9DO/pu4mcW+Kct6l1SY64c/gZSp3/gXKBZEoiv8joMeqmFHNQY+dkj5S1/Xy6snzTvoFvzjirZf0c7qcGL9tQYCCiDHm1GNj645eesShLcMHBPwUGjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGEkWCtC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGEkWCtC"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-899ee491af3so79363916d6.1
        for <ceph-devel@vger.kernel.org>; Sun, 08 Mar 2026 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773007917; x=1773612717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3QxAsF+ZuSBO0NYkqhfb3/S0fC4yP/y2N+yFargy/c=;
        b=OGEkWCtCo3bVmAZlE2g85QLQ/ggxAXh5rSJQZSvQSYlMT36MCI+96R3qppP1S3r1Vk
         lxSB74pJBhMl6rv/wpZHQmeWC4E6JDRPyob/wNnwCghNGvJVXKQNVCJDVfmF9DTKc7ZU
         DzeufA9s0Tlxt7DFjHg/LiApYP8A0KjLbrdqVpwgtEbYHUT3pJfTfrMu+qYMzhHXHOO1
         rXPtqETKblPwDSrnGK3Zom2KbcEi157/q1G/LlRYrLCeFYotnMb6VkM4sS6QvU+tcr5P
         CkA+KAohfFLA1By+BRPAXgm2f3AYsE1XnPsPDe0F1HOMvDFRvwbPUaHxzQ3nDo9fZ1GM
         n4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773007917; x=1773612717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3QxAsF+ZuSBO0NYkqhfb3/S0fC4yP/y2N+yFargy/c=;
        b=Ux4gFw/APX8qZCyUUPky8xFVOJEEEDfNab5XG81a66Q+rnnWH4nIOaZIutRq9us8g9
         NxUrEfs2RshwJjeN7LnTIEZ/erFwM+FegQPB6RIP63EY9TSSQt+HFQxYvjeZkuaGP+8k
         Ikm67sPZshR+2yidKL/YhpX7G20AeMi2hdkfrTqd/2xWJmaTXAqO6GJGi3JwdEaTDPV8
         MPzOua5ojMaQJbSVYXhwH7VkkQDkApDceuvWYWzyuZRFRykP9TWTNSwpPpK7Mxw8AxIQ
         wWjnrdo6crbHIdP4mdV73nHEmhCr2t+/IfYxtKVXxD3BOtaRIQ/Gy4shBq4YqZlLyPB2
         Ly0A==
X-Gm-Message-State: AOJu0Ywv2Q1qrmQYzfB3jqXXXD9xqVmD15te7u9MLz8eVQpdGK2aRPHF
	uJOSR1enjadHhFAM8t4Q+vY/ANquIZRBABjsvHaXLaeSJznwAL2tRZB+DhLFSA==
X-Gm-Gg: ATEYQzy47s9aWWAvWTFSY0LDQ8S3OmgRIj75+2h6ERFiyEQm6tvuhYBVVBCJBFXxs75
	dhC4LhEUKZpsIgQl8HubCpERsrZWr/WYluV+L+hDvwQ3IgA+7VVJDwlzL6US6is36AW751HWOjF
	Z+167Ls5AI6jqpJJ0b8Nq18ldh/8eQfIYUjveWoq6Ri/y09fnIiIn34AcQRMv7KusQwt22kPOpb
	1Oel8i/aqt3VUlIxVj4hJcDp0Xsy+jCD4mLaOenZVTxdrzPmOzEr1P1PsKn5XNICy1nOTrGE/KI
	kJUNtZw0ENvrsKzkSP4/d29MCqxMP9t5eRlncjKdUDzoKGLDA3Ks0b8e3+X2sBUcxc6I6OLzWX5
	ax1IB6OLCm1HzsQdo2m6mMFMlXzLW7TWcBBDLfuDBYH3Z0tWxQ3JfEelcDqJ/sR1lyt5zbSo6xC
	Frd6gV/fR/Yl8QdAcgxD5MWKL8+zAQv8cgHFhAuh8w9T7OA4C0
X-Received: by 2002:a05:6214:cce:b0:89a:1253:c81c with SMTP id 6a1803df08f44-89a30a3a6d2mr143332886d6.19.1773007916888;
        Sun, 08 Mar 2026 15:11:56 -0700 (PDT)
Received: from zambezi (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a316eca64sm61588026d6.44.2026.03.08.15.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 15:11:56 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH] libceph: reject preamble if control segment is empty
Date: Sun,  8 Mar 2026 23:11:40 +0100
Message-ID: <20260308221142.695096-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While head_onwire_len() has a branch to handle ctrl_len == 0 case,
prepare_read_control() always sets up a kvec for the CRC meaning that
a non-empty control segment is effectively assumed.  All frames that
clients deal with meet that assumption, so let's make it official and
treat the preamble with an empty control segment as malformed.

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/messenger_v2.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger_v2.c b/net/ceph/messenger_v2.c
index c4ddf7911f7d..50f65820f623 100644
--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -392,7 +392,7 @@ static int head_onwire_len(int ctrl_len, bool secure)
 	int head_len;
 	int rem_len;
 
-	BUG_ON(ctrl_len < 0 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
+	BUG_ON(ctrl_len < 1 || ctrl_len > CEPH_MSG_MAX_CONTROL_LEN);
 
 	if (secure) {
 		head_len = CEPH_PREAMBLE_SECURE_LEN;
@@ -401,9 +401,7 @@ static int head_onwire_len(int ctrl_len, bool secure)
 			head_len += padded_len(rem_len) + CEPH_GCM_TAG_LEN;
 		}
 	} else {
-		head_len = CEPH_PREAMBLE_PLAIN_LEN;
-		if (ctrl_len)
-			head_len += ctrl_len + CEPH_CRC_LEN;
+		head_len = CEPH_PREAMBLE_PLAIN_LEN + ctrl_len + CEPH_CRC_LEN;
 	}
 	return head_len;
 }
@@ -528,11 +526,16 @@ static int decode_preamble(void *p, struct ceph_frame_desc *desc)
 		desc->fd_aligns[i] = ceph_decode_16(&p);
 	}
 
-	if (desc->fd_lens[0] < 0 ||
+	/*
+	 * This would fire for FRAME_TAG_WAIT (it has one empty
+	 * segment), but we should never get it as client.
+	 */
+	if (desc->fd_lens[0] < 1 ||
 	    desc->fd_lens[0] > CEPH_MSG_MAX_CONTROL_LEN) {
 		pr_err("bad control segment length %d\n", desc->fd_lens[0]);
 		return -EINVAL;
 	}
+
 	if (desc->fd_lens[1] < 0 ||
 	    desc->fd_lens[1] > CEPH_MSG_MAX_FRONT_LEN) {
 		pr_err("bad front segment length %d\n", desc->fd_lens[1]);
@@ -549,10 +552,6 @@ static int decode_preamble(void *p, struct ceph_frame_desc *desc)
 		return -EINVAL;
 	}
 
-	/*
-	 * This would fire for FRAME_TAG_WAIT (it has one empty
-	 * segment), but we should never get it as client.
-	 */
 	if (!desc->fd_lens[desc->fd_seg_cnt - 1]) {
 		pr_err("last segment empty, segment count %d\n",
 		       desc->fd_seg_cnt);
-- 
2.53.0

