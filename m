Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051224446E6
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 10:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321662; cv=none; b=MNnvBBoUuGCpnvtDW+SFLY9tf9922r9ufdoLpEGWVEPnUHiVMgQeukSCMc0ZYqkYIyBf3NjCj46vmXGOkcJb23zbNbjjUhPZiUill3X3Nn47f1p7MOvM/Jt7vU2ecG2d9EBXgSLiqvWiyuFcCnr+78FPvasdXCPDOZv1ITWkCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321662; c=relaxed/simple;
	bh=BlIgo2y4Fy5hrKd1QKUkkESSegtx04afaFtVA1ds1gY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0uE8pP8aN0/XXu7ZJ1dGrocb69aY+pc4TIMDA5DkhZwotjUYAqLsnfy0dPujszeIm2T5CUI6RITHNX1fYd+kCFyugUmViP2eizyRcZ33qHpY5vyFkXIhImMuNWEaySUiY/NKKZKO3ggpNDk38xWQgeAukXtVhAnVGRUEKSyv1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZW7RvJ1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZW7RvJ1"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-698aa7ba3e6so1099763a12.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321658; x=1785926458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vFsiSXVzFdxW/ZniSNP4YKGbRVTSiHE8ZZ1h1zgY8AQ=;
        b=AZW7RvJ1STgaHPD067590JbiwZ7/34KkecunFz4HmT2Fi02qcgoKjEl6XHdy8YZyAF
         a1oi2y/aYLDURgNoJeiHP7TZdqGHCY4lG8IvCKSYD919abCIOKzi8qMnKv2gDZxFpy9L
         hyysoYYhM65ulovurImQpFEzWHzrMy/rj2KlTaNZJWfSjpNko9E/m5q6lDqq6tUMD6bT
         PFzrLoHh5b+EbjmV+E6OdzlQXjvc2ErhKNFIzk703pn1/Ktb5thQAAsb8gNV6ytBYHN6
         8LwS3GdKBv7lngBhfBrKWm3Ny5/coLObNc64Zdc9o5g9BCLQo53BuJU7NJUmSbQoYgz3
         Nb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321658; x=1785926458;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vFsiSXVzFdxW/ZniSNP4YKGbRVTSiHE8ZZ1h1zgY8AQ=;
        b=qpvdpszeEwgP6ZBIomU+S8n+G92gGlK6ZwCZKu8c8L+rfYiqgqO6qeBoxrWjaEWvx8
         TMJcwnx9GMR//K6IQNoq8J3QErtHrLzr1EbI63lV4semSi4NzRc17t72VGSD4XWdPMkG
         YKk3sM2TmvR4HTrgYvfzFO+VliqEFobO/fENQvuJqgJ6due0qmjkYb2YRVDW/mJlbfSx
         LfKhLhzCtic5sLjdAu4KB67mPKqpuAJ6WIY0KIQLY5Tlp4ZuUpOFKQQnTll2VtMdE8HW
         iCPiBm5essV93xG5t82E2xbdsMpZWaBF3ngOiOS0nreBe8BZGpyQkALK4WANOL2UGmVh
         WsPQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUmjwrVnbWG8pOjBZkAy/xFUrzDnSh4z2VIu6WHKJGTV45FtqVZeZzctr5+20JqrSIXKT2knkVVzQN@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1kKS59jCHY15Tc4jr+CpVXyPVEjoVAF2VsyWO8eny5oiSZxJ
	U0M5CUyKYwWlIx5Gkkg9L1gVWCnX/+97qz8COnXCA8PBh3Z3sRWIXMH7
X-Gm-Gg: AR+sD119/+xLqCc2pPh68dQhhVvMVnKONQFyMuofgnV8p8kpzD4mDkxpXisa/qLv6iy
	PB7GKcUlk8Sv7sqjjcK3gQfDDStxTFno38X7RmEsQgQ72tvpbNTE5PWE+yh1UGmBDqVVcFBplp6
	Lrij8vyCyYlBOtehRioOkLFeGiK2Mi8QVF2W4VL/SX9NLrBd/QhSnJGtFVUCEFP/ckNXd67RI18
	dVJ0epLdiZF9qh2ysT1WKB56zQ4ZZf0imfC6AgM+hKHgDbo+XiZFmj48F0NitKBEcAgpQZOGd7M
	xkCASeyMadXi3enGZBlfSa3JG80o7mkzfd786r9hj4Sf+peBK98/1XK+yKZOXhPSZ+qEHis83Te
	Gl+IbdtRhNnN6q50G0S/QTX9U1nEgbwvXskgPUALQeXIBnmA1kr2WavnP62hCTgX4n7o4mg4RCH
	tQr4ovZ68z1rCZQ+4cOX1MSVTCXuUdHljWdgPobhegJV/gmHo8l94OuPiEawp21wcJCQHqeMU01
	oNOLImfp+P5mPbNEaok13nLdPEwJTEvx1iBqjEExr15vFnHjry2oRpCLtC50Wv27aeby5WzAVZb
	U+MwMoHMr08Veo95ETc=
X-Received: by 2002:a05:6402:548e:b0:69a:596f:ba0d with SMTP id 4fb4d7f45d1cf-6a034a7f6camr3086746a12.33.1785321658080;
        Wed, 29 Jul 2026 03:40:58 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf0bsm661299a12.23.2026.07.29.03.40.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:40:57 -0700 (PDT)
Message-ID: <7217c204-786f-4fb1-9c09-fc1ac7c8a249@gmail.com>
Date: Wed, 29 Jul 2026 11:40:48 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/14] iov_iter: add iterator type for dmabuf maps
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785274111.git.asml.silence@gmail.com>
 <132442812a40277a5904cb2a8ca1e02f4f6e82a2.1785274111.git.asml.silence@gmail.com>
 <20260729065953.GB9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065953.GB9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 07:59, Christoph Hellwig wrote:
> On Tue, Jul 28, 2026 at 10:29:14PM +0100, Pavel Begunkov wrote:
>> Introduce a new iterator type for dmabuf maps. The map in an opaque
>> object with internals and format specific to the subsystem / driver, and
>> only it can use that subsystem / driver for issuing IO. The task of the
>> middle layers is to pass the map / iterator further down, maybe doing
>> basic splitting and length checking. The iterator can only be used by
>> operations of the file the associated map was created for.
>>
>> Suggested-by: Keith Busch <kbusch@kernel.org>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,

> I'm also pretty sure I reviewed this and vairous other patches
> before..

There was a lot of shuffling, so I dropped the tag after a 10th
amendment to the patch as I didn't know whether you want to keep it.
I'll keep it all for v5 unless anything conceptual changes.

-- 
Pavel Begunkov

