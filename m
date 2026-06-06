Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2E637BE6D
	for <ceph-devel@vger.kernel.org>; Sat,  6 Jun 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780761109; cv=none; b=gIVNRd4s1kCz/sQ/hkOLbVs3Vn0hnhWJmRC0HIqF2bs5I+8ZFPphRfdGg+P9N7+lDmlN+iyxeJwabskSAOYK2q14zHvlD7fjYVSZtIAcxlvsGm02a+L2rMLNIkDSpuvKqFZHVeCE4zp6x1ImGBu4pseRkg0yblLHGVt0iWXoox4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780761109; c=relaxed/simple;
	bh=b+biXWp6ckglrWOQeqnOK7JSiOFVopsxQurLx5ts2vE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rURxov4PFpuSgwYayJn3PDRpBHEgTBd7zHbWdrjulJZh/3LpejzhI3g6ostpPy4e+WV2Ix4Yo0HnmffvB7N025d853yByveBhMcPm+Eo8YjvVOQyzKkfnKxxxv84wzhxp9uF7r4hFK5ZrEO63Fd+aBk0PJow1G2+I6uDqmCD2mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfCpWJxf; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfCpWJxf"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c2d792c8so19846325ad.1
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2026 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780761108; x=1781365908; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kM8smwKK+VUgZJJLi4LC3kYF3TgGBfotkui6o3ZnmhQ=;
        b=gfCpWJxfnHah+mUGU2E9Qcv+GaaWTf1botMREYpWq/lsHoH6n33epVkWEIWLLOOZ5E
         ggf0C0yBPMyGsj2tjU8NTp+4WGFnyqLZRyxbVdlNJ816mwvNrfk8Ap64kzU0UViuUJGW
         L9OeUA4CFd7JxkGQNQpuHBkVUmSo3q2RK3xVSelTWc+1NjYqsY43d5hl2G91NolD4Muh
         q2Kr9l8Dzi3aIUtaucZnMZ21t5pFcMcMhj6ySPRkTaeYuPdsnGu4xZQ73Xbh4J/RVJEU
         /xXfULmLqi5PpzZY3vwkv4w1jbxDM8LZ7kandvnAYb63h8n/SEbJQyAN/TDdibx72a2P
         33jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780761108; x=1781365908;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM8smwKK+VUgZJJLi4LC3kYF3TgGBfotkui6o3ZnmhQ=;
        b=o+SqhOZO0ulJvtxcGe4RL7GVg6jT+qYiPIZllm7ruDE6E5RFN4i8asF88gLsIjSkeG
         JPyUVn80mLWE5O1brUvPGYPdJVSQL7qRhx8zfd+3ng8emwbfbb1o+bfTX4Mr+KEZUaqJ
         Icg+rXlKFC/km43ZqM1UBGXEYKmkjlSPNz9QCaS1JlS1a2zqytAiW6LFHtf2i5QGwv2V
         2U44bQFNfgG73hYVtLmvvV9zaXPGa8n3eotG/qvgLE0ZclsCyRDwQ5CLKH9B2dZlo2Cj
         8MGwcoxb7xWUm3Wjxlo4LUbGFIMw9B+Mg0YXJNgnXdPSRg/PLcCg89ZlVLgpiUWhfgeG
         PR7Q==
X-Gm-Message-State: AOJu0YylxDd9ILvJFg6JMt4gZPIGUGnIApn+XaLsFMc6QI7YxIRca1Ko
	CQMId4WViSs+ymAnKNs/8gdrCh8l6Nnnzw5qIHvcMGNbWZhfPUh9ToydXStl9+uz8M1Jxw==
X-Gm-Gg: Acq92OEltYxIsPltF94KCUvIf3yuZEFeDmdMqu5Dku5aXF/ZP7KZrohZpXKg8sf0o32
	ehME6NlyBfEmyfwk/YUUQxXHXs7YP60nI1E9diMm0LJtvi4GQIW1icxPjjbXUkBn/gObytF6LYv
	GIvCCW67aRMDaP0ZW+mUB/ltATaugdEGecLHrayapxLCs/G3MxXgawiHOL817jN4NBGdgjTKTn+
	eTgsxpyWsQE1L7JYnxKWDqzGtAnIwPtAft4D8CwrmCF2mwoqNmVv1InFvoQWnx/UjYI0Ci2M8xN
	PsnmtER85CWAyPVsjv7oZxuvojN4ZLym4xiZHajWHh5Ap2ZtApc4zd5srgsoGVj1WXOFduCtqrU
	fEP8wWsjOj8NTRwFXx4qDf6AvkkJmvM0Yf7PjroKULWxpIywtwfEU6AqFu8yC3cD1BGRAncv2/5
	SeFBpZh6MmjISSYAvmFIeEvW2rVIxkb32S3JsHyYGgtbkPN/t/jWfjgxCW/0o=
X-Received: by 2002:a17:903:244d:b0:2bf:800:19f8 with SMTP id d9443c01a7336-2c1e7e500eamr88158175ad.17.1780761107573;
        Sat, 06 Jun 2026 08:51:47 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([36.21.2.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e86dsm128908575ad.8.2026.06.06.08.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 08:51:47 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Sat, 06 Jun 2026 23:51:34 +0800
Subject: [PATCH] libceph: fix potential out-of-bounds read in
 decode_new_up_state_weight()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-ceph-fix-final-v1-1-e19325c14dd6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAVCJGoC/yWM0QpAQBREf0X32ZYVHvyKPKw1y5WWdpGSf3fRN
 A+nac5FEYERqU4uCjg48uIFdJqQHY0foLgXpjzLq0yiLNZROT6l3sxKV66A7l1pSpCc1gAZP2H
 T/hz3boLdXgvd9wNfEajbcgAAAA==
X-Change-ID: 20260606-ceph-fix-final-16f4e1df5a5e
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Josh Durgin <jdurgin@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780761103; l=2511;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=b+biXWp6ckglrWOQeqnOK7JSiOFVopsxQurLx5ts2vE=;
 b=D6HKyc9ODBxIoz84HHcuIwMxLHaeULK5B6fOBbngVHayK1814WdWkbp+qg2zcvZeVJc4ERdHi
 j3xkyExnQs8BoPAz3CIinckImErnd6IPL8Y3IfeSgaJnEtrsw7tuxNS
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

The new_state section of an incremental OSD map is validated and skipped
using a byte count computed as

	len *= sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8));

The multiplication is evaluated in size_t, but the result is stored back
into the u32 "len", truncating it.  A malicious or corrupted incremental
map can supply a new_state element count >= 0x20000000 (struct_v >= 5) so
that len * 8 wraps modulo 2^32 to a small value.  The following
ceph_decode_need() then validates far fewer bytes than the section
actually occupies.

new_state is then reprocessed with the unchecked ceph_decode_32() and
ceph_decode_8() helpers, which have no per-iteration bounds check and
rely entirely on that truncated up-front validation.  This can lead to
a kernel out-of-bounds read past "end".

Compute the byte count in u64 and bounds-check it against the remaining
buffer before skipping, mirroring the size_t-typed length checks used
elsewhere in this file (e.g. decode_crush_names(), decode_pg_mapping()).
The osd index used for the osd_state[] write is already bounds-checked
against map->max_osd, so this is an out-of-bounds read, not a write.

Fixes: 930c53286977 ("libceph: apply new_state before new_up_client on incrementals")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 net/ceph/osdmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b5b0587a0cf..dd3023fe821e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1842,6 +1842,7 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
 	void *new_up_client;
 	void *new_state;
 	void *new_weight_end;
+	u64 skip_len;
 	u32 len;
 	int ret;
 	int i;
@@ -1862,9 +1863,10 @@ static int decode_new_up_state_weight(void **p, void *end, u8 struct_v,
 
 	new_state = *p;
 	ceph_decode_32_safe(p, end, len, e_inval);
-	len *= sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8));
-	ceph_decode_need(p, end, len, e_inval);
-	*p += len;
+	skip_len = (u64)len * (sizeof(u32) + (struct_v >= 5 ? sizeof(u32) : sizeof(u8)));
+	if (skip_len > end - *p)
+		goto e_inval;
+	*p += skip_len;
 
 	/* new_weight */
 	ceph_decode_32_safe(p, end, len, e_inval);

---
base-commit: dbe8d05c9750b107b10c15361aad40fbb350bedb
change-id: 20260606-ceph-fix-final-16f4e1df5a5e

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

