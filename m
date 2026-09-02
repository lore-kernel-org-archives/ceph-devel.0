Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D13B4A8A28
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365512; cv=none; b=gT/VaQA3MZ+dpg6TghBLuYnck9p1F4vm7lYxx7ILFVmDcBpLhfynmPriHF9WNhEgAO7icgu6q/t7rHDakuImX8hj/aAnwXZOtftTCkQADC7cG0IL8GjpqWYKX5PbRE++pL+n8ky4H71wFHkJx7nzZmO+Hq00UX8QocP2+WYcqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365512; c=relaxed/simple;
	bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RSKl4LqKSLrizX2Tzm8oJLf8pheZ4/aNQOn+oLv4I2xZlT0Eqg7Gtvjz/UT2SvKuiFQzIMxg3MmEuZIyFLv/hhSB1mqoF+flvzJvYpp+RmeYVFtNexItYMZ8WXYv+o1Eb0Uy0pmFOBRhoCNT+y58bot6Vi2S0m5DTJPW6JybchA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=jLpjPwl9; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=nInfNnwD; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="jLpjPwl9";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="nInfNnwD"
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FQiN0305735
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=aLyb
	lFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=; b=jLpjPwl9inGsFVON+6si
	Rvlv6W+osuwovYo+i6o2//h/omnPHCpk/J9eE9/WhrJMApbtyoeghxdYBo6+nr4s
	FHPm6lNf2H5L8c39yR1bKkVFB3Fz1GXUUUfQ0oGq3O2FtvV/AqyTQXIOUqsmed1f
	D4mM9CQBIfAIEwDXppfGv/5JyFDnwL3G0erAopbRh6USzvIGYlQvf+wKzFKeogJa
	SO4AX2L8JWJUFb19o06OS6178SfVlv5/bcF7HKCpgVGKsszWOmPCbcnMWiZa6ULB
	+2UCtaSpPHnwXi2AtlxzOgnge7eU6MVT/9mpeS2FkDFItNXIgewgtvnyaxCTYjgq
	8Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ge8gcms7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:11:47 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ef04756caso22522571cf.1
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788365507; x=1788970307; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLyblFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=;
        b=nInfNnwDJ8t4WIbxkDROyZsLrGg6xN5PjhjnDmDwK2SqJE7VjsVOg/bk9Bs1qDd72e
         9Q6M9ObrrkyabbnEgUm+6fuANHaL4YYqEvQ4VHlyzQyFS4rCNAiV4pBzr4ZNTg1ZkLQb
         iUI/E2tv1P5T3N3skG2WUzMGddQdRyVInrL0tyPg9UtYOmVF2UxY1zuv9xR5iSuSdYTY
         YW8mOvUlpRHUvgnJEpDkjoI/yB1S34gL4IMhRKdYYH5C+qVgtPCT6iZRedHGBEyyiEFu
         O9fmKZIDU2ikzksYWTtGpK9GC56CTcklprmw7x8yQLoAOA9bmnQv+zwalnEr0e1kbqlW
         OC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365507; x=1788970307;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLyblFTyCRkRNvHlbjBlieXQYnfG93Mvps8LThXIpPg=;
        b=bk8R5aRC4miUDPmx8UZN3K3tX/lxnYVw4z2OlQxY487Vi4wmXZBOuhTm661cyUSoMV
         uY9yX/8jYYyQJb2jB7m/ZtwTfdNMdWggVAcq8Hpe5iU3msn4Tn4DT7X6zf7WqmjTWZtb
         LUBLpuYwUadtk3YeQElU9m2xnM2kF9il6K/X9eJC9aBXOk89nEg6LStOwHNYIiqTcLDY
         GqLd9oTMuUeRMoAsfVTCjNEp8T7U38h/89CmRN32rIPd8IPgxktdkx6u6bLcNJtmLD7O
         yP8CVw9pHnVXuCsOsEw+gljJ7tgTlgQFGdK/FJiHq8F5MzhnhEmrNF3guNbQGvDChWau
         iWkg==
X-Gm-Message-State: AFuF++lJXGwNNvdxEHK7MLAFgVtTH5vU7niynBpM0TgbcYQ5TAG1ELpT
	fnmaTLN5OES9uVOJxOt6zhjHPLu+ouj4sPQKfQ1hEEblpYEBBTeWZCDjxIE5uM5cq031Kw4DUIi
	kjgPUAZP/z4GRGyRPOPkm8o0+nzwqhNyg4ubjXdRtUIZgFm6XrGwhrjgkUaE=
X-Gm-Gg: AR+sD12Y76tAjls36hNovRA58zhn5CdtPJwM31UCwRil1BvS1K9uYqHxRPHb0KEI1jn
	uRx3zOsd+feid3ErBTZhO8VLqShPqpo0f2GlfR34Jr6N9dav5XViD+N8pGN/ej+FWoRSLqH4K/4
	ofLCTvq0fWI1Fuy3W8nSi6RgoD80fCfCQRrH/PoSaCeSaLZGy+507I5LkiTiMaIfLzeNErsXoOC
	wHrOWnpXYWtiEGoeh0p/tPL96DAk3OxOG2q5hYo6hJfKPGUGPiU7g4b20lQmOhpKCVTdd0ksuf7
	DO3juwvauofuIT3upA8YluEjhQwca18jBO1KbN95GVO0uvY1BFibIiPBLjRI5OuUtxrQFzC097P
	kjV0SBt98K6BA1YS+O4eJsVH35OlNF0E6wKphcKKemZvPcZCWvYyQzg==
X-Received: by 2002:ac8:5c93:0:b0:528:38b1:b547 with SMTP id d75a77b69052e-53036b4f832mr79145591cf.8.1788365507409;
        Wed, 02 Sep 2026 09:11:47 -0700 (PDT)
X-Received: by 2002:ac8:5c93:0:b0:528:38b1:b547 with SMTP id d75a77b69052e-53036b4f832mr79144511cf.8.1788365506821;
        Wed, 02 Sep 2026 09:11:46 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm21172636d6.26.2026.09.02.09.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:46 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:11:33 -0400
Subject: [PATCH v5 09/10] ceph: remove ceph_fscrypt_pagecache_page() and
 ceph_fscrypt_page_offset()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-remove-wait-on-page-writeback-v5-9-0b512e77e75b@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788365497; l=1581;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eEBEQRS44uRWq+68HnHuSJkJWcepL1mJ0SSpfrhNU80=;
 b=mhLl4P2uOVP0FkK73qk2YAGJAverCm+Y2gZfCWO42rTWySDxx3ye0TRAxoQYAV+wZ+pD3G6sH
 jnAzG298txyCAl7izlSoLKF6eTnU0e67S3qvIIIOKiWtLiMtrpJFa47
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX0jZCtP/5j0dJ
 MwXXMxgHZvtZXSDenLiBGnP3VQRCY6C0k9ssFJRlVlkymc1h6tzJL0VMz2TFBnAitQ4va4TfZPc
 iFRzTsVQfGm6AsrTGTWUmFbC1ln94iVjMBpGZMZP766cK6Uha1zbwR4j+dxTePWHkwjOV5Ohdah
 olSzJvxQ/+KOtTgrzQPMZjXPFC7V07Kf752AFC1yRIac6iq9xaEQkJy4U7WDGqlnu1u04y2iOfI
 ONMP8PwoXDW/mhZ9He9BJWqXs9kXjhr9LZYJ65ow4hCTqN+RIhYz/KcJEI2VBgZphNkkZ+EbGbk
 gMo6PFr+llhsL2Poi/voPF0OkbG+R/BRXyQ/2r5wKjf2aRG5w6ue/q6OFKj1dUf9HSuq6p/Tbqy
 bZoJfrmqEF+ImD2OEGcKtY6fML1bx9JGRIYIjZc7VBZWK2f/wvt1uBC9Xdlo1GDex9fnZFro6t+
 H7Rf8F4xjfepIybny4Q==
X-Proofpoint-ORIG-GUID: PVv9kIMGdCSM-QUEOay3YaPoV9PmyvaF
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX7ljVpfTfWrO6
 nGhSfrzfS7U69V8UfhIHSmjIIYzGypA65FLAD0+T8+O1wMyMd69rTMAHZmE2ryf7CNejGGBQN6h
 PFuH5hwiitF+hrD13x9Q4Mew3Nlht7MP5sjLcSAgN3nCWTyy4UMN
X-Authority-Analysis: v=2.4 cv=HNbz0Itv c=1 sm=1 tr=0 ts=6a984ac3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=HpS3TJQ9O3Ob1ozEcmik:22
 a=jfg2DRd2ap2c96lsYj8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: PVv9kIMGdCSM-QUEOay3YaPoV9PmyvaF
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 suspectscore=0 bulkscore=10 priorityscore=1501
 clxscore=1015 adultscore=0 impostorscore=10 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020143

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

