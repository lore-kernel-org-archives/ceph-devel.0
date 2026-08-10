Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A863B3F58DC
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371713; cv=none; b=ElW1m4pPQD6rGi5jNZ5WQc6EozgGOKPorGAvjlZUmhidb5+2zRiJ9cwOJ0yu3Irdecd30Lz/HG3FYnwWNt6yqq90LHvsewN3irsj/Y52EZPYKDYYV+1vED59UQZ/eTV/7R+5eAJVaFob8a/6e/ePAOW+u+5bQKmQihPSmo44xzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371713; c=relaxed/simple;
	bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dqOh9hqvlRFCYIEGbJ0re7Ji21EOkyyNuKFiU8HTygwdpkCT2/Gmd8i/JZj4K0riuVCPTYYNxL3iZn0tqQm+Zh6CDiPdYZ6txDgcp62zeyjCL/2kEDZ8NswFvMt2yQ7L+awaOUx8ew2/TC8uzERj7l/KXGVswAVZqm+iT4gRPeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=qjq+35LT; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="qjq+35LT"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaIaT3194470
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=aLyb
	lFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=; b=qjq+35LTpjf9J2w6F2hB
	vecXljYKiBnAzD5aenYJHzWhsNXgP9xHEliMM9O37gGKVD1vf/Se7su7wn2XbkLZ
	rD2Jym0BqslG5QgoaHVZ61V0B0C8zhmW1wU+QrjXQYIDVxiVIqKgSDWpi/1WUXHy
	ywTqc3FxNJY4ahiAjXPHYZJOy9kupo/J0IxL1BEaXBInVqdm6ONnvUYHFuTpUBSM
	bfA8k5gOrjl2wE7RFonKnU2MENdTTsZEevpboN2Rq7OQug4eKv7jl7Smq6U+kCzG
	b8RYvB92ovczaQwSBwLkIJDnlZxH21dFvqcBi4PRdU3TYYLfd7kGAt4/+bWKd9of
	HQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fy29132fn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:35 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52cd0374265so38076931cf.1
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371694; x=1786976494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLyblFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=;
        b=PV5f/Wj/gs0mCV316b01ha2nQL7Z1r3hfbvU53BCo0g3SONRPZmxDmQ2xXM9lpEtBL
         Xlf9QXcem92RN+lxHYt483vu8F6q0EuyUjow+fDs4x3YmikgpNHBst6RUDCj7pJV5bpq
         4PCmh9o5UceD2zyfIB2jww/p/gu6besIgfbBZNnrRsH+Sa8dw3/sGu3O4aW4v/hQ038K
         scjwY/ko2yIAi/pEO0JsyJnvPAV5kZ5twybk/6hTiosRTsdPNkDrwDS2ETfuFQywzDWZ
         FxoUqnXoM21hrVHNVaREUGekmgeQxy8Y2ODICNRiF81ENOLKRNAhRaRveDcoHvNXwq4F
         6xeA==
X-Gm-Message-State: AOJu0YxKZHO6YYtf97e961sumHk0+38VlqOCNoVJrmaUQogWnA0hlLZX
	zdyaz/RMLquZLDnbfyxLlb6v1vQ96ArYhl9D9sFS/+9eLIN2jH5HO9zhE3LakUqIjnvnB79G/KG
	hS7PcT0BHEXkThkEYa425VokEeNNw3Q3rldXS2sCxnF5JR6jWzFlTNji2eVs=
X-Gm-Gg: AR+sD13H8wP3OP907gn7UT0zEbjOQmkHK0jwwcyBwAADOVCfVNgojsF+IguJ6mtubky
	16uivHwPKgbpU/EIv2ARWQ406he6Wk7osGDCIYFg7NVYBYmMm2N923mcIWFAAaDg6iRbwzRIi9F
	xi9bfzGXtCHkJ9G5bazNgTyGZMJMzTwjMxsKSlXiGTRXp+XwMaHbbSNo40HegWjqBQGl/xSQI5W
	ex/nhB89RC1BRdqTrYAYjgLsgvgtzhxXHyM2vPCF4de5sVxd+tNPqc2YHnQo/B7cvtqnPDCq4/t
	Cxn+ZwSgsgrtBo6ey1CHhVqSyIaHGagGanZl4lNbAuuv8MnwZiskXtzQJxWF9msPN4BliZHGb3U
	C18rQOHvy
X-Received: by 2002:ac8:6f0f:0:b0:528:3ae6:14d6 with SMTP id d75a77b69052e-52d20a50232mr221693301cf.36.1786371694398;
        Mon, 10 Aug 2026 07:21:34 -0700 (PDT)
X-Received: by 2002:ac8:6f0f:0:b0:528:3ae6:14d6 with SMTP id d75a77b69052e-52d20a50232mr221692471cf.36.1786371693979;
        Mon, 10 Aug 2026 07:21:33 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:33 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:22 -0400
Subject: [PATCH v3 11/12] ceph: remove ceph_fscrypt_pagecache_page() and
 ceph_fscrypt_page_offset()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-11-dd7531704f26@columbia.edu>
References: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
In-Reply-To: <20260810-remove-wait-on-page-writeback-v3-0-dd7531704f26@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Christian Brauner <brauner@kernel.org>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=1581;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
 b=igitKHwKICJe64WLGnQtJ7juQTX89Q1kNusDsmkgFURVamzkBrRPYcM6WFXlcOnjVGCWu9jAc
 HjyznGVPVaGAnp/iTFafK7Se035x+xGTYGst6RxsqK2bKINK75nE3GU
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: hhI-CnmGp70fSg0ci9to0a5YQXD8u6C2
X-Authority-Analysis: v=2.4 cv=aMTAb79m c=1 sm=1 tr=0 ts=6a79de6f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=jfg2DRd2ap2c96lsYj8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: hhI-CnmGp70fSg0ci9to0a5YQXD8u6C2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX5CKEn8gGnlUQ
 6JUHDnU+Pgi2SdlwqHiQEh4DJ4yfJcaDXR4Mh1D5NrmiTyZBzMlHXRerQULefDMCrnDuzcP/Cnj
 r9Sw5JuTTBMIQl73XVSAZXkHS5GVxKdWQODeyxNVUiS6p/zkWq5VGSrb7GAhh8ZY9XXZ4P6Ul8V
 LRAMf3aidxKjfDd1zB/2TvqYeeGFpz0lmnmFHWOJwkETwiRCkr9SQcQ2wIWvUOtaGkboEGXeutc
 5fKKGDGmsPkC+cbJ1gFMqBvyzkhofshvphNwqG4vZbcRjvIhrLsgUR7qhPX2ic8pY/gtShhGkix
 m3pPij9QN0zcaKtm1P0fjhJ1tMxbU53IfghVt0e6Q8zYkbhG0tBpOS3+erBwx3AQdzO4h5/caSR
 aOdYlyr0c0Bmlu8SfHtSN3rDtbnxVskN4YR2kQi869HYh6BMwm8pDPHwvJyZVT3EdQgOrs0DWBx
 Xb0o0MpJmV41dHTVdIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX/X6QQvCDOOjj
 GobId5ATkjG15ya133cL3c0T8J4hd00Yi7im6TBF9LPqP9Eh2GmjG/Dw7zyAWRvkNCFX7z4mOM2
 VBAti+QfBdJDb3RkwmVKbf97qmVa0QqYeCNhjnQfalGPwP8l3zbu
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=10
 adultscore=0 phishscore=0 lowpriorityscore=10 suspectscore=0 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100123

All callers have been converted to the folio equivalents, so remove
these unused helpers. This also removes a use of page_offset().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/crypto.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 948c8b5dca06..d199dc8410fe 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -157,11 +157,6 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page, u64 off,
 			       int len);
 
-static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
-{
-	return fscrypt_is_bounce_page(page) ? fscrypt_pagecache_page(page) : page;
-}
-
 static inline struct folio *ceph_fscrypt_pagecache_folio(struct folio *folio)
 {
 	return fscrypt_is_bounce_folio(folio) ? fscrypt_pagecache_folio(folio) : folio;
@@ -263,22 +258,12 @@ static inline int ceph_fscrypt_encrypt_pages(struct inode *inode,
 	return 0;
 }
 
-static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
-{
-	return page;
-}
-
 static inline struct folio *ceph_fscrypt_pagecache_folio(struct folio *folio)
 {
 	return folio;
 }
 #endif /* CONFIG_FS_ENCRYPTION */
 
-static inline loff_t ceph_fscrypt_page_offset(struct page *page)
-{
-	return page_offset(ceph_fscrypt_pagecache_page(page));
-}
-
 static inline loff_t ceph_fscrypt_folio_offset(struct folio *folio)
 {
 	return folio_pos(ceph_fscrypt_pagecache_folio(folio));

-- 
2.39.5

