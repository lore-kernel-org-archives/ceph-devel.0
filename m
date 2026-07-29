Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD515394492
	for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347178; cv=none; b=VZ/M+tFo+Ci9f+ZFNFex0U7nSZBu1PqNaBNp4GNnw+b321Tead2KCyi/IWHjIWIWvSxu0fI3podFUxV3fqz7aCEbUR3ciGNbro20vhYal/SmpsEX+GMQVIgH2azdDmwp7mH8hQ04kSiCBm0UwhC9hgF7zY68s1nw36WC0q/WFn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347178; c=relaxed/simple;
	bh=UidFeDXv81Ur5iK25hdw53vt+RFWGx9NnnGs3apTKJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k8arOslobTRcncdWhXhwSSyQOSXOU3W4dNjMpJ5gAB8p+Zti12qtpkJ8VCTeHSt9dWGfAFHQboySLB2WxT8tNkFdAPl5AzdGFTyAssaf+XJCxOSWlypYuvU15dxrquH/qw2miScd0rMnqkZTaZKE0XS84A5uHyN6ZIKQjLnlnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhtNhxku; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhtNhxku"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4956242332dso10966505e9.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2026 10:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785347168; x=1785951968; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WKE9xNdjsRTW2zyuw6/ikQhgmzmnupdLH1iSl4caYw4=;
        b=LhtNhxkutVb/rQ1a9tAjPqKS+PDo91gQzXUzhrAppUhes7wCBEtJlmBszRWptzX92P
         wX9M7VrN5dJQBY9YL+kcNbAKxHdLKpFnosAfFsgl71SDaYzQYZfc398fOvi1JKDaqoHI
         Mtay1Qdc/JnUL59ypsHrWWoZb85CA3sIiyipMb2U7BFRXgz+zPg1YJx/YTGbShyP7S6H
         F4QnP9aOsxZ91Y88DL1EIBcYtcWXvXS2O/rFN2M4KOtit3fPOLDgPEiCGFks1udshJqY
         XMtXDO9ISMyh7B6RHX4Hw+OYY+VXibFRwRhYEtyrZMJBpjC29yLUNVys6GuWV+pYjIDE
         FRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785347168; x=1785951968;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WKE9xNdjsRTW2zyuw6/ikQhgmzmnupdLH1iSl4caYw4=;
        b=JDsOQKA9y/mlVXydYog7ip/VLhkBCwtaQMgE6qVwxsPxrnhZ/Rdrb/1jPfMZCb2p/M
         OVyY+lUwE5PubvT8JUtJVL4lxgg8qw/MQWUfksklOxeDiqXihlpB8Qyu1M2UStA1gNl/
         AoQ1oaKv1iS9CuRXNJE/GZCAqxQL2v1ct5scJWHeoMv7UE5d34PhE/Yhi8I5Pn/jcy19
         N64pZFuAiuwrKYtYGtbmoDdE/CwBbuHVU9SLTmpM49kw+hZhBesP++PUA29e6sSJqQFM
         NoVaKCa+Z07vKtNye0CuzMNHHkqAfnM95uAiTsCdoiCT8uLVZKCGGFH8ys465o17z/0W
         IInw==
X-Forwarded-Encrypted: i=1; AHgh+RpcfoSsuTDQl5gbMKFEcwwg4cSF/ukMA+MhtsrYmaNRojAvEi7k6p8ioQONb/vENjDSHP+qZDPM0oVD@vger.kernel.org
X-Gm-Message-State: AOJu0YwUnnSM/oOBK/UwB5OiGQUMBN/fHju+WPEJ5OZ8hHwzXRDbc01c
	8YpKa2emsJmZsER8qYoVtOvvb0qOW2Y5lzuCWAo1jlaTDDYylrWa090X
X-Gm-Gg: AR+sD11EL6BaK/JAxry7THbvM3sJnZjjXRdn35ephiXRYZGNChjBNSg/YinHKV789Q+
	JIzHJyr0Du32l5PIMCE1n9W9TDYIoNgvcihbYqQS6H3vEzblOzRMn3JXxgPU39dWmByCP/oB5Fc
	U0XsxlftfiiDPw3hqYJtFCq+adpFPuEi1pAcxSElLukT3AH7EIHmNYakCQsN9Z4s26ifswaifEk
	oPMhdZMJltjkx/8bjRgGlzzG2tjDZquQONNHwyao6L1fUHWiXvmrO+Dh++F8g4+25bpJfUsyHvY
	L2q58uUKXV7/Rmg0WPL+qgyfXfvp1Eb0sCneei/EeIWNLPBEa9DG8ZtkTOHtxIQb4kIs/4N88JD
	7xwf4eIUYN7N96ujBYlpoWsu1cG2dqKpgbVEEdkbrUw00Q+XwqU4ol9OXuDaB1SMOU41GhHS81o
	JsGFhL7jCysJJQRT7FdTOzmvgdylBgX+IAizKem7l90/bCYKqyZ6FKwM5W6adv//JqV1yb8ICvX
	lyC8jLyZfy3qcFDxBfJlckZfxR0Yymx433lB+JHI1alJSudejsOlyIbfdKlWtKP7/jLXGH3jIAr
	Gl1K9dUspnxXOe1NPy6ANrtJVY8tS/C1HF8IIE0=
X-Received: by 2002:a05:600c:4fd2:b0:493:e79e:da6b with SMTP id 5b1f17b1804b1-496c6590660mr98300165e9.21.1785347168019;
        Wed, 29 Jul 2026 10:46:08 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496c45b1c2asm171605965e9.5.2026.07.29.10.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 10:46:07 -0700 (PDT)
Message-ID: <5afa3726-6c15-41c8-af19-766eb76b4b46@gmail.com>
Date: Wed, 29 Jul 2026 18:45:58 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] io_uring/rsrc: add dmabuf backed registered
 buffers
To: Anuj gupta <anuj1072538@gmail.com>
Cc: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <CGME20260728213020epcas5p1721e72ba5544abf0b61482da005120d9@epcas5p1.samsung.com>
 <26dcd0ae5c87a3ada5710b14b6894ef343cec6fe.1785274111.git.asml.silence@gmail.com>
 <583fdfb2-5368-467f-a388-6d388859c995@samsung.com>
 <0df2f832-e8a8-4fdd-a5b6-e08657c2891f@gmail.com>
 <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3Atj+hJmF+Au1Yw5KMk--EHy_J=7Yof1aQNkUV0hCrdVEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/26 17:52, Anuj gupta wrote:
> On Wed, Jul 29, 2026 at 7:37 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>> +static int io_import_dmabuf(struct io_kiocb *req,
>>>> +                       int ddir, struct iov_iter *iter,
>>>> +                       struct io_mapped_ubuf *imu,
>>>> +                       size_t len, size_t offset,
>>>> +                       unsigned issue_flags)
>>>> +{
>>>> +    struct io_regbuf_dma *db = imu->priv;
>>>> +    struct dma_buf_io_map *map;
>>>> +
>>>> +    if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
>>>> +            return -EOPNOTSUPP;
>>>> +    if (!len)
>>>> +            return -EFAULT;
>>>> +    if (req->file != db->target_file)
>>>> +            return -EBADF;
>>>> +
>>>> +    if (req->flags & REQ_F_DROP_DMABUF) {
>>>> +            map = req->dmabuf_map;
>>>> +            goto init_iter;
>>>> +    }
>>>
>>> O_DIRECT is checked only during registration; we should recheck
>>> (file->f_flags & O_DIRECT) per request.
>>
>> Nobody should be able to clear O_DIRECT, unless I missed something?
>> And fwiw, io_uring wouldn't be the right place to do it.
>>
> 
> fcntl(fd, F_SETFL, flags & ~O_DIRECT) on an already registered, already
> open fd succeeds. The consequence is that subsequent I/Os switch to

Very exciting.

> buffered I/O and cause silent data loss. Something on this path needs
> to reject this combination.

Yeah, I'll fix it, thanks

-- 
Pavel Begunkov

