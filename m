Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615D54B049B
	for <ceph-devel@vger.kernel.org>; Sun, 16 Aug 2026 00:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838499; cv=none; b=Fqj744cMiZDxbbe9FWEIv7CkTub2T6pDuz0ZQmOxcUbO+d/hqmSspa2WtWxjSMJ7F7n/3uTYRditDf90emmLqH/kHCTEPxDWqSuPRWQZZdrU/Ssg8TVn/X3r/2YvukfwgXayVsvmuPN5d77iZVe+z+jn131+gTHJAPh4II3ohXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838499; c=relaxed/simple;
	bh=GLv7MLH1JWc+5XrUg1Z1RvY7w8aG92a4ZA0fo54R1DI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KUBJYTuHl5G0fswrJrZFwhR8GAsssWbishK0Ug9VUKLyagtMzX/WqUl2y/SShghLu9q57ibrfNcKXss2SoJYAWvpvDiWQ33+QvF1p2eCU3tpj1xs5zWtgcDQBnbNFfj5eBdA4EPSrsBuE1ONK9MxtCUHZy1SP/n1FbzVbcsKRi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=qDO2y/Ef; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="qDO2y/Ef"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4472500e25fso1356463fac.1
        for <ceph-devel@vger.kernel.org>; Sat, 15 Aug 2026 17:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838496; x=1787443296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPPcb+6L1tSSLsANqwKI7loeM1EwHu96h0gKbDhNEvI=;
        b=qDO2y/EfO1t3CC7NC3XoESwjR8/JgFZ75ERzn4KAiUkKS4Oq4LyMLiMaVem3HyPUzC
         aiNiTPv18jaYEhX6LQAYyQDYxeVvX13XDEd7o06Ae1cG82j1gRfcc5nKchSIyjf/xPO/
         BDRjJknqIe9XGJl1u9HX3s/6rqC6VjQ8vJpAeZWMllAOjnAM9EW082zCSHUFnbzqI5Gv
         dNPjKNg/FBcOzL4s92Bh5XGc8MBeo7x4edRS9J9uOaROxmsszLVgYjfDmT2Wm0m4URBz
         cFeCpY3XBU/f0+RUjPeaUofSMUmLfA5JewUZ8Bkh3heeQ1qmygZORMw4+uvO42ImRYcJ
         wJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838496; x=1787443296;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPPcb+6L1tSSLsANqwKI7loeM1EwHu96h0gKbDhNEvI=;
        b=iUQhqAW932aizzAtzGoP2qytW2Kd3X5OLGVw23pRNAm8Dkm/NEIBkM+C6jn/O2fb0C
         3JJJUVOtF3N3EfqUZLn7/QD+FVwyhEJ2tNgWeadX9kQz9XVvNMmEXHZpC574VUalMO9z
         EvLhuNPnKvIex/Hib4CYO8X5VGcpoCRJcOCPw6cVyL45e9sNj7haAJLbCpScKqy4XfjE
         Eyn6t243OxdF8aJ3Uo3nVUrwh1YFi6WXstL67VNYk0pLPk7t2/MBz3bRZzE5KfiSmlhq
         kOU8Isy8DY2yRmhyiL9JZc9A08/RERMECoHUxe/SqsuedpMcF7Q0GNxXliUQPMzFI8r7
         C82A==
X-Forwarded-Encrypted: i=1; AHgh+RrCXjd5vQ2cWtxQQbAfE7QXwpIvmw5kt5nheq2R8UCADfGM021FvustHLQIYD1DKFo0W6ZK8rfGqm5n@vger.kernel.org
X-Gm-Message-State: AOJu0YyvwyfPo8XOS+/L7lnZEuchjb+LY3m9OPoIr9ufsNjhoQMs/LIt
	xQYbpHyUasNvJbu0Gr7C0GdnIgijHNigejKPD4rOnoxUAf98pMf3HbtfVNXWx2a5Gco=
X-Gm-Gg: AR+sD10APQhmZ0bG6nJXuIOtAvBFjnxlrKvSz0VP9MdIgxTkZhlGhCkBnJsxD936mvS
	/BKuea1+R85URYw9dVfRP5FBz5Jek+T2P9gtOw7eMLfL0pFdcc7aWqo0fj4zU1soNF27gNKnNMK
	RUM1/S4OYfUSLvJUpe7fdpBPDvdYewMmDXtiOjrw6USmIs5NpL4L4b/9ExjhgZKLzbkZDgUBezQ
	AgiNnJOlzXDdVa3dvKJnZZ5NVeuFkj4kLP82IGXnPvJikKF+Gc/kUP3tsQOzknPC2q3iMSDDT7c
	1G1zTXefztFFph4t70wTFS90hpa6WIwqTep9zj7M//TOdRqZzN8Zgd+BvAqNSHImvPqA+NYiwI3
	0Ccf+8DYbgvgw7C8T49ZPYVRb+nVM5/Gm4iL9bKG4RX4vniwGr3W1QIGiI4lv6fmdYoX0WTu7jZ
	td6/9Gct69WHyaUDhAWy6w7JV3d2tzmx4ckYP54lJjviBrNooYmXoXiYMcx4S3fkRP8Qzb0OrCG
	nnthlLxHMeOaGEOKxILKUyCVV76z7Dt+6ge+PuLUg==
X-Received: by 2002:a05:6808:23d4:b0:4a4:ddde:5207 with SMTP id 5614622812f47-4b24198f27dmr12801839b6e.8.1786838496365;
        Sat, 15 Aug 2026 17:01:36 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:01:17 -0700 (PDT)
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
Subject: Re: (subset) [PATCH v5 00/16] Add dmabuf read/write via io_uring
Message-Id: <178683847578.1984298.10059277109543676478.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:01:15 -0600
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

[05/16] block: move bvec init into __bio_clone
        commit: e228404b05c8293f6a1286856e49ba3e55da1933
[06/16] block: introduce bio_iov_iter_set()
        commit: 8b8755e00847da1027fe6624277e43d289e2300e

Best regards,
-- 
Jens Axboe



