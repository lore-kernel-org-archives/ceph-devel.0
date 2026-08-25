Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E09647ACC4
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 21:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694537; cv=none; b=j54qZ+jSUVDJpktZA4r+uJtQzyZJK3FkqY6M480uazl52IfdmHq7l+efHyauutFFZY/oNNvSQSZjlPesyk5kuNWu6+hkYK20WrnMqStcW22X/A0iYLEUEl/vf+NRzggDHlkw8r55x6YF2sKbj00jPMRJGY8rBL3UtWPIphsw9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694537; c=relaxed/simple;
	bh=T/nmhI05mk+3FWUSunjzUrt2sVFvP2vBeVx2J/cc+Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eC3+/1vOzXKDefnxX4JgYLu/rZRwb/J9R9QyrMEgrJuakhSjVjgeQ88/0TjtdjrIeWisvgOjoBfn9TPx+Jw9WNOkCpDwrpT2EaOGQjZ779OJPTre89oiPRPiy5vgR8DYVsGRwFx6sunVVgAn+S5IG34kacgNsyL+6O7n+P7eIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=huccdhiw; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=HtqNUDYM; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="huccdhiw";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="HtqNUDYM"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PKYHTu2398743
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=4YvB
	1LKcHhBpg/oJay1WbU3LLj6nD01O5clYhNyL6+M=; b=huccdhiwF863OFhp2+Ob
	FmzJQNJASjcWpZtyVUC0qq4+5vWtXS+W/L5RKVveZi65C5BytlXuL8E0KTHGrMvH
	lVXtqK42vGiiIUEbAwLXwWp2MeFuYQQQMk1nKaO/YBoVBgLemNhnxM4L2dgaZUP6
	bt2R8bjO6hLpsxRESAFe7aV68sSypRx+JXriF02hKI8fcr4BRHNzNoZu3I53dRNn
	0qcZhotOj/8VCZX+WTTtBk0Mg7h1ryteeoGMpptUOaZLmh/Lj8fAXOc/AJsVrj4o
	nmOD5dyOmYyUbn6K3MOmI2RGjddOeRTKVS/vxlmit1kdWU03Yfz2Oz3XL8if1qDh
	MA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g9ch6ke48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:40 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bf321d786so2508871cf.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787694520; x=1788299320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4YvB1LKcHhBpg/oJay1WbU3LLj6nD01O5clYhNyL6+M=;
        b=HtqNUDYMRRGmoGI1FUSbTtXqg6T2YGrmqaeYOwtQkfl8rNUeN7X5ydBjueSN3JHPVp
         AieA1dA/q2jMSIk8YHra7r92MgbGlJhaAWcmsqVF+K7ERMCyrmmlnjPS05Hn68qkGQrF
         z5Qrysy2bVLWPcd4QI8+syrGdANwx8Mii28EyYTF/AMYGgrixnTnL+YBOMz/7NfsrjT5
         eXtlCk92DaAEPKcyhUlnEcUp+EzCucVEVFVJ7PA6OGRRdpCAUPDEekfwZNgPWTA80iWS
         0EePVb5ui43wJ945t4mufFcurg8NWxxcUWUn3w4HkDoRaIyVred10x9rrxh26zGSt4oZ
         1LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694520; x=1788299320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4YvB1LKcHhBpg/oJay1WbU3LLj6nD01O5clYhNyL6+M=;
        b=btysCb1sziyWws+bcERn+5sRKwkwvd3DtaoZqXiCMdV23P7LfkF9y73pI0paCr0cnx
         EIkrOxdtPIycoGXf5+ore/NtgeLb7jffudL+i5+gSntY8RsPG8aOvowt5g/y7OPmAq2L
         XnRtu069GH+pI3TI+hETTC0zKhlgM+hzNcmdnphiQAYUSHyV2Ls4w/HWSm9mDRiSqldj
         CK+hkwul+Su3MiCKOnPsqtin55vawdyc44nxJ0i+9iOGTUwwTUHAbk7DkfOnL8LW5IWJ
         6cdOfI7tyQS981QqOQw6SpRPJfmZoz5nh024K1RvlfKLHayPAj/kYuqldArn1XXWDuqb
         jwaQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdFifbIpdHbUcqiHTkEK3T8xjzvelxA9QQwo4FaqlOSTRuUNP0ngO+f+YnJALqYdN/taWfORFd9MpT@vger.kernel.org
X-Gm-Message-State: AFuF++k2Dh5IGFYrE9qTYOof2s0CaWSKG+x5GJMUeUMVZ6h0zi+lh789
	eqltmdBBZ46RAdBk5kpzymfcrweqqR6C+opQUuvsmObHzz1E53kEJajBk1DvIjmxnvKQC3dXfGk
	ruYhDxKps3CJN3CIoWlDau+Bla003iDobXeXpeocP7OiZ9UJvzCYzO1ZXJjoT8C3kPxFRlA==
X-Gm-Gg: AR+sD133JP2o9oSDCxl6oSQrAJqZ6YrDLVNt0GPrEobDVagJ7ebCoKjwWXQVJVhs0U1
	V14ReNFo1J5GwabQuH7XyTh13yl00WkgVE1rG7WXZaH+uQHeztSFmiUw/dpsw67nj4YyeNFMG6Z
	7fAGwKhfUGeKxeACU5JcCwWMoKhahVWjIFNUlWmpwCKDdyPOmswHO3clJDN7amE3f9crRYZ3dd6
	FNS/dL61rWVN+pVV5HwM+A5g/5XnfFFNjLKBFryvgPQKtxN2aGCwTNqhcQW+7pq8bSrGLo+vXgS
	iLrUV6+2uC0pkepw6jY1I3F1EeW6iG+L/ZEWlDQth4V+dkH8kflR7rF6UqDYm1uq7Z8juJTLRJv
	D3AcmexXSCQ==
X-Received: by 2002:ac8:7c4f:0:b0:528:583:a6ca with SMTP id d75a77b69052e-52e42283b15mr22006451cf.14.1787694519722;
        Tue, 25 Aug 2026 14:48:39 -0700 (PDT)
X-Received: by 2002:ac8:7c4f:0:b0:528:583:a6ca with SMTP id d75a77b69052e-52e42283b15mr22005951cf.14.1787694519142;
        Tue, 25 Aug 2026 14:48:39 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.157.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9ef8ffsm139207566b.60.2026.08.25.14.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:48:38 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 25 Aug 2026 17:48:11 -0400
Subject: [PATCH 4/6] ceph: convert ceph_fill_inline_data() to take a folio
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ceph-inline-folio-v1-4-d2366fade152@columbia.edu>
References: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
In-Reply-To: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787694507; l=4120;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=T/nmhI05mk+3FWUSunjzUrt2sVFvP2vBeVx2J/cc+Lw=;
 b=0moRzChkHC+B2jBVBCTJb2n2UY+hWA7pfQHC7ab2XjxbMxV5iuj8Ab5krB2M+ivTqsqAzXIYS
 mBUCcIPmcM7D3YH5JCfwARcmxyYowoX3ayUW4yNmpw07VaMgoUx4+2K
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX8nCNPr2wTUjr
 ++/Awn0UPHhmQRqTIbKIeB77QsXgiXMNSNcYh8XNftK0YXBvDXLRrWG9w5ORghbDJiiwMVhLu98
 Dh5lsSSjH9f5znDeOLtN3elcaEYt4TIvb2bACP00tGDZUTTikvJ4
X-Proofpoint-ORIG-GUID: qgCCXkDmN8zYvVPVGCXRvZxi4C6lv-8V
X-Proofpoint-GUID: qgCCXkDmN8zYvVPVGCXRvZxi4C6lv-8V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX6dG/nHbmnZ3J
 oTLFogGbGizKBYuX54pZzWdtN5DPIBcC2Y8WsqcB37zguellZ3jW37VYzArcnuCBGXAIJXMwTXB
 rUWoybZgFdReLsdNjdexLJzzQdBPg8FRpcp7WiLosNlgLFrcFj/9OPLS93NbHoWeQ/4riZXcRYT
 EKPhIUnCFCCduaHVIH9eQH0v5aECLe7O8t627e779jdcB0QXLz4jaJuubX3f0APbtOxtOLW4zsz
 M71y6gaQN9gn7FfwiuiYoTcxhO0lZ+we8111t0mfpymB5/rWtbMi2EurFZ5gDmsJGUFIuiSbXdS
 2PAD+YnAB2uLEO53l2k6tvSfh8RkHAkf79ucHVT+l9c/ZH+NzjpYKfpe6VWVu0+KakCUTbvUhuH
 EhXj3j6PgHSb4SgNMVgp4dyjuIlyloCfA+QE+jresxuAYJ7sOFIh865UJB6COgzQl7sCYCNaNTL
 KyW1EH4OUW3FHUqf+Ug==
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a8e0db8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=VsYqNs1x6zyujO4rtox2PQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=5ne0shk8uSHvIOEplNAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=10 suspectscore=0 clxscore=1015 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250185

Convert the internals to folio APIs and pass a folio in from
ceph_fill_inode(). The kmap_atomic()/memcpy() pair becomes
memcpy_to_folio(), which also flushes the dcache, so drop the explicit
flush from the folio creation path. When a locked folio is passed in,
the callers flush after filling it, so the flush in memcpy_to_folio()
is redundant there, but harmless.

This removes the last caller of find_or_create_page() in ceph and saves
six calls to compound_head(). The page_folio() call added in
ceph_fill_inode() goes away once the locked page plumbing is converted.

Remove extern from the function declaration while at it.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c  | 47 +++++++++++++++++++++--------------------------
 fs/ceph/inode.c |  3 ++-
 fs/ceph/super.h |  4 ++--
 3 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 988ead716991..2ff90b891fc9 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2196,50 +2196,45 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 	return ret;
 }
 
-void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
+void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
 			   char	*data, size_t len)
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 
-	if (locked_page) {
-		page = locked_page;
+	if (locked_folio) {
+		folio = locked_folio;
 	} else {
 		if (i_size_read(inode) == 0)
 			return;
-		page = find_or_create_page(mapping, 0,
-					   mapping_gfp_constraint(mapping,
-					   ~__GFP_FS));
-		if (!page)
+		folio = __filemap_get_folio(mapping, 0,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
+				mapping_gfp_constraint(mapping, ~__GFP_FS));
+		if (IS_ERR(folio))
 			return;
-		if (PageUptodate(page)) {
-			unlock_page(page);
-			put_page(page);
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
+			folio_put(folio);
 			return;
 		}
 	}
 
-	doutc(cl, "%p %llx.%llx len %zu locked_page %p\n", inode,
-	      ceph_vinop(inode), len, locked_page);
+	doutc(cl, "%p %llx.%llx len %zu locked_folio %p\n", inode,
+	      ceph_vinop(inode), len, locked_folio);
 
-	if (len > 0) {
-		void *kaddr = kmap_atomic(page);
-		memcpy(kaddr, data, len);
-		kunmap_atomic(kaddr);
-	}
+	if (len > 0)
+		memcpy_to_folio(folio, 0, data, len);
 
-	if (page != locked_page) {
-		if (len < PAGE_SIZE)
-			zero_user_segment(page, len, PAGE_SIZE);
-		else
-			flush_dcache_page(page);
+	if (folio != locked_folio) {
+		if (len < folio_size(folio))
+			folio_zero_segment(folio, len, folio_size(folio));
 
 		if (len > 0)
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 }
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index d52e2b389e0b..b91125567cf0 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1383,7 +1383,8 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	ceph_fscache_register_inode_cookie(inode);
 
 	if (fill_inline)
-		ceph_fill_inline_data(inode, locked_page,
+		ceph_fill_inline_data(inode,
+				      locked_page ? page_folio(locked_page) : NULL,
 				      iinfo->inline_data, iinfo->inline_len);
 
 	if (wake)
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 0a779cdc8392..30e625e02398 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1400,8 +1400,8 @@ extern ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 				struct iov_iter *to, int *retry_op,
 				u64 *last_objver);
 extern int ceph_release(struct inode *inode, struct file *filp);
-extern void ceph_fill_inline_data(struct inode *inode, struct page *locked_page,
-				  char *data, size_t len);
+void ceph_fill_inline_data(struct inode *inode, struct folio *locked_folio,
+			   char *data, size_t len);
 
 /* dir.c */
 extern const struct file_operations ceph_dir_fops;

-- 
2.39.5

