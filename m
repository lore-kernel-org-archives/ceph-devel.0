Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A843B6DD
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321454; cv=none; b=UKp1MjBkmGGqjTCqTHH1QfPpme9Rd1wMRuf+z9DBgi+Q4zGVxx/q74yJRop4Txt9fFy5+QA0BUhc8VIpbcBN1G92vkHZxJQaHYgCarF4zjUf+47eBfXT+Qdd7vuMJ5uYWIrUndc0BbnzZEZIU1tVWZJm7p4Cc2DbN8JXrqhefS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321454; c=relaxed/simple;
	bh=KMDBHWwtyZpTu40an4MnGq08B+PKsj/C5jew5swtPtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BrKfziP35DOQYRNghWlg93qE1zfJymUmZkpW094AtghdF5fPQQKQNjhvLgCMBlhoHNnIP523hK1UX5IHFZhxQOgEOaJBHyLZWZQSg+lgCI6M5h7mLOWWjDCvzNqOJ1UrA62tXs31Kz2vipQaJAecAK2Ld7s66wEc0p5KIFfln4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQuApLte; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQuApLte"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1671ec8692so101335366b.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 03:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785321450; x=1785926250; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
        b=UQuApLteJB9kKcT40XOCwRqmqtd9RC2KId41eJaievdgrQkAkYSBBD3tGi/u/fez2H
         wEj2YyP+qYvRZa4Xtb8VcOAWrjOaeRZICTY9aIFaKTVNuRWxM+CziTXGSrcKYbSYG6NZ
         y4dx/mcV4IB2wRg7eosVnKv9HjbGYw6trbjjsQXNwJ7ddaVp0aqZSyyvGyhhhzks7Aag
         9AB/FWkuXdmVgpfxoSsRPTW6Y25+o4N6kZa1DfBxZefcNyFwXULJk8t2as6huleg4iNM
         gL+plUqY3hdAwGxRONuYMqTwo7vM0we09dnFCaHO01nkbW4UsbTgf4dRtgYw1fJ3wLhF
         KgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785321450; x=1785926250;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8KbmJYcU1SAlCdU+OP1hBT5okmuW3fRl/0GYAxB+Rg=;
        b=AHsCzNiPt5xEEziP6IQ/CCFdfJFGhGHicUrTq67mfi58j6vuc2ylh64VMq93VY3ZF8
         f3mRaW6h57l23PBjPie2yWW0LTb+ThNv520IxAKXCt/byBVi+YtpTVuQVxiX/2DRFf1x
         DvaHg4BjKEBagWo1GocAsawSO7lr/Gw3/QK0mLq+xfThE9sVss/3v6Wo9C6fiGKhQl7T
         ESzSU28Ez0hKN1dcyYtPyS+RCSYkhGsPX0bqC3aZ8/Y9LD7fHw1q/esykm79LoW6lDG7
         yQitu8Hq8oNd44N+UBy4iHZlpaRHWhYohe8TQmoT6iE8ho97MgM/8RZnTnsmmiikXlwR
         lKtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpabgou6zQhykPtbf0y0g3gpascMjumWgL4n/Bsoaorem8Gp2KtQasqiwOz+5ehokZuDq/S+uaa/Ds6@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLqBUqSbQl2P/01QsGeN8uVfHS83GqJxowC0A07BoyuSRshVV
	aHdCcWC+fJIB4kdi/yKZBzgeCLwwtXBhyQPhZKb0ZWHb7FJ2UOnBfKQA
X-Gm-Gg: AR+sD12AyxPtceLZROptyA3Q7OMbJTdo4dZqEXlwQYq1BDGU4zrbqlknKvTTPYO3VL8
	ymOmq2WopTqH619NfDgC/leOZVZep96Y0WwkP81xcuv3jl42LDMYgxqjX2AMwia60IgVNM/8UjL
	RN9EKUgMd8T0ZoNvkwRg2cvYdZBxeuvwPizOEYXYSA5Za0/Ei2vlrdvgRn79hdWrypExLxxMhtB
	NbYHrdFKnAbCf8F8NJqetnzPBYJzX6l2Ngchljk/XT0dIsI56fyjuvTEqBJj2LOKbdgAo7DK1rj
	1Cj/gUYuuskpR9GbjRtGTI2MTB8QvDz5XKgPQHc3nbfcMvOZvegkVJoijhZIuQiIu5Yv0tMkdR3
	VN78B2PVMCQgkd5tEgTlUB0J8imSyDK8dIXOEk7BCr1dsPh8PiWQd+b/eCPpIH+AS4C+hDerLpN
	KiNPDqRZy53ZPycKuKU1u/022YPIP6ENiH/DmdE5pNTwDyVcuR9YrLhAiRHFJzb2AsA/oNa8djh
	B84h3eBybRjQHsuS5pOV+B+P4AQr+FTPlxcEW8ddhxqcZXiVPVcr9/Twz/rQttTOGCMm1evG1BW
	W/wDQPa0XyXSbtKBv58=
X-Received: by 2002:a17:907:9617:b0:c1c:62b4:1ebf with SMTP id a640c23a62f3a-c1f721913ddmr365145166b.60.1785321449861;
        Wed, 29 Jul 2026 03:37:29 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f84026c47sm93918766b.63.2026.07.29.03.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:37:28 -0700 (PDT)
Message-ID: <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
Date: Wed, 29 Jul 2026 11:37:19 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
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
 <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com>
 <20260729065927.GA9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729065927.GA9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 07:59, Christoph Hellwig wrote:
> The method name feels a bit convoluted, but given all the
> previous discussions I don't care too strongly.  I'll leave
> the dma-buf side review to those who understand it.

I assume you mean this:

+	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);

I agree, and all dma_buf_io_[ctx,map] look clunky, but I don't
see what I can drop out of the name. Suggestions? Maybe I at least
should make the fs op sth like "register_dma_buf".

-- 
Pavel Begunkov

