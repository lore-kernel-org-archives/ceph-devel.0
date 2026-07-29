Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428B435502
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 11:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785325572; cv=none; b=FhCk8XbQScF5LMftuSaM0Q7hjGabvfYNdImam0uEVHppq6+Xfy3RWTXpsaehpHM3f8NscVxGkdwzzV2Ih5sHfdV6xheicd1i/3sA3Ke/CkTpj3BxNUVdYEKjhcXIVbhaH6tC5IY+xLQy9x0Me3WuP4yrXi+BRTmebhdmJuZR1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785325572; c=relaxed/simple;
	bh=wYq/i9KhASJIbtNcdRJPIPtUhLDMmjpqz3feaFDSSx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lmhTa/Z3V5oC+4BExlbfnImaKjgJaKBC1O1BlZARI8dAg4sUXl37R7AmkGU7JQREj2jJPWYaDDO/jMCDVJZsrolug3AKBGqgTPfapaUXCa+k+C0I1b4qNP/hKxSQHpGJ/KgulC+8m0rk0+0JN4OVCj8O/IH78MOPFXjaEEP8PCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4tOmr3N; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4tOmr3N"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49558ce01afso5842705e9.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 04:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785325568; x=1785930368; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=57DEPZ87ucJ5C9uIRumsuvToNlPqHFcS1ybRBzt41xg=;
        b=Q4tOmr3NPrKlHbunO+WGW5tksNDRut0JzIrMssPFekJ8X9lIPuMDhroEwWKfBheT7l
         ir7lZheWSAUWya+TtSg+psDb7MIsaCY1h77JNK2glnfIFQ5TYjZBnquo8eKZffr4JMHa
         icbuyAij8m20iYdhp9VGYpvGCDeBAvxHi2WeoP4uO+eWfnSY7qFtJJZj6L3489hntzZ6
         sp7FREGcuncaPPnHQUO0X3hEr6RZ+RCUM9zoUVsgp0EBbJwgwnSfhmCP7E/H6VpYpo/A
         RcPuT7Ci+D0HiR2WH8sQOqDGg2PE0TTd5p/dfGykxHv0Yy66c6L0QoTm3VFjU/nf58kQ
         QKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785325568; x=1785930368;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=57DEPZ87ucJ5C9uIRumsuvToNlPqHFcS1ybRBzt41xg=;
        b=UqZ70LYM6930Y31/IbJL17rz0a446ZbuBatuTcBbz6oy2HwTOV9efpl/152WIrENp5
         VWgj/bHryi7KCNhE2NUv8DSIRv5CXpSjZO4pzPeYArNzusnH2F75eha8Obii/UekR2xE
         t3le8O6tuFKKNCWaGXvvdKyE/yvHxAQZ0Uoav+zMvo5Gsh+LZxJpPImagEGt4Kp+SWR/
         HxSoh8gS0WikeCmkB7tFCsrsDHYioDtJQOSWfDn7l4Jj985iWjK7sRq2ClTz0L/icQib
         E+77X6D4i94KnRgIR/CUo1TLhGjW/i84n1bGL521xiV6mALyL1I5nHVmMGGvx2DUZaqc
         x1QA==
X-Forwarded-Encrypted: i=1; AHgh+RqAAAj+9PiAHlg7PRWvI+2wwMCrl/4JxGaloR6WMO2ycNXzJpLNvyniIBb2zacixB69F/B3y2S9smhL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/yN7+6bgjWEF2POFz5az23SuB+v2rSn8c499ljHl8guFEOn5E
	JoSZ+6JFb9EpAdU1ULe6NcXAXSiViZzKBpZdS+q3cc1RJvtjXVrW81ze
X-Gm-Gg: AR+sD13y8kThTGHaZThjFYcXe2oQm++dA209ygrBmN/92vOnE1lwREghZ8DtXxR+HL6
	QuylHkIvTu1N+Cvs3liQg5Zq8+O8VoxVH/BjHNpoJkD7eUBK1ioXiKkz4KhbVF4Ny4vJfOcSLkC
	idRa6F2awZJFCHbcWV/BpArJyFG3gKWgx3NaTvz+Dwf0Z2Rc0195eSSKgkVou8rtmWaV7OuApPI
	/KJHgJ1+4Znjtn25pf0Wk8DU/21Q9BxM/cqvmXtcgFhJTKXcNCjb9DKlnBkp7potpbM8XRkYmc3
	aGoZ9DYc7MbLtwMVom8DPfP3PGp4ZSSZb2u+DOdHFSFuvG4WcGkdciqslvPLvBpufPvEEIXgdmG
	RZpRTSmgpwoqdkt20B5wlkrC/6a/4wJZM1xTXv+dBtIGXwhnP+gijhmAWn+3+M1Jc6h/0WL8uBF
	KwcAXhPXKo0XbCwQtjzSbdIhec7mbB3X5+FGfBGbEMpV+ofhCr/p1E5VJIcfUmT2TcP+UMZFdFN
	aPpI+tKfIisOf+0LkU5IN2kEqsuRqItc9nNKEo3Pi/85p5EBhAGrOjR1i1h7mZ5b0VebBtQhWSK
	cLNmoK8l2ue2vDX2owwSm4V4Zf9FpQ==
X-Received: by 2002:a05:600c:470d:b0:493:e365:7630 with SMTP id 5b1f17b1804b1-496c6431d1fmr69913135e9.14.1785325567969;
        Wed, 29 Jul 2026 04:46:07 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:640])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-497fecfccc7sm26554895e9.12.2026.07.29.04.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 04:46:07 -0700 (PDT)
Message-ID: <b03bba6f-0a8f-41fc-af59-2a69d271f28b@gmail.com>
Date: Wed, 29 Jul 2026 12:45:47 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
To: Christoph Hellwig <hch@lst.de>,
 Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
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
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, cpgs@samsung.com
References: <cover.1785274111.git.asml.silence@gmail.com>
 <5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com>
 <CGME20260729072126epcas5p3ad4422a45f1274b71f15dec8bf487fcc@epcas5p3.samsung.com>
 <20260729072117.GI9534@lst.de>
 <81412691.21785320403945.JavaMail.epsvc@epcpadp1new>
 <20260729113108.GA31120@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260729113108.GA31120@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/26 12:31, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 03:47:23PM +0530, Anuj Gupta/Anuj Gupta wrote:
>>> But I also don't understand what the use case for this function
>>> is to start with.  struct sg_table tells us how many segments
>>> exist on the DMA side in the nents member, which should be just
>>> fine for the SGL threshold calculation.
>>
>> sg_table->nents covers the entire exported buffer (<=1GiB), while a
>> request only covers a subrange[bi_offset, bi_offset+payload). Using
>> nents would overcount the request's segments.
> 
> Urgg, yes.
> 
>>>> +	if (!entries)
>>>> +		return BLK_STS_IOERR;
>>>> +	if (entries > NVME_MAX_SEGS)
>>>> +		return BLK_STS_AGAIN;
>>>
>>> Given that the block layer enforced data in rw/command and the
>>> max_segments limit, why do we need the extra check here?
>>
>> A dmabuf bio reports nsegs=1 (bio_split_io_at) to the block layer, so
>> max_segments isn't enforced against the SG entries actually spanned by
>> the request. Hence the explicit check.
> 
> We'll need to expose the actual nsegs to the block layer and split
> based on that.  Otherwise I/O might work or fail based on the device
> capabilities.

It was exposed in early version as I was passing a [{dma,len}, ...]
array, but we moved from that. Maybe I should put the minimum
segment size in the map structure, and (possibly over) split using
that for now? Keith had this chunk in his patches:

+		int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
+
+		nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE) >>
+								PAGE_SHIFT;
+		if (bio->bi_iter.bi_size > max_bytes) {
+			bytes = max_bytes;
+			nsegs = (bytes + offset) >> PAGE_SHIFT;
+		} else if (nsegs > lim->max_segments) {
+			nsegs = lim->max_segments;
+			bytes = PAGE_SIZE * nsegs - offset;
+		} else {
+			*segs = nsegs;
+			return NULL;
+		}

-- 
Pavel Begunkov

