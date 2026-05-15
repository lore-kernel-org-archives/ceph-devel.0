Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F204037DEB4
	for <ceph-devel@vger.kernel.org>; Fri, 15 May 2026 07:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830882; cv=none; b=Xypyz+azrh0xb4Rvp4L4nfbuTIrrtCkUjsANDEeEnjaMv7V8eIXU5xmCTmPNrugQAQbmK09ZCuMASbFXnoiMTud19bpoOfOu92pqy9hA/dasCZWUaRDxksAhb1ZoVm3Y7TW+sv8d6r5LocoUs8uhRUoE9NHDqOxesE57VTTzTos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830882; c=relaxed/simple;
	bh=ptO8iIALqsmxEsnL+QNV6cB2BmEie4vvh9/UZXV62RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8MAlIhIff88lsHRk1kNHQpjNx3pHXBEAQN7vmEQmz6fdwny5E4j9zPBXnrCMX2eI3Y1vsY5LuL0SlHayYLWGSbk22wSdNkDp8fIk3U73I719hwkY8wwTsAlss+cfDBHK6Aqu3udsGA72aNwKdU3PytkmuouSEoWBcYwujw08n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=r69BpmQQ; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="r69BpmQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1778830871; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=ptO8iIALqsmxEsnL+QNV6cB2BmEie4vvh9/UZXV62RA=;
 b=r69BpmQQZ6Lff7xzGBLuJvs+wX0xHi7qbnLS6X5lmOa0a3fvnPqSiFrld7KtWzccOFNvI
 x3lBnMCbIyevkQaXcOo8v274Doi5qoKV4DdXPvieTox931AISQ8Nuns2tjoCLsly416b3SL
 GHk0AYEJcB5A5sBHDi91SW1xVLWKqnIN1+VOsQQmYeobIgtY+Yd3uA0uOXkzD24lwsQ6lUg
 IC5HGnDYyZM9Sa10aaGWjge0obQbkTsI0SsLUEfw1jsGj86PTu6af3lfYQHo4RLEhylNbye
 NHcHbai/kN+h8mOvwa3taKdobLffJmnrWbUuSYEB+782nN5iNBVf92DZtcCQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 5A2FC5FD2E;
	Fri, 15 May 2026 09:41:11 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id BA0885FB21;
	Fri, 15 May 2026 09:41:10 +0200 (CEST)
Message-ID: <063a77e2-d189-4eb9-92a2-0355e6b7dc0d@tu-ilmenau.de>
Date: Fri, 15 May 2026 09:41:10 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>
Cc: "security@kernel.org" <security@kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <8edcef9c-0b7c-46dc-8094-dc55b62567d3@tu-ilmenau.de>
 <20260513081425.1477060-1-raphael.zimmer@tu-ilmenau.de>
 <a9e24eba42be211967a5342550561250c5894dea.camel@dubeyko.com>
 <e510a0d0152cda8fc1662d55e4903d3caa290a39.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <e510a0d0152cda8fc1662d55e4903d3caa290a39.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13.05.26 7:18 PM, Viacheslav Dubeyko wrote:
> On Wed, 2026-05-13 at 09:40 -0700, Viacheslav Dubeyko wrote:
>> cc: ceph-devel@vger.kernel.org
>>
>> On Wed, 2026-05-13 at 10:14 +0200, Raphael Zimmer wrote:
>>> A message of type CEPH_MSG_OSD_MAP holds an OSD map, which typically
>>> contains a pg_upmap part at its end. When decoding this part in
>>> __decode_pg_upmap_items(), a len value is decoded from the message to
>>> determine the number of items and the size of the allocation needed
>>> for
>>> them. If the len value is greater than or equal to 2^31, an overflow
>>> occurs in the multiplication that is performed to determine the
>>> needed
>>> size of the incoming buffer to decode, as well as for the length of
>>> the
>>> allocation for the ceph_pg_mapping struct. Subsequently, this results
>>> in
>>> out-of-bounds writes (and reads) when decoding the incoming message
>>> fields into the ceph_pg_mapping struct.
>>>
>>> This patch fixes the issue by adding a UL suffix to the literal in
>>> the
>>> multiplication to perform it as an unsigned long multiplication.
>>>
>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>> ---
>>>  net/ceph/osdmap.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>>> index 8b5b0587a0cf..42b7b5300901 100644
>>> --- a/net/ceph/osdmap.c
>>> +++ b/net/ceph/osdmap.c
>>> @@ -1620,8 +1620,8 @@ static struct ceph_pg_mapping
>>> *__decode_pg_upmap_items(void **p, void *end,
>>>  	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 *
>>> sizeof(u32)))
>>>  		return ERR_PTR(-EINVAL);
>>>  
>>> -	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
> 
> We use the pattern 2 * sizeof(u32) three times in the function. I can suggest to
> introduce a local variable that will keep this value.
> 
>>> -	pg = alloc_pg_mapping(2 * len * sizeof(u32));
> 
> I think it doesn't make sense to execute the same calculation two times. Of
> course, compiler can do some optimizations. But I suggest to introduce a local
> variable that will contain the final calculation of 2UL * len * sizeof(u32) and
> it will be used in both cases.
> 

Hi Slava,
I will rework this.

>>> +	ceph_decode_need(p, end, 2UL * len * sizeof(u32), e_inval);
>>> +	pg = alloc_pg_mapping(2UL * len * sizeof(u32));
>>>  	if (!pg)
>>>  		return ERR_PTR(-ENOMEM);
>>>  
> 
> By the way, this check:
> 
> 	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
> 		return ERR_PTR(-EINVAL);
> 
> will work  a wrong way for the case of if the len value is greater than or equal
> to 2^31.
> 

What do you mean by "will work a wrong way"? I don't see any issue with
it or different behavior in case of len >= 2^31.

Best regards,
Raphael

> Thanks,
> Slava.

