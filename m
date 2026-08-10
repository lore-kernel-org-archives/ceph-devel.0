Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE2B401A00
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371707; cv=none; b=q4knhkzWiNInuKosPtU5u4WXkaQUqZUmRZOvoQcu3dUZ0CXz2tm6y0uW74pE2heRSDbiyE0Xe5/RfnWAtFdwhRzYktE/URsp6FvJWtbRBDJSbi2VYVLvSYbFBpGKhRape4qfaLu8BOX8DC+1LtQQzRklc9qSVHk24c+H7dDTmxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371707; c=relaxed/simple;
	bh=nPmPX7TOd6iviTDoGDogGRf3WQ6WG/tn7FBA7wKc8Cg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UoRT3OPlhcXlEGxs99c0ORmGO/2HlItc+FYjvj07ssaHV+97HIP1ycsWZQ/iSLhXQy34lqFfRKxHVrLGUngXigibthM2N+u7CHOT8h2VudX41WrfvV7SlmFjbynA7O1PmMekZg7+tyeajYj43Rc7nSjCfb5cEK/fbrNmj9H1Ddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=JRWSYZBC; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="JRWSYZBC"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACaBSA3194268
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=S3D6
	qH/ZmLhiW03zXnR3WbvGewlE3ORw28iMnvFcpFU=; b=JRWSYZBCu8mCmTGWvbvU
	vcg0D3UlltsT26b7Dm8dsoBNf7JUve2Rf3wjD1IGOE5C9j16pqyNDU0ezcYckvwc
	D3Waz/SlkjxnyGgW33tX+qEMIzPzxINHd5uVbzU+cUrZAbcWnmSr3EnYBtYJI0o3
	ERZ5M42fdtlYu6dz7fRDYPZioR89JsquAnO5/OtDICrbd9VXEXfH5Xnk2KEV2SsW
	CLLp/Hje3WnV1q8CXfs4PsWzBTDli793kkT5BR43TwtTuTHTFNEvkFGzJuA3Uq1J
	swB9IoY0ic6g55WRvljs2HHbAugTMQ3MF97vNlXzv0SK8utjBw+zMceq+dy3G4vc
	JA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fy29132en-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:29 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51ebdfceddcso24512001cf.3
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371688; x=1786976488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S3D6qH/ZmLhiW03zXnR3WbvGewlE3ORw28iMnvFcpFU=;
        b=bbC4D1al6hhFHt6nqqIb48aPmheFjKx2LR/wVYOHZOP1P9mdQswxhHCv0UTcchaj+R
         D1PEJJ+kbvVr79DxkmdeH6q8ZVLm/NoWgcSs3oXF3McHr5TBWzcYH25wQskEZlp7YOEU
         Xe8FmmWTKEe5EFMEx7rpukDz7N+Q5oqAnCtjV7IrXkVgypb0FEMFP7N63rrJ5YaJEdcf
         KXn8JE4sszp+uMeYCgdoGqXl91FCX3CLeYyLNWMt1Y2coPXymdBDX9EhdWs+kXt3j8Mc
         yDiphmq8mw2OH1Mx5jJ69jrmQBr2N4TDfSqnfinehct1m64LOJJLWMQRA4ANIY50DJXO
         9xOg==
X-Gm-Message-State: AOJu0YzWm6xRMVk5XhbvRZ4cU8KgXHdAzFCD8LviZ87TDj74OmzMat2S
	ikmakZD0/0ed+B/ZJ/tcXKI6gZYzMcWunQbmoTbvTQbm4iI7F11w5fDafUERNsofs9OiCYjW+su
	eqWYfRtFvzWiXRgPs/Gi8Thd5VVN1Y6szRZ7aVs6pJX+b9JJ6fkjo4kPs9UY=
X-Gm-Gg: AR+sD11BhwUUDlN29EccAld4mqN0ixFjeEP5KsJJejE5F5wTMkUVIjmESuGCC+E+XhH
	Mn+RwWV8iNBGzGMLvR7OwSl2zsUXCMdYihG9hU3NhqE3vrPLyNrFVDr3CgumTiamTsJ3k+1eido
	YN3K4JBNQRbfs3b3wnVrUCwg22fo/s8BdT0eUOg/0BygpIfGpnnm0PqRZyBljFoBeUULsHbUTjR
	42vKoZJL7JWn68qOC86jJNzA+fl6VBxVPnahg2NP5bS3yz0AjeASK/UYUeb/8dDpKWxQ6TkoEed
	UAhm6TAXSgFE6k72x6CSkoKU9mTv3MAxvOY9hLKqJ92i5FiXeQAw89MFAdM79MkVTfHtKcz9n+w
	62Onvi/J7
X-Received: by 2002:a05:622a:144b:b0:51b:ecbb:206f with SMTP id d75a77b69052e-52d4c10b153mr22589681cf.32.1786371688087;
        Mon, 10 Aug 2026 07:21:28 -0700 (PDT)
X-Received: by 2002:a05:622a:144b:b0:51b:ecbb:206f with SMTP id d75a77b69052e-52d4c10b153mr22588901cf.32.1786371687575;
        Mon, 10 Aug 2026 07:21:27 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:26 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:20 -0400
Subject: [PATCH v3 09/12] ceph: remove page remnants from
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-9-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=2482;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=nPmPX7TOd6iviTDoGDogGRf3WQ6WG/tn7FBA7wKc8Cg=;
 b=khqDuSvEeY3iayitcAW/vunwtinABTC4Duk+Il2kJMRDY3Nq/xhyvNiLwOwy1X/owlcNbZVu9
 Ak1lnHZ3pf+AG3RpWIeXjwYuSfobiQr4Gh3ucmIBMR06VcopR7ZiCb8
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 1sLrNCyJVPx574jSEq1_Ws5617Mxh-NT
X-Authority-Analysis: v=2.4 cv=aMTAb79m c=1 sm=1 tr=0 ts=6a79de69 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=vHg950cVU3XL5QtsloQA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 1sLrNCyJVPx574jSEq1_Ws5617Mxh-NT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX59xFug0aayrP
 SIIW9IYjBdttXsUC8thEDIDM+a9WgvgZJg03uFlm090ZKjmSxD0ZlK9AIAtRmzGgQda5O6XHabs
 nzNkFkDWtgCen8LdelTheEBGwrlOP6moj3PQdlKBVlxaa98AMmFM3Gg4ES1R/q8WZ/7gUAuIFia
 FCEYW2DnR9gqQASLKq2l/lUYuEX1eCeNIFBNzo8v6yadqLdUf8b8E/OQh6NV+ADVaSb4muJtQbM
 RRjss0qGYRPwDEuvG4IyCjPTrPEK89NXDnACRJJP8Cf1wTFEn5fqIu8+QTlWeXWWXJKrwKd5qgn
 frs4GPY45Q+2fbbvE6Ln3Pcdm1jT4G2h+6qDkAh5tPAuKRyJWIQ3EKImGBqMhIFJhlSnGaJz0Ur
 4jy2tXlx2TxSREHIaVyNowpixhzk1HHwe6eBrqF1EJ2IOogem//IoizPzkWfjM9faxpGIqKz9u4
 THtPKFRf483Y4HgDiAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX3TMGPuwaVFIz
 R2fS41FS4ggfN7XMW36J2pgMv7G7ZcB22oe0jUWIv+I8hJAtz/96FPSm9Iex0K/kJ9yg9V+w0v3
 W4VM1ITEG682NGIOQt403LCUOn9gR9ihFCsUmMvCrWd/jdxxUu83
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=10
 adultscore=0 phishscore=0 lowpriorityscore=10 suspectscore=0 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100123

Use ceph_folio_start_fscache() and only use a struct page pointer at the
osd_req_op_extent_osd_data_pages() boundary, which requires a page
array. This removes a call to compound_head() in
ceph_set_page_fscache().

This was the last user of ceph_set_page_fscache(), so remove it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index a3324da08123..ddb12fccdcff 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -558,11 +558,6 @@ static void ceph_folio_start_fscache(struct folio *folio)
 	folio_start_private_2(folio); /* [DEPRECATED] */
 }
 
-static void ceph_set_page_fscache(struct page *page)
-{
-	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
-}
-
 static void ceph_folio_wait_fscache(struct folio *folio)
 {
 	folio_wait_private_2(folio); /* [DEPRECATED] */
@@ -589,10 +584,6 @@ static inline void ceph_folio_start_fscache(struct folio *folio)
 {
 }
 
-static inline void ceph_set_page_fscache(struct page *page)
-{
-}
-
 static inline void ceph_folio_wait_fscache(struct folio *folio)
 {
 }
@@ -743,7 +734,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 static int write_folio_nounlock(struct folio *folio,
 		struct writeback_control *wbc)
 {
-	struct page *page = &folio->page;
+	struct page *page;
 	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -825,7 +816,7 @@ static int write_folio_nounlock(struct folio *folio,
 
 	folio_start_writeback(folio);
 	if (caching)
-		ceph_set_page_fscache(&folio->page);
+		ceph_folio_start_fscache(folio);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -845,9 +836,8 @@ static int write_folio_nounlock(struct folio *folio,
 
 	/* it may be a short write due to an object boundary */
 	WARN_ON_ONCE(len > folio_size(folio));
-	osd_req_op_extent_osd_data_pages(req, 0,
-			bounce_page ? &bounce_page : &page, wlen, 0,
-			false, false);
+	page = bounce_page ? bounce_page : &folio->page;
+	osd_req_op_extent_osd_data_pages(req, 0, &page, wlen, 0, false, false);
 	doutc(cl, "%llx.%llx %llu~%llu (%llu bytes, %sencrypted)\n",
 	      ceph_vinop(inode), page_off, len, wlen,
 	      IS_ENCRYPTED(inode) ? "" : "not ");

-- 
2.39.5

