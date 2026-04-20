Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26B23382DE
	for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700023; cv=none; b=iXDwn2vRRKAZswMGsoEudYvf41N1r8IWaIF/xi4mJL1ecZClE4JxJyLBdnp8WyerMPwlWV/3VUukcytZiIxfAW6Xj2CxLDzkBHfGSWuP5ZlRCM6bOzkfBjpO9HGuFDit6d3BbJK16FQn4A9xkrdW0nIbRGFDk13xwDmBvunu2hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700023; c=relaxed/simple;
	bh=ACW6tz8sxKXMIV6vEgQpLcbjRoFpwTaSwJJk4RAqXjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWTTyR14yjpFkEIER+oAlCs+JUH7/voInsIOR6Ml4WNVEXWK+gQQr9Ej/JMIvxlWr4HSKnyEUBQ5gDBmXxS38BOQub1hBd4isbiU7G1tGjE6suBl7pS4MIXZaCWKpzslg+HhSMVTzpu3Vk7R5xu2w9PstLxkO5MWhaNhJnYlX/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=lXAEKHPx; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="lXAEKHPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1776699928; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=ACW6tz8sxKXMIV6vEgQpLcbjRoFpwTaSwJJk4RAqXjc=;
 b=lXAEKHPxQsasBP6b+k7vGF19pXXDNdSZ38S9xsIJbiHhb93R6s1Q2WY6nUlTiMWEP6HI+
 pRfFAxm7FWqjFp0gaRT/gqBdDPwCx3GIya9NKfPWsc5tItAV9DSaasodREYQ07ebDRwKlwo
 V5R729frzbzZhSt4yH6m6w1bxUmxKJqAexLwKzQVUF8mQ4pCxjG/fbtafEwv4D2crKC5Tok
 Utug/VXrEuDwiJ5M0J4nTcWmA/0gOkoobREboeKojPqiKwzebLgGsS3eYmppLWiiPU8Oaag
 vxaawcOYoTXHTEzzcQjdtmhS/D2LMq3dqos210SdLvDIIRIxd0NOYJd0VD+w==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 885F35FCDF;
	Mon, 20 Apr 2026 17:45:28 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 641C45FA96;
	Mon, 20 Apr 2026 17:45:28 +0200 (CEST)
Message-ID: <ec4a8bda-ca80-410f-8b97-413cf64d7f39@tu-ilmenau.de>
Date: Mon, 20 Apr 2026 17:45:28 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Fix slab-out-of-bounds access in auth message
 processing
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: "security@kernel.org" <security@kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <4f9fdcde-f5a8-43a8-9580-6ec3402c4185@tu-ilmenau.de>
 <20260320094154.1158656-1-raphael.zimmer@tu-ilmenau.de>
 <0959410fbce95fb8f5ac25de6c751421834ae923.camel@ibm.com>
 <395ea4e1-f83c-472a-b336-fba24368e5ce@tu-ilmenau.de>
 <9afcc984548bfb418f3fbab64dd98f5e14ed63c0.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <9afcc984548bfb418f3fbab64dd98f5e14ed63c0.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23.03.26 7:59 PM, Viacheslav Dubeyko wrote:
> On Mon, 2026-03-23 at 12:39 +0100, Raphael Zimmer wrote:
>> On 3/20/26 7:28 PM, Viacheslav Dubeyko wrote:
>>> cc: ceph-devel@vger.kernel.org
>>>
>>> On Fri, 2026-03-20 at 10:41 +0100, Raphael Zimmer wrote:
>>>> If a (potentially corrupted) message of type CEPH_MSG_AUTH_REPLY
>>>> contains a positive value in its result field, it is treated as an
>>>> error code by ceph_handle_auth_reply() and returned to
>>>> handle_auth_reply(). Thereafter, an attempt is made to send the
>>>> preallocated message of type CEPH_MSG_AUTH, where the returned value is
>>>> interpreted as the size of the front segment to send. If the result
>>>> value in the message is greater than the size of the memory buffer
>>>> allocated for the front segment, an out-of-bounds access occurs, and
>>>> the content of the memory region beyond this buffer is sent out.
>>>>
>>>> This patch fixes the issue by first adding a check that catches a
>>>> positive value in the result field of the message and treats it as
>>>> invalid, and second comparing the len parameter of
>>>> __send_prepared_auth_request to front_alloc_len to prevent sending the
>>>> message if it exceeds the bounds of the allocation.
>>>>
>>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>>> ---
>>>>   net/ceph/auth.c       | 5 +++++
>>>>   net/ceph/mon_client.c | 5 +++++
>>>>   2 files changed, 10 insertions(+)
>>>>
>>>> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
>>>> index 3314705e5914..555b1fab4623 100644
>>>> --- a/net/ceph/auth.c
>>>> +++ b/net/ceph/auth.c
>>>> @@ -215,6 +215,11 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
>>>>   	ceph_decode_need(&p, end, sizeof(u32) * 3 + sizeof(u64), bad);
>>>>   	protocol = ceph_decode_32(&p);
>>>>   	result = ceph_decode_32(&p);
>>>> +	if (result > 0) {
>>>
>>> Frankly speaking, it's hard to follow how this is correct without protocol
>>> knowledge. Do we have any declarations of result possible values? Probably, we
>>> need to have some comment that explain the situation in more details here?
>>>
>>
>> Yes, it would be good to have an exact protocol specification. From what 
>> I can see in the code, the result value is either 0 for success or a 
>> negative Linux error code. Therefore, a positive value here would always 
>> indicate a malformed message. But maybe you know more?
> 
> I would like to hear what Ilya can share here. :) He should know more. The 
> result > 0 looks not obvious to me. This is why I believe that, at minimum, some
> comments should make the code more easier to follow.
> 

Hi,
is there any update on this by now? Did you hear anything from Ilya?
I don't think that it's good to have this disclosed but not fixed for a
long time.

Best regards,
Raphael

>>
>>>> +		pr_err("unexpected result code in auth msg\n");
>>>> +		ret = -EINVAL;
>>>> +		goto out;
>>>
>>> Maybe, do you need jump to bad?
>>>
>>
>> No, Ilya recently mentioned that this is intended for classic decoding 
>> errors. Here, a more specific error message should be emitted.
> 
> OK.
> 
>>
>>>> +	}
>>>>   	global_id = ceph_decode_64(&p);
>>>>   	payload_len = ceph_decode_32(&p);
>>>>   	ceph_decode_need(&p, end, payload_len, bad);
>>>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>>>> index d5080530ce0c..7206db5f7695 100644
>>>> --- a/net/ceph/mon_client.c
>>>> +++ b/net/ceph/mon_client.c
>>>> @@ -174,6 +174,11 @@ int ceph_monmap_contains(struct ceph_monmap *m, struct ceph_entity_addr *addr)
>>>>    */
>>>>   static void __send_prepared_auth_request(struct ceph_mon_client *monc, int len)
>>>>   {
>>>> +	if (len > monc->m_auth->front_alloc_len) {
>>>> +		pr_err("sending auth request failed, because len: %d exceeds allocation size: %d\n",
>>>> +			len, monc->m_auth->front_alloc_len);
>>>
>>> Is it proper place for this check? It looks like we fail to send something and
>>> execution flow has no idea that we failed. Yes, system log will receive the
>>> error message but the rest of the logic will continue business as usual. Maybe,
>>> you are right but is it not to late to simply complain here?
>>>
>>> And if we don't send the request, then could it affect the whole functionality?
>>> Could we introduce a race condition or deadlock here?
>>>
>>> Thanks,
>>> Slava.
>>>
>>
>> This check should never be true. It is just a common place where a 
>> severe data leakage can be prevented if anything went wrong before, 
>> because m_auth->front.iov_len is modified there. This would prevent 
>> another bug like this if the logic before was flawed. To fix the current 
>> vulnerability, it is not absolutely necessary to have this.
>>
>> Maybe an assertion like a BUG_ON is also fine here. Otherwise, the 
>> handling of this function would most likely have to be changed at 
>> multiple places.
> 
> Maybe, BUG_ON() looks like more proper solution if we should not be here for
> such case.
> 
> Thanks,
> Slava.
> 

