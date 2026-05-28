Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199833F8C3
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 20:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001111; cv=none; b=McWn5/FHW++7nBbUbkOsrElB0y9skjwDuh5QKXticD6GimXGFgAiGjpmHROatE9o/AdiyJE86jyTpthV+ePt+1oYDECP/jQ08qMUB/mWZQZpzVKcz3tjKPiEDRt5RaHBolbFthHgSeQUzwk28ev+GsrNcMBsM5tYTPpkbbjUiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001111; c=relaxed/simple;
	bh=WCRjE7WHRkFro0JCIsNd1W7TNugW+KjsoPfkadQQcWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wf+hB6J9AjD87tfpr+9uAyFp1euAxuBjtNJqzHmU5bZXZ///Q9godGukWxXJYJnSw4Gx46G7+Gbh89VMCihemn9UNFRzmcobB6khjiKd6XF3InOCHEGSwN2EtbfOuvk2LN8WSRo982Ih+WQpD4XAZnROjg444A7MrxCJowe+3EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=MlciJuoV; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="MlciJuoV"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-90fa736d46fso787746185a.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1780001109; x=1780605909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=forDyt6db+I9z32GZdeZGHTlTQE/tr87Pw4gHRWCrZI=;
        b=MlciJuoVqkCCKqDdYozfGXsNjKdUeD5iKgd8aolzm4imkKtqe0fKfyEtdMRIagnLvm
         aGso+IXX6KNMogIqokHlxI8U/F0uoZ4YqpqIdXB9Mmt1B8b0fpo7G+T97aY8QObsHOxz
         eWdD+j6ON87Zxq9YjsONwxaJSsxlTSHRKli4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780001109; x=1780605909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=forDyt6db+I9z32GZdeZGHTlTQE/tr87Pw4gHRWCrZI=;
        b=gNmCu7WcTQPndN/CIU6LrKLhvxJns5uiusdu42JaLKzaaSLfAguRO/QOKUT1/vq1R9
         4fgfLiF1riDgKbbX7R+60IiMz9u9oJZk2SCYmm2i3pqsA+AIOIEicMR+4t58QQaz+E99
         yuFRieG/2I6WaiBFnfgHLS5RU0CTsDG75ApHH02LhimCtS5R9W4ZLOSev4AmNbFWhH5w
         hJQzNPZlilD4FFYe33shT4fc0darPpdgD3JWiFZvCxMi6z2ofXEffQU9w0RuxAiVABtT
         7NinMHAGh3gMlHjD86faETIWpiLLuXfA0mhKwwO8oXy11HLGBCFwKxDsZ7E5hULwpwOc
         xLQA==
X-Forwarded-Encrypted: i=1; AFNElJ9rjn4pZ89DxQMln0r7f2RThu0nhODXbFxXJDKWSDimV0cnppT5TBPIdvZyDdUB7woxDZxt/UBS6CBp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hPcYd0E1oq4CXWtA6U4SIll+BbbKrhT+jQvtbSLO2n2PYv08
	XEAMDbBryQbJcB7+00vNQawpqY16zxedoaOR5QoWsXhx/9x8NE1yDwpuBHF6vbudbA==
X-Gm-Gg: Acq92OFZMr9GCGX2DtvqgF5qkjghwFQ+s/RIatSt23xwj5dEVQYoZYxPHO6kARl9N9D
	Hf7XhMUqa+gxt/mlrNG9HE8itz9/2PsGlQz5Q9bXavnWrKqZDlj7kIgSf7T3eUVO8UclaNFvLv3
	NS8N64hOdVm5gH4Ikb/aMJZT8GoMSC7F4/4EeGcEIhDDUerxApKn+7aAZiMYfpjPyEfVdB6aYo2
	VeM8xz9pCiV2dwD2oLJgevYImlFzTVo9G8b54wRbkUbnpKTzXJ08ccv0moH7JEgmw/+3xRis3Ad
	QMe4s3YDKeU/fMJ9qSFuBhww8HGIjKMxJ9WF84sI0S1WcmOCVpVOA2FiOkiGC/pYTDNc3vLka0/
	SSBPcmywSRTqPfXHH9VPVMTDHgoNj7U4bNZZPKk238NEuLRoOOgIsOPwXlvtf1/L83Z9SeoEiQg
	H/4ueai0uJ6Xb0r2G1QCVCPN0OLZDIdFnspONn8iU=
X-Received: by 2002:a05:620a:8012:b0:8fc:5ae9:7743 with SMTP id af79cd13be357-9152cf55ce4mr101633785a.43.1780001109080;
        Thu, 28 May 2026 13:45:09 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id af79cd13be357-914f870c37dsm933031285a.19.2026.05.28.13.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 13:45:08 -0700 (PDT)
Message-ID: <703f52e1-f31b-4683-95ad-14694797c2c9@ieee.org>
Date: Thu, 28 May 2026 15:45:06 -0500
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rbd: cast snap_count to size_t to avoid tautological
 comparison warning
To: Rosen Penev <rosenp@gmail.com>, linux-block@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "open list:RADOS BLOCK DEVICE (RBD)" <ceph-devel@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260528202151.136274-1-rosenp@gmail.com>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260528202151.136274-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/26 3:21 PM, Rosen Penev wrote:
> snap_count is u32 but the comparison is against a SIZE_MAX-derived value
> (~2^61 on 64-bit), which clang flags as always false with
> -Wtautological-constant-out-of-range-compare. Cast to size_t so the
> comparison is done in the correct width.
> 
> Assisted-by: Opencode:Big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

This is a simple fix.

You might consider doing something similar for this code in
rbd_dev_ondisk_valid():

         snap_count = le32_to_cpu(ondisk->snap_count);
         size = SIZE_MAX - sizeof (struct ceph_snap_context);
         if (snap_count > size / sizeof (__le64))
                 return false;

Reviewed-by: Alex Elder <elder@riscstar.com>


> ---
>   drivers/block/rbd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 94709466ad19..b4ba51db9a28 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -6079,7 +6079,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
>   	 * make sure the computed size of the snapshot context we
>   	 * allocate is representable in a size_t.
>   	 */
> -	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
> +	if ((size_t)snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
>   				 / sizeof (u64)) {
>   		ret = -EINVAL;
>   		goto out;

