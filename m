Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468B22D7A1
	for <ceph-devel@vger.kernel.org>; Mon, 18 May 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093246; cv=none; b=X9hWMSQK25rYbYwvQMoAEPAQ5wEAkvvbJx7DWgDGsEve0RT3kBXXXoa6A9gDjtxO/GgMnV79c/0PYwCdhabxzSAkDRcqmtdYb/B8czKKe7Twbdn0CPzhbfKI7+78/Uju4MfAUqSKGpga+aKxt/XWDUu2rwanFYJbn5WBR8MCXZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093246; c=relaxed/simple;
	bh=i6MXaCoGKGf9RqlXjBODqnNkAUWaVCyuavvHC2RNxCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ApiuCwlxKpRH4TAi5K4HzTsmdHIFAn+b1xIHHggoMVWB8K89rVtfHKAb3CnhPLurpppJbHULNCHlGT1YajEV9zrDtDPLSy5Ot0M8FlQsJdwEzEneB0dfbcMmKjCpco2eKrieCiQSd213y9EC7VtEe2v9mn03h5UpU8i/q0WgDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=T4mVeh1g; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="T4mVeh1g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779093235; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=i6MXaCoGKGf9RqlXjBODqnNkAUWaVCyuavvHC2RNxCw=;
 b=T4mVeh1gg0r+Eu9PKJolSzBHWU0mCahfqNbi/AB2S7ql8pbaBW07Ov/hOT2lntWEivNpF
 PzSwEDJc7vkhYKGbrjwPvi32O4ZlrGX4ZtDb+Us/gAZ2yIK7wodF153wdamOMD+cJeJY7O5
 vpgiA1y0lVTmk8WV+zO0aUTe+s/CLiVdBZvBY4mqNJe0JVSIQpQVMqght7NFAg5rwM2w2hm
 wn0Wmh7xGsj9QkMbujFv4BioABzPAjhAKx3fZaJnhte569w65K9NCbyWpjAdYQ2iM5y1Ffv
 Z+HR+KfPP738ukls0mXw/HxufJDgBD0xeGuHO7i96CAs/PUvrHkGJJbMfR1w==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 2A27A5FB7B;
	Mon, 18 May 2026 10:33:54 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 058B95FB64;
	Mon, 18 May 2026 10:33:52 +0200 (CEST)
Message-ID: <1aeaa00c-d83f-4788-a5f6-5dfe1c1b70f7@tu-ilmenau.de>
Date: Mon, 18 May 2026 10:33:52 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Fix out-of-bounds writes with oversized monitor
 reply messages
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>, Alex Markuze <amarkuze@redhat.com>
Cc: "security@kernel.org" <security@kernel.org>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <3f154565-9f37-40aa-b34a-be6f5c2b4463@tu-ilmenau.de>
 <20260515133129.1595265-1-raphael.zimmer@tu-ilmenau.de>
 <f919b66a7cc03dfd22231b87353ebeaf864e3d0a.camel@dubeyko.com>
 <acc9afe112e83e42a5c1d3a1560bed2cd3554900.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <acc9afe112e83e42a5c1d3a1560bed2cd3554900.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15.05.26 9:22 PM, Viacheslav Dubeyko wrote:
> On Fri, 2026-05-15 at 09:49 -0700, Viacheslav Dubeyko wrote:
>> cc: ceph-devel@vger.kernel.org
>>
>> On Fri, 2026-05-15 at 15:31 +0200, Raphael Zimmer wrote:
>>> When processing an incoming reply message of type
>>> CEPH_MSG_STATFS_REPLY,
>>> CEPH_MSG_MON_COMMAND_ACK, or CEPH_MSG_MON_GET_VERSION_REPLY on the
>>> monitor connection, an already allocated reply message for the given
>>> transaction ID is used (if existing). Such a message has a
>>> preallocated
>>> front segment with a fixed length of 64, 512, or 32 bytes, depending
>>> on
>>> the message type it was allocated for. The actual length to receive
>>> into
>>> this buffer is read from the message. If this value exceeds the
>>> allocation size, data received from the network is written beyond the
>>> end of the allocated buffer.
>>>
>>> This patch fixes the issue by adding a check that compares the needed
>>> front segment length to the previously allocated length when
>>> retrieving
>>> the message buffer. If the needed length exceeds the allocation, a
>>> new
>>> message buffer with the needed size is allocated to replace the
>>> previous
>>> one.
>>>
>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>> ---
>>>  net/ceph/mon_client.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>>> index 66c0d6d6b33d..b84dd2bfe77b 100644
>>> --- a/net/ceph/mon_client.c
>>> +++ b/net/ceph/mon_client.c
>>> @@ -712,6 +712,8 @@ static struct ceph_msg *get_generic_reply(struct
>>> ceph_connection *con,
>>>  	struct ceph_mon_client *monc = con->private;
>>>  	struct ceph_mon_generic_request *req;
>>>  	u64 tid = le64_to_cpu(hdr->tid);
>>> +	int type = le16_to_cpu(hdr->type);
>>> +	int front_len = le32_to_cpu(hdr->front_len);
>>>  	u32 data_len = le32_to_cpu(hdr->data_len);
>>>  	struct ceph_msg *m;
>>>  
>>> @@ -721,6 +723,15 @@ static struct ceph_msg *get_generic_reply(struct
>>> ceph_connection *con,
>>>  		dout("get_generic_reply %lld dne\n", tid);
>>>  		*skip = 1;
>>>  		m = NULL;
>>> +	} else if (front_len > req->reply->front_alloc_len) {
>>> +		pr_warn_ratelimited("get_generic_reply %llu front %d
>>>> prealloc %d\n",
>>> +				    tid, front_len,
>>> +				    req->reply->front_alloc_len);
>>> +		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
>>> +		if (m) {
>>> +			ceph_msg_put(req->reply);
>>> +			req->reply = m;
>>> +		}
>>>  	} else if (data_len > req->reply->data_length) {
>>>  		pr_warn_ratelimited("mon generic reply tid %llu data
>>> %u > preallocated %zu, skipping\n",
>>>  				    tid, data_len, req->reply-
>>>> data_length);
> 
> If I am not wrong we have a wrong refcount on the new buffer issue here. What
> about something like this?
> 

Hi Slava,
you're right, the call to ceph_msg_get() is missing.

>   } else if (front_len > req->reply->front_alloc_len) {
>       pr_warn_ratelimited("tid %llu: front %d > preallocated %d\n",
>                           tid, front_len,
>                           req->reply->front_alloc_len);
>       m = ceph_msg_new(type, front_len, GFP_NOFS, false);
>       if (!m) {
>           *skip = 1;
>           goto out;
>       }

*skip shouldn't be set to 1 here, because this results in skipping the
message instead of returning an error for the failed memory allocation.
Instead, the null message pointer should be returned with *skip = 0.
This results in returning -ENOMEM from ceph_con_in_msg_alloc(). This is
also stated in the comment in ceph_con_in_msg_alloc():
"Null message pointer means either we should skip this message, or we
couldn't allocate memory.  The former is not an error."

Would you agree to leaving the control flow as is, without adding the
"out" label and simply adding the
	m = ceph_msg_get(req->reply);
to the m != NULL case?
Also, I can add an explicit
	*skip = 0;
This wouldn't be necessary for correct behavior, because *skip is
already 0 when passed to the function, but since there is no actual
guarantee inside this function, it may be better to have it.

Best regards,
Raphael

>       ceph_msg_put(req->reply);
>       req->reply = m;
>       *skip = 0;
>       m = ceph_msg_get(req->reply);
>   } else if (data_len > req->reply->data_length) {
> 
> Thanks,
> Slava.
