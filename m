Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E873546FF
	for <ceph-devel@vger.kernel.org>; Sat,  1 Aug 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599510; cv=none; b=Hea3cJR10ClfCrAt0Wyt3eDn97Za7x/Pza0AVvwF7vEMVDmhZvSow+/6QA8gjiby75pVZMCnfCKbGWeV/RWynmk8BbpGIT6SdGyzrRh8cZeofR2UKRLqqgO9zReY6lJVMzTL49ByiQ5g3BrOTd4EbqicehY1eZdH/lAkx7ec09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599510; c=relaxed/simple;
	bh=PHUqDIjZ/fDz2a0/0v9uQuWQT4kuiEnCn87yNoeA1yY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceyifdA5bUClvJbDPSQaKkrcy4C3enoNl+neSOXUnCzBv/X2TqduG7VJ1UHPj5Gr1L9NGmie0qWAAbux0UxlM/mU2N0x1HFP0dt9s0AgTExi2DiuXa6R697wu3R9Oq2lZZpK3OCkDaOnTg62CXynyf7ZTNcQk9x92yvvSzo8XTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgBn7OYN; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgBn7OYN"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d02b4c3601so23014435ad.3
        for <ceph-devel@vger.kernel.org>; Sat, 01 Aug 2026 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599508; x=1786204308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ijUzk6DmoV2KfP6NttCifTbOeJnZ78uDbymc6z2HdV8=;
        b=NgBn7OYNrfRieIBwlg4KoAGaQqQTlisou0OcugD6Ej6l/TaCFca1OiqCFyMpkC//QX
         r3UzS7SaCQ0sXrHi0EcoqlS4Ji6HKYLrWuwEJBOJt4z4LQTy7a1Sd86sPqoLTYbS5LWz
         lNyKClBDTeDgtecTN+13oelghUTMJ+Rk9K+65P+ktmgYx3fzP29/3slmIrJuXwEcqjK5
         HZihhFREitU7d+ghO6rCdjhDYR9CoWDEjMYxL8E0TOjUIkmdI4wd6zO+NZR73cE7hvah
         7vUJQry9aFAW3SldEaNxvG9FSt2XLDzrfqX5y3najTxpF3VuU2eOA+ZOvct8Y0iX7o0C
         uKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599508; x=1786204308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ijUzk6DmoV2KfP6NttCifTbOeJnZ78uDbymc6z2HdV8=;
        b=IFQl72aMhY/9VHo0l/X7PYOubdx51tJ5jwCdjC2ZIvtBiW+/u7lQx4RhX3pjWVpyPH
         qi/LdhSR1kSB87kSAAau5SfgthJcbXFTbbrZp/E1cChKVspx8O2N71HVuaeP/VTUUi+L
         YJ7Rs9X3l2A9it3OJ1xDJ8G9j1LrcA4TctO8mPVF+w/2Z4FtqEaCzUPIFH27nzv9+b68
         bPDTxarZh6XxfGnXyftoDiMFWWPiEYxthnYoTOwJJhgi84dPoHf0xYFqCaWsXqqD0zxI
         E/JiWwXWBFzB4x4j/eh8OjCh6pkUvgSNauesKUOHHOxt03lEZdijMhYjCnDBfSBcloIg
         PbPw==
X-Forwarded-Encrypted: i=1; AHgh+RrfmGS5IwU/3Xh9/XiG0CFDi0qRtuMXDfye4jWYiU7MGUDuv0ibdktI0F66vJictovKNRVDfXshcRQ5@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQs6M5xb+fGC9DpChpfz9hBBNVQugxqgixg9g2RGEILxY34ON
	dlULVpIGwK2e+wrtfnTwaPr/IcsK55ctxgtj9ZQtB3plLfg/9u46KyjC
X-Gm-Gg: AR+sD116mcQ/kF3EQvh+9lDfPp+oxahfudsuk/4t+xw3x/s6Of9JoTaQX/dqRPrFu9G
	91F2neZIB9x4Uq8kRiCzAF6asmuQ7WBFb1g0lUjRsPdDjzyVaxtZzDz6jD9hqdjThW4mOhj0zR1
	rXawA9e2+6QyulXFDdU9l5Y/ZHcd62PQnDbXR0E906GGY6y6z2qC7evNrv4BaLiM6/g/jlhFECL
	gWSUu0x8M6BBFT+BAF5/ncdW3KgceZnSAZPM4yL6lr0n3WnVIM6HngejrtF+oSLtWYEtk/T0Jrc
	1oHOmrSZOk/dVBtK4gzxI7Ud1fEpSAtwRkqTLbGPF6yz7h4Oa4UvB8vlrovzcbad6RazH/MswdX
	4ieNgFxtJEtZWDPtVXNuXSB70nil6ukXcGPbJ92o9EyzhDxGfmvuv+H+d5OgC4qvMdW6UFiZovc
	BwMhPId0auFzKpeOM+N5sg93DdOScfw8qXwcK2pCLTV4+KhQPL5vVdWIGdUsfpGAMUgvV5wBlcK
	+dviPc6VUeTKz7ksLHWIgedT0wtlOcDlYxcilHtC37IvtDx6pmXdNtMIms=
X-Received: by 2002:a17:902:e945:b0:2cc:9179:335 with SMTP id d9443c01a7336-2d0521e87a4mr39523185ad.8.1785599508438;
        Sat, 01 Aug 2026 08:51:48 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:51:47 -0700 (PDT)
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
Subject: [PATCH v5 14/16] io_uring/rsrc: add uncloneable regbuf flag
Date: Sat,  1 Aug 2026 16:46:26 +0100
Message-ID: <65be6058af60c33328f9ccd8133d24e2bbbd0f84.1785596451.git.asml.silence@gmail.com>
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

It's hard to implement cloning if the internal structure needs to be
mutable and/or relies on other ring resources. In preparation to such
buffer types, add a flag indicating that the buffer can't be cloned. It
might be possible to add cloning in the future for them, but that would
likely need reallocating the structure and reacquiring resources in case
by case manner.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c | 5 +++++
 io_uring/rsrc.h | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 406619158fbb..f041b0db77af 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1381,6 +1381,11 @@ static int io_clone_buffers(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx
 		if (!src_node) {
 			dst_node = NULL;
 		} else {
+			if (src_node->buf->flags & IO_REGBUF_F_UNCLONEABLE) {
+				io_rsrc_data_free(ctx, &data);
+				return -ENOMEM;
+			}
+
 			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_BUFFER);
 			if (!dst_node) {
 				io_rsrc_data_free(ctx, &data);
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 98ae8ef51009..83aa86e6f320 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -29,7 +29,8 @@ enum {
 };
 
 enum {
-	IO_REGBUF_F_KBUF		= 1,
+	IO_REGBUF_F_KBUF		= 1 << 0,
+	IO_REGBUF_F_UNCLONEABLE		= 1 << 1,
 };
 
 struct io_mapped_ubuf {
-- 
2.54.0

