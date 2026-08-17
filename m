Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA6037E5F2
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994149; cv=none; b=Ft78rEwGAmNQD0kFGjJpZyhwSjybMOjuJ1VurMpRAyQZaJPMFzsGrti3j/rih8iHP+bsOlo9ole4ORn+RQng/PajICroYhsVrRTMi71O+xBqaKCJV6L5LDNazwjNnNqEz4zsXQI3CO/1Riye3AKQplNo6XgV+gVrD2gPRMMVgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994149; c=relaxed/simple;
	bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vCUOmly3WqsFzoZSzOZvE90bexYm7HCWmwcBgqjv1S7Z9/VMQT0GS5SlCLuGr2/y0Q76XAYlWzpMFqtpFBknV5pKNBQ90x8JcGPWr7iigFGDGabprJenfnQnGM8ezwg3wVCq4sWrJ6KclH1BkwhhYXGW3o2Tg9I1bPzpBa/Xo80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=TeHYh2Y1; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GvpAXIYO; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="TeHYh2Y1";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GvpAXIYO"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIYoaS4004667
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=aLyb
	lFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=; b=TeHYh2Y1YenO8IvrhIYW
	C5kAs0PM6N+jzagTsty3cj6nEqEAxWKoa5R83VA9O7e03R8Gx4GiC/zcbcrDJwaL
	sZpNxHPoAtP4gmH+uogz+ArpuQVxTHrSgoVqVXNmjGKWUw4mfGaIGw6/4CdE0fep
	oy4ldJLO4FFVeyeTx7wnuDkGx3an7i8roVeB9JjozUPn9UmoSX8yoavIWv1OESV1
	PNwlvwyEOkYJdcO81iP57RewLN9BUk2kr0ELwr6HD6zZRNgLFy1Wx8j0+pLtBv3y
	FRkH7mbbp/ryM1sAo74kkUwJto4vpCd3fe1xD7vmB6MtqmXwPBs9ZtzSWKZO3TWU
	sQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g43e0anf7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 15:15:46 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-936d067836eso391576585a.0
        for <ceph-devel@vger.kernel.org>; Mon, 17 Aug 2026 12:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1786994146; x=1787598946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLyblFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=;
        b=GvpAXIYOBOaWnq3nDPxCRDaWtLGYUgZRRCVPOJSxJU8Roajxvh7aMFZzSL+w4k5Gzi
         V4/Kd53K+Mv1K1vQmtRKz/wZcnsdsBVdgBpq56KgwS2ZVNBTGkme7Gm2WCDRrEmwifHt
         na/vwli7aCl4jGLl0EwP/mdhS8U4KgmPc2n8Xi10G1MSK8SkmnEAW/Sill02J4nf5WyS
         q8ebYqXQy5yVKAkAKZ/Y+7vs94jsbXTiG6+VFakjITRnPeHRlkDvC7FviCM66mp8B1GI
         Er5lGKqNWuPeKJLBaipoSpGZYjfLiB6Srpwf0OzjBGq+p/AvzZEWif151pddqTsJmGxY
         5SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994146; x=1787598946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLyblFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=;
        b=U5RafmctrFfr3HRlo00Xbzh6f6NpZSNhgpuxyoqeN+rALU78m9sG1r03Vml8t9rMBe
         9OhCw0sgFlZLB8XbxTX741ZdTiZdjFK9wt4o/5ftQD3gTLuCxGEAm9WPrETXQRQ5/lLO
         UVka5uV3rHeYWZJKEQlbSG3IAijU1NHMibX/4mP2fvcLbn+Zxb+dtXSTYV/XIQy22n/V
         pQDlVeRyku9gdPhCMTn9LjVU9i4QBafLRpEdmz2bKZ61m9B1pHii/YBJCR/3gGSE+V42
         6YOO9eL2r8BthLstRcoSPuqseTdTGrWY/7AUOiGRib59YRM4WLvPiwC1mb2bKf85s988
         0nNw==
X-Gm-Message-State: AOJu0Ywq4tJ8yZOir0zCPAyML7ikIJ7NP3JS2poAOCDFTpVK+udTwyo7
	IlRVCiLud+fawnvlabcdjKzAJ7JbfdMuMXwZgMGhWHXMdMs0Wu9wRgFXCO3FUB72q4O78K7Y3jX
	iIArH0pp9DuMEQmsE1YnvS5ySDyW6JL2YIg12NnKCPgbuZ7v09NmWwQH7WJ8=
X-Gm-Gg: AR+sD13yJv+bqq6FvBh0HAZPOu5OgatOlKwsdPch856pQHMwfnm43wbE/FdBJsN5Pd0
	UomlO2QYfrz6apfy+hVkenpYwUzxUV+Vbv3fPYilrJnxujEfey559FpmZogKUrjUx58DUCXmfQy
	zmnJp6frevPIvJcrXH6zA6UAUg8M08THD7jjzv1orwabhLNXH15g5E0Ms5jJFLlI7KCRRe7CFxM
	SWzzINB2N9uqOu09wJgDgnAIxH8Nj4Tk8aQsU52/ARV49MV7ZRsqQPQJbX/kHhharABOxV8+WNl
	IyEI+M9/Ea2bNSxBBW65gfbb4F46uNKpMH60dKg25jCNb+ZJF3B4NS1C2rWFVFNQn7kvonIyjXw
	K/biD1QAn
X-Received: by 2002:a05:620a:a09c:b0:92e:6637:db5 with SMTP id af79cd13be357-936d228696cmr2748625085a.16.1786994146066;
        Mon, 17 Aug 2026 12:15:46 -0700 (PDT)
X-Received: by 2002:a05:620a:a09c:b0:92e:6637:db5 with SMTP id af79cd13be357-936d228696cmr2748616985a.16.1786994145438;
        Mon, 17 Aug 2026 12:15:45 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.67.107])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961098cdsm194692085e9.6.2026.08.17.12.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:15:44 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 17 Aug 2026 14:55:25 -0400
Subject: [PATCH v4 09/10] ceph: remove ceph_fscrypt_pagecache_page() and
 ceph_fscrypt_page_offset()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-remove-wait-on-page-writeback-v4-9-0e5e53d47eb0@columbia.edu>
References: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
In-Reply-To: <20260817-remove-wait-on-page-writeback-v4-0-0e5e53d47eb0@columbia.edu>
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
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786992937; l=1581;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
 b=qAtAvRG7QqoV4dTYjah7e0qaLWVlsv2EL09mFwD3adW6JVHxsMbDyjXVpto/xGBQ34jOHpmaC
 Hx6ZlYJf6GyBa6k2yHOfl9r5H5xkqVxaG667fE0uyRk12c/9IGOtJnW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfXwMNaZ9YMf/Rt
 jd9BNjK/jp60B2iKG2xvIedXGm8qCyX2Z7onofNVqqXtYfOI51I6yNaqtsvbkh9aC7hq7QWTa8x
 YUzNMPYfzIGosr8ZQF4MH5Wlp6s5KLUDQL8vbo4q4b56AIbNN0yzfTcoHLKqImwy6WuOJaJ/gIs
 jhzEvK5u1DG7PXtHkQpMmblCjDoSsq4dW3gVFqeNtuSUfkt4F/ntm5csGN8w/XXXIxlw9e0xKWv
 ORN0gNMAUaqo5HyMaAERWNd+9gNBQOyo0V8goOQX132L/w7aqfyiMoXbHkKhUKzy8M8sPyMQEco
 D9o41llvvWV7vvYtFIuUZFFuI/YvXgZv4zY74NkrLaMaPpf7h21uRwV9IccnCUmIE3H19s4QZB4
 u5tCaRoWjN2ThX3gRcj9/CgK98Lhirhzb174F3p62KeMplc34RZudt9plGqLZe8NDKf5pkuIWEi
 OnkY8aR3YYjWG8nNXYA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE0NyBTYWx0ZWRfX9mep5JbUP63L
 LxHTxKi2XtkTihfFHHGq1wib3eOmRLVIB2J8V18/E5KUwsFSiRhWhfZwrIKw34d8FfqYmlyNZoV
 Z3mQ9eXqxj2APrwjxSy8puuy5ogtS1QZmaFDJ0zImXRVA5gF8QVu
X-Proofpoint-ORIG-GUID: J0tmBRAmDN600MGCYlHR0gGQ80Kgo-SQ
X-Proofpoint-GUID: J0tmBRAmDN600MGCYlHR0gGQ80Kgo-SQ
X-Authority-Analysis: v=2.4 cv=HLrz0Itv c=1 sm=1 tr=0 ts=6a835de2 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=+gpNN1aRt999K7yrv1sWlQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=jfg2DRd2ap2c96lsYj8A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11878
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 bulkscore=10 lowpriorityscore=10 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170147

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

