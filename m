Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113964756D5
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274191; cv=none; b=tDe9qfRdUMFuDK21lg6qwA47zb+HS2SwB4RIBevYeMHUFfq52cKkPGBSy9geoYZbgHr0jlEXkcUESLogyQ+Ti2ALO9A2pc+JkvEXwPd0QpCDPq2XMim6GKR3Hb3ZaunU4+m0COksuGv2nEJTpXTXFwl5BvirHAxx4ygMY8M1ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274191; c=relaxed/simple;
	bh=7Cx4C9dxI3ZjGFKQyK7oa4f12dQmgpPqsHOYLKXis2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzx+Ot3HEvs8N+loCiU0k8bs+XaIoGGw3KIq380XeL0ueFhK0VjptN/b7Y64XbQYWprn9heuB4MLPFkSiLQ9edMuRe5igKXJ0+3X6Ai+s6OpiozImvALT9smpeJALoNdZ1pnfQ5JmBiZxo12/IPxzvRe3sorWxMlkXyftqQaP7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oBTxOknY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oBTxOknY"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f96c5b722so199062f8f.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274186; x=1785878986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uu/V2cY9fiEPZWKdFNoipI3xUZZg8n/4RaaqV8GEYhU=;
        b=oBTxOknYDHxP4heVZhIQDq8Q0jSpdfSjAaECVqDGe9wTFy/5/I1Fo/nGrsqUGLnuFh
         /XlAjUFY5v4DGSaUYshefy/6TRdbhg71yhJGZRGdoOfkkkLY2QleYznJNCsa1+8v/J5l
         k7736kmAGwyGdcTFJs4b9D4pN6mwUptXcfu8a3aVVuB2XQYud69TdF3R3RqzGVMmQFu4
         YhSvoO3/e7145OOZN3qPZaa8a9cD1Df8hJLr270/aazqVf9UJ+JZqwdpy43iYznYMH8v
         qIbhc91fXDZwOo9hjTH3t1lt698arlny1wJn68S4KKBRN2z5YJCicew/K6FbF+h48aGO
         CHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274186; x=1785878986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uu/V2cY9fiEPZWKdFNoipI3xUZZg8n/4RaaqV8GEYhU=;
        b=Sk7NnzSD3AgA4cO8SFBWGCcee9NfhSbdCi1SOHcme2jFDRZKLT42QWvYnRdxiyhLUm
         4pyE9akXDsBRVSqvEWZ6o2Px9jGDsSvkRoZMLyUUrRcdnIdGD0JyY4GgAj0WtQUtAGH6
         fSaUbORemXS2WzlRH7LS9ZNY4eC6twcpDXx25eFO8WpedauVmw1pNQlLIa5nqNtSyZIV
         or5tbR67x3/yqjj64EucD4h0xp5NVS+hT+CCBh60Lp6wSuhDqqhLmQ1FmNqmwvbag7k8
         rvVhPw+FQXa8Z6c7uZmFlq+5+TsKSTzUTELgHdOxrXMNBlgnZUbmjzBl86mLHsiTSvF7
         UJYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr1YmetAmZEVYzbMjjYNZig88mi3xKTk47HCnV2H/5FfMlREx09VynlWL7+HnxcMZEO/ttYIxP8DyQn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxajd2dOPESLtn2P7FKiZd7VjBEe3Uf7NXH6+u4Iylu8x2qo1U/
	L81ZuLHWNHtRUuz6GW3NQ99nYBt/J4eSrd80wUPamQbAPPwaa3AeOO5I
X-Gm-Gg: AR+sD13iKxC8mHvBmmGFX3I5/0EP1Nw9H1acXtIgui2YtRRAkwzLWk51XKicSdYmg/u
	6W5DhQu9feKRpPonvPdESqGBheeIwGdFZjupaJ3aSIRequUQTx/431z5BqErORNzalAXgifC/8x
	FnwQwXh8iPljgesP7JT1TClq6SU27vo29BGpl+ppTaBzCwuBUrgC/aJD+wU3/6Q7FJ+Le+/5Q0O
	zKilb9dw5AgDLNLNnJ7XDPrAA+L0ImyrOX7t5Roi63VS9Rss/s+UZsDPxotgJmKxjFSfnDUzhfi
	N+D5+z0v1ELouxZL3HtD7O9mZopPGd3NW5lxBBLKwL0rJP1YmQCGUxbQ1l6gNXTUIM2mb+p+g4A
	pFVDmApXzZaTec7M+qi8vz+8nWCv2/eB2PWixblecPZ7MP23+Ryr71GYn6mkuIg8QCNeKDKFAVJ
	VwKMDKqRXKjs57TjNyOYfivtT8wtc2Pd1VqDiT20cTsprcbfROLlt7Rn5Uys2kc7aR+hq57P6tr
	IBcluXKMo8bCTv/2mo=
X-Received: by 2002:a5d:584c:0:b0:47f:95ce:6f48 with SMTP id ffacd0b85a97d-47fb1ec9671mr5039007f8f.11.1785274186132;
        Tue, 28 Jul 2026 14:29:46 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:45 -0700 (PDT)
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
Subject: [PATCH v4 02/14] iov_iter: add iterator type for dmabuf maps
Date: Tue, 28 Jul 2026 22:29:14 +0100
Message-ID: <132442812a40277a5904cb2a8ca1e02f4f6e82a2.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
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
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 11 +++++++++++
 lib/iov_iter.c      | 29 +++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index a9bc5b3067e3..6c31ec131a71 100644
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
index 273919b16161..6398b306d0e2 100644
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

