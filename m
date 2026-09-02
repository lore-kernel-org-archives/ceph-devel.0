Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943C34A5EBD
	for <ceph-devel@vger.kernel.org>; Wed,  2 Sep 2026 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365511; cv=none; b=mE2pZA0pesKCYA+IhYhlW4jpVDmmwdMsjv3CTBTqowTmrWNwfPYyBqxbnLyxPU7bjKeh5yZfWHZ3RJgjFlvuq851/iM7RHq8HPojjj8TxtgRLzaywv64/mbHhz5xkbtVUZYUPZQiK2o7a51Iy+DATppTI1iBNvRmgdEgkVQBnok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365511; c=relaxed/simple;
	bh=rZI4wY7ubss2UkuIjYXh7kkv7IuPpkYYSXBGDgUAZ0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5EmQzNAFdIUYfrUEeoSI4d+1eYWlDrF1yvI3WzBhh96cDDo1QHqKi31n2jfVyuHHCvPZBKTss7/pnTB6GHrZro3pcY3OFmE9CnRWRclMBXk7BAbuEcwzy6EbKym38Ku8K2Bd2mRYF14ZdjZ8xLn3vASD38YnQVkmThEGa1D62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=qH9P93jh; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=m6h8ODCr; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="qH9P93jh";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="m6h8ODCr"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682FPXjV449643
	for <ceph-devel@vger.kernel.org>; Wed, 2 Sep 2026 12:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=c+n4
	YzUiwE3r+eN4U/3I84mF1+YQlObNero0rB9Azq8=; b=qH9P93jhTXOiKLiyjfpQ
	oMYsc6l6yq2NIl1f+jAdjtzsnWTrStnFpMVPJAebFDCznEpDnCxY6Iaw3JLF9NxC
	ITjiPUbZGKQFOuf4CKdfPrLZDh10+Q9ciCtq7GMyRe91bAVKgbZER0HSl10rBLkZ
	+rvN6JsV9z/09vJDu6s3uhFK3iytxjpdystRy/bxsJ4DdpSe9JKysS1nD50iEfr8
	oRwevYCDNJss+wOwnISO2LZcOT2af3ubjc0M+VMrlLRStzRDFeqf8RoJC61MLnTF
	FU0Knfjeh0XykINd9EIZFerJG55+RmckaYakAu2NgV6hocQ3v+l19MrkApDfxp6V
	mA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gec25kxap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 12:11:46 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e62e3459fso238144985a.0
        for <ceph-devel@vger.kernel.org>; Wed, 02 Sep 2026 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788365505; x=1788970305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c+n4YzUiwE3r+eN4U/3I84mF1+YQlObNero0rB9Azq8=;
        b=m6h8ODCrXCT9AKCflVOjZP+CUXv9FLcZvowX5AbDZoe2UrfKC/8BiCdg70Mxu0NUuz
         vANEoJnLJe85RWJC04QBsPM7w8rFP+odOVCAWFQyZOX9HmUMmHW1ZUM+E+2FueN+1vZO
         7Yes8a4lbK1aAgT2F9thIqARSJ/ndk9gwsSySmVXiSwKIplxhkUjZTToMrRuK/sR9RGR
         Wyc5AdhJggCi2gIcGTOGvVeac1GKah2ZaPNFW/SORR8deMXWQikg/WrPOGMLuhlvn0Rx
         J/fT9G+frB81pFnOqJhIxTdPy2HW/s+zRHN2I4vYPevWt+1RambTzd1wRW6VbphoQ3RD
         q14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365505; x=1788970305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c+n4YzUiwE3r+eN4U/3I84mF1+YQlObNero0rB9Azq8=;
        b=HTCxEHrYcf2QOtJjpmU5vtsEghWfkLpjldHDvYccwW4jJhtquuboa+iMbWkCG4aOga
         cjAqZM3KQ7XnsketPFg86Z/3FdeP85dgKuIR4ym2a7bdzolQJKewa83rL8flASqmpZKV
         m+ZhtzpRU1mtE9fPwQVHeFIHRcHLz5JICc5G7mH1brnYbAv0XGsAN6P7fSnnf9LQ/PuJ
         kwQi1q7XPbpAkhWu5paSAVVQ/pexnei2eV/PYD+XZBBtXDQKK8sl7jyKFrXnwufm40Dn
         rUMWXaSCCac/Od9ism3xYYSLT0LbQ9hAGW2JY0acc88R7FB0mGOglwzN0VZSANrom82+
         M/ug==
X-Gm-Message-State: AFuF++mrDVWqf1jAWZQP+W83NAX33nnlwJj2aUy0XD+hZgjLiNGb4JMz
	+Y9CAswgi/T+1kaQUNJquB3Ke/TPxNzllsAeqTeiC1Ss1i6YhQwLE87uq6CNPsDW3DHga28VT5S
	T9TXW6UyMxO20vFaC1JtJ9+YGq73TdHhKJccmaD7SMw+wCrf+mEsbtWN8cWM=
X-Gm-Gg: AR+sD13iDinb9JurgtioJEFoshkxDEM7L6TAwZYSnDcqhSnJNOMHcm6Yic6dl74hOG9
	m9O6jBTqd5IBfJrXIgipvjTluJYpq9o2+D0Xb88Ckw1xEBKQGksiODJaIko1LyoFPZyrVHgZ9O6
	lifUvym7znMMO0X2UIya99p6BhZKEVBIi6VLTvI07jro+Q8BU9Mn578ugIkybKsI+6CxNqwPlFt
	ZxDrQ3e8VVxUdVZ2+O2vT/WP9/gTBjY9sCbut8KDKuJXAkGv1yTqTAW+O8vQJHvQ2/tWmma6bPu
	l9VJP62e3VsxDv7MAb9z3NBDI+RvaXtLJjnJXLuT8uwllrtCXTdadcbKGP6HddnQg37iKc9NIay
	Sw6lg4k/NCAXUIXCXdVv+ZegLy/zFrlBrqrh+g9ZGB28tRS27jPSF9A==
X-Received: by 2002:a05:620a:22c6:b0:939:6dfc:a95 with SMTP id af79cd13be357-9396dfc1dc3mr25300885a.52.1788365505409;
        Wed, 02 Sep 2026 09:11:45 -0700 (PDT)
X-Received: by 2002:a05:620a:22c6:b0:939:6dfc:a95 with SMTP id af79cd13be357-9396dfc1dc3mr25293885a.52.1788365504773;
        Wed, 02 Sep 2026 09:11:44 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-193.net.columbia.edu. [128.59.178.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9eec7608sm21172636d6.26.2026.09.02.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:44 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 02 Sep 2026 12:11:31 -0400
Subject: [PATCH v5 07/10] ceph: remove page remnants from
 write_folio_nounlock()
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-remove-wait-on-page-writeback-v5-7-0b512e77e75b@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788365497; l=2482;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=rZI4wY7ubss2UkuIjYXh7kkv7IuPpkYYSXBGDgUAZ0U=;
 b=dXln4uVWRrEYHWoQ8PQuT8JNc9K2DQvK2z4cdLVYxjOM7rwnX9exKiApm3gO5UszntMYf6aAB
 go6AoGDiTjqD7mdfX+V9ZyXHXwoQZf9XYkxECSGpQg7/ggG9GhaQzij
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX81X8Bo7h+Rfj
 L9xwcvBP9QJz/Iq4Zw/jawk3kKNSJajIFgg4rGx2sdu+wF82DEE3a4frEBPCboQ5B/0p1PsFKGq
 BkkzM6Im8N32tno+bNNy9Zn0yT07XvUYMv23BL6kljJAvHsh6f4k
X-Proofpoint-GUID: ieoAu4goeKTGVKmqcP6tNCJJLUS5NEAs
X-Proofpoint-ORIG-GUID: ieoAu4goeKTGVKmqcP6tNCJJLUS5NEAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX1T8il7YmYSZl
 kA5WBLTbf/fik2h2XAXPzWkSNCb6v5/63nqgZmMU9MUZaHtzsiBOL5332cC7A6vufi3jZBvnVIO
 tBYegGfVKMMyEsVCj5rDtlj2dyaUpeIjJmqeT6yXx0b2Z60VJR37t2YxwHoK3GBL5GasXQIbS4Z
 dYipYsnl0SI5FQs8+nGKJJhNdtXMrYGiHxVyNWIIHYbcfjVtsat3uwhuH+OZgvEEQeX1UiDCsJt
 u8rXklUlHJPi2/txXD3HhqbbdOZT3viDcwagOpdsh5PZVwBNLGkN/5T67w8F3bThVpT+Y4pnFg1
 hTC4QEMhCG7vtW4VmnmuEwyqUYeZhqnEAJy/0pz51mUwWdqQse1uzYaWrtYWRM4CPbNaehRPSRK
 TNOE19vh0++m4+KmDaD+BaERM7k+6HBwI8MYOY36/EPQjQ7Kk3POOblu0Ya5GRiSerF06L+zXvn
 4Crt/WqbjMOc0alKW0A==
X-Authority-Analysis: v=2.4 cv=BpWtB4X5 c=1 sm=1 tr=0 ts=6a984ac2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=XwBYxoxBwSosfWEfMcqm5A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=nej-XM8oC_bN5SNaFc0A:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11894
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=10
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=10 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143

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
index b0deff481d95..8e761144e8fb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -563,11 +563,6 @@ static void ceph_folio_start_fscache(struct folio *folio)
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
@@ -594,10 +589,6 @@ static inline void ceph_folio_start_fscache(struct folio *folio)
 {
 }
 
-static inline void ceph_set_page_fscache(struct page *page)
-{
-}
-
 static inline void ceph_folio_wait_fscache(struct folio *folio)
 {
 }
@@ -748,7 +739,7 @@ static u64 get_writepages_data_length(struct inode *inode,
 static int write_folio_nounlock(struct folio *folio,
 		struct writeback_control *wbc)
 {
-	struct page *page = &folio->page;
+	struct page *page;
 	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
@@ -830,7 +821,7 @@ static int write_folio_nounlock(struct folio *folio,
 
 	folio_start_writeback(folio);
 	if (caching)
-		ceph_set_page_fscache(&folio->page);
+		ceph_folio_start_fscache(folio);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
@@ -850,9 +841,8 @@ static int write_folio_nounlock(struct folio *folio,
 
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

