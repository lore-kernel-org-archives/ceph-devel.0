Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0D3448D11
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322193; cv=none; b=m1kl9x3gqamyv/aHUkTTje4ZUYqzohqZ7mMNenxr5UrBcYNHuEYIj6B0UWrVKlvdX8WytSVtOy/MfCt9hOmXTsZVsCPgwhDOZCrRnOhpV4OI72rUsB6sX74GhZrnOe4sDd1xKGFpgqaphluLMrIdI66+BGqkSe88Yd+RJTFxmlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322193; c=relaxed/simple;
	bh=iNi2nFSA8g81W+/HnLXlWmnLlyUILEZvQTRGox6oYII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfyYs83yCvq608GKmyxWqemunlJGfa9CxlVRGa36JHu5mZU05UDDvPh+dXIqVnrRiorHticHYf8/C+9XbfyTVBGQNaMdAMAlnSxZvMVbzUH5jMC7WYH2+cWhkLslwpIlVqafTBRROhSWICZCm9UaomRH6xMS/sxBmuQQY/kLO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s6f7Plz8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6f7Plz8"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so80210966b.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785322187; x=1785926987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
        b=s6f7Plz8hCZXfh5yIrDR0xQ3OAAJW6lfJ2nNCx9b0/4iAG0GjMrmw0T2rVHZYMI3hC
         ogOq+pzXWmy0m4piruY/4MCQ6T5/GjyfZFStJ+gYah5OmM+m1d++9jRz/weyos5l098f
         FKfMfTpcSM/RQ4KFk7bZuZtsZrdsse0K1beCRAdbe3KejCBQse+RNHSN7A/poayBldUY
         qHhGuPV6sNvmWF3VcHF0EaKge4A0A3Ypobo1f3LEr7c7xqOluLhscdDkMdcrVLONA7yh
         GeN3q6i/ptpHpfZ3AghdpxRH9Iqg/z4mdXe7W5VY1LoT6bi8nFV5VNT3iV8ElLNkLJbG
         UoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785322187; x=1785926987;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3xVEH4RvIZup14rRYV4Zvxl83sd+HTGGj/jXhd9ySH0=;
        b=BNchUo86S06A1ByVj6Z+EMXyN9fAl/GFuF+/q0iThhtuZSEF4ZQJfmPcqfVX7iKjUn
         LqUuczvyqnnh0Sfeh0gqF6lePud7O/TYJoi+YUEXACJbXFpGxtopRy8JAMy4HFBPAkkY
         S+zhXDNN/PMyiumpsiCgn0EAqwMHQ0h/GT56F2GXPOvnjyK7WwheNTtE68XDMdZoHCYh
         6uwpl4LrjXYLxQJOY7vS1W6iQwE7JdqRXEU4kFWtw9P9r31Q6UUJlcffgen85G+VRPcz
         3HDrWRAvsK8ErKssplrSzv9u4Gt1aBBrGL06J0e3Y4RYQ4z9E6LhWudy8LHgjGaUbmbY
         uBvQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJhxCLeKfXT2JpnmiEtiP9CebLkdz+xqv9+XDOCTRKWAaTkN7npeN9GrUSAFKSfD8/oy1Csx0kxaXX@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHZrGASPB+U9y4J9ZrB3cOeFEfeTLhSpARMoezkt2hbrTv0UU
	c7Pfe5j7TpRzcRfV6vnMpprxr/Lr1Yc9oSQJp7QYzFPkZ7jRsdroYBxB
X-Gm-Gg: AR+sD11KtLBOI/f/7+0AnkJopdZT2fmmPvKGn4f63ExyV8r/yEEJniaeOXokf6/H3p7
	0ZNIWRslcuU3nL4r/npZ4lPB17Pf8Q8kzbadWO0GJetIdkSVrUu3V53Yt9djGUqz1dvJRTyfrPO
	ttRuYQ3W7wcZFSKRtdpbKb4FdlRoEKxrW+D/DmX23W2Nl35yX1djfJfm+KfoqSZH2iWB1qiC6aj
	90Ciq8SF8fOaRlbYx3D9KWucsiGDVZyfpmmew860c+7UJNAcyJbdpbN49IpqSW4f7theQOdAH/l
	mq2aEg3MAH0frvcEMBHxPx2GHMYP8PRI0Otz9legp2Rd/wqVemzjjuNqMibxmelMU8kqWPzCs0D
	o7RJYTfPV2BdKXffYQRa1RO2TZ7Kut6+ynM0YRzCWVD440j3nE4Je6eDQSNKNMWKAaDZSmeRSML
	C0bdQZcURhLnViloeLBoX+/diaFZ94dzIHZbQSRJiUa+X8v8o/XRkX0HS4/O1spN5JZU3/OQGSp
	lotQty0HiJyuiZB3CC6L0nQeGi5kQ/qLfgUCCF57NjX4y6hx+zsiROG0/c6oT23NLk0ye6URDLt
	jwDHhA6z1oelFFkJijLLWvEoMBI+qA==
X-Received: by 2002:a17:906:fe47:b0:c15:bea2:d209 with SMTP id a640c23a62f3a-c1f7215dee1mr299738366b.4.1785322187169;
        Wed, 29 Jul 2026 03:49:47 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83d27f47sm97965566b.26.2026.07.29.03.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:49:46 -0700 (PDT)
Message-ID: <c81be43c-2fe3-4403-b8a9-dd19855eeb58@gmail.com>
Date: Wed, 29 Jul 2026 11:49:36 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
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
 <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
 <20260729071048.GH9534@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729071048.GH9534@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 08:10, Christoph Hellwig wrote:
>> +static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
>> +				    struct dma_buf_io_ctx *ctx)
> 
> Please stick to two-tab indents for function declaration continuation
> for the nvme code to keep the code easy to maintain.
> 
>> +#if defined(CONFIG_DMA_SHARED_BUFFER)
> 
> This should be good old #ifdef.  Same in a few other places over
> the series.

Going to apply both for v5, thanks.

> Modulo these minor nits the patch looks good.

-- 
Pavel Begunkov

