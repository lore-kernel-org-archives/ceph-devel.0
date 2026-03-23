Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8F232AADC
	for <ceph-devel@vger.kernel.org>; Mon, 23 Mar 2026 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265990; cv=none; b=Xytn8fJYT0bpJeI+H6nPt2B78pVE2C60LwQhb/Ctw8cz/o2mdcCZcCaK1PuwrMajqSo4q93tCjbxRvg5aT6aQ6sq86AFDf3M7P1mk58B8Tw3ieR7oY+H52EMw6dlWwJoUlsle0AJFnk8G7hk2I9RHN2T/QdP7DUKKek2Im6Axrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265990; c=relaxed/simple;
	bh=gXPAK0w3fkAnCg7P7XbFEam3tZO0iQR32OHMlEW/D0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdsxMhdO7u7HHhkdhdmn85jUhsu/cOl+yd63Ku7FRNhbdTuiH3E4I7hLTHNesMeM1HQGrvPY8euIH69kMJoV5bTP/RsJsEwVG8xaicJja5QNZ8bJ1BsPYZQLvx1YBrkvNJonS1G/FZtJAErc2TbUJueXEG4ETY5Qb/Ls2UvDTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=YowpWyHo; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="YowpWyHo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1774265980; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=gXPAK0w3fkAnCg7P7XbFEam3tZO0iQR32OHMlEW/D0A=;
 b=YowpWyHoIHPlZeEC1VKP+MKsb2gxIuUVOQHSSp00/sBBbOfWPgku9tnoTpB0uAFPu9meA
 G/u/TQnvhSM75bkfBvep/cULiWVHXtw3g8RzWJoeh1FxENiWUb4K1GB0W30QCXO4Qs9Yq2n
 GmjoIFpNZjQ4wGv+o6hl7QLFx0nrw8D3JooYtFbWxNMB9K3Ak0X5fbhDYm1dAwHgFgIx6BB
 BSAzOcTIGOQ4EVC1Ly9p+or2NVzjxUrlc/Qi1wLgsjaCGDFBoE1M/bKOHy8k58eWCTnbflk
 GOPmJOsmKRKfCorGTkBzhvX/s10f0D/vgcwPsV0tGISHRVxr6E7DJllF+yXw==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 426E95FE5B;
	Mon, 23 Mar 2026 12:39:40 +0100 (CET)
Received: from [192.168.178.114] (unknown [217.252.212.162])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id D2C225FC91;
	Mon, 23 Mar 2026 12:39:37 +0100 (CET)
Message-ID: <395ea4e1-f83c-472a-b336-fba24368e5ce@tu-ilmenau.de>
Date: Mon, 23 Mar 2026 12:39:37 +0100
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
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <0959410fbce95fb8f5ac25de6c751421834ae923.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/26 7:28 PM, Viacheslav Dubeyko wrote:
> cc: ceph-devel@vger.kernel.org
> 
> On Fri, 2026-03-20 at 10:41 +0100, Raphael Zimmer wrote:
>> If a (potentially corrupted) message of type CEPH_MSG_AUTH_REPLY
>> contains a positive value in its result field, it is treated as an
>> error code by ceph_handle_auth_reply() and returned to
>> handle_auth_reply(). Thereafter, an attempt is made to send the
>> preallocated message of type CEPH_MSG_AUTH, where the returned value is
>> interpreted as the size of the front segment to send. If the result
>> value in the message is greater than the size of the memory buffer
>> allocated for the front segment, an out-of-bounds access occurs, and
>> the content of the memory region beyond this buffer is sent out.
>>
>> This patch fixes the issue by first adding a check that catches a
>> positive value in the result field of the message and treats it as
>> invalid, and second comparing the len parameter of
>> __send_prepared_auth_request to front_alloc_len to prevent sending the
>> message if it exceeds the bounds of the allocation.
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>   net/ceph/auth.c       | 5 +++++
>>   net/ceph/mon_client.c | 5 +++++
>>   2 files changed, 10 insertions(+)
>>
>> diff --git a/net/ceph/auth.c b/net/ceph/auth.c
>> index 3314705e5914..555b1fab4623 100644
>> --- a/net/ceph/auth.c
>> +++ b/net/ceph/auth.c
>> @@ -215,6 +215,11 @@ int ceph_handle_auth_reply(struct ceph_auth_client *ac,
>>   	ceph_decode_need(&p, end, sizeof(u32) * 3 + sizeof(u64), bad);
>>   	protocol = ceph_decode_32(&p);
>>   	result = ceph_decode_32(&p);
>> +	if (result > 0) {
> 
> Frankly speaking, it's hard to follow how this is correct without protocol
> knowledge. Do we have any declarations of result possible values? Probably, we
> need to have some comment that explain the situation in more details here?
> 

Yes, it would be good to have an exact protocol specification. From what 
I can see in the code, the result value is either 0 for success or a 
negative Linux error code. Therefore, a positive value here would always 
indicate a malformed message. But maybe you know more?

>> +		pr_err("unexpected result code in auth msg\n");
>> +		ret = -EINVAL;
>> +		goto out;
> 
> Maybe, do you need jump to bad?
> 

No, Ilya recently mentioned that this is intended for classic decoding 
errors. Here, a more specific error message should be emitted.

>> +	}
>>   	global_id = ceph_decode_64(&p);
>>   	payload_len = ceph_decode_32(&p);
>>   	ceph_decode_need(&p, end, payload_len, bad);
>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>> index d5080530ce0c..7206db5f7695 100644
>> --- a/net/ceph/mon_client.c
>> +++ b/net/ceph/mon_client.c
>> @@ -174,6 +174,11 @@ int ceph_monmap_contains(struct ceph_monmap *m, struct ceph_entity_addr *addr)
>>    */
>>   static void __send_prepared_auth_request(struct ceph_mon_client *monc, int len)
>>   {
>> +	if (len > monc->m_auth->front_alloc_len) {
>> +		pr_err("sending auth request failed, because len: %d exceeds allocation size: %d\n",
>> +			len, monc->m_auth->front_alloc_len);
> 
> Is it proper place for this check? It looks like we fail to send something and
> execution flow has no idea that we failed. Yes, system log will receive the
> error message but the rest of the logic will continue business as usual. Maybe,
> you are right but is it not to late to simply complain here?
> 
> And if we don't send the request, then could it affect the whole functionality?
> Could we introduce a race condition or deadlock here?
> 
> Thanks,
> Slava.
> 

This check should never be true. It is just a common place where a 
severe data leakage can be prevented if anything went wrong before, 
because m_auth->front.iov_len is modified there. This would prevent 
another bug like this if the logic before was flawed. To fix the current 
vulnerability, it is not absolutely necessary to have this.

Maybe an assertion like a BUG_ON is also fine here. Otherwise, the 
handling of this function would most likely have to be changed at 
multiple places.

>> +		return;
>> +	}
>>   	monc->pending_auth = 1;
>>   	monc->m_auth->front.iov_len = len;
>>   	monc->m_auth->hdr.front_len = cpu_to_le32(len);
> 
> 
> 

