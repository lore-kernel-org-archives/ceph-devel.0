Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9B3D7D82
	for <ceph-devel@vger.kernel.org>; Wed, 20 May 2026 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279496; cv=none; b=QBmh9YhqpApflZGBip7w7Q0JPPJXix6F1ka1HcCDHk7e4XHjUeq3n2xEmBaDzS7sg4p4qqGm08H7QlEnfVVIkASlsfFkjFFzGc4JC36Uwlvsd3I0LvgKndsxVPQwjo7TmIEmESWHaLvl5+QuGM+mBjoPpHn6Y4xrobIixCbh680=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279496; c=relaxed/simple;
	bh=bU5JUzmNhN3J6H9B4XhG7H4CU4VjHJNcaoT5uPlhP9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExZeektmQ0sJpbcORbYA/OSSfOu91QYs3uud6V2BubJi4xrMPG/aXtUTzMss3J2d8RUwebHXHINiUuirJYnkDJl/e7U2Z7c3OeJos/4pA9zT67f+xWxarjUJomA9asvs1AJ1PR2jze5EELQdKEZkgPXjip//jTNYlooAriRJ0IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=taMbuc8n; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="taMbuc8n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779279484; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=bU5JUzmNhN3J6H9B4XhG7H4CU4VjHJNcaoT5uPlhP9k=;
 b=taMbuc8nK0o+xSRBslaZDdrYs3S/LVCY49hE83LLdzGqnHowHxm/pDZAvG7YJ7TUyJ8OS
 sR14Aismvt2U65kGgWTFlI7PcD5A5XO79RVe5rKpRT6rYDvzidWd9KVFKJlL8y56Ecj3r0M
 RKnjD4ABVzHgXslwDEvbaywwvujnl6d2DtPOZOhxBcI/wM1wBcHfKok2Aa6jraX9BCulcLR
 7RMMZFpncqGYtsvXNZefmqo+a5U2kVbtnChnA87ys1AbmDvKGS1ua/R2o/Al+VoE6N+IAMp
 SVrgjqVifZvX1QOnh41/hGGAFyMU68sjpf0cja0ScS6EYcIpbAHDjSLj2faA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 92FBE5FB5C;
	Wed, 20 May 2026 14:18:04 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 08FE95FB24;
	Wed, 20 May 2026 14:18:01 +0200 (CEST)
Message-ID: <c772f70a-97f7-4c71-9351-8973080a37bf@tu-ilmenau.de>
Date: Wed, 20 May 2026 14:18:00 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <20260519111407.2191040-1-raphael.zimmer@tu-ilmenau.de>
 <1c2c36664428fb4066b096041f1cebdb984d0664.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <1c2c36664428fb4066b096041f1cebdb984d0664.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19.05.26 8:58 PM, Viacheslav Dubeyko wrote:
> On Tue, 2026-05-19 at 13:14 +0200, Raphael Zimmer wrote:
>> When processing an incoming reply message of type CEPH_MSG_STATFS_REPLY,
>> CEPH_MSG_MON_COMMAND_ACK, or CEPH_MSG_MON_GET_VERSION_REPLY on the
>> monitor connection, an already allocated reply message for the given
>> transaction ID is used (if existing). Such a message has a preallocated
>> front segment with a fixed length of 64, 512, or 32 bytes, depending on
>> the message type it was allocated for. The actual length to receive into
>> this buffer is read from the message. If this value exceeds the
>> allocation size, data received from the network is written beyond the
>> end of the allocated buffer.
>>
>> This patch fixes the issue by adding a check that compares the needed
>> front segment length to the previously allocated length when retrieving
>> the message buffer. If the needed length exceeds the allocation, a new
>> message buffer with the needed size is allocated to replace the previous
>> one.
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>  net/ceph/mon_client.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
>> index 66c0d6d6b33d..267dfadfbf8e 100644
>> --- a/net/ceph/mon_client.c
>> +++ b/net/ceph/mon_client.c
>> @@ -712,6 +712,8 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
>>  	struct ceph_mon_client *monc = con->private;
>>  	struct ceph_mon_generic_request *req;
>>  	u64 tid = le64_to_cpu(hdr->tid);
>> +	int type = le16_to_cpu(hdr->type);
>> +	int front_len = le32_to_cpu(hdr->front_len);
>>  	u32 data_len = le32_to_cpu(hdr->data_len);
>>  	struct ceph_msg *m;
>>  
>> @@ -721,6 +723,17 @@ static struct ceph_msg *get_generic_reply(struct ceph_connection *con,
>>  		dout("get_generic_reply %lld dne\n", tid);
>>  		*skip = 1;
>>  		m = NULL;
>> +	} else if (front_len > req->reply->front_alloc_len) {
>> +		pr_warn_ratelimited("get_generic_reply %llu front %d > prealloc %d\n",
>> +				    tid, front_len,
>> +				    req->reply->front_alloc_len);
> 
> There is a difference between dout() and pr_warn()/pr_err() outputs. Usually,
> CephFS doesn't show function name for the case of pr_warn()/pr_err() family of
> methods. Even if we would like to make an exception, then __func__ could be much
> cleaner way. Also, it makes sense to mention tid somehow:
> 
> "tid %llu, front %d > prealloc %d\n"
> 
> And I think that dout() could be reworked too:
> 
> dout("%s tid %lld dne\n", __func__, tid);

I didn't know this differentiation. Upon looking at the code, it didn't
appear to be very consistent, at least in the libceph part. I based my
decision on how this is handled in the related functions mon_alloc_msg()
[1] and get_reply() in the osd_client here: [2]. There, the function
name is printed for pr_warn messages. However, I can remove the function
name here. I also thought it would be better to print it with __func__,
but I wanted to keep the function consistent for now and not change
other logging messages. This patch is a bugfix, and I think it should
only fix the problem and not refactor any other code. This draws a clear
separation between bugfix and refactoring work. Reworking the logging
should probably be done in one separate commit that unifies the logging
in the whole file. At least that would be my intention on how to handle it.

> 
> Do you know what dne is? :)
> 

Yes, it stands for does not exist. This is an abbreviation used at
multiple places throughout the code, especially in the osd_client.

>> +		*skip = 0;
>> +		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
>> +		if (m) {
>> +			ceph_msg_put(req->reply);
>> +			req->reply = m;
>> +			m = ceph_msg_get(req->reply);
>> +		}
> 
> If I understood correctly, the purpose of skip argument is:
> 
> msg is not NULL + skip == 0: Normal — receive the message into this buffer
> msg is NULL + skip == 1: Skip — intentionally discard this message (unknown tid,
> oversized data, etc.)
> msg is NULL + skip == 0: OOM — allocation failed, connection error
> 
>  BUG_ON((!con->in_msg) ^ skip); [1]
> 
> So, the initial issue was front_len > req->reply->front_alloc_len. And if we
> cannot reallocate the buffer, then it sounds like we intentionally discard this
> message because not correct length of buffer.
> 
> Does this logic make sense?
> 
> Technically speaking, it is possible to consider this as an allocation failure.
> But the key issue is the incorrect length of buffer.

I don't agree with this. I understand skip the same way. If skip is set,
the message shall be skipped/discarded, e.g., because it was malformed,
unexpected, ...
When looking at this problem here. We got a reply message for which a
reply message buffer was already allocated in advance. When a message is
longer than this buffer, I see two possible ways to handle this:
1) We say this message is malformed because a reply message must never
be larger than the preallocated buffer
2) We say the preallocated buffer is not large enough and we need to
allocate a larger one

In case 1, we should directly set *skip = 1 and return NULL without
making an attempt to allocated new memory. This solution would be
appropriate if it is enforced by design that a valid message of one of
these three types (CEPH_MSG_STATFS_REPLY, CEPH_MSG_MON_COMMAND_ACK, or
CEPH_MSG_MON_GET_VERSION_REPLY) can never be larger than the reply
buffer, and it is always a sign of a malformed message. I'm not sure
about this, since I don't know all the internals about the message types.
In case 2, we treat this message as valid and allocate a new buffer for
it. If this allocation fails, the key issue is no longer the length of
the message, as we decided to consider it as valid. The problem now is a
failed memory allocation. Therefore, we should return NULL + skip == 0.
When looking at the other message types that are handled directly in
mon_alloc_msg(), we see that this second solution is used there, and in
case of an allocation failure, skip = 0 is returned [3]. The same holds
true for the corresponding part in the OSD allocation path here [4].
Therefore, I decided to implement the second solution.

Mixing things up and saying "The message is valid if the front segment
is longer than preallocated, but only as long as the allocation
succeeds. If not, the message was invalid from the beginning and should
be discarded" doesn't sound like a good solution to me. Also, it isn't
consistent behavior, because an allocation failure does not happen
deterministically based on the message length.


I don't really understand your reference to
	BUG_ON((!con->in_msg) ^ skip);
because you didn't explain it any further. At this position in the code,
we have already passed the
	if (ret < 0)
		return ret;
check that would catch any negative return codes from
ceph_con_in_msg_alloc() (including -ENOMEM) and therefore must be in one
of the two "valid" cases. This doesn't really interfere with any of the
mentioned solutions here.

Best regards,
Raphael



[1]
https://elixir.bootlin.com/linux/v7.1-rc4/source/net/ceph/mon_client.c#L1540
[2]
https://elixir.bootlin.com/linux/v7.1-rc4/source/net/ceph/osd_client.c#L5443
[3]
https://elixir.bootlin.com/linux/v7.1-rc4/source/net/ceph/mon_client.c#L1539
[4]
https://elixir.bootlin.com/linux/v7.1-rc4/source/net/ceph/osd_client.c#L5442
