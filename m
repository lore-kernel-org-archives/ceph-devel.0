Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAF047DF88
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274213; cv=none; b=P2X+3Nnd1RIahBfTeWiJ+IzqXqj+d7AfSycjYVn61H0G2NgPUS65WZO6CuSTLxvaih5fkDIsTnHum9UF9kXb8YZ0RUDvY9WayP8VGpQACmw/k0rHqwLX0hQSP53/TNg4cS42c3sh8Tx3JGvv2WerwoR4MONydqta9I8zlnYHreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274213; c=relaxed/simple;
	bh=GOpsniia9YGwJC5+Tf9jZp7skqJgnlIpNpZfRP/ds68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hS0qzDuyhC/N0iNcGTLIuznQH81F95ljmKeIwFSfwVkHGEtrN0nAyEZC5NUBX3wg0c8aC3MEH5OyAS28crEmVeDQRTyThYDfeybPw2hPUi56PXDHou8fY8FU4qQtST+fWLvswEBQoZTKCiCijVwRdo3+/p95s+gQhn/zJnfYLGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5Ym4u/V; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5Ym4u/V"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4728c12ba97so237119f8f.0
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 14:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274208; x=1785879008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
        b=H5Ym4u/VExLT6WCLEE6Kv4YIjIw58vB034j8JEtU73/52h+pQnIHzfk9AFZZ7sYOjb
         8zlZzzwzcZzyJN9OYpWJ55tzNZb0Mo6Waf1q38cQDVRs8lfGOHXMPls5sh4/rm8Leqmy
         gXWt8McGH1ltozIKZ+VJYO62dYGsgiFSxlNJtrV9ymcJBGJA7MTfe0qICFv3efxNTiUi
         Ewfiu/Ea/sINTuGolpH0q03ARYDniehuDgUm3WrSEVB4y7Nf8kgeqlwD7CDcQQ4L8f8u
         Ao9Ov92XKpNK+yJ/fcgLbF6EbI1zlAJ6KEoSzfPPH9VNM8LzJsDWMTMZKpQ3fvXK7dMo
         lepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274208; x=1785879008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jomHTWh5pLJKgL2wIyki6K11K3ENYcuFeD6DEOIqSFg=;
        b=sHbsszRouybz4n55Mvj63Di3AtImYN517/wMQyFHNnZnlBeJ2Ih/A/4rUTY+PJIQzj
         DOTk68vrRtIZ8SiMCfxZUlW48hM7mUIkfX8QKtkycOOrhOqyDB2DU4FF8I06+/3X2MUJ
         m5Wg2jzLtECtrFEdH1zOqAKwM3UpkfeVXAsJfjm6/UB8XnArf4YMD2wB8RmkwgjvGQqG
         GBghq6LLavpqFzW0W6lxMDiPaaYdX3eg6OX7RWNNek67lXkHbQHgxdj1mHFuJPITGEot
         M+3A+yQQytHSVq47A2g/Wja1wyrhGqLT7dxXZ0TKeWpy29pC/fXGuGOopA674H9589gZ
         lURQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr463a67e6NnLvIkVvO3lnzgqRv2ai+3jVdaQQnacTQeJsdDksNJo/IUvoqwAVoCp6fCa/pUqJourE/@vger.kernel.org
X-Gm-Message-State: AOJu0YzzPLLmKhkLA21MpSPrOn+hm+Lhq5ssJVW0FfHgtMeOD4ItOjLi
	ZLNEQVE5oQB2NccCxaD0jupt1r3V2CZM+Taj2JlV+ICCqr6flCyAH1Ry
X-Gm-Gg: AR+sD13QxZxWVVSNBiY9qgnn46uI56daiZ8NS2zSJhW7DtHlh8E9iOOKf5veSEdha22
	+Tg3C0d83/ZSfgjZ0kKKiuNNVygDs7sqsQzwUAyVXN0M5lmInpjHxgwFv1+8x1IIatDC6MsazfR
	+iOIep7jTnr3l5xfV6IEZuWwdPnr5wjTKsVtWQFyzEs7OwnaLmEIYSuKVBZgHzvgZCUtNla4cMp
	7qVUw1cB2BKjTdu2XZPwnQhRpIIn3Mlstgg8/zSJCS8lWoJne1Wv6dxfo3AqufLOcnMQXv4Kf9q
	y/E2sIv21oyC+1OlgkTZ603yn7tOvOhhFE/hbrb//eWOlHVoTxjuJpidKjlv5+0ljS2IKmE+MyF
	4MfzA9GpXYVNNjw6BkgsqwHgYQyDz21cshoewokMGDIo8nOSEjoqvMNH7tK9DjTi306ObVSm/A0
	m2JVb6v4AGuxwemoGhpX7PWqv6/lMRr7gpbOCf8JW1eUlxgaCyxwVlv4ig8aa3EF65o/Y7jChrx
	4tcxzhVJfACIKYyBoc=
X-Received: by 2002:a05:6000:2f81:b0:47f:97a4:f121 with SMTP id ffacd0b85a97d-47fb1f108a5mr5045703f8f.30.1785274208062;
        Tue, 28 Jul 2026 14:30:08 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:30:05 -0700 (PDT)
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
Subject: [PATCH v4 12/14] io_uring/rsrc: add uncloneable regbuf flag
Date: Tue, 28 Jul 2026 22:29:24 +0100
Message-ID: <a138961611aadf950ce6ab9215f00ae888b8ce72.1785274111.git.asml.silence@gmail.com>
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
index 24fc3232a66a..d57e8a0380b5 100644
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

