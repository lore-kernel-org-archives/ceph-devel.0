Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC83283FF5
	for <ceph-devel@vger.kernel.org>; Wed, 27 May 2026 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779889408; cv=none; b=Z84Cnp5nb4nda2fpxN3UOksFc9v3I11U3iNbkT7M+o/xgSdzBwSU+ElXZCOqop7PsmwKbh2CC1CsfX/JCIhv4i62aCELgphdjig9vMwDX1YKCndI6Qa7tvQMbhu4wR0rvO4I/JGK1Vu/iTvkGeK9NG8FDYZjRfbiHe2K+NchhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779889408; c=relaxed/simple;
	bh=9AgJv2oG1aSydPjieFuHSGbHOg9VkPzRlMRY6QMY+EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOKthBk6UjxgXLSVdC+GaEEWAHsbwtwNyDW8dXqhUzjDuMxDeRucA/ePNsujpN/PkZIZEbXpFCr+KVNiU7kFhq5yQAPESkFHvxf8lcHxJgPfwL5hXK6uQLvW9Plpd0PCAaXuu8XSpb1BEJTiqsMLj1K4jFn2PxTsnQU2NFH0Rio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=DZtrum3G; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="DZtrum3G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779889394; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=9AgJv2oG1aSydPjieFuHSGbHOg9VkPzRlMRY6QMY+EI=;
 b=DZtrum3GQFZBk7h2EUShDAgfXKvWE6IeXtIZ2XZMgcVqH51WE//2aEJM3zwGaFhZGREIS
 JYuVtyGLHGxFPtl0Cb/4/3ogOYuKlCy4i9hPjh3Y3rzIUIniHO/0iYOqKxzemhav8pcMbJl
 JbtTEkbGMUZF3rCR0g2D4xYRJNXsuONrPPIV4jhpNt4ZNy0VXY6nByMZ7vMIv0en+lDZN9D
 0dy9XQwE50hQgvTvfi4m0drPgIzc6yZV8ISRzgKLxaQ2DPQltyc0vFuMK8NTd+EbAFnmBEs
 EZazECv4DMXq30Rs532rYzCU/D5FCZpHm5tFE5rM7CBEjxgYseZVHYFNkYxQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 7EB865FB57;
	Wed, 27 May 2026 15:43:14 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id F31185FB64;
	Wed, 27 May 2026 15:43:13 +0200 (CEST)
Message-ID: <23c8b73d-2d90-400f-be24-281b1dda269b@tu-ilmenau.de>
Date: Wed, 27 May 2026 15:43:13 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Fix multiplication overflow in
 decode_new_up_state_weight()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>
Cc: "security@kernel.org" <security@kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <8ece78d3-8a7f-4d7c-9619-ccc41f1bdd11@tu-ilmenau.de>
 <20260526154443.3467352-1-raphael.zimmer@tu-ilmenau.de>
 <47b69468215fd0748aa4ce95034b0a19ee8ccc15.camel@dubeyko.com>
 <0d08c0d7fb21e1ea834c7c75f9f0cf4c967f9c76.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <0d08c0d7fb21e1ea834c7c75f9f0cf4c967f9c76.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26.05.26 9:46 PM, Viacheslav Dubeyko wrote:
> On Tue, 2026-05-26 at 09:33 -0700, Viacheslav Dubeyko wrote:
>> CC: ceph-devel@vger.kernel.org
>>
>> On Tue, 2026-05-26 at 17:44 +0200, Raphael Zimmer wrote:
>>> If a message of type CEPH_MSG_OSD_MAP contains a (maliciously)
>>> corrupted
>>> osdmap, out-of-bounds memory accesses may occur in
>>> decode_new_up_state_weight(). This happens because the bounds check
>>> for
>>> the new_state part is based on calculating its length depending on a
>>> len
>>> value read from the incoming message. This calculation may overflow
>>> leading to an incorrect bounds check. Subsequently, out-of-bounds
>>> reads
>>> may occur when decoding this part.
>>>
>>> This patch adds a check that catches large values for len that would
>>> result in a multiplication overflow to treat such osdmaps/messages as
>>> invalid.
>>>
>>> Fixes: 930c53286977 ("libceph: apply new_state before new_up_client
>>> on incrementals")
>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>> ---
>>>  net/ceph/osdmap.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>>> index 076763420b1d..4638df7ad231 100644
>>> --- a/net/ceph/osdmap.c
>>> +++ b/net/ceph/osdmap.c
>>> @@ -1846,6 +1846,7 @@ static int decode_new_up_state_weight(void **p,
>>> void *end, u8 struct_v,
>>>  	void *new_state;
>>>  	void *new_weight_end;
>>>  	u32 len;
>>> +	const u32 new_state_len = sizeof(u32) + (struct_v >= 5 ?
>>> sizeof(u32) : sizeof(u8));
>>>  	int ret;
>>>  	int i;
>>>  
>>> @@ -1865,7 +1866,9 @@ static int decode_new_up_state_weight(void **p,
>>> void *end, u8 struct_v,
>>>  
>>>  	new_state = *p;
>>>  	ceph_decode_32_safe(p, end, len, e_inval);
>>> -	len *= sizeof(u32) + (struct_v >= 5 ? sizeof(u32) :
>>> sizeof(u8));
>>> +	if (len > U32_MAX / new_state_len)
>>> +		goto e_inval;
>>> +	len *= new_state_len;
> 
> Maybe, we need to consider:
> 
> if (check_mul_overflow(len, new_state_len, &bytes))
>     goto e_inval;
> 
> What do you think?
> 
> Thanks,
> Slava.
> 

I also thought about this solution, but I wasn't sure which variant
would be preferred. I saw that currently nowhere in the ceph/libceph
code a check_*_overflow() function is used and therefore decided to use
the other variant. However, using check_mul_overflow() might be the more
elegant solution and generally less bug-prone. I will send another
version of the patch using this.

Best regards,
Raphael

>>>  	ceph_decode_need(p, end, len, e_inval);
>>>  	*p += len;
>>>  

