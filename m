Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C333543BDB8
	for <ceph-devel@vger.kernel.org>; Tue,  4 Aug 2026 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832928; cv=none; b=BIzb9b2NHbIVGI7PIqTdJJlD3FcVn0zaP4X7P0YIBXBLw+YPwBehTB22IhmFGgmVhIMFMCereR7T/N+KIUVZJNZMlm+ENK90d9oR2jzyf1bgN7mUvr6KfTp7ff4UwCDTuLZwXruyefgpwdi98+ZZsEpwzk65EdUK7xiMXhN8ZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832928; c=relaxed/simple;
	bh=SD2jpuPrRshOPjZPDhOULtKF/IyS30DOHYKRJQ1eYRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dByDcOCCtsKdQiy4BGPsEQaflsMRCJ0Fzje4oK3bQz6OJ4tK3WlSDalDlQ3+vg3cSsSCz2ta2TemZvqIJrEuU71h7qo9Z8Y8XNefxI/jelgod0LkPCaarDhNhQdiK/e7vQik4KicWIMBD28oKPL2pUIT1YdvCeil0VAjQ6N72uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PA0v0brP; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PA0v0brP"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so533155a12.0
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2026 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785832926; x=1786437726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U2I8sdYMfYJjOc8dSgSE9HfEVezQOKs2ggEWu0ibP00=;
        b=PA0v0brPxdaG3MEMmRscI/ZEK7lPZvVtloK+bV3z/F9OTMQIQYQK3/DIi4u1GI7qFN
         loGlkGRq//5VBuMSUY8lNrmwfGcdY4Dc3skR5sZU+/7VijefGzbiWad1oWBUhNiRIcBR
         cATciU315li3smb1VkkPjTv/WGRzNvjMRooeuj3M8NegTKCk5+CniXtcBKbrwzdX5Ppk
         AEZ81m5gD/uKb6SuQr7oj0ccxoRAvDdPkdHbgbpQj8hdWtBtKR3OCIc+XDmV+K49o6JU
         g8ze6gtlfWfC4/AeGKb2PunLoQvQYsHnEgqI3aEJhVqD8xaegcnxUAv7aD+3NAQ+DF75
         YToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832926; x=1786437726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U2I8sdYMfYJjOc8dSgSE9HfEVezQOKs2ggEWu0ibP00=;
        b=V7ZWDFPP8wFVrD+BggaXWUbhpBbKLNZTd6JHOq4hw3BSdmVaiWUHIx5ZPnrT+4/TOY
         Xcj4MGRoXp3c1yEPKNO0BZ7xkIWXTmWe4i17Psq5wWmVwPPDMWzmAwpbJerugR5Brs3o
         HJH2NEjHG3xvkYyMW7dE3EiXKyEyfqQbThz2WeJ3kLgC34d5QNVRNpjuQyumgCC6JoXY
         EBzpZhqyPDalNBFq6scbuny1K9gI0L/I59Oxcxn97h7mt8Q64odywD3F86EPM8BCHMrs
         zDQec95KoRZhWKoP65X0pcDBPojJRtrNwm1ITiRfC2DFARsQBAvbAvgXb5I1kx2Ywy8N
         tPcg==
X-Forwarded-Encrypted: i=1; AHgh+RpsW+4jNOkuYvXSHJzV0lA8nBCKz1D3duNgEb6WaW1nAcgpp+8ftig0Y1bOMWvj4LwCrfaIjXBbPfL+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1taJuI7CTv0n3PtE6Dn8ZuPQkvXvaNl6xncKZY3BJP0iAm2t
	obfFpHkabQdWyvhFyO7R2tysZvb7V9yyHtlEHniQUGJTvm6HQgk2Q1op
X-Gm-Gg: AR+sD12Fwoj3pMdXqqFe6kpoo+9ueIKIJkMhic5gT+iPeWyUMxoGOERnmx7AtqaLSWB
	8j5RES6MlXQrDbym7U9q8RBzrATB0XmX0nLn80g2s+VXRuXxuUomUVX6C55M2am+eEby66kOerm
	L3ybkU6gZm5nHvwIKgZYSca+WEPM6WW/f3tWwp1dM85kwJypdsYf87YaYaYbsR9LTjt6eOGZbp6
	zeqQP9E6T4IOmeb0aCTrH/RXebgqJR3udYmpP9n42XOEGdg7uhlYbe9hwNizsEO/UgJE7tAZ5Y0
	Noj+6V8lPWe15m17z3a0YUe0LBb9FrEKkqBWzF5sKFrEO6T+DhS7qMmW+hv3n3kXv2JSwo65XHK
	kXq+AWIeBuXXoW0KK/WfKr7iMiI1WUyKKlb2OXustKrUh3Ks6Ivd1KvJbwSnJVRDbnG2uGd15wD
	Dxy5O9kITzD/u+wSYKclVhdUNakrX3Svp0zoUQqNsC0iHAMijprmhQvyqMNGPygcrLTSJkoU39t
	PKvo26mg0oxc86FlEDsUUlzXxOLWomhpfL6VGYpcVa6Ab52oXRukvsAF5vHUQvAW3YqIP6822xm
	xtv2QQ9tsiUHmQpZ+5FA
X-Received: by 2002:a05:6a20:9188:b0:3bf:6c27:38b with SMTP id adf61e73a8af0-3cb6c937c3amr2601207637.29.1785832926102;
        Tue, 04 Aug 2026 01:42:06 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:541b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea0a73sm4753273a12.23.2026.08.04.01.41.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 01:42:05 -0700 (PDT)
Message-ID: <53c9cf90-4284-4b6a-ab2f-1686c7461bf8@gmail.com>
Date: Tue, 4 Aug 2026 09:41:47 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/16] nvme-pci: implement dma-buf backed requests
To: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
References: <cover.1785596451.git.asml.silence@gmail.com>
 <CGME20260801155005epcas5p4ecdcdf532aa2c2ff4e94638eedaa435b@epcas5p4.samsung.com>
 <9e3dd1b2d71dc0f9bd556b6a6d6e48fb6a8d727b.1785596451.git.asml.silence@gmail.com>
 <c4cec417-24b8-428a-853f-4e1ff1e29a6a@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <c4cec417-24b8-428a-853f-4e1ff1e29a6a@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/4/26 08:29, Anuj Gupta/Anuj Gupta wrote:
> On 8/1/2026 9:16 PM, Pavel Begunkov wrote:
...>> +	if (WARN_ON_ONCE(seg_shift < NVME_CTRL_PAGE_SHIFT))
>> +		return ERR_PTR(-EFAULT);
> 
> This should be 'goto err;' instead of a direct return. If this ever
> triggers, it leaks the map and already established sgt mapping.

I can change it as I'm going to respin the series anyway,
but it doesn't really matter here as it's a warning and
shouldn't happen.

-- 
Pavel Begunkov

