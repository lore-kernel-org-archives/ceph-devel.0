Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AEE36196E
	for <ceph-devel@vger.kernel.org>; Sat,  1 Aug 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599261; cv=none; b=fZieQJn6SMhVP7jGPHrp/hkmUhaDZ8Yu7da7hHUULusr6+LXMRGZv1txlBe8bsFuH7R6uRkp348IruJqONFNtb6obbWQl49sPzrXPh5cfPc15mXf2YTJ72x4aVMZwsAD0hndgHdamKzHkEFRkHZBbEUrHkE7+HdolNY5LVJFHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599261; c=relaxed/simple;
	bh=Sk885w4deQUdDIZkngs+gEwd3P7jw50PmIJ0N6VNkjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aezElggfiSEpivrYXHXc82zw0RsDkqjkMMba7dV1IALuxO5DCmVO0NfbRo9e7ogeOzeeX2i5/h7UJFJKgUXvUKuhByOUHMdXvtQqGp/wJ2Xm2noaUKH5ZeTbLe0rmtscB2dU2Sk6dzjWcO+ryI8/zI+bEHe22DXGm3hxMfdZaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnZIGVMa; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnZIGVMa"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ceab75934dso22602085ad.2
        for <ceph-devel@vger.kernel.org>; Sat, 01 Aug 2026 08:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599255; x=1786204055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JlAMfxnCI+4aukUkFCGEvLd7cna91lGu4ajCL8U6GrU=;
        b=AnZIGVMaeM7VNzhjV69IBYj69IGlN8AkwrX08snF88V+gWeBxQdHr722rrQs5E7nCQ
         9BEfnfmP0tNpVRZCdLsJ+K4T6eTuutyxtmLWlD7gSp9QwXpG0uzPc6rRk00bVAfdga1P
         c92UpK293K23Gk7Wvn6q8b+ioEd/E7Ov5zJlC3rx7Ec5smQyqRvP3ZJOxxmaYEjSU+VS
         lP4i2FVHQ21Z5ordwM5KxsD3vDeT2yOZnUYvcjE/kVrJLtVzJGItCrsyqfJRXc9blS5l
         2B8jZ3gZeQUnH3OS5Cva9kOFKpsJg9KRVLrfWFcAr7G31zOGaiH5ed1ChYPl50HLqYxe
         yQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599255; x=1786204055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JlAMfxnCI+4aukUkFCGEvLd7cna91lGu4ajCL8U6GrU=;
        b=JIZOxfvElIuItins5Egs93GZhaK81A0TYl8F9R1H6sZEf6HOXUNEoQqMo99a0V7gn/
         YrOmyoRuHDqHomiilLdIQHXDPlSVjcGEb9C60FgrUmknRm1UHzh0XBPPHFXWdqj1LzSh
         tGp8omGxjjut3OJYjURuFPcCF9kqhzDJFL1kitUdCDsxLSUrJ96TPTo6i6pPEPtotvgP
         W74qItHK4ExRIyJg6F7X8y0A/4Kim3r9wiri/gMo2mkSmlkTDRfXHDKz5ccDapN5nX7R
         zvsZFyD2WmAlNEJm007Drunnwgm5d02aTBfRkzPeRQMWRFG39qCPFSaqoayLF0Yo8k4f
         KepQ==
X-Forwarded-Encrypted: i=1; AHgh+RqR0acxyXDExVb+hL5wYKZLRbiTtG193QG+FJTb6ti5uwkZDRit8eipotkumDr8pmc9IqvkGO6Z0YSu@vger.kernel.org
X-Gm-Message-State: AOJu0YzUFMvXuICRolihoDeB/lTCrOauHvrmQGXqVli7NUKDTyk0JQ5A
	Yu4mv7SjCp/guGjWFKskC+h5wDCZgp2Je6OqB9cTNsGF39b2euQ+O+Qk
X-Gm-Gg: AR+sD11NdxYeTt2EpVPL7XLTw+aj2xbVaP2CE1z3lAZH/DNx+VGvGLgsNYeHYdozfLz
	PQk+JA+IX5DlazVh/5Dgg4CldbHtIqIFAPGrYfJJR4ypI2qbIalkXvDNYcBo85GNbrpi4cR9t0W
	znQO4BKOH0ztJbKjojh9BbbiLrhsnuBDJqYtJtAVEm2LzdyGf9T8KCFV6g7d7UXMKklab04Ig5e
	rD4U0R60J0Nj/oyabVsAObnWJST+/TngKDtM39AkBoirfL6Eb1io4DEdESDGNcLfN/YsWdqmbQD
	nf+YN1ot9hQ2E/2hypET4l1NqAu5YsasKye1P7rqpPJECqYiFgTLb9CPKXDPtv2BIpyCu5qqPiy
	CYlRJOmPVNTZxHraTHWx1NqJzodwIUupFG/SM+/uTNIG4pVGIoYZVzcQoEjCi5Nh+OBX+V6dGa9
	13nzLs+HdNRGTqo+1KiyTzJh5eK+R/xd5jJjcNYxjd76INX9Iw+SEJK5PflNH//yD7Af9pZ9Bd1
	6RZQCfuiHKH1Zf8iu5taiCcp4kEj7EZs0i8s10eIqSSz1NP2mmlD1pfFH0=
X-Received: by 2002:a17:902:d2c4:b0:2ca:e5c:7fba with SMTP id d9443c01a7336-2d0524da9d3mr35313785ad.39.1785599254851;
        Sat, 01 Aug 2026 08:47:34 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:47:34 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 02/16] iov_iter: add iterator type for dmabuf maps
Date: Sat,  1 Aug 2026 16:46:14 +0100
Message-ID: <c1ab6c0db3853b339a89aee0b1a9c5ac0c48b79e.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new iterator type for dmabuf maps. The map in an opaque
object with internals and format specific to the subsystem / driver, and
only it can use that subsystem / driver for issuing IO. The task of the
middle layers is to pass the map / iterator further down, maybe doing
basic splitting and length checking. The iterator can only be used by
operations of the file the associated map was created for.

Suggested-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 11 +++++++++++
 lib/iov_iter.c      | 29 +++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index fe2e985d74d2..638c1116e912 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -12,6 +12,7 @@
 
 struct page;
 struct folio_queue;
+struct dma_buf_io_map;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -29,6 +30,7 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMABUF_MAP,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -71,6 +73,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				struct dma_buf_io_map *dmabuf_map;
 			};
 			size_t count;
 		};
@@ -155,6 +158,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_dmabuf_map(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DMABUF_MAP;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -300,6 +308,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			struct dma_buf_io_map *map,
+			loff_t off, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 34a52e9ba9e1..de5c1040a4a0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
 		size = i->count;
-	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
+	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
+	    unlikely(iov_iter_is_dmabuf_map(i))) {
 		i->iov_offset += size;
 		i->count -= size;
 	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
@@ -631,7 +632,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
+	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||
+	    iov_iter_is_dmabuf_map(i)) {
 		BUG(); /* We should never go beyond the start of the specified
 			* range since we might then be straying into pages that
 			* aren't pinned.
@@ -775,6 +777,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			 struct dma_buf_io_map *map,
+			 loff_t off, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_DMABUF_MAP,
+		.data_source = direction,
+		.dmabuf_map = map,
+		.count = count,
+		.iov_offset = off,
+	};
+}
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
-	if (likely(iter_is_ubuf(i))) {
+	if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
 		size_t size = i->count;
 		if (size)
 			return ((unsigned long)i->ubuf + i->iov_offset) | size;
@@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	size_t size = i->count;
 	unsigned k;
 
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return 0;
 
 	if (WARN_ON(!iter_is_iovec(i)))
@@ -1469,11 +1485,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
+			 !iov_iter_is_dmabuf_map(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return;
 	/*
 	 * For the *vec iters, nr_segs + iov is constant - if we increment
-- 
2.54.0

