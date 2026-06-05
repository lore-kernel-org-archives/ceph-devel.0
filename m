Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034273D9DA9
	for <ceph-devel@vger.kernel.org>; Fri,  5 Jun 2026 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646591; cv=none; b=G+/la6q9+GBbR5ZsLs6r3414zpQlok/icocL7Ve82vAg5sOcHnbqwPrPtWKDHYsynEsOzCEhzMpABvrk/2jj1QY09waNIpmjInFoKlKps3Ecv6T6CvpDqeAWjq+CJjJyUf7e0DJp4wEMTh0jrt6EYtHezkh7CgFREFfdDE91TLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646591; c=relaxed/simple;
	bh=Afx3LVzQJKpVONohgZXCtJH9l2+LxGwg6nho6LdnYlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0MLdQ/AD8saK+0qSUiX8ziA8olgW5MAuA0VujjGaQZN1g36usAazO/nsVpqRGPLiNdL3qVh66nJbyZaGKx1ekMkxEwJ3cV5dAhsWEnmT0ya681E27BDt+52MQ0R8IC+PyHNPN5l79BlSRGAtCMC4ofIZO7MZO6jXBSPcjimQ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=Sk3aURIN; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="Sk3aURIN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780646585; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=Afx3LVzQJKpVONohgZXCtJH9l2+LxGwg6nho6LdnYlE=;
 b=Sk3aURINwuxBmPjGfOh0gunMsTx5qGqwOm1BgeLXRBSeu4/hqBhhRYbeVQxZ7p95iSg9/
 yXjn/zOz6UlJUZaW5toqgzjaaxuSG4kbftH+Nc151ZDZadl8fPlwN/DHFKkt5Fsd1zEHCXB
 i+DzVPRh02XYC4rnEPgWvTKJl+fhYAfyjihHWK9/WKUKuD0OxbaseIuZpY9iDguT8GAk/f7
 qLLmLELKIOvldoSR5ZNhyG9eyJyH9vCZkJ22Z6MSK8PjW6bXaYe0tUsCseqNgtleR5O3XfI
 PpXyat6ArOuEf2L0rUdcL0Oz0RTiE4AMVVBp4x7Bkbu/+EkMAJA3mPHrM+Lg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 82DB95FD4A;
	Fri,  5 Jun 2026 10:03:05 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3ADE75FB21;
	Fri,  5 Jun 2026 10:03:04 +0200 (CEST)
Message-ID: <c059088f-93fc-4473-80eb-098de0a0bf03@tu-ilmenau.de>
Date: Fri, 5 Jun 2026 10:03:04 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
To: Viacheslav Dubeyko <slava@dubeyko.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
References: <20260602151025.4145216-1-raphael.zimmer@tu-ilmenau.de>
 <0d6480e8c6c64dd13d45781bccdb097d8025438f.camel@dubeyko.com>
 <9dbe4363-85cc-47da-bc16-abe6dd8d7d07@tu-ilmenau.de>
 <7973116eb155a81f8e886028318904c3ce5b7524.camel@dubeyko.com>
 <a2022028-8290-45ee-b7a3-312fc56010ee@tu-ilmenau.de>
 <03a15ae6cdeba53b1a27000d71415fc7fd949576.camel@dubeyko.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <03a15ae6cdeba53b1a27000d71415fc7fd949576.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04.06.26 9:46 PM, Viacheslav Dubeyko wrote:
> On Thu, 2026-06-04 at 18:03 +0200, Raphael Zimmer wrote:
>> On 03.06.26 7:16 PM, Viacheslav Dubeyko wrote:
>>> On Wed, 2026-06-03 at 10:57 +0200, Raphael Zimmer wrote:
>>>> On 02.06.26 7:15 PM, Viacheslav Dubeyko wrote:
>>>>> On Tue, 2026-06-02 at 17:10 +0200, Raphael Zimmer wrote:
>>>>>> When processing an incoming reply message of type
>>>>>> CEPH_MSG_STATFS_REPLY,
>>>>>> CEPH_MSG_MON_COMMAND_ACK, or CEPH_MSG_MON_GET_VERSION_REPLY
>>>>>> on
>>>>>> the
>>>>>> monitor connection, an already allocated reply message for
>>>>>> the
>>>>>> given
>>>>>> transaction ID is used (if existing). Such a message has a
>>>>>> preallocated
>>>>>> front segment with a fixed length of 64, 512, or 32 bytes,
>>>>>> depending
>>>>>> on
>>>>>> the message type it was allocated for. The actual length to
>>>>>> receive
>>>>>> into
>>>>>> this buffer is read from the message. If this value exceeds
>>>>>> the
>>>>>> allocation size, data received from the network is written
>>>>>> beyond
>>>>>> the
>>>>>> end of the allocated buffer.
>>>>>>
>>>>>> This patch fixes the issue by adding a check that compares
>>>>>> the
>>>>>> needed
>>>>>> front segment length to the previously allocated length when
>>>>>> retrieving
>>>>>> the message buffer. If the needed length exceeds the
>>>>>> allocation,
>>>>>> a
>>>>>> new
>>>>>> message buffer with the needed size is allocated to replace
>>>>>> the
>>>>>> previous
>>>>>> one.
>>>>>>
>>>>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>>>>
>>>>> What's about Fixes here?
>>>>>
>>>>>> ---
>>>>>>  net/ceph/mon_client.c | 24 ++++++++++++++++++++++--
>>>>>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>>>>>> index 66c0d6d6b33d..b33ae17546f8 100644
>>>>>> --- a/net/ceph/mon_client.c
>>>>>> +++ b/net/ceph/mon_client.c
>>>>>> @@ -712,6 +712,8 @@ static struct ceph_msg
>>>>>> *get_generic_reply(struct
>>>>>> ceph_connection *con,
>>>>>>  	struct ceph_mon_client *monc = con->private;
>>>>>>  	struct ceph_mon_generic_request *req;
>>>>>>  	u64 tid = le64_to_cpu(hdr->tid);
>>>>>> +	int type = le16_to_cpu(hdr->type);
>>>>>> +	int front_len = le32_to_cpu(hdr->front_len);
>>>>>>  	u32 data_len = le32_to_cpu(hdr->data_len);
>>>>>>  	struct ceph_msg *m;
>>>>>>  
>>>>>> @@ -721,14 +723,30 @@ static struct ceph_msg
>>>>>> *get_generic_reply(struct ceph_connection *con,
>>>>>>  		dout("get_generic_reply %lld dne\n", tid);
>>>>>>  		*skip = 1;
>>>>>>  		m = NULL;
>>>>>> -	} else if (data_len > req->reply->data_length) {
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (data_len > req->reply->data_length) {
>>>>>>  		pr_warn_ratelimited("mon generic reply tid
>>>>>> %llu
>>>>>> data
>>>>>> %u > preallocated %zu, skipping\n",
>>>>>>  				    tid, data_len, req-
>>>>>>> reply-
>>>>>>> data_length);
>>>>>>  		*skip = 1;
>>>>>>  		m = NULL;
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>> +	*skip = 0;
>>>>>> +	if (front_len > req->reply->front_alloc_len) {
>>>>>> +		pr_warn_ratelimited("tid %llu front %d >
>>>>>> prealloc
>>>>>> %d\n",
>>>>>> +				    tid, front_len,
>>>>>> +				    req->reply-
>>>>>>> front_alloc_len);
>>>>>> +		m = ceph_msg_new(type, front_len, GFP_NOFS,
>>>>>> false);
>>>>>
>>>>> Does false is correct here? If we provide can_fail == false,
>>>>> then
>>>>> allocation failure results it:
>>>>>
>>>>> 	if (!can_fail) {
>>>>> 		pr_err("msg_new can't create type %d front
>>>>> %d\n",
>>>>> type,
>>>>> 		       front_len);
>>>>> 		WARN_ON(1);
>>>>> 	} else {
>>>>> 		dout("msg_new can't create type %d front
>>>>> %d\n",
>>>>> type,
>>>>> 		     front_len);
>>>>> 	}
>>>>> 	return NULL;
>>>>>
>>>>> The can_fail = true would suppress the WARN, matching the
>>>>> intent of
>>>>> a
>>>>> graceful degradation path.
>>>>>
>>>>
>>>> I chose this to be consistent with the handling of reply messages
>>>> on
>>>> OSD
>>>> connections [1] as well as the handling of other messages in
>>>> mon_alloc_msg() [2]. I'm not sure about the graceful degradation
>>>> path.
>>>> If this allocation fails, it's an unexpected out-of-memory error.
>>>> However, it's no functional difference and only affects the
>>>> logging/WARN_ON(). So both options would be fine with me. If you
>>>> think
>>>> it's not a problem to not be completely consistent with other
>>>> similar
>>>> code paths, I can change it to can_fail == true.
>>>
>>> I already lost myself in all possible combinations of various
>>> arguments. :) You set *skip = 0 and if it means that we would like
>>> not
>>> see BUG_ON(), then we need to set can_fail = true. Otherwise,
>>> can_fail
>>> can have false value.
>>>
>>> Thanks,
>>> Slava.
>>
>> I'm sorry, but I don't really understand what you mean by "we would
>> like
>> not see BUG_ON()". I don't see that setting *skip = 0 in this
>> specific
>> case is related to a BUG_ON(). Can you please explain once more what
>> exactly you mean by this?
>>
> 
> My point was simple. If *skip == 0 means that we could have the
> BUG_ON() triggered, then can_fail == false is OK.
> 
> Thanks,
> Slava.

OK, if you are talking about the possibility that returning m == NULL
and *skip == 0 triggers a BUG_ON() anywhere in the calling path: I don't
see this possibility. We will ultimately return -ENOMEM to
ceph_con_workfn() and treat it as connection fault. Therefore, I will
change can_fail to true.

Best regards,
Raphael

