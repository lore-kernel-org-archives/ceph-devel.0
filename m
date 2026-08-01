Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4EB30EF8F
	for <ceph-devel@vger.kernel.org>; Sat,  1 Aug 2026 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785599321; cv=none; b=mBKTK4uAx0CFX6L22pfyDqgRr8MjKV/bySiu2C8937QiSmsTrNdescqBrX0j+lMLmHWvsZTuK5kRbieqkgqIzG60PvjHxB5IfydLlH4CoN4S0sdwOVitRG/F0bZ2ek5EJwHt1d91rpod0Dv5PxnhFd0nH2dWFRT42CF0gZHoKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785599321; c=relaxed/simple;
	bh=1jBAtnFGRJ/F8gXs/co1VF+epb8VpkeomtOw2fyD9ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N0lsf9Pjn3PfA5gT6AbqtOxGxw80Hx+q6qO0pYBwHQwN0I+ivJNCzHzIP22/sxWTiEBYGcQ8aFEACUJjTKXtShTk7x629SSps2MfFXfgPFhRAbWsZBolqErwchnVYQGjTTd0wNYSdwynGQy0ab+6/XRvgpkffc7mnQsGUYY5ALY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mfc1+mx3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mfc1+mx3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2caced6038eso19726005ad.0
        for <ceph-devel@vger.kernel.org>; Sat, 01 Aug 2026 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599318; x=1786204118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fyuZF+rseQvIVevAALiITcY143h/8lAr4kofVhDXVW8=;
        b=Mfc1+mx3iaWZQWiA5QbqTZ5Zw+/2gz7kxceU2jPXHLFc7Q551+c6i9znSKBY40Mkzq
         nNqleKOAjLfLlqvNbSdbx8mSOGzT+mcVb9LdOvSnZDurqec52Ik42xRqu3/XDqdmM6iQ
         phiNHZDOOoTJNIGi/wJSHcNqv9HCobynIk3XdFlR+UzJK4EA2YqSHNu3UBwuHnb9dGe8
         pUZa4XywpGm7sKEwummT7fdZUxHFNHWyz49tJRuLiaKVi0UuvTQWzyX/TvZo0grubca6
         AiqWBvrzLV02UC8WX+M5waI5pApeOP3t7+NQnPkP3HY62bGqbKua4X02C9O8YktU+rZy
         Ft9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599318; x=1786204118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fyuZF+rseQvIVevAALiITcY143h/8lAr4kofVhDXVW8=;
        b=MSS+Zy80/sDdIgxdVl+seFg6EXjS+FxHyidwhlrBkfVE2mOJxIP/u7yjsvSC7sThfh
         Z4O9t8YcepwgC8MEhndFFvnp/QTLKcYYTR2x3i7zCqpqSIFANpxGNQeXIl3FA9tnu3HS
         rPWkTmyLONFYc+i+5LjGyqUYGc+9FgKAWSQS6LgpmYSrG5V4zSS6FpUFIErXKjXOzjfG
         2LtfGbkMuzJqFIwiwmaoy7MPCJ/+Dcm8bNf9uq5R02yQqA1+FZKuEOuatktumdgbyhR0
         JjiCuHuBIl+uHspA/8j/jHKrwc14/rLJzqHM1QMID3HeVATtzgzemb0uaEot4Oadmsw+
         jpqQ==
X-Forwarded-Encrypted: i=1; AHgh+RrsGItzSOOAONZkGsBsiy8/g/HehPhmVteXBXnC/ipGT9bwL42jenAR8K9CvRrc/H+SBnKadZTVfiEm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw60eQJz70A7/ilMBctsr5jLV4boGBNa60VeNMpA0lj1jHxVNn1
	95rs7+byuGCermC3c9lz9YSXHFxPtL14b0w5mzYIdmUeKMt3qTYR3RxY
X-Gm-Gg: AR+sD10DuXP3U4P5KVGMUUMqFpnPgFs90QRa+FAognBZ5cwNiqzjrdtFu3Y3dcwTd1z
	7YD6hC/WlK8jQ+3RpuhT/ZuSO2zPlzJJwpNsB0PN611wMTdkwySaN+LFjdkfKFwH5i35vDij2Ef
	b3eBDsRtCp/JhI832z0ZPfn5FuJIKxjKuzb5tiaiVaU6f4BwCiu15T64DhsF7hp/z3dgYreW+kj
	5Nr6AtS2O/EECXz6H6nYc1VHzlSi/3FowxbtahdBYkzfeifyKzfq7XOR4K//eDFPJQmNDDyZkuX
	BhJgeNrQ70cOY1tCRvR70IfCdBhMV7pb2ITd2TzuEeLAmiKvbNVyFqQ0MKKfcijn/w4rAMaMqw5
	KT6AlpAesEBfVRbANZ46J6xWxOKmhKk8sb9+AnEbT5K4QXcnSqnrN/wkk535CcTPbTB68XOovpa
	wjHNpGOsDet1lGp2x0yX6m3R3X2BV69nyFyPtw3n8NAqln66bfdNxwmCzWiLe/vwK9ZwBU3ZC52
	W8ewy9dAR5gFoFPKuFlpf5DdrGLjalU+lmCLcHYS//bMDs=
X-Received: by 2002:a17:903:2c0d:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2d0535b3b1amr33657505ad.7.1785599318082;
        Sat, 01 Aug 2026 08:48:38 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:48:37 -0700 (PDT)
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
Subject: [PATCH v5 05/16] block: move bvec init into __bio_clone
Date: Sat,  1 Aug 2026 16:46:17 +0100
Message-ID: <6ecfe8f9b1c6bfb8665fba7daf55d9ad7a8a3243.1785596451.git.asml.silence@gmail.com>
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

Consolidate bi_io_vec assignment for cloning in __bio_clone to keep any
further changes in one place.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4074a0496b93..00f99d03ac91 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -860,6 +860,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -902,8 +903,6 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		bio_put(bio);
 		return NULL;
 	}
-	bio->bi_io_vec = bio_src->bi_io_vec;
-
 	return bio;
 }
 EXPORT_SYMBOL(bio_alloc_clone);
@@ -923,7 +922,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 {
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	bio_init(bio, bdev, NULL, 0, bio_src->bi_opf);
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.54.0

