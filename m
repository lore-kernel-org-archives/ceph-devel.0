Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A448665B
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332366; cv=none; b=NMqYng0VE/OyopesBeNmFH7spGzBM3EJWktcxG7yzY76m34dAnjbSu8AqP/qC3EhfRsoAU3OJwPxHHuJSW+CaTYer0CUsosHKHE7mpJ3CkVvJTOW1Bcb0mJq8Y9kyUWh1HV5CsbOM+5QgJFTVVlQNlNnBIB33AyBb0czgP+u04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332366; c=relaxed/simple;
	bh=uY3sUepmqssMOr1jNQvyXWE6qqQrkaRqI5lsNd3E8OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXewnyWWKN1md3OJnrfVHTyXUCrw/k6Uztju6QjVbUumUTkeRAw3vsxpzn24EYxHvwpnVd0f73LlpKwa8a2ehWc/WM8Np7zlumQ/3EPE7gI/Gyom6NHC3/mkGIEmA2AWtQdJWpzGvrjSc9jKPvnsIZWuN0FyquzNPedZrpFQ9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGVPcDzP; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGVPcDzP"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c16794450aeso122643266b.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 06:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785332352; x=1785937152; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
        b=KGVPcDzP8wQ2SyiaYgiEB/4+DEBMYVALsc3jCB2ht0eAjAMxzC7NXELzSBNNQc9MON
         d+5UWFqymcPii4NKyLLs61jvxSrgM4urA7UkU2HBYDgPFjDRMUOonbQMxjRRz2fM1A1G
         0KQEeIhH9kn1nef3qZipqo46Ff4aokfZS8yASW93kTavs5E/4t210s8/nqPmRCI2xWmQ
         cfiUS6RP81gBjK/rG275PimVCBEjZw1hM2fIi52JuSxl+y5ssYS80UyMSVQF+j+qwWAN
         5FmGmrGXBoIq6mhUzjQD+AoBX6TSFQp9EuI2mNAYYE4/W/exMXsXk9Ptt68mGWbQptup
         dcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332352; x=1785937152;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3aN3udKBcENjBD5UHxw3XhgPgHCGso1JhkYTFHwhTGI=;
        b=KvZ7Hi0HpVi5xkWgRX/MgE+2t/T5YeCEG/ZcpfWBn7afQK9aEh+WnUchOUvEh9Sv9r
         nNEks8S4FgfhQMVStd2nv8yTUTFsZAt6q7QPd7LJhyxDFMYLQyqmDGELEXZ1k2BySqa4
         74bMC4hJP313k1sd5gO3b2p4TSbvpdB4OmG9MeCYHLCOz2s12nknkhZ9crKKT0kDHd91
         +37i0IvL0p6LKk/46qIczZrB1c4Ic5oB6TQE7SZKBTzPf4dVBiOhhVK1GXRzKzQGDmcS
         VF1ILv3bsaqQwFADT12qCdGVI4m8ucxkJE/ZNDDq5CZBBFi4jee0dGPy6fKi/FvtBeFe
         feJw==
X-Forwarded-Encrypted: i=1; AHgh+RrkqaT9WwfwkCv4j2h1sZtUZ6RUEewg/XXXA4vXqzY4+6Me9IulnobKzXdIg1hwU0PckIS0uQ07+8PT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/OPKPL1KlzRqGhlRB99odiHEiMBExVd8xySTI5p0c2SPfNCH
	Uxtfxy4BAe9NILrSi1zlVjJQpUWXwA0lpdHXtyYZcktETlCyD+5N+wR3
X-Gm-Gg: AR+sD10oGM0U0D3OxBt7UH9hIGdRq3ATmPp/HMB4GltDlCHODnL97AwRNquqwTn4a+T
	Yxcad/AV3jQT/iZkq+Ga1g/IyDz6qPQOURajbOnMXvJzYXmFwU0CFIHI8+SNM4eokqCVXKHhMOQ
	bEG+wtRaf2IDQz67Nuch2U99wsOpexZJatd1q4cZwzAKMEzuTw0uiJo+4oCiKkceaVIbrowKn+T
	icWr1QCCTLr7XojNIX+Q7L4xViEYg9dNfWw2BBeqy+t2DnfyX3A1HlCW7uPKyn+F6rExSABfj/m
	fz17twhQUdF1SCVO8rUaFiKZSs/NP8qaQAtqpcwvP/oOW10NP1l/3GFRV6wq/LMxMkg2SZtGC03
	C8XCevaIalNSi6r/s5fhNpFfjmvHy34xYvUNV+v0vW99O1sAn4MqpoqYXjEzMpEBXDzZA5DyHiZ
	bqYHbbn8hDtkJy+n1fCFxeohgDjCbh01rl/Wgc8oSQO92rYbKyuIl+JMapwNtnwjB9geX3IZebT
	cBTc+3vmhb1Lk3cZYxn1SKJDZqk0od/Rk2hV2/rzJ3oqxKP8gI5AkUJ/OHT2geS4TI27QWAzy5u
	RgPm0vHMka5GqiIumFY=
X-Received: by 2002:a17:906:f598:b0:c16:7b66:4932 with SMTP id a640c23a62f3a-c1f721bf58emr374209166b.64.1785332351629;
        Wed, 29 Jul 2026 06:39:11 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4de5bsm118685466b.29.2026.07.29.06.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 06:39:10 -0700 (PDT)
Message-ID: <dc72d46b-7b45-4beb-8e36-d810d2a94c28@gmail.com>
Date: Wed, 29 Jul 2026 14:39:01 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] io_uring/rsrc: extend buffer update
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
References: <cover.1785274111.git.asml.silence@gmail.com>
 <CGME20260728213008epcas5p418dfc10b7ef786e162ade86d14430475@epcas5p4.samsung.com>
 <633d33d8e278999f55126794fce948343403494a.1785274111.git.asml.silence@gmail.com>
 <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <73317bf9-f7df-43f9-abc2-daa25a675485@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 14:31, Anuj Gupta/Anuj Gupta wrote:
> On 7/29/2026 2:59 AM, Pavel Begunkov wrote:
>> @@ -882,8 +894,13 @@ static struct io_rsrc_node *io_sqe_buffer_register(struct io_ring_ctx *ctx,
>>    	struct io_imu_folio_data data;
>>    	bool coalesced = false;
>>    
>> -	if (!uaddr) {
>> -		if (size)
>> +	if (desc->type >= __IO_REGBUF_TYPE_MAX)
>> +		return ERR_PTR(-EINVAL);
>> +	if (!mem_is_zero(&desc->__resv, sizeof(desc->__resv)))
>> +		return ERR_PTR(-EINVAL);
> 
> desc->flags  isn't validated here, unlike __resv. nonzero flags should
> be rejected too?

good catch

-- 
Pavel Begunkov

