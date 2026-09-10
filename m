Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57E3C1F41
	for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2026 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073729; cv=none; b=OMDdvmvFRxtQxua9FQd+uTT+xJmD7pqSK1SjxNXoN+9uAjIOu8dsh41muHXc2qKm+/4x10sd82s95zZ3UPhBse6oQ/gqjL9eiKv6kj3pvp33tGstV8/WtJQfPDMcEnuQcQxOdzqiubpdeZMmFk7fQoYceSvkd4oR2U7XHcI/RpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073729; c=relaxed/simple;
	bh=hFrf47wiCRa+Xp/RSbKkY05XcZwBmlybD2veRYYsg0I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lw+fb476xC+PywaWwvX3vZvvNToxzwEXql1D43bjN3TbjRMkvwng1mMwc7rhWXObGpPvGFBbE04F0pNfAUyz7dOI+ycpSGa2EX9L1D+s+hJgjXNfRw5/I8TMHJyTHzOWrRSbkgktOZHfs2RFdaoPF9js6QAWXAvP3hy/EIqx7o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=cHd6WKoA; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="cHd6WKoA"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ffa69b7462so205461a34.3
        for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2026 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073725; x=1789678525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pkbEmlLYOqHu2rT/pG1b8F4ZrumOvKHVAf/LIvXXM5Y=;
        b=cHd6WKoAkZVsRuu8KoPan46EIfg6VdtlPtEjUgBLJ19o6s1C/So7zaFjSumnMYu52q
         g+3GprZpgU0qqMUqp+UrgaslT8B+rasqcvgdgxaJjLlxpgNB5bLc+pW2uIgtZuO50nIN
         8FddKuSLz9D6zKO2i4DK7tPcw7Jr8FfiZj8U+yXum0nx5TON+d78WYjsZEgmdVpqMuBo
         lpf6R+zGcruYC6JtOBQi9qbGI3djIIKqnjdtTScIeqK0RHFiOH6Xj1GRaKoBYgs/tjxW
         UpcjGmb23ts0wrHJG7xwegI2ArRgUltSREuDSdffE77y5yNlQSNvMQ+ExKi8opZqMeiZ
         C09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073725; x=1789678525;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkbEmlLYOqHu2rT/pG1b8F4ZrumOvKHVAf/LIvXXM5Y=;
        b=pscGIikNmTprBpBuCjJAOECJrvhFgjTgkuaiNmVkEESWWfpqYkJ+YcD7BOd1roB8C+
         7i8f0LQI5uPr+oPJ2XtiMu3PqFq6pkBdWpdU1GhGjyMcaumRlUysE9Vr7uM0xCH9DGGn
         2TgzLxGuMfq6MxAm90k7IPDDcYFauGWXywxmogDYOT1WIe5kVLn1Vn8Z+cgVnU1gROB9
         NSVc0LfXxD73Hb8B0Tbdz2mkVkkS94JarjK1cGzb7NQG5fe0A4gHZKFGgqG3cTk/scPs
         p4twv28ri5NeBZERJtnQ9FBseZPXG9xvOvQPbSoS+5EfOMmMLgLySBtj5yfyvnJqtTRT
         f9wQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVnO/kh8AmiO+YxsWnvyGxVCqr/jCTGXsD+aYo9NeY3cQBsZLmOR5bZHttbP25qsUVCpYqCIvFnuIp@vger.kernel.org
X-Gm-Message-State: AFuF++nd9VdImXLjuWuKY2KZbO6yodN4DfbbwPJnDHWb/2aUCcCOUXUX
	ITeaNVg6ktQvXh2BMSWcGlId9ulIte3DMUW8MYDKkw6WiDdBz8D7j0jdPVsvg6EdcOQ=
X-Gm-Gg: AYBFou1Br3RZ4cU7DbuafLiXd2aeX5vTgIC5V490T6ZAPt1X5IljT0NxvwwqeeG186V
	uwFxdr9eTxHe5xT8dE4Cdh3rXH75CkLC4+tQry8vObTBF9CSN2soo7pmv7PMqA5MZ2AkC2RvV+G
	NOCYerBuquyt7gnXPtIa+vf2mrsR3ywFRVmXJ0A7XD18xm34LDIRw5tF0RneXVPyPAH22I4h1YE
	tnrE7uSD8eNtuYoWHe5xhIo+KpplWcXQzyC09Zt1M2xP9nROhoc8E4MAUqzy7iPZ4FDu1C83otv
	WSHkjERrXPnX9EW6zoNPgnK9v8gAaXcX7EjhtuM2zUpeNzJvkAxDFONoqGkKbgWRV7R7SgO3HPe
	jdaeyMkSo6Aogn498EXSCpd7k9CLSFOeQfgMc/q7HSrPibVjNoqMObs+El7DEanTAqtkY1UzpTu
	WU5LIEpf+spCfGITgD6Mx75ERZeqreOb4fDMneJCUlGr3vikzlHrkIU4CNFGxiDybaPPrAPcfY1
	/buInezgMH3hI3nXOBt0U59BF99ncg+oRl+jKKnHCYydYPKr/w=
X-Received: by 2002:a05:6830:2702:b0:800:d883:997f with SMTP id 46e09a7af769-803fec02e59mr471619a34.2.1789073724704;
        Thu, 10 Sep 2026 13:55:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:55:23 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
 William Power <william.power@intel.com>, 
 Phil Cayton <phil.cayton@intel.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>, 
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
Subject: Re: [PATCH v5 00/16] Add dmabuf read/write via io_uring
Message-Id: <178907372259.484803.15807864431748251506.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:22 -0600
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
> The patch set allows to register a dmabuf to an io_uring instance for
> a specified file and use it with io_uring read / write requests. The
> infrastructure is not tied to io_uring and there could be more users
> in the future. A similar idea was attempted some years ago by Keith [1]
> (from where I borrowed a good number of changes). Later it was brough
> back up to life by Tushar and Vishal.
> 
> [...]

Applied, thanks!

[01/16] dma-buf: introduce initial file I/O infrastructure
        (no commit info)
[02/16] iov_iter: add iterator type for dmabuf maps
        (no commit info)
[03/16] block: rename bi_bvec_done
        (no commit info)
[04/16] block: always adjust bi_offset on bio_advance_iter
        (no commit info)
[05/16] block: move bvec init into __bio_clone
        (no commit info)
[06/16] block: introduce bio_iov_iter_set()
        (no commit info)
[07/16] block: introduce dma map backed bio type
        (no commit info)
[08/16] block: add dma-buf support for raw bdev
        (no commit info)
[09/16] nvme-pci: implement dma-buf backed requests
        (no commit info)
[10/16] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
        (no commit info)
[11/16] nvme-pci: add SGL support for the dmabuf path
        (no commit info)
[12/16] io_uring/rsrc: introduce buf registration structure
        (no commit info)
[13/16] io_uring/rsrc: extend buffer update
        (no commit info)
[14/16] io_uring/rsrc: add uncloneable regbuf flag
        (no commit info)
[15/16] io_uring/rsrc: add regbuf import flags
        (no commit info)
[16/16] io_uring/rsrc: add dmabuf backed registered buffers
        (no commit info)

Best regards,
-- 
Jens Axboe



