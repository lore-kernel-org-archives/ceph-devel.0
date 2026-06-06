Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C691D9A5F
	for <ceph-devel@vger.kernel.org>; Sat,  6 Jun 2026 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780790114; cv=none; b=qLuqaQ8wA7Not1DRC+isSfkhI9cRCNqYBsr79Dm30aTRNOifkix8qWRoNLLfSRXgczcyGjxBu1NIbCTfPhrQxUQ2qeCgMRDAksYKPR2b9cK6ba6hnmKYwMjq1zBqzlAkv3iGAJdjJ+6dVOH/sgt/nHGkcuxspOtbN3gHbRigO5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780790114; c=relaxed/simple;
	bh=K8OYtNJC3IIZRMBqEi51lk43u3HkOmDMFO6SNuAuxjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X8BWyvngjHbockD7OmnLUpN7FE6ixPl0pqYUp5uHBnub6d5+TKphE3TnWhJB41Gv4rZ+qOWrYIUeiYnvJlhOrgNyXF2Y54ywDqC9TSwkZsYtO3v2YDkU1bhzYW5wg/9vOKuVUnqNmYiH9rBJdatnkZ81GBGHRFj5FrjfQDW80dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=CjTBQgqW; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="CjTBQgqW"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4865e953031so3687371b6e.0
        for <ceph-devel@vger.kernel.org>; Sat, 06 Jun 2026 16:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1780790111; x=1781394911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wVY/Nc3kfIfRXZcic+3QshizwzyK0GaTXzlxRWeoy2E=;
        b=CjTBQgqWJ1AoG9moWTWz/rQBt2XUZTccRHRslxYYs8rDeuZpPFCHGbg9VlYWySgi/M
         v+skadR8BA+TmVHyxiH8MN2S9tpcYgaodi+e8NJUN4oT/9dw24a69wRaPWJqVTzFs5El
         /EI3L5s9ZNmjOQ3JMpDrqny+DSq7+oQcGwt20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780790111; x=1781394911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wVY/Nc3kfIfRXZcic+3QshizwzyK0GaTXzlxRWeoy2E=;
        b=m97vbhHEwJkjeNF/HXEu+cYE25NNPILB2OWyF3IzC918y3xo/dsVCloQPBg7XcmRAl
         cwiXNqSTLPV6d5afFQlLya/nM18rU3chuaV5b3CYdGQvz/pJLTj8FvPsqa5D5B7MKU6K
         VQ3JoZgtwyZFCxdqFtCaI55QWMTg+us3gpWi3u01L1nHY+ILUblw2/Gg3R6II/ohstjN
         TGkLlDBI5oqfYlYRSkpMtTY/J439ltR+Vps+Ry1/3hrxAC15460u0+AWkkP/H2TI54DT
         aaPAipbg0Y3NRKH+dDPKL6GJICqzYQP21wNsGMrDUBbn++XcFFe09cBorD5z+rsyWuQG
         M4Ow==
X-Forwarded-Encrypted: i=1; AFNElJ8crbWFPWYHb5pf8X5y/45EyruG7J33nAJxUrZngwptFfnrcrFRMEVlApB0XQxSn259jTHT3hThQhDv@vger.kernel.org
X-Gm-Message-State: AOJu0YyRr7K6CqXr+NMrbfJod6J9UkI6TM/yvHD3EvFri9gMMQ5mrO19
	8uEBpyqhvGX4VCtCzwqd/RcHhdK8CC0HC5UikqgSER375/HQL11DNIgkX1HHQyosJw==
X-Gm-Gg: Acq92OGujL8sH0fcZRb+R1SR0tpKLyL3o/ewLDfR708moWrvzZjarlbN49uyRFkbr20
	35gltSPvR8kuL0sr5r+kTRPpCA1oi8AWcTDKTGK8pHoqk3ZJrD5/9w/svgJ4ZENOswi4d2Q02PB
	hqWbBRg3Rict2k2YXGC8oBMHC+kUy2iTcFkHmg1A+nvvo5MB0yKo4SdtVhIIpWLlewOJ97niXbs
	5E1CsY5X19u00JU9unnUXjlyJY8KM/Y0QrtWpZDqSwWBt0eV648oGkCjoufVKiyQyc75QmHyiS3
	aoltSuDquo8tcuXbIgNdpGf+4bAUBzPqPx6idb7cHKiPJRIwEQcXXNCh9j4P0j1E6FZ4PVdO9jV
	tYYuzDWZ5tO8ygBVIIDoo1eE/Ado36N/G5FQKg63qY6Zi7xPQvPQsuWYydnP8RfY53qqbsvo11v
	I03pJO4K/SM3G/XNqLkFE+mpQNwMZr4vXlCf2h4GPPZ5sv8EVgcEti
X-Received: by 2002:a05:6808:15a5:b0:479:d674:dcca with SMTP id 5614622812f47-48692c881fbmr3789772b6e.4.1780790111555;
        Sat, 06 Jun 2026 16:55:11 -0700 (PDT)
Received: from [10.211.55.5] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4865b5a53bcsm10302924b6e.3.2026.06.06.16.55.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2026 16:55:10 -0700 (PDT)
Message-ID: <dcb49836-cebf-40b0-81b7-c06cf84b81a0@ieee.org>
Date: Sat, 6 Jun 2026 18:55:09 -0500
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] drivers/block/rbd: Use strscpy() to copy strings
 into arrays
To: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Jens Axboe <axboe@kernel.dk>
References: <20260606202744.5113-5-david.laight.linux@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260606202744.5113-5-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/6/26 3:27 PM, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Replacing strcpy() with strscpy() ensures than overflow of the target
> buffer cannot happen.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
> 
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
> 
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
> 
> Note that all the changes are only compile tested.
> 
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
> 
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
> 
>   drivers/block/rbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4065336ebd1f..632fa2d56ea0 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3672,7 +3672,7 @@ static void __rbd_lock(struct rbd_device *rbd_dev, const char *cookie)
>   	struct rbd_client_id cid = rbd_get_cid(rbd_dev);
>   
>   	rbd_dev->lock_state = RBD_LOCK_STATE_LOCKED;
> -	strcpy(rbd_dev->lock_cookie, cookie);
> +	strscpy(rbd_dev->lock_cookie, cookie);

This looks good.  The rbd_device->lock_cookie is a 32 byte
array.

Cookies passed in are always a 32 byte array (despite the
function only requiring a string pointer).

Reviewed-by: Alex Elder <elder@riscstar.com>

>   	rbd_set_owner_cid(rbd_dev, &cid);
>   	queue_work(rbd_dev->task_wq, &rbd_dev->acquired_lock_work);
>   }

