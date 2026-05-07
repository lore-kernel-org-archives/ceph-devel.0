Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A9315D21
	for <ceph-devel@vger.kernel.org>; Thu,  7 May 2026 12:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778157145; cv=none; b=Yo8SmCYftmzVH5wah83MkIeb6mSoCGa6wDWY/tHNEgMq77IH1GoIydO7Lee0SZrQ7nASRZ3VZ8aISs4bZn9cl6P6aahMetkF59wyOKom4zHTdBJZjx/itGI5Gu6Pk00Koosbs0H2b5owoePlRzJCBG47LXaJLuo98fEh50abA8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778157145; c=relaxed/simple;
	bh=+JMsqCc4rU4dAAZaXT1k1/ECFvSw89z5FiWOxTcddTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKdMA5GeHPT/RvN8nRltZs9/WLXRSKnh2md7cFPyEN7IgzIgupPIOa72jKsNi1UsBiN0eagfkXhHlK+hXoHj6lmCNWHqSrYg9QDLmld/QJU3IaNj9cKnBk5IESKJ22pkqSxxZ0v0yLUkCjdp3FiEnu/SaZxUav3/j6sLJT67cUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=UtaxxTi+; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="UtaxxTi+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1778157140; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=+JMsqCc4rU4dAAZaXT1k1/ECFvSw89z5FiWOxTcddTA=;
 b=UtaxxTi+omH2jma0N95t1uRQzO07ulfSbRG7isoJvCLYO1LNMoTeXYoJ0vgM6IQ635Jwj
 V/EfWyRSXQgFPWZiNNMQVHjg9sfdNbEUIgurYV45Y2Wmo+sbBlpBtmcRjjaOnouqOkq4O58
 ZnpwaGYJdrQbTzIFUK6+Yqnml1LG3NFFbRi+CF57FVuh160bK5eXHLiTgCi7jCOuqTifaun
 RQN97lILVMgAn7pxUOYCklL6eTzPmufBJkf2F3Fm8cUc3Vb0bpRWVZ9GdgseI0avnQOSMmW
 Out9Tt56FnJsWAD+GariU2GkGZT1G5Dv+p7GVc04Xgv7lYHY480pYv/7Odvg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id E03FD5FCA7;
	Thu,  7 May 2026 14:32:19 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 9EA8C5FB28;
	Thu,  7 May 2026 14:32:18 +0200 (CEST)
Message-ID: <973d160a-2f8f-4afb-ac4d-233aa68c3994@tu-ilmenau.de>
Date: Thu, 7 May 2026 14:32:18 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Fix potential out-of-bounds access in
 osdmap_decode()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <20260505090812.500588-1-raphael.zimmer@tu-ilmenau.de>
 <ba35c81180e74517613e3dad41e5f5a938be4137.camel@ibm.com>
 <ce329dd4-54b7-4bbd-ac9c-7ea18488e0e8@tu-ilmenau.de>
 <5e0fa20df4322f6facc80dc6270a59b0361de410.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <5e0fa20df4322f6facc80dc6270a59b0361de410.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.05.26 8:14 PM, Viacheslav Dubeyko wrote:
> On Wed, 2026-05-06 at 15:04 +0200, Raphael Zimmer wrote:
>> On 05.05.26 8:55 PM, Viacheslav Dubeyko wrote:
>>> On Tue, 2026-05-05 at 11:08 +0200, Raphael Zimmer wrote:
>>>> When decoding osd_state and osd_weight from an incoming osdmap in
>>>> osdmap_decode(), both are decoded for each osd, i.e., map->max_osd
>>>> times. The ceph_decode_need() check only accounts for
>>>> sizeof(*map->osd_weight) once. This can potentially result in an
>>>> out-of-bounds memory access if the incoming message is corrupted such
>>>> that the max_osd value exceeds the actual content of the osdmap message.
>>>>
>>>> This patch fixes the issue by changing the corresponding part in the
>>>> ceph_decode_need() check to account for
>>>> map->max_osd*sizeof(*map->osd_weight).
>>>>
>>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>>> ---
>>>>  net/ceph/osdmap.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>>>> index 669348d883f0..2095e73ccf6c 100644
>>>> --- a/net/ceph/osdmap.c
>>>> +++ b/net/ceph/osdmap.c
>>>> @@ -1705,7 +1705,7 @@ static int osdmap_decode(void **p, void *end, bool msgr2,
>>>>  	ceph_decode_need(p, end, 3*sizeof(u32) +
>>>>  			 map->max_osd*(struct_v >= 5 ? sizeof(u32) :
>>>>  						       sizeof(u8)) +
>>>> -				       sizeof(*map->osd_weight), e_inval);
>>>> +			 map->max_osd*sizeof(*map->osd_weight), e_inval);
>>>
>>> It's too complicated computation for one string, from my point of view. I think
>>> we need to introduce a static inline function which will include this
>>> computation. Also, 3*sizeof(u32) looks very bad for my taste. We need to have
>>> some named constant here.
>>>
>>> Thanks,
>>> Slava.
>>>
>>
>> Hi Slava,
>> for what exactly do you want to introduce a static inline function? Just
>> for this computation?
> 
> Yes. Why not? This is computation that has some meaning. And it can be
> represented by function with name that could make the code more clean and
> understandable, from my point of view.
> 
>> The computation inside the call to ceph_decode_need() is done at many
>> places. The 3*sizeof(u32) is a common pattern in the code, although it's
>> not used consistently. Sometimes plain numbers are used. I don't follow
>> how you want to introduce a named constant. It means we need enough
>> buffer space for three 32-bit values. In my opinion, creating a constant
>> for "size of three 32-bit values" wouldn't make it more readable.
> 
> What this 3 means? Why do we use exactly 3 here? Who can understand it? From my
> point of view, it is really bad practice of hardcoding some constant in the
> code. This constant has some meaning and this is why I see the point to express
> this meaning in the named constant. Even if this pattern is used multiple times,
> then it doesn't mean that it's good practice. But, of course, you can be not
> agree with me. :) 
> 
> 
> Thanks,
> Slava.

I try to explain it with more context.
First of all, I haven't written the code or designed these patterns. I
can only share my impression based on looking at the code.
In the libceph code, the common pattern when handling messages is to use
the ceph_decode_{8,16,32,64} functions to decode a value from an
incoming buffer and simultaneously advance the pointer to this buffer.
This function does not include any bounds checks. Therefore, the
ceph_decode_need() macro exists, which can be used to check whether
there is enough space between the current pointer and the end of the
buffer (or relevant part of the buffer) for decoding some values.
Additionally, ceph_decode_{8,16,32,64}_safe() macros exist that already
include these checks. For decoding single values, often these safe
versions are used in the code. If multiple calls to decode happen in a
row, the common pattern is to first call ceph_decode_need() with the sum
of the sizes of all following ceph_decode operations and then simply use
ceph_decode_{8,16,32,64}, so that the bounds check is only performed once.

Now, looking at the check affected by this patch. It performs a bounds
check for all subsequent calls to ceph_decode_{8,16,32,64} that happen
directly inside osdmap_decode() before the next call to a different
function. These are three single ceph_decode_32() calls and two calls
that occur inside a for-loop, which has map->max_osd iterations in both
cases.
This is the meaning of this computation. If we move it into a static
inline function, that would move it further away from the actual
ceph_decode calls, possibly making it even harder to spot such small
mistakes as the one fixed by this patch, in case the control flow is
ever changed again. Furthermore, I can't think of a good name that would
describe this computation here.
The current bug was introduced in this commit: [1], when a pair of
parentheses was removed. I decided not to use these parentheses again,
but add an explicit multiplication with map->max_osd, because I find it
easier to follow and closer to the control flow with two independent
for-loops. The comment above seems to explain the part of the osd_map
that the ceph_decode_need() accounts for. But it appears to be outdated
since the mentioned commit. I could update it in a v2 of this patch and
move the last part to a new comment at the correct position.

Second, the 3*sizeof(u32) originates from the three single calls to
ceph_decode_32(). I don't see any different meaning in it that would
allow using a named constant with an explanatory name for it.
However, as I mentioned, I haven't written the code, and maybe there is
something about it that I missed. In this case, I would need more
information and a suggestion on how we could refactor/rename it.


[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=dcbc919a5dc8c2629684a113a90c0b6fe10c3462

