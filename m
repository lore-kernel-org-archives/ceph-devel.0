Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442E4E55A
	for <ceph-devel@vger.kernel.org>; Sat,  7 Mar 2026 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772876290; cv=none; b=GK/21ecFMHbSj/i0RYprxIlCfx+nwSWG/6udfvdPXPH3IacM3CisXeTsBPgpsZNeFCwnzlaRJwg2N6zst/b8CWIskLV9Q3WIM4YzZu2Umol03c82szjMSwqPX1JeRNMkXnBlwuNXjs3wRwSbEUDrmnn3nNsy7KCmnSptEasHUag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772876290; c=relaxed/simple;
	bh=t9u6CVCAZvzsOm6q0Clw8mfj0jgha2hIrbqfrJ7NznQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSRPV7aCMCUpFRGVLO90dsliJthjAF7/YLmMJylUnOoQxoXkNfcZJ3HUEIYW6B1lGN1YPYy38pR94cHEXQ9voErx+5EtLb9s/woUGWpDgEOQO9SNKEuCgbFd3y59zvn1doem958N4KkOmCPuo0M8dfhThonvfiPb9+z4nyma/MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=zzwb6ZWM; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="zzwb6ZWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1772876278; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=t9u6CVCAZvzsOm6q0Clw8mfj0jgha2hIrbqfrJ7NznQ=;
 b=zzwb6ZWM3WwcXvnP8JGlgiRXXJ9dBah2ZtPu6kWoB1ClenTL0MR94wO1vaOKKe76f2fIX
 G1bX9xarm64neC/ZxEGAulJRnd8KM4IqbqnkTlnJaKpllbndMco0hdvTnE1tY1og8ctCKuX
 A4nv+c55yFc5Sbe/4FKxdKFA8ovxQtSpPxzOU0K9En1yY1qZHXROLWxtUEUNCgoA17epPB6
 ehLGUjKOytrdNkKhre597MidPeq1WeM9eRWr/Nh6vCrHsE6XfVi6Y6lHYgEkOuXS6FUMFk6
 uN/qnCmg+6X5dNinfBXS3hbyzeDVZqxoaUD5CMl9c9TSAET6faF+uo4pP17w==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 796F660170;
	Sat,  7 Mar 2026 10:37:58 +0100 (CET)
Received: from [192.168.178.114] (unknown [217.252.212.162])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 527F35FC96;
	Sat,  7 Mar 2026 10:37:55 +0100 (CET)
Message-ID: <1bf00a3a-d022-49eb-890e-a9b52a9da0bb@tu-ilmenau.de>
Date: Sat, 7 Mar 2026 10:37:54 +0100
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
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <2ddfc235e05ab8705a92f5e2e1ed780f47b9cc30.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/6/26 8:24 PM, Viacheslav Dubeyko wrote:
> On Fri, 2026-03-06 at 10:14 +0100, Raphael Zimmer wrote:
>> On 05.03.26 8:33 PM, Viacheslav Dubeyko wrote:
>>> On Thu, 2026-03-05 at 17:40 +0100, Raphael Zimmer wrote:
>>>> This patch fixes an out-of-bounds access in ceph_handle_auth_reply()
>>>> that can be triggered by a message of type CEPH_MSG_AUTH_REPLY. In
>>>> ceph_handle_auth_reply(), the value of the payload_len field of such a
>>>> message is stored in a variable of type int. A value greater than
>>>> INT_MAX leads to an integer overflow and is interpreted as a negative
>>>> value. This leads to decrementing the pointer address by this value and
>>>> subsequently accessing it because ceph_decode_need() only checks that
>>>> the memory access does not exceed the end address of the allocation.
>>>>
>>>
>>> Do you mean that payload_len could be bigger than INT_MAX? Is it possible
>>> scenario to have so big payload size in one message?
>>>
>>> Maybe, the problem is more serious than simple changing of int on u32? It sounds
>>> like we are hiding a real issue by this fix.
>>>
>>> Thanks,
>>> Slava.
>>>
>>
>> Hi Slava,
>> actually, I don't think that a correctly functioning monitor will ever
>> send an auth_reply message with a payload larger than 2GB. This patch
>> shall prevent a (maliciously) corrupted message with a huge value in the
>> payload_len field from causing a memory access to an out-of-bounds address.
>>
> 
> You've shared the Call Trace with the patch. So, I expected that you had a real
> crash.
> 
> OK. If we have the corrupted message with a huge value, then we need:
> (1) Convert int into u32 -> you've already did this.
> (2) It is dangerous to continue parsing the payload with corrupted payload_len
> because we definitely will try to access the out-of-bounds address during teh
> parsing. We need to check the correctness of payload_len. As far as I can see,
> ceph_handle_auth_reply() receives buf pointer and len value. I assume that
> payload_len cannot be bigger than len. I suggest to compare the payload_len and
> len. Does it make sense to you?
> 
> Thanks,
> Slava.
Hi Slava,
I don't completely agree with your second point. In fact, payload_len 
should always be smaller than len. But with the current version of the 
patch, we will not try to access the out-of-bounds address during 
parsing if this doesn't hold true. That's because this check [1] ensures 
that the address does not lie beyond the end of the allocation. Changing 
the data type of payload_len to u32 ensures that the address can only be 
incremented and therefore only be inside the allocation or greater, but 
no longer smaller. The only exception from this would be if p += 
payload_len would lead to an overflow of p. This would require p to be 
already greater than 0xffffffff00000000 in the beginning. As far as I 
know, this is not possible because you can't get an address in this 
range from an allocation.
Consequently, adding a check that compares payload_len to len would not 
hurt, but it's not necessary to fix the problem.

Best regards,
Raphael

[1] https://elixir.bootlin.com/linux/v7.0-rc1/source/net/ceph/auth.c#L222
