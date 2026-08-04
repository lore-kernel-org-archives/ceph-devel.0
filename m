Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA664734ED
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869554; cv=none; b=MWO85vP2Fr+UXE8lZZiz8i6Hy1V7/Qmeh9vZjkbftizqDMWZ2tSgb4l+IrIE2N8EzKaKw4xBgJn6q04hM5Tll7rbOhOYFPYsFBfcol8x9xQzb1MepoEFeNW6gYe6IbE/37tsmqmORXCvi8/hfHYi/ZuMHkFrMoqRc8LQsOjwVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869554; c=relaxed/simple;
	bh=9zGm2Ur3Nw8t1fGAniDrK4O8Ro9h7p/uEv8uJfX+ZUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKDtojzi2gLYmWnEu2jDQ+c5Dizz+ZBB6nwF6Va5pyIZP13UH67giHkcSCqDnDI3CErV0iuw7AF+CYso/FTIOA5hdkQ0XSkjZ6WLaUsOdgoGZUQmFkOhC4LVnwbrz07OIf6zzu4cu2kWVL5aBeposxefX5tnslbAuG5vy1tFFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HY0pFEmU; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HY0pFEmU"
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYJ9L2227902
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=yedV
	j+u8P0Tmm47FPkrJoqBk2IvRgeJQ6pNoT7nNxrg=; b=HY0pFEmU2udRqNNtUDxJ
	9RSw/lY1Vy7TzmvBYQFFbm40N4EWHwXjduXKD6rPYdsd71ltw1pMGfLRlKg+A+Tm
	EeksvS+7yGHcIeZbpz3F5DcsvH4dB6uY9vtQfupd+eVglKx19C9VuMyTDCGkvwLB
	gniMiWuNavsOszMidxOzzU/aeuza09cTtZR7VTESvwda2biUIollaTjfdJiZ3dPE
	L5PMfaZONppi5iegiAmsn14rGXFS5Ij1b+24q9tudfiyTDVE7d6zTN/lW2/GFaT1
	Pl6n3xbk8eztta/yTTrL0tVMLE+xrrmnzNP2S7pbmok6hsdSwINqqHG6Ys2BASdw
	mQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fuhh7abp9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:30 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c01ff996dso1003341cf.2
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869550; x=1786474350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yedVj+u8P0Tmm47FPkrJoqBk2IvRgeJQ6pNoT7nNxrg=;
        b=PjwzIAbq+F/xYM6rFeJv0SrlC+J7QO+gd3SYrFigswEkvDNbg81s65scJ03K7X1bgX
         b/yqTZB2vJUJi5CWGVHanZXHMGMUzoYgU+x1HCWBf+bdI+a/iydYNFfv7jWRe7sq+oUZ
         H8jtvADZImln3W9z1zlDR1q2lmehvjH8bWCQkYNdoVupf8z2RGlE72n8o/ROW+EazOZN
         vIwAiez4O/y1j+WdDXxvPVlXiQgWbi61mEwBop2fkf8pOAsvXow1kE3czCNKQGlZ3muz
         pbw5pwvXG7sm2s3r2QnLRMRvXTEfrZ73nFCdvdx8GLxRaj/fsPFnyxQp3+DCrNx5+/nt
         zyug==
X-Gm-Message-State: AOJu0Yx/tgm+RljjlYRjLUPbpdmMxqjQA39R/0XuRqxxT4sDqFXco18B
	JmzoIpepd8NF3GiOs34foRXUxnK8aTh/uI/xvxINbHIfvOxcIwWnAKA30pN4XDCnt9uTt5JCJXN
	IaE6yIcunvqbPZ+FTcHe3fla/RJvW/h3oPWuKNmOMqx+KKdvurcL1kl048QU=
X-Gm-Gg: AR+sD13VSV7n0lP2v88bHre5BOslBbYW2YKpeX2fDK+ShrfKbhvIw9cbE65R3e9Xbyy
	Z1k+xuAgswt8VnAmYKoNl82BPQfPxKdgRTJBWu7VKaqvLvk12Cz5YrJK/nJVkVQJ3kHdNFiCZkY
	jE0qtCaRz9IuVOZCALFO0uA2XznZz8UYDKbwqkuXWYScSz8kcar/Yolnope7h4i1zA0lWAAR7b9
	9RsRDsDgpOeRQ/jLcOPeA+w8d06366O/MHL6bFk3CTEGhPNCWZyP2vL+3R1gf+Mcohd+ByuERBI
	S+MAsAudIAeufTwAAUMAy6lo/9JW2klliVi0gSjXL4xA3y2nHRvtxlQmgoxzCuCYu133MD4mLpt
	AtvW+MNmC
X-Received: by 2002:a05:622a:355:b0:519:8998:661b with SMTP id d75a77b69052e-52ce60c07c6mr12783021cf.20.1785869550472;
        Tue, 04 Aug 2026 11:52:30 -0700 (PDT)
X-Received: by 2002:a05:622a:355:b0:519:8998:661b with SMTP id d75a77b69052e-52ce60c07c6mr12782271cf.20.1785869549978;
        Tue, 04 Aug 2026 11:52:29 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:28 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:10 -0400
Subject: [PATCH v2 02/10] ceph: convert
 ceph_wait_until_current_writes_complete() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-2-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=1518;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=9zGm2Ur3Nw8t1fGAniDrK4O8Ro9h7p/uEv8uJfX+ZUc=;
 b=YhHy2DJ2mcWRFMayaQHzRWVDDTYASGlGUJSMGAN80QdBcHSVdXLZ5tByq7B/kPH+1jdGwugfR
 syQDU3doLFhB5JzGHt5ToPbjDwQSP/Ct8ZorKaIRSv2e2Bwqyj1AwU+
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX9ranEDhR1xPh
 jsdHcnHNdBBubOmciyUBRf5m9FKGGar+i2lxDyC6/SkKYKUIILApXp6ScCJlx5CQUacFhVATz22
 tmp0+m1cEXZODJ+FOy4hxPcwNWkvGPaxg3nUL1HQ9UJSySwGKdIi1iAyCSZuYj4uGpKL1qrAOlU
 L8u//2fodog4DaTNUlbAdOZmCWfuH5sI4o6sjetsKPPAyBuZujtwgFQl14g4ps23OrOUoeNvzUG
 vPFhIpy3ypaF2rW/XRKxUgF+qOoDO/RD4jwMcmaQ0peFpTCWEcMpOsswHy1NP3Wyz6SjhGmzf6E
 JTbCbKFUKhVhQQIt9gTnCmRugXTXWvvTejSUQph414zwk6gyqBBe0j2ukR4KgQcJ9J4cezx+JR2
 G2I0fIlE6ouKiqIOJZdfeNouiJkrgUMBotfyKCkUKN+khJoEb5hnvGIM1UMHwrW1kffHAlEHoY5
 aJSCuMcvDDUUWKtEYDQ==
X-Proofpoint-ORIG-GUID: 3Ukcves4dWgZkZec_kl3sbCMh4ulDkUx
X-Proofpoint-GUID: 3Ukcves4dWgZkZec_kl3sbCMh4ulDkUx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX21QY2LqfZghN
 k3dHB4LTv3AVcmmrdsGvR8hl06PHA9me7jjuQ1xOsgL1KYg1AGazp0neIX6hJNUDoFcSWIgDWzC
 J0sWtBoVbKByh6p53ngvO4z0drRWBwGCfTi6EYQNtEhoFS+bvT70
X-Authority-Analysis: v=2.4 cv=PYzPQChd c=1 sm=1 tr=0 ts=6a7234ef cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=jHxIr1HyPKZ_Q5_91PL3:22
 a=JfrnYn6hAAAA:8 a=oBeIbaJldBQvbLH65vwA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=10 bulkscore=10 priorityscore=1501 spamscore=0
 impostorscore=10 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040152

Iterate the writeback batch as folios rather than using
&folios[i]->page. Use ceph_folio_snap_context() for the snap context
check and folio_wait_writeback() instead of wait_on_page_writeback().

This removes one call to compound_head() and the last caller of
wait_on_page_writeback(). No functional change.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8347366ce5d9..967243f425f2 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1624,7 +1624,7 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 					     struct writeback_control *wbc,
 					     struct ceph_writeback_ctl *ceph_wbc)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned i, nr;
 
 	if (wbc->sync_mode != WB_SYNC_NONE &&
@@ -1639,10 +1639,10 @@ void ceph_wait_until_current_writes_complete(struct address_space *mapping,
 						     PAGECACHE_TAG_WRITEBACK,
 						     &ceph_wbc->fbatch))) {
 			for (i = 0; i < nr; i++) {
-				page = &ceph_wbc->fbatch.folios[i]->page;
-				if (page_snap_context(page) != ceph_wbc->snapc)
+				folio = ceph_wbc->fbatch.folios[i];
+				if (ceph_folio_snap_context(folio) != ceph_wbc->snapc)
 					continue;
-				wait_on_page_writeback(page);
+				folio_wait_writeback(folio);
 			}
 
 			folio_batch_release(&ceph_wbc->fbatch);

-- 
2.39.5

