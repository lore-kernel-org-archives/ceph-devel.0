Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0543128D4
	for <ceph-devel@vger.kernel.org>; Mon,  9 Mar 2026 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094540; cv=none; b=VbebXgqCDBknLNDlf7lFe5zpxQ5s7SFImqSEzhunDtgD+vgEgPCET0dehBJfZfj9I06q/YyhWl7LxBImZnr35KSNqSEQCuRfYKRqAQ6X5g0chzyGZbsT3k53Ywzbohr7GusF2VrSHdJjAHwGop1OzBeiBGQNRRwo3S6qKcSdIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094540; c=relaxed/simple;
	bh=w6hZw2T1dANjKzkNSU/hunFY7555qtMdHe7BOdDU47k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdLc2VL+m3ZMifyZM2XVjZvm0Y+8E4M3nKG53T/vvOAGphx5SLO7cUY7emBUESYwBRpGkVn6SCAKHThbvyqWtSydBgzuiX44NrFZPOmmFrjudQtQDz/l4VfjRK+jtpN/OdiVvfVU4lfBkXbDXXpyDeA5ww+5mB02HLLlTNvVWpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=JIS4Suc7; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="JIS4Suc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1773094530; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=w6hZw2T1dANjKzkNSU/hunFY7555qtMdHe7BOdDU47k=;
 b=JIS4Suc7WuSQ1xib8dsHPjOCAzN7GpX9YbG7Wtw91LPn/IEK+fdb48iHR4XA25kGeVau2
 bUebbrvCYb+42QalXOmQ1YJ+BslzLjJNkK74cklQauugl4OuPK9Mrn1at6TPmMiW48nlQoR
 be7L3GNwkeqNZR99AF2rZFeI+vGP+mgpiiLK9JBYNjy+fem68ff3x0PID/fiHyaOoonXbns
 StxDMIIYYqzax4DuAmuiE9V3BSd8ln5q46Ueb8zejK3bQTxHlftTjvSDbRycN2PR6ZLvH08
 ZRJWS/Mzkevmy5pezMYrQPPi0RDHh4U8pfoegSpV4DYeEsEQ/gGxOF17VfkA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id E2D8B5FC9F;
	Mon,  9 Mar 2026 23:15:29 +0100 (CET)
Received: from [192.168.178.114] (unknown [217.252.212.162])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 0DE7C5FB27;
	Mon,  9 Mar 2026 23:15:25 +0100 (CET)
Message-ID: <0b2be270-b5da-48bb-a7ff-14115b17c44f@tu-ilmenau.de>
Date: Mon, 9 Mar 2026 23:15:25 +0100
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Fix potential out-of-bounds access in
 ceph_handle_auth_reply()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <20260305164049.2844606-1-raphael.zimmer@tu-ilmenau.de>
 <9a967105c12095a4e5f32d1c49550c2424580483.camel@ibm.com>
 <1b946af9-8c9f-49e4-9f36-efacaf2bcbde@tu-ilmenau.de>
 <2ddfc235e05ab8705a92f5e2e1ed780f47b9cc30.camel@ibm.com>
 <1bf00a3a-d022-49eb-890e-a9b52a9da0bb@tu-ilmenau.de>
 <3d6435690a9485f3c2f93ec6ce03388d6e5911d1.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <3d6435690a9485f3c2f93ec6ce03388d6e5911d1.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/26 7:30 PM, Viacheslav Dubeyko wrote:
> On Sat, 2026-03-07 at 10:37 +0100, Raphael Zimmer wrote:
>> On 3/6/26 8:24 PM, Viacheslav Dubeyko wrote:
>>> On Fri, 2026-03-06 at 10:14 +0100, Raphael Zimmer wrote:
>>>> On 05.03.26 8:33 PM, Viacheslav Dubeyko wrote:
>>>>> On Thu, 2026-03-05 at 17:40 +0100, Raphael Zimmer wrote:
>>>>>> This patch fixes an out-of-bounds access in ceph_handle_auth_reply()
>>>>>> that can be triggered by a message of type CEPH_MSG_AUTH_REPLY. In
>>>>>> ceph_handle_auth_reply(), the value of the payload_len field of such a
>>>>>> message is stored in a variable of type int. A value greater than
>>>>>> INT_MAX leads to an integer overflow and is interpreted as a negative
>>>>>> value. This leads to decrementing the pointer address by this value and
>>>>>> subsequently accessing it because ceph_decode_need() only checks that
>>>>>> the memory access does not exceed the end address of the allocation.
>>>>>>
>>>>>
>>>>> Do you mean that payload_len could be bigger than INT_MAX? Is it possible
>>>>> scenario to have so big payload size in one message?
>>>>>
>>>>> Maybe, the problem is more serious than simple changing of int on u32? It sounds
>>>>> like we are hiding a real issue by this fix.
>>>>>
>>>>> Thanks,
>>>>> Slava.
>>>>>
>>>>
>>>> Hi Slava,
>>>> actually, I don't think that a correctly functioning monitor will ever
>>>> send an auth_reply message with a payload larger than 2GB. This patch
>>>> shall prevent a (maliciously) corrupted message with a huge value in the
>>>> payload_len field from causing a memory access to an out-of-bounds address.
>>>>
>>>
>>> You've shared the Call Trace with the patch. So, I expected that you had a real
>>> crash.
>>>
>>> OK. If we have the corrupted message with a huge value, then we need:
>>> (1) Convert int into u32 -> you've already did this.
>>> (2) It is dangerous to continue parsing the payload with corrupted payload_len
>>> because we definitely will try to access the out-of-bounds address during teh
>>> parsing. We need to check the correctness of payload_len. As far as I can see,
>>> ceph_handle_auth_reply() receives buf pointer and len value. I assume that
>>> payload_len cannot be bigger than len. I suggest to compare the payload_len and
>>> len. Does it make sense to you?
>>>
>>> Thanks,
>>> Slava.
>> Hi Slava,
>> I don't completely agree with your second point. In fact, payload_len
>> should always be smaller than len.
>>
> 
> It sounds like contradiction to your initial point. :) Your initial point was
> that we "shall prevent a (maliciously) corrupted message with a huge value in
> the payload_len field from causing a memory access to an out-of-bounds address".
> If we are talking about corrupted message, then there is no guarantee that
> payload_len is smaller than len. Otherwise, if we have guarantee that
> payload_len is smaller than len, then even integer data type will be completely
> enough.
> 

That's not what I meant with this sentence. I meant that you're right 
with "I assume that payload_len cannot be bigger than len." Checking 
that payload_len is smaller than len is a check that every valid message 
must pass. Subsequently, I argued why I think that this check doesn't 
give any meaningful additional protection regarding this issue.

>> But with the current version of the
>> patch, we will not try to access the out-of-bounds address during
>> parsing if this doesn't hold true. That's because this check [1] ensures
>> that the address does not lie beyond the end of the allocation. Changing
>> the data type of payload_len to u32 ensures that the address can only be
>> incremented and therefore only be inside the allocation or greater, but
>> no longer smaller. The only exception from this would be if p +=
>> payload_len would lead to an overflow of p. This would require p to be
>> already greater than 0xffffffff00000000 in the beginning. As far as I
>> know, this is not possible because you can't get an address in this
>> range from an allocation.
> 
> There is also no complete guarantee that pointer addresses will be sane. I
> prefer not to rely on sanity of address arithmetic. :)
> 
> Thanks,
> Slava.
> 

In my opinion, when you have a message that comes over the network, you 
should be prepared for it to have any mathematically possible value in 
any field. Therefore, we shouldn't implicitly assume anything about 
either payload_len or len. But if the pointer you get from a memory 
allocation inside your system is invalid, you have lost anyways. Then 
the check for payload_len < len doesn't help anymore, because the 
pointer will be invalid even if this condition holds true.

Nevertheless, since you seem concerned about it, I will look into it 
once more to add an additional check.

Best regards,
Raphael

>> Consequently, adding a check that compares payload_len to len would not
>> hurt, but it's not necessary to fix the problem.
>>
>> Best regards,
>> Raphael
>>
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__elixir.bootlin.com_linux_v7.0-2Drc1_source_net_ceph_auth.c-23L222&d=DwICaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=q5bIm4AXMzc8NJu1_RGmnQ2fMWKq4Y4RAkElvUgSs00&m=6I9IAzgahWU9YVIkblmw9tw32zGC6mVGUJvjruRcqRsG3hJxbjfupAa-aMFQdPK8&s=3-qdekcJB2nBlXQyb22erDpM3rmThxA2mIwKz6jogYk&e=

