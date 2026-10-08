Received: from cvsmtppost31.nm.naver.com (cvsmtppost31.nm.naver.com [114.111.35.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CC3BFE50
	for <ceph-devel@vger.kernel.org>; Thu,  8 Oct 2026 06:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791439632; cv=none; b=s3Q5rruTdRgncHvfANOGiipo7B+QFlOaVlEDKCj9JonoBjJSvVLgcLd8f1SDqOmuTwf01YJqnGa/xP4X30hz+MbLwPMjlw6rPFoT+A5/dKGyM7uV/MO8wUpsOuLUOANRN0AZzNjbTOsX5xqDoC8PU3ezrc7p2CkeLFFiSMV1pfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791439632; c=relaxed/simple;
	bh=47AgVHutgz3MI+foRTf9VHaRVysjmYW8BMPk+hOfs4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLMuS9xXxv+IbIicbBd8gZWYH6lLxG59T25rYH+Im7pF39zy3oCo3xjNOe/hXw4Fj4wjWjtw+juHlIpLB+eKMtXEN6iA7eH96+/aHV2pvOjZqKQR1n8/P63ia6d6qiF+D20mQ40sxY8HHilum3T6H6yIEtjCoSaAI24OnJtyU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=B03IiWtY; arc=none smtp.client-ip=114.111.35.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="B03IiWtY"
Received: from cvsendbo012.nm ([10.112.24.38])
  by cvsmtppost31.nm.naver.com with ESMTP id WPx-Rex7SzWMo1oeT11i3A
  for <ceph-devel@vger.kernel.org>;
  Thu, 08 Oct 2026 06:07:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791439628; bh=47AgVHutgz3MI+foRTf9VHaRVysjmYW8BMPk+hOfs4k=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=B03IiWtYcIiUUy2MucE6nJFbtUCNqCXuws5S6NztU55xxdUT83R0xDA6cSC+IgYHY
	 MrIJmX5z8s0mBv9ctXeknHHibJ8pqtuMiLrOaN7QIdp3vjrawVwUieI1zgZOX6lqO5
	 5Cg0dbv3MOWX8KILPHFcRqAcpxKLToLjyQLfeRoqwotB27KoAlmS90jZUSrn8bqAX/
	 ExEwgrGtcyJec8b4q5clkwPaqzEOeJkMXSGZP4v9943bfjFY/LFJDp05Cc+8TY4JkH
	 TxhMTFefcxOjgwkU/AyDEwqPPWm3A+im5etVZeaZD6UGD6+ARSDzoBLF4Qqq02hJ8k
	 82dyxdDLYaL0w==
X-Session-ID: uw-vB7++R8+9mJ+2KP8O+w
X-Works-Send-Opt: OPFwpzGdjHmdKHFOMr39Ko3YKHmdjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: rqYmFAulFqJZ+Hm/KoUX+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp003.nm.naver.com with ESMTP id uw-vB7++R8+9mJ+2KP8O+w
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Thu, 08 Oct 2026 06:07:08 -0000
From: sung byeongchan <tjdqudcks0424@naver.com>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org
Subject: [PATCH] ceph: prevent MDSMap in count overflow on 32-bit
Date: Thu,  8 Oct 2026 15:07:01 +0900
Message-ID: <20261008060701.182128-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MDSMap decoder checks that the message has enough bytes for the `in`
vector by multiplying its u32 element count by sizeof(u32).  On 32-bit
kernels, a count of 0x40000000 wraps that product to zero.  The check then
passes and the following loop performs bare four-byte decodes beyond the
message front until the kernel faults.

Use size_mul() so an overflowing byte count saturates to SIZE_MAX and is
rejected by ceph_has_room() before the loop.

The issue reproduced twice on the tested baseline in an i386 KFENCE guest.
The same frame was handled without an out-of-bounds read twice after this
change, and a normal small MDSMap continued to be accepted.

Fixes: e9e427f0a14f ("ceph: check availability of mds cluster on mount")
Assisted-by: LLM
Signed-off-by: sung byeongchan <tjdqudcks0424@naver.com>
---
 fs/ceph/mdsmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 53079ef34c3a1..d1abfb1d6130a 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -316,7 +316,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(struct ceph_mds_client *mdsc, void **p,
 	{
 		int num_laggy = 0;
 		ceph_decode_32_safe(p, end, n, bad_ext);
-		ceph_decode_need(p, end, sizeof(u32) * n, bad_ext);
+		ceph_decode_need(p, end, size_mul(sizeof(u32), n), bad_ext);
 
 		for (i = 0; i < n; i++) {
 			s32 mds = ceph_decode_32(p);
-- 
2.43.0

