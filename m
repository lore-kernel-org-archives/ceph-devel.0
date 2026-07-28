Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A8247ECD2
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274214; cv=none; b=cCe+crqAZoE3kKP02bdpW3CzZPdPptvREmrKj9XQamYaFuT2zgcBS73ltVyg6fd+nQeZQ2b5jg13egI3FPCpjC+d2ycqBm5VJoz6B8d9Q5UBN+xBUk+lvxYiQvHzEhmq9r/5Ie7Lf3IEuchq4XjR8WemRoe8WonOy3fjkmLGpew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274214; c=relaxed/simple;
	bh=bt1fjQx57j1sUPSIKU54YXB3emwAGpiLG3SIBERbcvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MM4ijPhRnebatPBLvT2EwWZSRp/LUlnoHMIqFnQBfAZkaxbSIVBejUVIj08/LsHN8QK/0rLFRLswb92LuV8kQlHJxxL5mGVarUA8ZHrlMAG+ALHNJK4mlJ+ZmrbXgQiOh2YDoDxwpYjQEz37gfDyQPkHq0YsxX5XqbWRuhlfsIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3I3XC6d; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3I3XC6d"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso259712f8f.3
        for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 14:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274210; x=1785879010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mhCvEG3xgv0esCi48jrWlXZeUf+lVK0keP2zUsWb1Q8=;
        b=D3I3XC6dQ/oOKK2O/2ofvHmwDqjhElP2Cr/usPPiueWfnxSn291o1UoHCTlZeOOIVL
         4D0hz6PHOvhptiOnA2XMfGCTho/jrTmMeHMeaiKcW9CXsuQqojpwhUvNpCaMoyyAh7il
         T3/CXl9KoCt22vkEBKM9GTdSMrEIiT9rxrEfM4phZpjjKShmuR8flxyCxHxCWuoyylrJ
         jNJsleztVMOIFqxHPMpw2oqJ43P4msMjLX4W5xT0180dH0o09UsQDoUmJywdzP/RE8uF
         zDmVjFxxGG8kn34gn5KiBCq6veaRLjHl0rFSQu1Nou8MfP9W+dfpVN+PP4dZdFQ2guM6
         c0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274210; x=1785879010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mhCvEG3xgv0esCi48jrWlXZeUf+lVK0keP2zUsWb1Q8=;
        b=apDNHEPyCDGRiuWCCUNQmn8i5l8PQp+9wtlIZRSznLVGVhFgXnls3uxkrVaJZCF69F
         4x8UD5A90njDjCECLknWYzwf2RktzONEoFmyc2RDHSXP/4++h44yKKMwTRCKHraXwauV
         EsC7uUyCIRzijgU16krHoAeHSwUqVhaPvif1jxVAWVVoQgXc7o9/cNurzfnJOC6sATVD
         HrVAluHwAOpcOGTz8GFBlDhMXjPMh54S+LsOoKBohya1BPbrEZnmG+wvWoZ7NiViBI2C
         tt+zVNlu3uwHwDu4ZgagCeWnn0Tqi/c/LjtgdRDQf3s3W/2U6FevnPI1NvcKYSJEq9kZ
         Mvsw==
X-Forwarded-Encrypted: i=1; AHgh+RrcLGEf+lg1mRju+cVXtdpZo2AP4fzedN/yDIlTvEPnYvmzpvYaBAqXrnuvV0klnKR0Txgh5RC3QZYr@vger.kernel.org
X-Gm-Message-State: AOJu0YxlOzkjOVEWCsWjxftGFqD8ME3M8Ao5arcGmwv33XJc6yZy+t9n
	w1RtaZl0RPeIbPlE50dOyjFx5PddFfDxHRe+iEIDsZkBoFd4de9tLOua
X-Gm-Gg: AR+sD10+rVUunU3o2zSZNi+uYRH0dW+i/ZRdWwBE2OLjyGqdKuCsv9c795Kh3H/g0Eo
	g6DU/gbwnYPX4nFCWTH4512Sz+gHDNLx93lz28PMEcjiabrEzTQ+G4A1ZNcapzCA58cYLF5V1C7
	My57MpDf7BQAeNCV3L3/2N+gqb3iLubdvK2mDgjRysTRM/Jh0gR+8nwK3o+LO6GYvmO40qv6Ym6
	7q+nmWLoVBLgq2vWOZ5xnnGN0V0LicWTsRYL20AZG7ZGzMhOECU8DVv0vLFVQsAgbkvdUthT3Ve
	ZSUFrwPDeElDGn1vXBkEgAbmcpchnUivMOgPS9UEbnR5Ax6zC75iHPXI2l43Zx1DdYKdhuB5VYM
	qDGvNtHzyP1zj1xeptJ0zCwtglqwzRNe7bI+ejAQAX9H7CeybUJXa+k2JM2gi6VVxpsqN3G0VIa
	ULOUb8oko5nO1yhxKzaHIEJwHyWU9hugJj59cvOQjagyFb6baNg4WT2kbBZqKi03zs/iZxDPLVj
	lvF4JF0
X-Received: by 2002:a05:6000:26c1:b0:476:8a:5 with SMTP id ffacd0b85a97d-47fb1f12d18mr4496873f8f.34.1785274210211;
        Tue, 28 Jul 2026 14:30:10 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:30:09 -0700 (PDT)
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
Subject: [PATCH v4 13/14] io_uring/rsrc: add regbuf import flags
Date: Tue, 28 Jul 2026 22:29:25 +0100
Message-ID: <9eac63cb6aae06f591e6d0c67505ea2c16dd99e6.1785274111.git.asml.silence@gmail.com>
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

We'll have special registered buffer types that can't be used with all
opcodes and need special handling. Add separate flags to control
registered buffer import, which will be used to specify what kind of
buffers the caller can handle.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/rsrc.c |  8 ++++----
 io_uring/rsrc.h | 24 ++++++++++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d57e8a0380b5..05877b4c0ee5 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1245,9 +1245,9 @@ inline struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 	return NULL;
 }
 
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags)
+			unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 
@@ -1656,9 +1656,9 @@ static int io_kern_bvec_size(struct iovec *iov, unsigned nr_iovs,
 	return 0;
 }
 
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags)
+			unsigned nr_iovs, unsigned issue_flags, unsigned import_flags)
 {
 	struct io_rsrc_node *node;
 	struct io_mapped_ubuf *imu;
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 83aa86e6f320..f12abaf63270 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -65,12 +65,28 @@ int io_rsrc_data_alloc(struct io_rsrc_data *data, unsigned nr);
 
 struct io_rsrc_node *io_find_buf_node(struct io_kiocb *req,
 				      unsigned issue_flags);
-int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+int __io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
 			u64 buf_addr, size_t len, int ddir,
-			unsigned issue_flags);
-int io_import_reg_vec(int ddir, struct iov_iter *iter,
+			unsigned issue_flags, unsigned import_flags);
+int __io_import_reg_vec(int ddir, struct iov_iter *iter,
 			struct io_kiocb *req, struct iou_vec *vec,
-			unsigned nr_iovs, unsigned issue_flags);
+			unsigned nr_iovs, unsigned issue_flags,
+			unsigned import_flags);
+
+static inline int io_import_reg_buf(struct io_kiocb *req, struct iov_iter *iter,
+				    u64 buf_addr, size_t len, int ddir,
+				    unsigned issue_flags)
+{
+	return __io_import_reg_buf(req, iter, buf_addr, len, ddir, issue_flags, 0);
+}
+
+static inline int io_import_reg_vec(int ddir, struct iov_iter *iter,
+				    struct io_kiocb *req, struct iou_vec *vec,
+				    unsigned nr_iovs, unsigned issue_flags)
+{
+	return __io_import_reg_vec(ddir, iter, req, vec, nr_iovs, issue_flags, 0);
+}
+
 int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 			const struct iovec __user *uvec, size_t uvec_segs);
 
-- 
2.54.0

