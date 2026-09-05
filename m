Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AD53321B1
	for <ceph-devel@vger.kernel.org>; Sat,  5 Sep 2026 23:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788651031; cv=none; b=dMXhoy5T/3VUB/i+M8fYdNOrWyujKLPJZ+ydkVxp8aNBMxCAMgrYxN926ZwZ2MxvqfAf0+W/0ChWG0xjL/oePre2MWc0LFqeODjqNaj9ToCGc2MzGXGlN7XGkUUINf/xCmpXTyu3+G9m1F8bmF8uj41NSTDs2SA8SMLEsQL3ffc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788651031; c=relaxed/simple;
	bh=9WdIrSvi2Dd9/cHdtNtBKG51gzHcNlt3FXz2tP6eqRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QFUJMjUiyAlufUfSZk2bFYJYOG6CQsmOLwFrRvshZAy5W+z2ugkbPGgKozFjJZLGmRcRMcu5Ot/kC9GOhkonSxlM7Gf6aGaKfGgGpxrRNXbJrZuhbOdihxC9+/kC+HfsdIO5gET9Use5MXR/j8+yd1YHK1Uw+o66O8DzEgtxBB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=VX0n9pZu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=XQw+wjsV; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="VX0n9pZu";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="XQw+wjsV"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 685MZHnf2074496
	for <ceph-devel@vger.kernel.org>; Sat, 5 Sep 2026 19:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=B54jHdq0L65Xn0XLXmBrgVwFYd
	kF1OSwoP0TYJa2eCw=; b=VX0n9pZuIRIeaYeoPVxazG235pBKDYrMKPSf/gRBO4
	wXB8X/KliYvWiXqIMSlYxnSh4jgqtxsDzhyuCBOcO2CA4bxv2MoPKDHGJMUQk6tD
	Q2io2ogKJ64nRVJY7KY7KV66GNc+a4Sv7qB2Dg7FfFjx4XJ9RQ+2cqPeL9M3jHXp
	obJs4Nd7fc6uKpEZw/mZMymcMZujRjr6DxAc7qdmid0A7Xe9XN8ferYKk0zSFiuV
	K/ZfjcMUfkOVHU+fUOdwx0j3H4b5DVSXJ93975AxzW4WsUgTi0mej/G2wevNflT+
	3QAU/Dt6Jl96wkFixR9EMQl3l6uLBEBUNFXhsvDeIuUw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ggc6qbpbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Sat, 05 Sep 2026 19:30:21 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-52fbe82672eso40910191cf.1
        for <ceph-devel@vger.kernel.org>; Sat, 05 Sep 2026 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788651021; x=1789255821; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B54jHdq0L65Xn0XLXmBrgVwFYdkF1OSwoP0TYJa2eCw=;
        b=XQw+wjsVWGgiLwkaFbNb4HdAFASuED7lVfJpX5uiPiu46OVo0bWU/neUJvG10hh2Jf
         GC+GmNoH2SICtUEFSSEoJ+sqIJ3mDSV5Rglu7B31NpR3Y+PWrng42nuakJn060HXSyk9
         TeAlw4+GoMv5xlBlnDWxBtc+mXInIqbeqKuQTKy0gyPGI1gnOI1BAx+EFkVolbYCEMk5
         ntrIPj6Ztuyntr2hMzY2Od8Lsscw5YzpLCNDcSX1fyztN0dCJ9N31piI/Wx6tuiTiSJQ
         PkiK9l/oPUb7E/Ql06UqQWcheB2zz8236usF6VHfnQ0pxbQOiSy43mKt77SvHrVQu00c
         3H4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788651021; x=1789255821;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=B54jHdq0L65Xn0XLXmBrgVwFYdkF1OSwoP0TYJa2eCw=;
        b=Fp9nN2m4/Lxnz1ZmUZDiTM4Cl5eFxEKoj7sYDSf250N4ulJbnFLqlZvu0v3ZpjSMd7
         cr/SVzEGVnAa90SqP5T2LhKBNxJO+RguivEve+bYmawikDyvltJ1d+awm+hRxrOKQEEc
         ffvt+exd14VGCy+5GNjRSbhha9V2ZzoPqQRjFnNCc3a1zJLWwscMcBmoLpNMUts8g4Ss
         nCS6lZSMPaqV90vKEyHO2Lx9Uu+jaWT0dQJhfqYx+r5lAo4d+kt+4O8eLQSg/wbR18dm
         5i7U68O/zjgPkZ9oui0ZtleOCoWp5PncVaLuoJkSAowS7wa+2pafVTcjS66tVBbzIVya
         OzdQ==
X-Forwarded-Encrypted: i=1; AKwUvByWkc5STnYy0zrPykgTDaQAjIOkInRn1RWW+cHjmD1uDGZR6O03S0AAyKVaRVJtEUAbzEGtP4GtfyeA@vger.kernel.org
X-Gm-Message-State: AFuF++keBfRgAQLhlYHwqwmuoB9SwnUzt/RC49Rfn45uOsTimbxmK/sL
	Lbzo8SrumsNSL7xoGNLp9lE4MB+TrrTPE+KWzHm8RjhLbtCB6bKEgbZyBKOzKlP0DDyAM27/i2X
	DxyL9arRPwhzRAO5LzuZJ54M5T1zRCuTKJSqxvGdWGJjpGX6k29Gq52rGEnY=
X-Gm-Gg: AYBFou3rpDeFN/nriyWvfDv+CVe9JfzcLBCB+baTcXobufGo+aetvLJq23eSnyS8aFX
	PRht+WDqJZYJM3sqRsWxth26ORI8Jn3juUkkEQ8RAMWmYLmlbyhBtM2qkxZT+MdE/poQGQr7IaD
	tiSR8Du2NvNeq9dBqlL8Y7rZwhlE86aOwH1+GyadfK4s0Ru0VB5sFAW2+kGkRmKgRRl8mBXGM63
	zLLiLiBP5+MINns2+HWWcdru/P6eZEyKQsnp6rqCJ3vv2dU9SgMCP9xMbmu+vr5JajDh8zOkFHe
	BETmuhsJh6IhoTSDuPp9MlhSDzMScKZJRgKthC/puj/vM591qc9+dhU51Qud4A6NDg7dH9zguzQ
	SYnso0XhWfbN23qsMQsYvCV1KcjZZYlnM+QMurpKITrjAjg==
X-Received: by 2002:a05:620a:4609:b0:939:8d65:fa9b with SMTP id af79cd13be357-9398d65faa8mr934150585a.31.1788651021133;
        Sat, 05 Sep 2026 16:30:21 -0700 (PDT)
X-Received: by 2002:a05:620a:4609:b0:939:8d65:fa9b with SMTP id af79cd13be357-9398d65faa8mr934144685a.31.1788651020480;
        Sat, 05 Sep 2026 16:30:20 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-179-57.net.columbia.edu. [128.59.179.57])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb303b8sm559334185a.20.2026.09.05.16.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 16:30:19 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 05 Sep 2026 19:30:16 -0400
Subject: [PATCH] ceph: use iov_iter_extract_bvecs() for direct I/O
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-b4-ceph-extract-bvecs-v1-1-b1cf2c92b671@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAemnGoC/yXMQQ6CMBBG4auQWTtJIRWtVzEu6PAj4wJJpxISw
 t2tsvwW721kSAqjW7VRwqKm76mgPlUkYzc9wdoXU+Oa1gV35uhZMI+MNadOMscFYowgg7/UrZd
 wpdLOCYOu/+/9cdg+8QXJvxnt+xfKJiYbeQAAAA==
X-Change-ID: 20260905-b4-ceph-extract-bvecs-e9cf47164c98
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Cc: David Howells <dhowells@redhat.com>, Christoph Hellwig <hch@lst.de>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788651019; l=8980;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=9WdIrSvi2Dd9/cHdtNtBKG51gzHcNlt3FXz2tP6eqRQ=;
 b=II5bIK7NS983Upd9194ITOueXpAW59VB6rSFvaJMDvmucHL17W1ZSp4kx01n816BWULQEqXh6
 ZsCVjnsEao7AbsCznApg4pDRkrq7Wj+QrJdUNmlHr7/XzIOcnEJe5+O
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: BUjSY8lZXdx-gHuxOmxZ2MCHv3QQXNoZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDI2MSBTYWx0ZWRfX07K1N41XEx+r
 Lx+sqfGgnvMw4QxzzDMSX/oLeQUlZ1CvlNLPcpdLbp9LFsmhDMPhuVZvLTtaaQr27y8WHCy1Rxl
 PfB6rHkIPmdi2B/Bs8yIVd/XZCHDVAeCG1g+BMrjLspK+3aHeyLTjq5MSMj1UePfBq7Qb4kphvp
 vJdlzu5X6eyESfnGjObr2C+V7YCDQNwnt6+iy1xCkkUnPFnuOd37d2KI8APwGzRbrZSzpD4E0Pf
 eVeflne2x/I8M/Ol347J6BvOWOK1Mo8IPe/Dj80ctBcHPE+oENJsHh7AGM4inujR6n8Lfcriz1b
 NiwlYmkguDcdv/7cNvL3TTThMj5uA5F775iJL5KfKgp/IizyvhQ9u0MB5J+HWLTLH0tfpZ/h+2V
 A3gLG9PiqaSjw6Q/fAmVPJlRfI1gP5+/5e3YDLzfSO9tsdaeKLwmNJcAyceroszS5iQ1ooWs4xA
 6P9h5qPQu4oxShGxv0A==
X-Proofpoint-GUID: BUjSY8lZXdx-gHuxOmxZ2MCHv3QQXNoZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDI2MSBTYWx0ZWRfX+QmswvYG+RDS
 oBv356gNhSvbhcVcEJFG/BjXSV38xt7eZorKIGbN9kXoXgmRNlwVlysK19/w453iraX6Ks4gfL0
 0d3XDbL/G0kAudgdXNnbM5eA1tqDDeylufwCcl5j6OFv1hD295+V
X-Authority-Analysis: v=2.4 cv=Fug1OWrq c=1 sm=1 tr=0 ts=6a9ca60d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Qh9WKzuy3vK2roC+qB/eOQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=OIAt_Amlr7pWAP3joXgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11897
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 lowpriorityscore=10 spamscore=0 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 impostorscore=10 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050261

ceph_direct_read_write() builds its bio_vec array with
iov_iter_get_pages2(), which takes a reference on each page rather than
pinning it. As the page is not pinned, fork() does not copy it early for
the child and page migration is free to move it. If a process forks
while a direct read is in flight and the parent then writes to the page,
the parent gets a fresh copy while the read completes into the original,
which now belongs to the child. The read reports success and the parent
never sees the data.

Switch to iov_iter_extract_bvecs(), which pins user pages with FOLL_PIN
and borrows kernel pages without taking a reference. This is the same
conversion the block layer did in commit a7e689dd1c06 ("block: Convert
bio_iov_iter_get_pages to use iov_iter_extract_pages") and fuse did in
commit 738adade96b2 ("fuse: Fix missing FOLL_PIN for direct-io").

Since iov_iter_extract_bvecs() coalesces contiguous ranges within a
folio into a single bio_vec, release per folio in put_bvecs() with
unpin_user_folio(). Unpinning is done based on
iov_iter_extract_will_pin().

The bio_vec array no longer needs to be zeroed. put_bvecs() used to walk
all npages entries and skip those with a NULL bv_page.
iov_iter_extract_bvecs() counts the entries it fills, so return that
count instead and don't go past it. The array is still sized by npages,
as that is the worst case of one bio_vec per page. Cap npages at
USHRT_MAX to match the type taken by iov_iter_extract_bvecs().

This also replaces the deprecated set_page_dirty_lock() with
folio_mark_dirty_lock() and drops the on-stack page array.

Tested against a Ceph 19.2.3 cluster with KASAN, lockdep and DEBUG_VM
enabled. A reproducer issues an 8 MiB O_DIRECT read (libaio and blocking
pread, with and without THP), forks while the read is held in flight by
pausing the OSDs, has the parent write to every page of the buffer,
and verifies the result. Without this change the parent loses the read
data in every variant, and with it the data is intact. The AIO and
direct I/O xfstests in the generic group pass as well.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ceph/file.c | 81 ++++++++++++++++++++++++----------------------------------
 1 file changed, 33 insertions(+), 48 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index dafaa59aea67..06023233ecb2 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -95,52 +95,32 @@ static __le32 ceph_flags_sys2wire(struct ceph_mds_client *mdsc, u32 flags)
  * need to wait for MDS acknowledgement.
  */
 
-/*
- * How many pages to get in one call to iov_iter_get_pages().  This
- * determines the size of the on-stack array used as a buffer.
- */
-#define ITER_GET_BVECS_PAGES	64
-
 static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
-				struct bio_vec *bvecs)
+				struct bio_vec *bvecs, unsigned short max_vecs,
+				unsigned short *nr_vecs)
 {
 	size_t size = 0;
-	int bvec_idx = 0;
 
 	if (maxsize > iov_iter_count(iter))
 		maxsize = iov_iter_count(iter);
 
+	/* iov_iter_extract_bvecs() only handles one iov_iter segment per call */
 	while (size < maxsize) {
-		struct page *pages[ITER_GET_BVECS_PAGES];
 		ssize_t bytes;
-		size_t start;
-		int idx = 0;
 
-		bytes = iov_iter_get_pages2(iter, pages, maxsize - size,
-					   ITER_GET_BVECS_PAGES, &start);
-		if (bytes < 0)
+		bytes = iov_iter_extract_bvecs(iter, bvecs, maxsize - size,
+					       nr_vecs, max_vecs, 0, 0);
+		if (bytes <= 0)
 			return size ?: bytes;
 
 		size += bytes;
-
-		for ( ; bytes; idx++, bvec_idx++) {
-			int len = min_t(int, bytes, PAGE_SIZE - start);
-
-			bvec_set_page(&bvecs[bvec_idx], pages[idx], len, start);
-			bytes -= len;
-			start = 0;
-		}
 	}
 
 	return size;
 }
 
 /*
- * iov_iter_get_pages() only considers one iov_iter segment, no matter
- * what maxsize or maxpages are given.  For ITER_BVEC that is a single
- * page.
- *
- * Attempt to get up to @maxsize bytes worth of pages from @iter.
+ * Attempt to extract up to @maxsize bytes worth of pages from @iter.
  * Return the number of bytes in the created bio_vec array, or an error.
  */
 static ssize_t iter_get_bvecs_alloc(struct iov_iter *iter, size_t maxsize,
@@ -148,22 +128,20 @@ static ssize_t iter_get_bvecs_alloc(struct iov_iter *iter, size_t maxsize,
 {
 	struct bio_vec *bv;
 	size_t orig_count = iov_iter_count(iter);
+	unsigned short nr_vecs = 0;
 	ssize_t bytes;
 	int npages;
 
 	iov_iter_truncate(iter, maxsize);
-	npages = iov_iter_npages(iter, INT_MAX);
+	npages = iov_iter_npages(iter, USHRT_MAX);
 	iov_iter_reexpand(iter, orig_count);
 
-	/*
-	 * __iter_get_bvecs() may populate only part of the array -- zero it
-	 * out.
-	 */
-	bv = kvmalloc_objs(*bv, npages, GFP_KERNEL | __GFP_ZERO);
+	/* Worst case is one bio_vec per page */
+	bv = kvmalloc_objs(*bv, npages, GFP_KERNEL);
 	if (!bv)
 		return -ENOMEM;
 
-	bytes = __iter_get_bvecs(iter, maxsize, bv);
+	bytes = __iter_get_bvecs(iter, maxsize, bv, npages, &nr_vecs);
 	if (bytes < 0) {
 		/*
 		 * No pages were pinned -- just free the array.
@@ -173,20 +151,24 @@ static ssize_t iter_get_bvecs_alloc(struct iov_iter *iter, size_t maxsize,
 	}
 
 	*bvecs = bv;
-	*num_bvecs = npages;
+	*num_bvecs = nr_vecs;
 	return bytes;
 }
 
-static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool should_dirty)
+static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool should_dirty,
+		      bool pinned)
 {
 	int i;
 
 	for (i = 0; i < num_bvecs; i++) {
-		if (bvecs[i].bv_page) {
-			if (should_dirty)
-				set_page_dirty_lock(bvecs[i].bv_page);
-			put_page(bvecs[i].bv_page);
-		}
+		struct folio *folio = bvec_folio(&bvecs[i]);
+		unsigned int nr_pages = DIV_ROUND_UP(bvecs[i].bv_offset +
+						     bvecs[i].bv_len, PAGE_SIZE);
+
+		if (should_dirty)
+			folio_mark_dirty_lock(folio);
+		if (pinned)
+			unpin_user_folio(folio, nr_pages);
 	}
 	kvfree(bvecs);
 }
@@ -1325,6 +1307,7 @@ struct ceph_aio_request {
 	size_t total_len;
 	bool write;
 	bool should_dirty;
+	bool pinned;
 	int error;
 	struct list_head osd_reqs;
 	unsigned num_reqs;
@@ -1469,7 +1452,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 	}
 
 	put_bvecs(osd_data->bvec_pos.bvecs, osd_data->num_bvecs,
-		  aio_req->should_dirty);
+		  aio_req->should_dirty, aio_req->pinned);
 	ceph_osdc_put_request(req);
 
 	if (rc < 0)
@@ -1560,14 +1543,15 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct ceph_osd_request *req;
 	struct bio_vec *bvecs;
 	struct ceph_aio_request *aio_req = NULL;
-	int num_pages = 0;
+	int num_bvecs = 0;
 	int flags;
 	int ret = 0;
 	struct timespec64 mtime = current_time(inode);
 	size_t count = iov_iter_count(iter);
 	loff_t pos = iocb->ki_pos;
 	bool write = iov_iter_rw(iter) == WRITE;
-	bool should_dirty = !write && user_backed_iter(iter);
+	bool pinned = iov_iter_extract_will_pin(iter);
+	bool should_dirty = !write && pinned;
 	bool sparse = ceph_test_mount_opt(fsc, SPARSEREAD);
 
 	if (write && ceph_in_snap(file_inode(file)))
@@ -1630,7 +1614,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 			}
 		}
 
-		len = iter_get_bvecs_alloc(iter, size, &bvecs, &num_pages);
+		len = iter_get_bvecs_alloc(iter, size, &bvecs, &num_bvecs);
 		if (len < 0) {
 			ceph_osdc_put_request(req);
 			ret = len;
@@ -1639,7 +1623,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 		if (len != size)
 			osd_req_op_extent_update(req, 0, len);
 
-		osd_req_op_extent_osd_data_bvecs(req, 0, bvecs, num_pages, len);
+		osd_req_op_extent_osd_data_bvecs(req, 0, bvecs, num_bvecs, len);
 
 		/*
 		 * To simplify error handling, allow AIO when IO within i_size
@@ -1652,6 +1636,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				aio_req->iocb = iocb;
 				aio_req->write = write;
 				aio_req->should_dirty = should_dirty;
+				aio_req->pinned = pinned;
 				INIT_LIST_HEAD(&aio_req->osd_reqs);
 				if (write) {
 					aio_req->mtime = mtime;
@@ -1719,7 +1704,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				int zlen = min_t(size_t, len - ret,
 						 size - pos - ret);
 
-				iov_iter_bvec(&i, ITER_DEST, bvecs, num_pages, len);
+				iov_iter_bvec(&i, ITER_DEST, bvecs, num_bvecs, len);
 				iov_iter_advance(&i, ret);
 				iov_iter_zero(zlen, &i);
 				ret += zlen;
@@ -1728,7 +1713,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 				len = ret;
 		}
 
-		put_bvecs(bvecs, num_pages, should_dirty);
+		put_bvecs(bvecs, num_bvecs, should_dirty, pinned);
 		ceph_osdc_put_request(req);
 		if (ret < 0)
 			break;

---
base-commit: 190736464f4572bfb360fd3747fb827493e02e09
change-id: 20260905-b4-ceph-extract-bvecs-e9cf47164c98

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

