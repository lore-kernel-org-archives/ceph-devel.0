Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E58496D40
	for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2026 20:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073926; cv=none; b=fH7Yd64LCYXQkc4FJejCOiSASby9ea92bNNfCqmSFBs67n2zP8tKlycgC1yTVlVyP12ojeDRI8Lw3RF+V0QIIJGUuOFm/62DDkfr79SpBlUYHBnZOuFUZ0cYdqvIfvh1o4wmFqL5nY/86lgxkJHoYcTuFiZv7ZaKP8E7iNqGhP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073926; c=relaxed/simple;
	bh=ylWdr8yhyOUHr5p7rV7V/FTvMFhwSjE7Fa4ndWREMxM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rq3Hiz+RZQgp5Wp33NqlVRIhyrc6pqkxorYRzpzs77F0dv3Nb7ODo1pD2iwjDJUiX6R6wQ34QUYSv9U7BkgNegfbsGdCHUjKuiYZCT7+j/J/AwJGJ4NxKWva9mwpVqeU/+IXDgZqVYv1ih/mb4deVlNhvFrMt1j71LD7YIQlcNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=JCWIFFcL; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="JCWIFFcL"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-46fdd5884d0so97151fac.0
        for <ceph-devel@vger.kernel.org>; Thu, 10 Sep 2026 13:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073919; x=1789678719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=227EuAsNywH5Ru6uyjfcvigTr1soLZnaZRqqI+5pgxA=;
        b=JCWIFFcLxLQxXdXDZEqLRBuXsJhUNNgngvc5gWsDUDvJybqybK9yVb7iLek50ShSMZ
         /weV9JaumU1fbMQSuJRjtmii5oKcvXI7hapFyIj9WN1anPieaNLAHzzxFVkj8Ivrd/Jl
         pbN/PxTQogxvZNrlHqRZtGoAM8uAriRL0ZuTT5QF0L3VfSsLvn7cHYJWEnnsRDuATUDR
         ol3EcgyDzCYe1VdcsqdVzSFGG63cpGPsck4oVgcEVsNpWQ6wl7Imye9o2679pizPWvOH
         XPgaL+71rKMZA1s640W3tlBhJbBFo9l3PYafygM90yKbz34uCamWM5ssODooIH9n/OZG
         4SRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073919; x=1789678719;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=227EuAsNywH5Ru6uyjfcvigTr1soLZnaZRqqI+5pgxA=;
        b=GcVKKzzVYlFc2nYINVVeN9Rz8c3bP3YC+yrbuHT4RXuS7WqFa8Ql6TXMxMsyRgoAZ0
         lSVPBEPJoyrx+Ri3aGJHnglwPKKUu9xQfPyLZVvh1G7GhKgXmIs+Jc0jGiq7xM4cZTei
         FWlXBAxLOfs4hzR/ulvVfAh1cyVYC10P9vemvVTv5UBal/61hBxzbR8nXJZmq3fOZa1q
         1Z/8BXZRkbMRIUMlaSn33J5flxuqMyyuS6lR/uf5WqlnOqjnIW+tz6HjgQOi6gIChKBy
         dt/43fCD2efFzliFWAzjTVSHEw5h0AEA6YZkm54qgRQj0gffvAER9rtpso2wLkFoxNLt
         +tVg==
X-Forwarded-Encrypted: i=1; AKwUvByDy39CIGTdfmYDG76jDmMX5GVrB6R9wEakt38xzLx3tNO2GfQrxP6/CPs/D8vULlUXLzqAKEc8ULw9@vger.kernel.org
X-Gm-Message-State: AFuF++mGzdA3qNJR7HFgfRQf3czgRsNBjfWXTv6rc20GGEQnHhkZlqfk
	lkusZSaftWRxmniN5qebDT6ZDEnTxcke6isrFUxd8Nd6l+LgJ5tX9tC+T5dpp8/JFlo=
X-Gm-Gg: AYBFou0R6/ltp0B9JfCuNTNcYzx9X4XNdcD3bkZytX+9bbfH83BH4zQ5n2M3jrxhjhV
	D6M9g3SgMcUHB4Ag790d+qQQ4uje4upGc58q4VqF8LLpW6i/L53zTwmk0BNMVrKAN7uiYsqU07e
	fQB9wdNhGJFgf4Q36jm1CxKr2u/770mRJFK2TQ8rZIqHL+HkovxX9dJeozonUkZaLRGIBaMzOtz
	y8zv1Wkkh1YNwXaR8n3Yad1yMJTfkEMb0an+oLH4bFM85xqldUvjsCCxlEtccTO1ZDRqwSiwYU9
	kD2z6zTIJmgU9A9soREJ0Hcw0KdOaL/ic0f3CAbdxeKnWgVHeMtIMtRL3EvL08txi850krfKdSm
	nDEfAJ0JfpJXxtX3vrnjfdjqEwKY5P3FC6nCqHN6y/1vKHIenHZxpabDI277mzsjtoyP5tFqNLg
	8mMkl8ihe2JIWigdxI+0wB7P2dY1HabGbjh0H9LLTUIa49xhe3IZzZ7pyhG1+0CZniV0B7H1dWI
	me3pV5KNKmOqVxtP2hw9Cj3RL9rm94MKUJzECLnu3S/8kIn4i3WPjMt
X-Received: by 2002:a05:6820:3411:20b0:6c0:5630:bdef with SMTP id 006d021491bc7-6c0bd97850emr353461eaf.67.1789073919642;
        Thu, 10 Sep 2026 13:58:39 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c09a122443sm1108879eaf.9.2026.09.10.13.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2026 13:58:38 -0700 (PDT)
Message-ID: <eb469580-509a-4895-a819-e7f3e4fa0b0a@kernel.dk>
Date: Thu, 10 Sep 2026 14:58:36 -0600
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] Add dmabuf read/write via io_uring
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Damien Le Moal <dlemoal@kernel.org>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
References: <cover.1785596451.git.asml.silence@gmail.com>
 <178907372259.484803.15807864431748251506.b4-ty@b4>
Content-Language: en-US
In-Reply-To: <178907372259.484803.15807864431748251506.b4-ty@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/26 2:55 PM, Jens Axboe wrote:
> 
> On Sat, 01 Aug 2026 16:46:12 +0100, Pavel Begunkov wrote:
>> The patch set allows to register a dmabuf to an io_uring instance for
>> a specified file and use it with io_uring read / write requests. The
>> infrastructure is not tied to io_uring and there could be more users
>> in the future. A similar idea was attempted some years ago by Keith [1]
>> (from where I borrowed a good number of changes). Later it was brough
>> back up to life by Tushar and Vishal.
>>
>> [...]
> 
> Applied, thanks!

Eh no it is not applied, was just looking at the series locally and I
guess it got added to the b4 ty pile.

I am, however, wondering if we'll see a v6 of this soon? I had some
comments on the nvme dma mapping, that can be improved, but I'd rather
defer that to post getting this included.

If the series is dormant, just let us know, and we can pick up the bits
and pieces.

-- 
Jens Axboe
