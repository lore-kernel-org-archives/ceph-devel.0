Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8903F8231
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786371696; cv=none; b=RQizkr5VNCeAaro3lWTWEA1335J+a1fvbLsr+K6OZl9gSZtN6lO74Yv3oh3RkX9CBcVxxpX5hteTdBYk0oxVf9UHOhhrUiCX+i74umKy+p7PcgUQwNimSZz/0FGiZRdziy/AyIQcjHFz+d4AeASVEx6H2qNtUYZdi+5vU8qsfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786371696; c=relaxed/simple;
	bh=kLEOqEnFcXW+rNVmQEljA3h0yllVd5ca9DQ3khlYlWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GPm5GE1J/udCIswaNrzzyWvo98/AOgUR1E1MY9KdRL8jdwxQs1RBpUeI7vz/f/tZd1Pwibe91SDtmbrnLWGPht/KqODSOTueqvRXos3UmJY8xovHDhtA6XL2UPqQrXEQ/OVB+zpr0daIImf0p/rbDFToHtdPGMkk7jfIDewxp5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QE29lpQB; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QE29lpQB"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACa99L2990304
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=9wYX
	/ZIYKVfQPG27uMx8tOqEdGsdSAkMZMuyFrH1L8I=; b=QE29lpQB/ULYlNngi21a
	/hTWjHq6AZmD1jtPW4qIsTEUVkjzLRzyD2DepfK0JzhyI7UnmEptrsJ2EM1Jiatp
	930l2Adj9Cl8YlIXCq8v70vsP4kPoYlVYrCjZhD7o9N/Hg5Hawttp8xS1pxz5yyA
	tU0Hfq5fWnNyb2QXDXQW//vSN9M515bDPdIKyXQ67MfGCz63VTGRJlhEumOFuhXq
	mveUu3P3jcaaBXDl9JZensPr9NK+G+tKVBC8MLzutth5TpqpZLVlicpuw35fn2Ww
	fdUiRmfKanF+tCI1U1Da8edHrJKxx4LyRA4ArOgQi3zLi1t5TGtiFFWlnjHOlt9B
	Gw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fxykwujg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 10:21:22 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c20762d21so25726391cf.0
        for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 07:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786371682; x=1786976482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9wYX/ZIYKVfQPG27uMx8tOqEdGsdSAkMZMuyFrH1L8I=;
        b=MQLYidwD1B5DIPuMWc91hdtmjGYw7pTbBLipUHfiYjKhjm97QAV+6TmtjPv2/jCppI
         kktlEh294VQIp6nRftdyMVm1jUSNCzHLvuYrba3/hEcdFDWR030/1ia/93p1uhrQ5LgV
         Rh4rbIDfnaAjIGQGvrMb3ZfOliyZLna22E5P+VpWK03q6gjEbB1WgFzz/X9mrEDu/pGo
         EmxDJofsJxqqqNtaEi3UYEtlze4kzowktXvYxr0dYi0bFN9WHstxAFu5IlWuobIdbTzZ
         fq6g+FypZNCj/0mTkpGJmaFKwuHrjTtQCU74W6e2qGP54OSf3pLOI/UsbrzgSvsBj+pP
         Q4Og==
X-Gm-Message-State: AOJu0YxcVyId2g6re3tX90881Z1GeTJVQ4M1DMYELT2RmmOIwaFTUgB7
	sQfnkfICsDK4tkyTpdDymPDHoXFlAltqyMfcTB0dirwpifz8Gmw1rM0+mg+Vta931oixPQmJUrh
	xw0hv2ayKIYnMuI9s6l3I01u5XBVoI40j/ISdfJfDj2a5TZTSiwz953E1zq8=
X-Gm-Gg: AR+sD12gaVSymvLgX4uTp3YuwfJM/EYnasfhCZu+h8mY4Snl65sCNearC5mXhWtXYfE
	NBmbDXY/cLR7INqsOcNv20ofD+JklTXARGeCbrhjq9vfqOGWMCwhf0+5IFFFGIo6YTYa1v7yDih
	xzBi1jUP9ctQrquieQjUzSO7DwGu8bKltGsoDh1q1kIgmYFJKhM2JcBGlvO5nvceeNqJG+t4FEc
	6adRRyG1bvmSRMhqWbK2t51xZpcHKM23be4wAYTsazDKeITW9ZjnwvaKXVxwO2lbPWZJR2ZXBDA
	OZ5OX2w+GRWYZL69j/i+3ZDN2b+rOek4kU4gs5cCoAIpx6tpxODJLq/YMZsvGUqsI8af/cllBfV
	3w8e3XIit
X-Received: by 2002:a05:622a:58c8:b0:52c:dffc:4645 with SMTP id d75a77b69052e-52d18e1a66amr253262371cf.7.1786371681878;
        Mon, 10 Aug 2026 07:21:21 -0700 (PDT)
X-Received: by 2002:a05:622a:58c8:b0:52c:dffc:4645 with SMTP id d75a77b69052e-52d18e1a66amr253261341cf.7.1786371681258;
        Mon, 10 Aug 2026 07:21:21 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48002145589sm37383983f8f.1.2026.08.10.07.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:21:20 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 10:20:18 -0400
Subject: [PATCH v3 07/12] ceph: convert ceph_submit_write() to folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-remove-wait-on-page-writeback-v3-7-dd7531704f26@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786371655; l=4661;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=kLEOqEnFcXW+rNVmQEljA3h0yllVd5ca9DQ3khlYlWQ=;
 b=joNh9X5mUvffrlxkKTmBkr0iWmzW7a5lLjSbuFRThbu6aArrCyt6TGzZNH/GWLmWekE58e/D9
 Y/+qkhPxIWUAoYE6Mj5KUz7ZnB0M9pwSraQitcVWKcL1lN5xiSjMjtw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: DNEyNtcANUD7k2GTM7EpJZx-HA0FElw0
X-Authority-Analysis: v=2.4 cv=S43pBosP c=1 sm=1 tr=0 ts=6a79de62 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=zHmcO6jMd5r4EZ4U0P0LQg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=RfODlEta0-z8xtihUo8A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX8tBzrTE+dqa3
 dUVd0ObLuSgr6TzQuIwebzqQP5FkztiFJnIThaGiXHJzLz1Y1Blpm/rMEZ18R7P3HE5hZc1pRCI
 kHIy02SZ0GGb915QjOtljvGI4Vg+GisULpAT3aEFQbRfC2TtnrIunf6B1YghHnL8b5qOfv3vdoI
 XIm/YDAuYZ1r2TUUzYOCwO3DmR1V5ZCzX9Cy3LXDBl5BTMRw3sWK08HDKwcNOc5TzkwTwN/DnkV
 JA7UAfr8wnTLfcBjWOyK/FCzvGmOUWgPA7bIh/i4uEVHM/O6YTT18d2yIShR3tOqmp6FZDh7pSW
 H7C05X7Gh3agEl/Tp+MfA+yaBxrOCxHm/4VZOQcS1kO/ylIq1k5AiENA/aVttNWcBUnMSnCdLSt
 1AmygOJSQsM0HydfRXNEdAWNKPOoeiQ//C7hKLxMdVtEUp/VTXj2tYuCd/T8jW+yajOTZKpsBzS
 LgCbL8zQrcGyur+OdUA==
X-Proofpoint-GUID: DNEyNtcANUD7k2GTM7EpJZx-HA0FElw0
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyMyBTYWx0ZWRfX0Rv/ezeeu+KD
 4hcmAzbgpHG9EZKFv1Syw9XsB+qRwrAXZ4OtN/OguTJnRM+CA2OntDxhL8aWDs4dYbZsgMiwe4l
 3uuA9vg4kZbdKB7GYb9m/QFqrC+HQksyge91MVX9LKFt0xI752H2
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11870
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=10 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=10
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100123

Convert the request assembly loop and error path in ceph_submit_write()
to folios. This drops ceph's uses of the set_page_writeback(),
redirty_page_for_writepage(), and unlock_page() compatibility wrappers
in the writeback submission path.

Add ceph_folio_start_fscache(), a folio counterpart of
ceph_set_page_fscache(). The remaining caller of the latter in
write_folio_nounlock() will be converted separately.

In total, this removes eight calls to compound_head() hidden in the
page-based APIs, while adding four explicit ones via page_folio().

Note that get_writepages_data_length() must still be passed the
possibly-bounce folio, not the unwrapped pagecache folio, as it checks
fscrypt_is_bounce_folio() to round encrypted lengths up to the fscrypt
block size.

No functional change.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 28f0b16da2b0..a3324da08123 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -553,6 +553,11 @@ const struct netfs_request_ops ceph_netfs_ops = {
 };
 
 #ifdef CONFIG_CEPH_FSCACHE
+static void ceph_folio_start_fscache(struct folio *folio)
+{
+	folio_start_private_2(folio); /* [DEPRECATED] */
+}
+
 static void ceph_set_page_fscache(struct page *page)
 {
 	folio_start_private_2(page_folio(page)); /* [DEPRECATED] */
@@ -580,6 +585,10 @@ static void ceph_fscache_write_to_cache(struct inode *inode, u64 off, u64 len, b
 			       ceph_fscache_write_terminated, inode, true, caching);
 }
 #else
+static inline void ceph_folio_start_fscache(struct folio *folio)
+{
+}
+
 static inline void ceph_set_page_fscache(struct page *page)
 {
 }
@@ -1448,14 +1457,14 @@ int ceph_submit_write(struct address_space *mapping,
 	struct ceph_client *cl = fsc->client;
 	struct ceph_vino vino = ceph_vino(inode);
 	struct ceph_osd_request *req = NULL;
-	struct page *page = NULL;
+	struct folio *folio = NULL;
 	bool caching = ceph_is_cache_enabled(inode);
 	u64 offset;
 	u64 len;
 	unsigned i;
 
 new_request:
-	offset = ceph_fscrypt_page_offset(ceph_wbc->pages[0]);
+	offset = ceph_fscrypt_folio_offset(page_folio(ceph_wbc->pages[0]));
 	len = ceph_wbc->wsize;
 
 	req = ceph_osdc_new_request(&fsc->client->osdc,
@@ -1479,21 +1488,21 @@ int ceph_submit_write(struct address_space *mapping,
 		BUG_ON(IS_ERR(req));
 	}
 
-	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
-	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
+	folio = page_folio(ceph_wbc->pages[ceph_wbc->locked_pages - 1]);
+	BUG_ON(len < ceph_fscrypt_folio_offset(folio) + folio_size(folio) - offset);
 
 	if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
 		for (i = 0; i < ceph_wbc->locked_pages; i++) {
 			fscrypt_finalize_bounce_page(&ceph_wbc->pages[i]);
-			page = ceph_wbc->pages[i];
+			folio = page_folio(ceph_wbc->pages[i]);
 
 			if (atomic_long_dec_return(&fsc->writeback_count) <
 			    CONGESTION_OFF_THRESH(fsc->mount_options->congestion_kb))
 				fsc->write_congested = false;
 
-			redirty_page_for_writepage(wbc, page);
-			unlock_page(page);
-			put_page(page);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_unlock(folio);
+			folio_put(folio);
 		}
 
 		if (ceph_wbc->from_pool) {
@@ -1519,8 +1528,8 @@ int ceph_submit_write(struct address_space *mapping,
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
 
-		page = ceph_fscrypt_pagecache_page(ceph_wbc->pages[i]);
-		cur_offset = page_offset(page);
+		folio = ceph_fscrypt_pagecache_folio(page_folio(ceph_wbc->pages[i]));
+		cur_offset = folio_pos(folio);
 
 		/*
 		 * Discontinuity in page range? Ceph can handle that by just passing
@@ -1553,12 +1562,12 @@ int ceph_submit_write(struct address_space *mapping,
 			ceph_wbc->op_idx++;
 		}
 
-		set_page_writeback(page);
+		folio_start_writeback(folio);
 
 		if (caching)
-			ceph_set_page_fscache(page);
+			ceph_folio_start_fscache(folio);
 
-		len += thp_size(page);
+		len += folio_size(folio);
 	}
 
 	ceph_fscache_write_to_cache(inode, offset, len, caching);
@@ -1569,7 +1578,7 @@ int ceph_submit_write(struct address_space *mapping,
 		/* writepages_finish() clears writeback pages
 		 * according to the data length, so make sure
 		 * data length covers all locked pages */
-		u64 min_len = len + 1 - thp_size(page);
+		u64 min_len = len + 1 - folio_size(folio);
 		len = get_writepages_data_length(inode,
 						 page_folio(ceph_wbc->pages[i - 1]),
 						 offset);

-- 
2.39.5

