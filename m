Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503523D2FFC
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 21:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694529; cv=none; b=EmyMSxo9trRiU98nGUchA8SIMnDX3HKagMop3U3Vh5MZJKr18hB4yadYfjFqfc+M4b0KBoPaPX5Ufz0+RrB/NFDCaTGCTTBhZjK7uPJ7GDy7rXrFCYyLMp7O0InwcDs0XZXD7VaMgdC7g0KGCy53sn9MY+uOWy3DXyGvjMzi95U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694529; c=relaxed/simple;
	bh=5mnQ59Kt0OIYMokksvMAZ1FVhKteWG3EBgc1Bwca4CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ohwqKEm6uGugu61asT+evQH2uMlCaix3Vpoxr90p9UXzscrp6WB+fY324wMzQONRi0gNuDYcz35ts5xKJPuNTIEgnYH3SgANbFoFq+cXtB97hNjZRnw7LRgzC81r59XezD0lBdKzE2aDunhGCrD8PPP7LPRukizvwDmk3WYDNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=V2taz5+v; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=O9m4mUtw; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="V2taz5+v";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="O9m4mUtw"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PKYU742399035
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=wiE5
	KpVe6SLleEh488piHvHxNFFf1zRPmpQZ8l06A4Q=; b=V2taz5+v8yTkcXYxAmkQ
	qNktuLyd3ULqgHsDVgkxpU3QTFEmhQXPTPFXV4ifjEOnir+uzXbZ1qMXb08VNPDs
	E4n2d5XAFxVkzgoa9IW7c4E8xXn5EFwFJAqdN3tdUpGmsFKhmW2eLyz8lszOtQY4
	FLLroBiTAhzmxO93CKlrupAodIHmt9s12Z9jGrvYE04idMyBFXoS6UA9Lu6VMx34
	JiehlGK1BE9YGaUw63hW7ySdBf8j0oS0yEPLPSP8It9JrnzHiL/rctYn9s70Woeg
	TmbibEfTDDkvU/6yWclxRX1m+oHe5Oibaqc+o2Z+3Em3Vgbkd/n6L2VRaOGBevoG
	KA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4g9ch6ke4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 17:48:41 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52d7b3b6aa2so348461cf.1
        for <ceph-devel@vger.kernel.org>; Tue, 25 Aug 2026 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787694521; x=1788299321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wiE5KpVe6SLleEh488piHvHxNFFf1zRPmpQZ8l06A4Q=;
        b=O9m4mUtwTJR8NaQHKR6CCh33JMiD6vVh6ukxERodJIBB3wcPJS3BqeUwEO6WdWTB8C
         DVw3QaVXSwQPhdJhfoDKjXjbO8pYkHXaZ19kzr0OVp0dfg4dz+RlKQVZOczdUC0ki+R3
         tI33/IyuNUOND57+Ywjq8s3czpW6N9t5Y3YxSFZJrDiu7nSYKmrpkf8nFh7+N6724XAX
         X3BTngr3b5V8z0Qrww6JAD6cAhtLHrK0E7db1Grx/6hzO/+lnrA2kzg8ZdB39VS00+iI
         QSHAGd6Fp0eAr4SANnE04Q7j6BF4gbItO86zVBvxHEpVWkwPW9leB7V8H9os+jfGRX89
         5Zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787694521; x=1788299321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wiE5KpVe6SLleEh488piHvHxNFFf1zRPmpQZ8l06A4Q=;
        b=rcwS/LOe89HHieIR8OsAmCxYmA5WTrth8mnRzU4eO/9KyyPKp1gq6mFydHsIKPK2bX
         /D5ck8/LS1KUBnXoJc1ui6Z4frT7/vpN5/8+taLyGGfag5D3zH6tHDudDCvy0aNxyAm3
         +p1N9UV4P/5Osj8Nw/EJYYRo2+RBV9zzoDJGQKwhzh5EfkyzijLs6ODZ1sddWeCem7cP
         Uw2uU4T5OGyYzznu0IMmLbxzUB1H8UFcLqkQt4HOC1dJDp+YMgX3nj4Yibeqf7PR/0SO
         x0jyY70Lu1FqrP7nvh7mAGZZeM1XzDaeLH9LDXTOwSZ0fV1rlmz5fPcZ+SgwyLwJ/v+U
         Tgwg==
X-Forwarded-Encrypted: i=1; AHgh+Rr6exADcSwlty7ETcALZVtvnzoNGp3R1MpghbGWlqu9twPF04FpSIEvFAqbXkEvFDcDPqcfta2dgdJN@vger.kernel.org
X-Gm-Message-State: AFuF++mTO879cqbxqQIMVyMYqBZnCnKQiVnjg1FROMDLWL2RmV3wedfN
	OKPtbp7nYCozGjlztaiJTw1MHKapxKSpO58K8eocqtuXaFn+3VuRx6wxA5xFMIUTs4882kKih5V
	aI4Ij/+5UOOuJG7DuSOtCho3a2Ut+/XYs87i8p+VQjVI+RwthbodWyrYEgYVCc1408AVtRQ==
X-Gm-Gg: AR+sD12A9HFBzPx3LZGZxJKU8YBXCkEaYSO1gUUZLMhwkZO0ZfyWTUy14WzGLmU/ah4
	34dFY0ZhDYz8EWaRp0eMgJEgrx266R1t488zzOf2YBYtFZlEHh+yLOL166S7rwfsg7P4zwLlUBG
	t/CQ8gm6eilKV/JDwnFbVWUvqvtrl+wGc5vHD7U53CrwGxNcPuvVUHB1DFrtMUk8kM2bH0b9rTG
	ISRkmKU311IGD5IiZrfUCnjHxw7rvLfWOtKQvPsx5jg7r+2MWBTHWo4h7VC0wDGG7B0ogod8CqV
	RaqdI7r4pwL2NSJUSzjAQ7esj9QiAPuxl5oFGGBG85AmeX7hbMtp56s47Ja1ykP/TikkSNr8anN
	y8rGfTonTlg==
X-Received: by 2002:a05:622a:1108:b0:52d:f12c:59ba with SMTP id d75a77b69052e-52e4235cbe2mr22967131cf.33.1787694516491;
        Tue, 25 Aug 2026 14:48:36 -0700 (PDT)
X-Received: by 2002:a05:622a:1108:b0:52d:f12c:59ba with SMTP id d75a77b69052e-52e4235cbe2mr22965901cf.33.1787694515107;
        Tue, 25 Aug 2026 14:48:35 -0700 (PDT)
Received: from [127.0.1.1] ([37.142.157.200])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9ef8ffsm139207566b.60.2026.08.25.14.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 14:48:34 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 25 Aug 2026 17:48:09 -0400
Subject: [PATCH 2/6] ceph: use a folio in the inline read branch of
 ceph_filemap_fault()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-ceph-inline-folio-v1-2-d2366fade152@columbia.edu>
References: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
In-Reply-To: <20260825-ceph-inline-folio-v1-0-d2366fade152@columbia.edu>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787694507; l=1873;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=5mnQ59Kt0OIYMokksvMAZ1FVhKteWG3EBgc1Bwca4CA=;
 b=gCFx5lEJtfe6hYbmYfodfCAOA02Oob2rOClr3tv18NzhTBaUb8Iy/j7IPfZzY52SS9J4tgbDY
 Qy3lH1mCZ8HBwezkk64qGkoqZSkRUiHqrnjfb+ifUlL8ThJ3T5RZKKq
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfXyfY6FoX2qHLl
 iPi7KMFkhv8FUdbVig8DPfSYmI20yP7DZw538cc/HCFavIdKcFz4cEA+Y3F73a9LOJ8sK4RQ5VU
 kRRqNraFCo7U3CdjcDDnqMfW+40I5vbpiD2/eCjTYB80USFLxRUm
X-Proofpoint-ORIG-GUID: fXUBfbB95yaSR7TuMGt74zgR5aNyXs4l
X-Proofpoint-GUID: fXUBfbB95yaSR7TuMGt74zgR5aNyXs4l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDE4NSBTYWx0ZWRfX1e1WxeRCUJkn
 YzIeATx5RljAeJhHgPxkvXqw2jHeecPlHgvzHCvpHnczDi7sbZtTXJhtOJXo9PhObhdRKFedSxk
 M5IjopVl8H8877RZNvTz+6FHpSh2gD3yVELYoB3UaITToffi9+TrUhOj2d939RpYJUjbya09Ri1
 lBu1sjiBHFMox8RX/zAzJj1+sXA+0+32AgEhna4zyn52eJB0UTMF2ZAm1a7t9TzKQixcTRa4z1r
 ebUJoUYfKcVh1/e/b2JiMCowya28Hn0HXPsP+Zzevu3V0o9aTrcPznGbtk+UteRZfkPWDqlfdDt
 HTLYNLq2b9dcCeBkV1d0FMa04h1RmPGPX9cqayQc5zPRNMIVIV+ocDmwHAyJwAV5UUbbPF3qPuA
 0FoPJ11Bu7DsEal1zxEqwkVi0jrvT1Iu2eXpZkdtanPZWHg8m+5P29XrDWy29WxVoNebk7dY6Rr
 +cEgReHJqET+MAsDdHA==
X-Authority-Analysis: v=2.4 cv=F9JnsKhN c=1 sm=1 tr=0 ts=6a8e0db9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=VsYqNs1x6zyujO4rtox2PQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=Z6_CKfthfhLzab0EPLcA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11886
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=10 suspectscore=0 clxscore=1015 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250185

Convert find_or_create_page() to __filemap_get_folio(), keeping the
existing GFP constraint. Saves three calls to compound_head().

The __ceph_do_getattr() locked page plumbing is converted separately,
so pass &folio->page for now.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/addr.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index c05bdf5d7273..988ead716991 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -2054,29 +2054,30 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		ret = VM_FAULT_SIGBUS;
 	} else {
 		struct address_space *mapping = inode->i_mapping;
-		struct page *page;
+		struct folio *folio;
 
 		filemap_invalidate_lock_shared(mapping);
-		page = find_or_create_page(mapping, 0,
+		folio = __filemap_get_folio(mapping, 0,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT,
 				mapping_gfp_constraint(mapping, ~__GFP_FS));
-		if (!page) {
+		if (IS_ERR(folio)) {
 			ret = VM_FAULT_OOM;
 			goto out_inline;
 		}
-		err = __ceph_do_getattr(inode, page,
+		err = __ceph_do_getattr(inode, &folio->page,
 					 CEPH_STAT_CAP_INLINE_DATA, true);
 		if (err < 0 || off >= i_size_read(inode)) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			ret = vmf_error(err);
 			goto out_inline;
 		}
-		if (err < PAGE_SIZE)
-			zero_user_segment(page, err, PAGE_SIZE);
+		if (err < folio_size(folio))
+			folio_zero_segment(folio, err, folio_size(folio));
 		else
-			flush_dcache_page(page);
-		SetPageUptodate(page);
-		vmf->page = page;
+			flush_dcache_folio(folio);
+		folio_mark_uptodate(folio);
+		vmf->page = folio_page(folio, 0);
 		ret = VM_FAULT_MAJOR | VM_FAULT_LOCKED;
 out_inline:
 		filemap_invalidate_unlock_shared(mapping);

-- 
2.39.5

