Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01548A2C6
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869574; cv=none; b=k0TJ49CYzBQa2ORSqZZqAUpAGZCG7SIZsmG0AMZFLUtuB7LDpgvTGN/fp+hWWVmkEhbm1iYjdIs3L0HDBDdxRsR/KcGrwEldNcN3v4GVoSvTGtO99U/q4G6gg5Q+LGoWInLW6fgkfGiH63fb40TaZKbO+gxCSyR21czh/YG0D0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869574; c=relaxed/simple;
	bh=500EpqFLV6KTsCK9vzHr1t9+N59E2kCrXGhqPKPlKoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TAFnfVWqWYnPpOZEbTZJhienvAfTjkb1H4w63PFLp4scybDEW4baFQxbRVPUV7ghqu5M+tBoYLEyti6/LNnZnvKQntXE+eGjqhcIylhtKWMsDjWUQAnJFI24GW828wFdgojVmzY3YOmU8PtTsJgPKposLNh2wDLJ0gjnsk2/ee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=TPTrIWS8; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="TPTrIWS8"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYAkQ1999451
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=CnNA
	DUinRNwat8S2OMUK6WgEOXqYRvhZzhuvbRl7oDQ=; b=TPTrIWS81PZQemSMf5t5
	USmw4FdbDjyN23RSCrdvIHFD3UxdDzJM2cuFbsGXRn2yYlsFMmIjuAEPYcHTLZo8
	r+NXhE6fYTMMXA59qf892/pQaTWOjgo1ucaACTygfBYnLdmAfcDyiCHIIzbHul1L
	Tpj6OzRAv+sHcT+Zm7L1xgKT31VyonHxG9et1b+U/3e4SpnP0HtQrZIWySFMSKRd
	cP+LRLaENEs4VsHRQ7ggn5EGtWpcx91FFZAKvwna3vKScKHLt9QGl+3KSo3C1Vhu
	pgYiG/Uft7bzf2wKit7jqnk0vGinskVKijo4mmbWqRonm9FrG0Ajl6MXVEygOOly
	4Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fujcfhv4w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:45 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c20762d21so1323411cf.0
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869565; x=1786474365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CnNADUinRNwat8S2OMUK6WgEOXqYRvhZzhuvbRl7oDQ=;
        b=WZJLk8oTdw/OvRcHHhMIPYGiFIgr02B/Hu9lo8i29e/jY+O6pGLLvDf5GmDI9XyyBD
         GOurxCODC/CZ1G07cxF7K99xnLPVzzHTgZoNHgTHdpjKo2CbUQ5GP6yDmFeqpu6gSnBC
         03KLr1XQBeMTFWElotb8JCeSswhuWvyRdTFFl3bZhvbbhyUA6ZBQ5xNEZ5mOtlS7V20O
         udYFHPUVFRsqE94xPtfrh6drJ8ZW1Y6N/q7KQvlmate/Y1y4CC8DfzCbW+wY0vwSq1xP
         eQ2hU5P397GkQ00YhS6rbSvWKwAdFhspK9mqIE9J4i5t+v1OdvXLQGHvYxepg05SnJ7+
         1IJA==
X-Gm-Message-State: AOJu0YzZHN9Y4Scxk15N8Q8QBWG7fiFUXQ/5xQU6EUOABqwoIUwJNFJl
	+v76LcK4On7wCiop9GIZKQ/EvPZB+l4ilKZ2MV0g7KvPcml5a9zFyzzt39CJPuk3pWSD3h6amNb
	Qg0aEGdVRxUnV5/MjI4LrYIpJZ5AVQz6UK7w1aj9WEujZmMr+7Q1YBVwCe6k=
X-Gm-Gg: AR+sD10kvQKDWpF2Y6fucu67DHXOANBf41+a7X/7FsAaHPf428IVaXy2gWs535zllIA
	WY1tsIxgGHLmQ/NVLjWxYo49iqRboIG8cL+/6Hcj4j+NKU4Hs/Gt67ZBAD0i1a/2KWWPt6w/vQo
	AsPjjnv0SMvu37wIoVLTKPy6u7+X1LaOdggSwceEuq3WqLl4S8UhcnzO4NRXMesqFQ/hJ/+k7Gw
	oEdms0hmtc2yYpA60WZsMt1NyWSBZD8/edOmnX4TpjNssJo1RhzcV5z5GmcHHtyxlBBb5h+pYQ2
	Bqc8a0UPS/fWh93STR5RVzJyiczj+F5uSx/S7zT/7HZ55TDwbf7ltSWEjwqGvx0wlh14L7iDpKD
	vOGAUCGE4
X-Received: by 2002:ac8:5e08:0:b0:527:f0a:ccbc with SMTP id d75a77b69052e-52ce5fa28acmr15090591cf.18.1785869564655;
        Tue, 04 Aug 2026 11:52:44 -0700 (PDT)
X-Received: by 2002:ac8:5e08:0:b0:527:f0a:ccbc with SMTP id d75a77b69052e-52ce5fa28acmr15090071cf.18.1785869564163;
        Tue, 04 Aug 2026 11:52:44 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:43 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:15 -0400
Subject: [PATCH v2 07/10] ceph: remove page remnants from
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-7-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=2510;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=500EpqFLV6KTsCK9vzHr1t9+N59E2kCrXGhqPKPlKoc=;
 b=UBXFoH6y7LgXHIhuQeQIAJrJ0u0TLtb+QPEwzLT3I8tdP4d68PDNx+HUqFw0HznkZYJXgc93m
 lkPyciv2BfKAqFjgWwF7vCQck65jvJA4ziPdSBfbfyDO+n229Fd4GIj
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX2X5f7DOXqRNs
 FZk31VSx/COSqgP7F1E25UcmApis0L5B3xD30BKMKU79+NJSGAx/F+R2oFZrS2ON6aX0dMBMSiV
 FCCDRwAevWSIXkBeYSUdfDyKBKp0puHQPIJxw3E/eomBqsfrxmJmW21LnU6PmOBRRH6wPHU+Ozz
 NGE6YTKlju8faeTI0DW843m4TfoE8n/yo6Jx0m2HKHESWV92O3y/rzhE2Tr4AaBmjHC8eNnQN6r
 C6FOAM2N4oSGZeBbUfRvD0/CFM4tIX2yjuHVahV+0wgJx4uqL9bcajwK6en7C9Cp7wz9zQHM0BZ
 E39szZUS36ku835YIVVHfxBEWE5zMYG54YtYo1wlMixZtEvvnZUfIcVsaNCKBF+D9VIftVS/GYc
 vUZEP5MzMXPZoycMMKyzA4IQDoMmrEqMZLPD6XKXfASoRYbhWmh90x83uDhBqYQdW4kb4kr5RI4
 Z69o850IttvsZluY9KA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX7Oogm99MNIJN
 EFoBiovEV8YMpCY0jsbujbABFqzqFuony4YnYXyvo64Fdf+cXzJkXUp6QWXUSmZadGw6+UgI4wQ
 miUmisBq0p4ZIhsKroMrZBWq+SWUEtaT7TWN47GKQt+mzZ2108e+
X-Authority-Analysis: v=2.4 cv=efcNubEH c=1 sm=1 tr=0 ts=6a7234fd cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=xhPbJxARXHWvbxRXPbEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Zh1w-Xp6ltexovuGqlosxG5jB6is2NRd
X-Proofpoint-ORIG-GUID: Zh1w-Xp6ltexovuGqlosxG5jB6is2NRd
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=10 malwarescore=0
 adultscore=0 impostorscore=10 clxscore=1015 bulkscore=10 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040152

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
index a96986c503bf..59e559bdfdff 100644
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
 static void ceph_fscache_write_terminated(void *priv, ssize_t error)
 {
 	struct inode *inode = priv;
@@ -584,10 +579,6 @@ static inline void ceph_folio_start_fscache(struct folio *folio)
 {
 }
 
-static inline void ceph_set_page_fscache(struct page *page)
-{
-}
-
 static inline void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, bool caching)
 {
 }
@@ -734,7 +725,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 static int write_folio_nounlock(struct folio *folio,
 		struct writeback_control *wbc)
 {
-	struct page *page = &folio->page;
+	struct page *page;
 	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -813,7 +804,7 @@ static int write_folio_nounlock(struct folio *folio,
 
 	folio_start_writeback(folio);
 	if (caching)
-		ceph_set_page_fscache(&folio->page);
+		ceph_folio_start_fscache(folio);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -833,9 +824,8 @@ static int write_folio_nounlock(struct folio *folio,
 
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

