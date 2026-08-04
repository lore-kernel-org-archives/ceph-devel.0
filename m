Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BA4908B2
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869559; cv=none; b=i2Is5hkRUPGOmjqnZZeL6X1CLPTehhiBCaFi0n//fPSg5go1drbzdIdwOJ7l7i7BVE3JONpPmuSZptCqhEYr0pbxM8HrVPWuwO9e68cajIIBCeBPO2iqn6bHukf+HQ6uV7FwmdQJp/aMSWJzVtLc7OKGgRR6SNGV8uxhx5p41XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869559; c=relaxed/simple;
	bh=ZLn4GmbBBs4DJzpxg5iY9HTTJ6Xur2Gxm1ww+3ec0uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOnKHH5qk/TI8YZI6B8IKeDOdW5uKtjHaG9jUwGY4mOFVUM8EYRctmGGEKltlAfZVhzcv665LvSmgGn++JmTSgN3woMVTRP55ErKYLmUymEdePXSNp6UWjhsOHoWuxAzkM40gZAKjUm/Hl0EEE9XfdWX9XCHR00aJjv979PVOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=orP4G7rp; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="orP4G7rp"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674IYAPq2213073
	for <ceph-devel@vger.kernel.org>; Tue, 4 Aug 2026 14:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Hrfn
	ottRt8RY51efcxtpgPFZmS0xvtqTx86D5p3Srj4=; b=orP4G7rpYSxdzMQRVI2s
	CNyB6CtqRdTN4aTJuVK04d5E17G1o69HkG4AzD6u25O7ICHVAZE1GAnPopsdyqlz
	iyEgK1W+d4mQrqW6wQPKmYyhwsDq8xaQ0BCY9MVXLQ7qP1kit5mu1YDzDB/zTZ55
	l4UTwwBxgv4xVduEYwJjWpcOTKOYEuVX8njCXBYWgkdbMzosk2SooZRuZ4Aui8Ff
	rRtRKXDjvsU3TSD/ENPpuNcIuTp/ZRmDHxxos47Q6wzAPrNS5PyC3txKJlhy/i9W
	HBzh8TqfoOMSESAk7aRsw4AZ5ZFn+Hw7ybz19RafXxccwpo4KILa6kXk3ys1Q2wT
	gQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fukgqs6b4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 14:52:36 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1c7f135bso1950631cf.0
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 11:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785869556; x=1786474356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HrfnottRt8RY51efcxtpgPFZmS0xvtqTx86D5p3Srj4=;
        b=IaC3MsCsHIk/4OghXy7PacgrpwpgiflpOVSGCNhYsBwedCfQIhWaPl9voBRPvQxsPt
         xLo54ZsQCJewY7GZe/5Baf5ClzFUKz112y1oKxs09f675QgvbdIn7321+X11ARg8kAxu
         pJO96nXl5mknxK2qTY4LZxogUrL/6plgvWDAc5PMown2jriLQ3EEFJ8V3+onPsrSj/u5
         FqwSDUm6IC9vQo7aYCOeel2tuR/poaNSOFQ0xC1F9b2zpDvw42OvPotQlmjZkZXxJRFH
         2ZcP0MfL9vA5mZNdqaS63ge1vSowHpwMQShMKLhR8+yfoSoJMgUFBVs9AV35da2vZyMQ
         t+xA==
X-Gm-Message-State: AOJu0YxASginXuBwJyeaaJVfWoPn/b85i+Ts5hGCm4R3P9eJi3veThMJ
	+fbvqs7qXFO9Ua5bl9wlYyc36QyRGNEfGDcyRsA+q99Ut5hsUEKMpbGXipaWkMwVnKdDON2Sh/m
	Aq1GxvpUl1eGNuCZBrdvObzIiVrQ8JMiRWASPyL2vvvjUvPpQ+wjx+zAO/yI=
X-Gm-Gg: AR+sD12oH5si4CnG+dkdCZQW+UMQYQ54QxIC2Gc+6VKvWhWbVVbPjOhgYNlN5KyLNrR
	8HMKDjvRI7CaDR/wMzgubvxhZEVS1ZyqrDXc0QFypCTarNAlvkO2KiBA6D22HI7tDZQg48WsDFC
	9erP9BZMAwG4lrhxbd1NbQPvdTuQklfyhG4MgoScHSSl74cbk0Qe35pCI87lWgAHmmX251S5fNx
	2R+vTkbQylEl+OVo41Q2BRE/JAfXQJ8w0uc9/05nSG9Np4kvhcqZZ8MqNltfdwnbTnit995vdlA
	1L5PeCSlYH0bffKC4v5EZVVeV/rdSxAsTPL3RaQvNElohQ07xCXxkwW5eWi5wc6Y1hoCP+pSM4X
	WdMeIw3HY
X-Received: by 2002:a05:622a:4d89:b0:51c:22c5:daf5 with SMTP id d75a77b69052e-52ce62c6cf6mr12809331cf.38.1785869556124;
        Tue, 04 Aug 2026 11:52:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4d89:b0:51c:22c5:daf5 with SMTP id d75a77b69052e-52ce62c6cf6mr12808671cf.38.1785869555591;
        Tue, 04 Aug 2026 11:52:35 -0700 (PDT)
Received: from [127.0.1.1] ([77.137.77.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d7fsm2313275f8f.20.2026.08.04.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 11:52:34 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 04 Aug 2026 14:52:12 -0400
Subject: [PATCH v2 04/10] ceph: convert get_writepages_data_length() to
 folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-remove-wait-on-page-writeback-v2-4-81f0ab065284@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785869541; l=4666;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ZLn4GmbBBs4DJzpxg5iY9HTTJ6Xur2Gxm1ww+3ec0uo=;
 b=oth0Nf14fRObazwrdx6pe7EJlKObc8Y5tWmZKRvFAWjLufDheiwH1ZkewJyJhwIs0DUt/Y4AV
 KJKOHQot2zAAS1u1iOv6yf/vIMfhsOm9h8XHLJdtoZigFowDlJQvo/J
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX36rCUPUXscCZ
 Tgk18ZB2Onp5hRjM4i6ELyT/uvB2LL4LzJPiMVqmA/Rd/Us1O9w7VwS1EIYK9ToutuBHBUuR5xA
 L8hyOIEqDMfehs63n5KUjvXVHphz5XmhHDAFiqUW5cM+/tsAM5sQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE1MiBTYWx0ZWRfX8FV8QhUDNt+k
 50t+ZsXhBnfikE9UCkmffifUUCf0C9UxrwrL3voMwubcSogxwrqKp0yEZZhdvVME2BxZFHpSuBg
 2Qq7wUmU9Yn8A7rClW8ah1mJgp7eH/7veBQ2HfKWIwgxDTnSKqrt5IqVkZnKuQNLeqIa0YRze8z
 phnCf7nke3RvMXZX0R4ApRbuqgc32WgTMiEE8STYBFSZUsiPS41ZYsyVYZUMbasg/p4o3eSzcNe
 269h0rUKpU6ruMQf7f0T6jFBoIAurUw9IQcIZyzxFUO2iz0/OO9bhu9B3MPVEfn0JdxkLT9UMP7
 s9u4MVQHEnRScmMjO0jqi4/KWwZKj83EYe/C2wyiJnSGNJ3YLRj9JFuG5wc2Fp89cc+VWb3xww0
 mnA/xIa3XEPCM7sM8LBZDi2BPb0uQqh2UOzsTFpfZ/8DCvVW8Zgp5FHygjdDMmxt1v5vgx6E3Y4
 /Gj9qV2WPVFA8gYXcqg==
X-Proofpoint-ORIG-GUID: Wpf_fiJ4qBBJJr4rJvXBsVSvqBVE_yse
X-Authority-Analysis: v=2.4 cv=X+Ri7mTe c=1 sm=1 tr=0 ts=6a7234f4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=j1J1DEHOHTVaJYOjuVnKiw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=4S3DF5rXG3rfafK4-1MA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: Wpf_fiJ4qBBJJr4rJvXBsVSvqBVE_yse
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11865
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=10 impostorscore=10 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=10 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040152

Introduce ceph_fscrypt_pagecache_folio() and ceph_fscrypt_folio_offset(),
folio equivalents of ceph_fscrypt_pagecache_page() and
ceph_fscrypt_page_offset(), and use them to convert
get_writepages_data_length() to folios.

This removes the last caller of page_snap_context(), so remove it as
well. This also removes a use of page->private and a call to
fscrypt_is_bounce_page().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c   | 25 +++++++++----------------
 fs/ceph/crypto.h | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 967243f425f2..c81e9da42df9 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -29,9 +29,9 @@
  *
  * There are a few funny things going on here.
  *
- * The page->private field is used to reference a struct
- * ceph_snap_context for _every_ dirty page.  This indicates which
- * snapshot the page was logically dirtied in, and thus which snap
+ * The folio->private field is used to reference a struct
+ * ceph_snap_context for _every_ dirty folio.  This indicates which
+ * snapshot the folio was logically dirtied in, and thus which snap
  * context needs to be associated with the osd write during writeback.
  *
  * Similarly, struct ceph_inode_info maintains a set of counters to
@@ -68,13 +68,6 @@
 static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned int len,
 					struct folio **foliop, void **_fsdata);
 
-static inline struct ceph_snap_context *page_snap_context(struct page *page)
-{
-	if (PagePrivate(page))
-		return (void *)page->private;
-	return NULL;
-}
-
 static inline
 struct ceph_snap_context *ceph_folio_snap_context(const struct folio *folio)
 {
@@ -692,7 +685,7 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 }
 
 static u64 get_writepages_data_length(struct inode *inode,
-				      struct page *page, u64 start)
+				      struct folio *folio, u64 start)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
@@ -700,7 +693,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 	u64 end = i_size_read(inode);
 	u64 ret;
 
-	snapc = page_snap_context(ceph_fscrypt_pagecache_page(page));
+	snapc = ceph_folio_snap_context(ceph_fscrypt_pagecache_folio(folio));
 	if (snapc != ci->i_head_snapc) {
 		bool found = false;
 		spin_lock(&ci->i_ceph_lock);
@@ -715,10 +708,10 @@ static u64 get_writepages_data_length(struct inode *inode,
 		spin_unlock(&ci->i_ceph_lock);
 		WARN_ON(!found);
 	}
-	if (end > ceph_fscrypt_page_offset(page) + thp_size(page))
-		end = ceph_fscrypt_page_offset(page) + thp_size(page);
+	if (end > ceph_fscrypt_folio_offset(folio) + folio_size(folio))
+		end = ceph_fscrypt_folio_offset(folio) + folio_size(folio);
 	ret = end > start ? end - start : 0;
-	if (ret && fscrypt_is_bounce_page(page))
+	if (ret && fscrypt_is_bounce_folio(folio))
 		ret = round_up(ret, CEPH_FSCRYPT_BLOCK_SIZE);
 	return ret;
 }
@@ -1565,7 +1558,7 @@ int ceph_submit_write(struct address_space *mapping,
 		 * data length covers all locked pages */
 		u64 min_len = len + 1 - thp_size(page);
 		len = get_writepages_data_length(inode,
-						 ceph_wbc->pages[i - 1],
+						 page_folio(ceph_wbc->pages[i - 1]),
 						 offset);
 		len = max(len, min_len);
 	}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 79cb563fd887..948c8b5dca06 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -162,6 +162,11 @@ static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
 	return fscrypt_is_bounce_page(page) ? fscrypt_pagecache_page(page) : page;
 }
 
+static inline struct folio *ceph_fscrypt_pagecache_folio(struct folio *folio)
+{
+	return fscrypt_is_bounce_folio(folio) ? fscrypt_pagecache_folio(folio) : folio;
+}
+
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline void ceph_fscrypt_set_ops(struct super_block *sb)
@@ -262,6 +267,11 @@ static inline struct page *ceph_fscrypt_pagecache_page(struct page *page)
 {
 	return page;
 }
+
+static inline struct folio *ceph_fscrypt_pagecache_folio(struct folio *folio)
+{
+	return folio;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 static inline loff_t ceph_fscrypt_page_offset(struct page *page)
@@ -269,4 +279,9 @@ static inline loff_t ceph_fscrypt_page_offset(struct page *page)
 	return page_offset(ceph_fscrypt_pagecache_page(page));
 }
 
+static inline loff_t ceph_fscrypt_folio_offset(struct folio *folio)
+{
+	return folio_pos(ceph_fscrypt_pagecache_folio(folio));
+}
+
 #endif /* _CEPH_CRYPTO_H */

-- 
2.39.5

