Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB37E47B413
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869580; cv=none; b=HD23tok7bLuzwyWFUyZyoYhX9CLKu8Kf1wlj3yEjs/IxXnUDTwn1EK37w2wJ0kGQKv4ZRjhe8hxIh3kLQQVp2S0ff1sbdwy6CzGdR+p9z4YLvrhnCnYUH7lUkl0CzP3cKS8XAmNW2c39uWbc/Bgun/N+lO2Cp1CsyYUWZgyRxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869580; c=relaxed/simple;
	bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=grH49bi/HRwkyKcEJ00idrQWeCaz1Ym8harTmZKJRU2FeUy0GF8GM3HDz8OXfUvOMgb+qhmFz1Xehz8j4FZ90UqUQhC6DKi3pdnNPNdTJqmeZW24FbfjzRj3RU/EZWDGfFmtNvGvQfOicBGbq7G7HchR2xlMO7PXatTVjmC29NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=FZQOfS2m; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="FZQOfS2m"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IY9NI1999421
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=aLyb
	lFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=; b=FZQOfS2mrfDQVv1eTgY+
	KoHIWPv7re0oYNY5Ak+9Hk5q72AtkKqpgtlokthMwfu7jmQ+xhBqpqTKIepB9xhZ
	yneWNpbAd3zsItw3SHaMvretXA8+qaOYKNdIy2mbHY6etbfVU/MT7PT4rI2duJf2
	SObadpunqBBBfBBH0bcskN2hDOlTjn+dmhWIx0Z9FnqRYEARekOL413g9Prd2gAf
	kws3L6gGJE9ofKW/2qGu3L8D/L9n+jOo/8oGUM1LSbYoUhcQxOEfeMqBDH300VMU
	kNoC4WkxuLNNlJj5+5KRd8r6O+yNS22qEK9drDas3n7Wtji4lmrhWGPQq3CnQ6rS
	wA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fujcfhv5p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:51 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0e702df8so1120051cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869570; x=1786474370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLyblFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=;
        b=Gq76DURvkUah6pp9xCtITxytA84fCAS605f1jAUyM56T/vhN7GNlkCFvqDsZsN/BSz
         AgtQrOKDXjO5uJzCzAkfLJgWotk8dO2Qx0yA4ED4en2OpAZ64qW8S0fG/2sGoqcIgu8M
         eI/uq6YSWFuf8n+3UKIVe67gXuO/BGa+tA58C5UzSPGMgacPhzEcteUY2+41SW6VDdjq
         B7RhTH7fK7ubwBfEJDogUq6E/bHbx8tvp9ivk0/wTmevjliWqupFOWBA8Qvu3FzUiAnc
         bd86Ficp3xNVxgAIjg9ZRToKHCqETv/8AZMnervNNjZY8utgDL9NlWlaB7yBZqJN0Uil
         T29Q==
X-Gm-Message-State: AOJu0Yz0g2bLq+eZU6YqhSXMwm3L5SOliIT64HUlgsYDQn9USjTml/QJ
	Mtu30LV+Frs/6jkNVjTwRiz385b70vSz+DodypbX8mt327WHPaU4G0XNbGO+nXQLa5riQBZpMWZ
	+klR0tRQP6GV8HEI6zy6r0PfoKoNQfFd3O3uXUYfZas65VmjnN4QSf0586BY=
X-Gm-Gg: AR+sD10aRjgsxkEW647upS7lerkXdblLKmBLtPu78RjfM53NwAyHOOi5NcnogecF19D
	QoTG4CWRJG2VX0RKJ68s2JjRwDt8P1j+SYe9zmIpZaa4lBPgW3sJYRphRpBvtts94xgm4nph5MZ
	A8XXM9SGSSoQPFLW+gnskfouP673fSRo9hRjDEwkGMX1+TLjnxi3vrtUmke6SEH8W+2YtdCH2AU
	nm8s7gvVpjLw9VrBzCD/GlbGYHAK0PzjIidHlPojwOtpRI2g078mhKEXzmn55KurR4rKAb6Lm9/
	6771XfRFys/PDxvUUMRPqnq9xnMTMnyh3f0vznn0qIMvemXHXeewisourUYvKKaNAxfA8+YUNJ7
	Csk6lc0PF
X-Received: by 2002:a05:622a:345:b0:527:6dc7:5c5b with SMTP id d75a77b69052e-52ce61009cfmr11185391cf.21.1785869570486;
        Tue, 04 Aug 2026 11:52:50 -0700 (PDT)
X-Received: by 2002:a05:622a:345:b0:527:6dc7:5c5b with SMTP id d75a77b69052e-52ce61009cfmr11184811cf.21.1785869570010;
        Tue, 04 Aug 2026 11:52:50 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:49 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:17 -0400
Subject: [PATCH v2 09/10] ceph: remove ceph_fscrypt_pagecache_page() and
 ceph_fscrypt_page_offset()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-9-81f0ab065284@columbia.edu>
References: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
In-Reply-To: <20260804-remove-wait-on-page-writeback-v2-0-81f0ab065284@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1581;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
 b=ymFYHbrvN5rEjeaHcX4tJ/TZFBIdDlWxKA60/JN0KDJrq2/K4VZWWR2AOJJsHb/WIAfLsRBdE
 dVh0f4m20VEA7/0gLk/zQLeySGdoHYncfupyZbHlWLadTzarlMg/B7k
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfXwVHqAIBtO7Xt
 OvipDR5XdfhOIRDcG9lS5tQG05pJawbWhUrlD9cby5U36M5zYYYKYrl6AzGrvtE5eM1swZFqCl4
 nF1C06Szg4+O8qPqESMOMSSoTz1vWVyTRBn9X4skqYpJH3rwQjkKRBF0vzs4+HeQsA1jusZE+AB
 Txr9Im/crQZdgevlbJkQ3riDMI9spQnDbA52bPIba+MeMMna5/ApUlHWgOrj8ABXsaxRBjdT2o5
 IMsIW/MULmjO8Nhug4fn9vwx2wXp/dUv6Xv9LPHqMQGbSKbuamQtfr4+DnLRVtPwBzUfQXmm/pL
 OTGFRbXq0SW+xbCpl+yAruP7jyBEvCbwcvM1f2uE8d7B9g3T9gZsPJJAXxA/5m599w1Acl9Ww1q
 Keju2JUQlagPz2KZ0qsQGDzwdueczodui9drjKsjwYqlmJng0/tiEq1g8WZs0uL00pxBClK+8SU
 2IDEpvGYh3LPOE4FMgQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX4cY1Ar2vmSSv
 /nT1jIdd7i0+3+m35hfMbVcoZE6EV8OgiWufrHnf8bqbx/0QkTPzyv9zZWS03XinlmQwp1g3n47
 OfFN8oFgLqWjfaFX1VgC1U6TTnENuffm8nI/aJOxRPs4cfMItiom
X-Authority-Analysis: v=2.4 cv=efcNubEH c=1 sm=1 tr=0 ts=6a723503 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=jfg2DRd2ap2c96lsYj8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: cYFXjpOPQxJMuKkX_VRTgFVCklvJV2jE
X-Proofpoint-ORIG-GUID: cYFXjpOPQxJMuKkX_VRTgFVCklvJV2jE
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=10 malwarescore=0
 adultscore=0 impostorscore=10 clxscore=1015 bulkscore=10 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040152

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

