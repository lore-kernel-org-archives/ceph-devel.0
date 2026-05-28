Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AB734B682
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780003245; cv=none; b=Rp6HouQXfxNjX4SSv6sHBiVdutjUYcFlA4CxAmP+TUd9ZnCJJp8DLz3BdUUeZxS85lvETd7btYmbhRlM581aB/7lVffAtKVGPgRP+NlunjcnkgyKTcGx7nECIIwpnJ8FWINXnpHvZVjy+Z6V05/EeDw8SnGIYkSEQjJ1x59pjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780003245; c=relaxed/simple;
	bh=A94/tG6lKwQbFmTIH4sDEme76FVU1xOwfrmbZsKbPC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIysQ5kef/mbDtM2f1XIN3jj0Nj4rdiAwJnSw0feT5nyeVAVHIqwWNwAGipdrME/ynIx1wvew02sGHx1B3ZfmsAsUvQ6fiMr58C1tyCUkCTf/x2s7kzhCYGmdDahjWf6kS8IafJJKwwvy6fhLTcjEP4dcMG0CDNWqdkjaufENFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=U0xapiU0; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="U0xapiU0"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69df5352d0eso836755eaf.3
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 14:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1780003242; x=1780608042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=REoNE1HfXaVLqrZcttqszE/nOIthQd3PR5HKi6IwFgI=;
        b=U0xapiU0YMyockxdy40A6yiBs5y98rBhsm7KOzgP2z54qLQzrRsxz9GcwlasBHHU42
         WivFvQTIPomIou7Mgrm0+ugQJRKFTzHy7Y4iVZcuhcSviUgoriizCwwOlR+wyW21zj1j
         5WJoF27loXVx34OcWAkAL4DDkUNXIy66LBSZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780003242; x=1780608042;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REoNE1HfXaVLqrZcttqszE/nOIthQd3PR5HKi6IwFgI=;
        b=Po7M6cYNVx/zwQ8nivYseFaly4m0VEUFt/MUhUNN+Xba1uprYdveOlBRCU3749jx9V
         B4fq3uGUsO6cNsCF5lr3utqH9IQY3V+bgJnzx7AehppKdvKRdVct952NlcOQ8cdFdb6Z
         LfCZMuEI/Zb3dT5pCvLbqhHbdgInW8ZPhPpf3TQinRzk1U/iS3a8HJ9Z0Jd6/DFyWaBo
         Gd1axj4VXg0/W0dlOP//5Z4DOyiBfLnIhsavbu/CmpeSwj2E81QmtkV2jwKwy2bLF8lH
         RVq/6zZZRVf9ogt3h/xk6bOwUW23Xj0pD4WDXiPEL7T0a5r/XnWI7GooaLy+4XIptfW9
         naCA==
X-Forwarded-Encrypted: i=1; AFNElJ9Pr1URWevQ0oEOEtoqKWBKqdQIkc2+MzLiPKvtdbNFyKImmCphDC7lKXeVyCa0kXqZUXdytCsljjQd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5t1WW1ux6q9R9ls4gnHMLxA7w/te+XjRPa+TWospG8GXCXUQ7
	JxvyG3/+DJg+kwNAUPM6nYtnce69gaprAH3FLiegVjIcLWKcMpnRP1/ZxKSdTotibA==
X-Gm-Gg: Acq92OFMvfVKkz9n1ytpFzUsw+zv2q1nU9q2ezk/Vl35juB6AxvPOveTprr91MfjGp4
	RMNxTvYIoxYEYYl3tRZVBPhwOXPJC0cKLhlUWfGtqEJgR7PL/cptwyDcRZnOY9ug8EX4dp6YV7y
	Mz+bFroaJfgVhX3ALqIvXmteDPUtXECL858pu83Pf97SbgafPc6/k3m/XoUUx2K/nlmrw2thGX7
	KkqG6cOucRFj6fwWLPw4ksYdHPaR23PscLJzJH/UtGkOoVQVBWjEYziM5fubAE6bpST+bypvkzp
	Tu6uGdFOE56hgY0ML35vci4HAuQTluxGtlqzfmj0VPzLpShna32qZTwqhLkHyIdzyT5W/fIWQoR
	aAV4XZL1vB2NIB8t37lYMEVN6kmYV1/F3HrWJCbMF/YYr7zqdKTIqZe5ZIqMSkasvXxKig2OK7y
	WMtpcTkotkUEegoAhjTD64p8CKEX3/
X-Received: by 2002:a05:6820:4dc3:b0:69d:fe44:b399 with SMTP id 006d021491bc7-69e03eff921mr174988eaf.19.1780003242288;
        Thu, 28 May 2026 14:20:42 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.googlemail.com with ESMTPSA id 006d021491bc7-69e040ce50fsm118638eaf.2.2026.05.28.14.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 14:20:41 -0700 (PDT)
Message-ID: <01625bb3-1a91-4d2a-bfc8-7d34ce4b5e5b@ieee.org>
Date: Thu, 28 May 2026 16:20:39 -0500
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rbd: cast snap_count to size_t to avoid tautological
 comparison warning
To: David Laight <david.laight.linux@gmail.com>,
 Rosen Penev <rosenp@gmail.com>
Cc: linux-block@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Jens Axboe <axboe@kernel.dk>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "open list:RADOS BLOCK DEVICE (RBD)" <ceph-devel@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260528202151.136274-1-rosenp@gmail.com>
 <20260528220505.73eac71a@pumpkin>
Content-Language: en-US
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20260528220505.73eac71a@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/26 4:05 PM, David Laight wrote:
> On Thu, 28 May 2026 13:21:51 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
> 
>> snap_count is u32 but the comparison is against a SIZE_MAX-derived value
>> (~2^61 on 64-bit), which clang flags as always false with
>> -Wtautological-constant-out-of-range-compare. Cast to size_t so the
>> comparison is done in the correct width.
> 
> If that warning makes any sense then the cast shouldn't make any difference.
> 
> Why not check against RBD_MAX_SNAP_COUNT - the buffer isn't big enough
> to hold any more than that.

I like that better.  Please do that instead (despite my
Reviewed-by provided earlier).

					-Alex

> 
> -- David
> 
>>
>> Assisted-by: Opencode:Big-pickle
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>   drivers/block/rbd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 94709466ad19..b4ba51db9a28 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -6079,7 +6079,7 @@ static int rbd_dev_v2_snap_context(struct rbd_device *rbd_dev,
>>   	 * make sure the computed size of the snapshot context we
>>   	 * allocate is representable in a size_t.
>>   	 */
>> -	if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
>> +	if ((size_t)snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
>>   				 / sizeof (u64)) {
>>   		ret = -EINVAL;
>>   		goto out;
> 
> 

