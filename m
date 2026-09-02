Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0604AA037
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365511; cv=none; b=LPXZT6y9AAEH8Yvm/LRgWio5VH5RQVpzpy/i/k7u3e8cTVkE5Dho5PKVjC2KC086Qozl7jYT/G26PzpGujKBVucE+pkR82Zp9Tt0WpNXo8JT76H58MReDXSu3/KcqRqOjJg+RwEy6owrL48OdHMRtP88RDwNFk9+7CplvkL9c6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365511; c=relaxed/simple;
	bh=6K8So0zhiUop16OU1SZV0hMFVqYlDNvoFdQhENITqfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXwnp8GkmDAE0T6UyISj2ZEr7ajXfonSucDXQZv4/l39wgkEqH6az9FPLzunyz2KQIvrzqLnV35lhzJ/NjOiPO6P27E9ijQzPNbR6cm6ATJvdpjt2u0NxstJhnF+sCiFaY6BFWvWq7cH72STWUxkeHr8EyEVqwI+gNahXu2DPaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=VQzM7zYU; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=H3UPO2kb; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="VQzM7zYU";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="H3UPO2kb"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FPZ1i449700
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=9+vj
	1JvoRB8URu7nTUl8whzOblI6NEX6HUmsLA7DRaU=; b=VQzM7zYUgtlfsq5J/nb3
	P7Qnwg7W+edOkq0ZxQqtKRlrHI4POu29oZGnm7ZLTua+wlogYx5xgR0ommtw6eRw
	GXdodYprFDLCcewEI3AD8r7BLf5QPCQtO0B0pMXc35W4zS6bGzxXsV8zkFwE7vDr
	0jHIwhVVGZfBhLV7jvb0so4Azq1zeqxQonsc1FSWlxIdFXBG3OuvPovxLJyE93Nc
	lYqh+b3VLhAhjgGFlvjymYXF49kjNuY2R11EA50S9P42ZTDQzkd7NxP9HP91rZGt
	FUI1s6Vk8XG+h3beVoxH5dvAyKOGYcAOm7hg0wq8OSogKMoYxaQiPl6bmCgScXlZ
	4w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gec25kxab-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:11:44 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90e7de22fddso26446536d6.3
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788365504; x=1788970304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9+vj1JvoRB8URu7nTUl8whzOblI6NEX6HUmsLA7DRaU=;
        b=H3UPO2kbSQxtdet2pIsnLxrfncinzA6yvbT+bJpEVFBLPvJ+5PLc+g1B2qzKi6lKT4
         PYHJfJouo8GYbu9uH59zpyja/zYGewyarEZKV8bUCaHe+8Ly3z82kQ5S8hj5/KNsR2a8
         IPDEy1JaNe96uk4O2DulDHOxZnQvptWG6fnOOOmQ7joUCBCNCE5c+srrXD1quRilf/nD
         WXn6ZdxuiagZdXEJoERA2PFD5Ju6MmIR+klqeBMsvd0jTHKXULQEM5KKz2Mtv80E2TSN
         vllqC+QNgvpyZBA7Oiaunbod4SMIEFUu8kO9WbCTckN60ZNUigPHIzwMVXAHCnAA4gIR
         LEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365504; x=1788970304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+vj1JvoRB8URu7nTUl8whzOblI6NEX6HUmsLA7DRaU=;
        b=iBWAJP8xstlYy0pJRIcepmV4KFPPAS3aAVFeCOrPmPCDVNaNod15V+ig/N7vd4PEJ5
         QKWIjKLFe74+NYlQNhdjjzrAAoGB+1ekjG79IivIHOWM/3MHg8jeasn1ZjBHJm3Jc3WM
         uSkBZTFha1Pn0V/kUOkujHJoCUpjGWNgjMPL8WZp8Pl0Gf36VEwIJ+nZd5TpRPnQVHt2
         ORLJk8E1uivddoxMoEs7qrKgMgEnfthHJo9vIjGydDMWuaCWHLMD3Dd1UQGsNvy15Gmt
         iHyNKefN7HoEnQlDSMqTU3Uflh2vw8G3zI0hx1NXOp7Da3VaU2y5q0ljw1KwFbCZPAYE
         Q+jA==
X-Gm-Message-State: AFuF++m6XwJgibRd+Hyk7ZN3MvGdAiqR94emSG9yWEVP1/EkpDzYyO8G
	ZsPn795XtwjImi3pNqfsuuT9K8/2BwmEoTdKKVRPfFjiiruyFyb/D7LCZJo9FHQ+v71cZyz9XnS
	Sec6DN2bGJtp0VeS4n4dDY3Ce6GV/HQt0S9NNieTiMPpsONef5JtJSvUn3BI=
X-Gm-Gg: AYBFou362EHlSutrJRbVh/stmjRcIx9tSp4peaGilHGVnpehFweLbMBzjlj7A/MB+va
	Py2RRe+EF0DbE9Kc5B3USio/BkMc5xnbqM13r94HG5ujxyya8fKs9qaprEVUsg9xJoyOP1lzAdu
	G3dKa6JcZY2ka5ndQeBjrt50ApBfENpsBPeybpMCQpO/MK938vInjJNkW2PCdUbr972D4uYvF4G
	ZsigPyq8dWMQZXG3lnnZG8u6FSmdoXlUIFUAi3DnAks2hMF31HB9nWBA2X3gaqNK30NS/s8Gnqm
	UgNt6x2rNx2oO93gAyjf0Ik9dV8oG+Dsh9bJ0/DywSQlnsVrE+9Tr0+RYtJCG72T6zg2/pDPESH
	shV6Oj7XJjqbGNWS6D6tu/t9+MljgTad7VtYtRbYu6Lpcdx/w0f51Ig==
X-Received: by 2002:a05:6214:202c:b0:90d:af11:89fa with SMTP id 6a1803df08f44-90e9f20411bmr93549566d6.2.1788365503799;
        Wed, 02 Sep 2026 09:11:43 -0700 (PDT)
X-Received: by 2002:a05:6214:202c:b0:90d:af11:89fa with SMTP id 6a1803df08f44-90e9f20411bmr93548246d6.2.1788365502907;
        Wed, 02 Sep 2026 09:11:42 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm21172636d6.26.2026.09.02.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:42 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:11:29 -0400
Subject: [PATCH v5 05/10] ceph: convert get_writepages_data_length() to
 folios
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-remove-wait-on-page-writeback-v5-5-0b512e77e75b@columbia.edu>
References: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
In-Reply-To: <20260902-remove-wait-on-page-writeback-v5-0-0b512e77e75b@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Christian Brauner <brauner@kernel.org>,
        Jeff Layton <jlayton@kernel.org>, David Howells <dhowells@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zi Yan <ziy@nvidia.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788365497; l=4666;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6K8So0zhiUop16OU1SZV0hMFVqYlDNvoFdQhENITqfA=;
 b=JKXesfZIXTjBUNRG2Pk1JTEoygoduPU/zW8UFIh8uwhpdqqLpACWjRIm4wT51NRFd/M/FBHGx
 iWAT9m9xyTkCSBNHk4MINOQRqPMDSCfJDcgbEngShrNqgRcWDydMh1W
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX9x1oRGyqWBtj
 AUBjVQ/sehrUyZDEk6d0qL8rSfcSrL7u9lJSzNqOgw4GIzhaXkmz7N++8HKeXUKlVdrbgvxBzDe
 IgKDJQnccDzxCqmH/6/Uj66Ui95IAGY0gOUAP6FUvQVp+DJiFp/f
X-Proofpoint-GUID: KKk9aYZHXjVQHvYJyPCqXyuoo3le43gr
X-Proofpoint-ORIG-GUID: KKk9aYZHXjVQHvYJyPCqXyuoo3le43gr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX2IX/L/T4Uwv0
 g0+t+JC/7OKj3aZfWEcCiUEhD0+7oSTHvmQda4OukAY+6EbbpBwFmdnHTTesECvBWMoIK8WtfV7
 fwqn4My7Mu1UJXJs4zIUQg9giXotWCgdUlcjfUjeDRJfJDz0apIyG5MWie4LmxCfxSdDhKbE1Qa
 Edn9rUVpymk1HfPwAHDhY9KaYzjIZxUGYSLbK1eana3QzUU4+C4G34+z2Pz3MkwYE3E57m4F/2t
 7vq3peprBM/cVFEIxEtv0VX+JDLzrsSScNM0WflYGb2uaUxvO0I9dZAkEu/N0akhoGtcnOg1Hw8
 U30BPrRQf10NfZq3Qy8pez+4e3/4l7e0fkVoBG7TCfmJ63Ef3OILNnEWCZ1QfGNymT4SAI0uFk/
 BbxH+xh2CyrjdiTeCaASK0gkr18j+VevOhMH4OqXE51ga+cFbEOwIAfguA8001zZlcX200b7WmQ
 X1UBcFDINptjknJem+Q==
X-Authority-Analysis: v=2.4 cv=BpWtB4X5 c=1 sm=1 tr=0 ts=6a984ac0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=4S3DF5rXG3rfafK4-1MA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=10
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143

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
index 5e4b9da5970b..a72efe96e1f8 100644
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
@@ -706,7 +699,7 @@ get_oldest_context(struct inode *inode, struct ceph_writeback_ctl *ctl,
 }
 
 static u64 get_writepages_data_length(struct inode *inode,
-				      struct page *page, u64 start)
+				      struct folio *folio, u64 start)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
@@ -714,7 +707,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 	u64 end = i_size_read(inode);
 	u64 ret;
 
-	snapc = page_snap_context(ceph_fscrypt_pagecache_page(page));
+	snapc = ceph_folio_snap_context(ceph_fscrypt_pagecache_folio(folio));
 	if (snapc != ci->i_head_snapc) {
 		bool found = false;
 		spin_lock(&ci->i_ceph_lock);
@@ -729,10 +722,10 @@ static u64 get_writepages_data_length(struct inode *inode,
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
@@ -1601,7 +1594,7 @@ int ceph_submit_write(struct address_space *mapping,
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

