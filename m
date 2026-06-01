Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6F3388E44
	for <ceph-devel@vger.kernel.org>; Mon,  1 Jun 2026 10:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309326; cv=none; b=cHUDtvINHOoNYtPL2WdsOlGVDKxZvXIap/r90yxrIPhBXBGW53XaTdz+zUHWWKx9a5ErC9yy4CHjAL0mO5Kd51P6A6ZrcFTiBLaXUhcOb+YAyxzYMOyL776F6fYOnX/VtAJHeLvl8QsRGccFzK38eYqFp8pLmO8DJ+EoGaUYYHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309326; c=relaxed/simple;
	bh=RimpklqnoIr7gnrJerin+BEcHo5G7shDf+U2NkHpqGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5wrDCL2AzeFX9yHNcrBjbx7tnknvgjJIlRlcOTp1MPwt0TdmUBqNMBnuvXpYET3wAztb3ynp0i1wbVPvP1Tn+4wchpRxeBpjveKqQOIpzByy3XReCqnQK3FH0SNZVpnGhBDH9VDlTx7J+ezbm1/j6vmbXt1SYzgnNbp44R0qs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=ZYRxUFqL; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="ZYRxUFqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1780309320; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=RimpklqnoIr7gnrJerin+BEcHo5G7shDf+U2NkHpqGI=;
 b=ZYRxUFqLj+kpPJpDWf2GGMxEjwb6jzT1i0hZpABsnSNVo67Q618GLfup7IJHtCOZfIANM
 GExA9CTKzuq2VwYsEiO1Q7TMkkMmSNcFjl8EDcevzpxuGZEo/NPUpkiL8CBlteXi/VXnw0Y
 gD1c8tyIngU3QKtsrNSwigkQUz4sQxGlwZBLxygfnxF+DPqo9dwhLjUT1SU6xsnBDEcYhgE
 WcC+kPauk816aBQPV4pbb17U/WiVzPUmbwrXUTjuLU0hDV18He/X8tWEhrsJ550EQZ8rwXs
 P0+ciof4ShvbV5W6kCHcUmysyJ4jl31fA9PcSkoXcWkmKTIP7K/6f5gd5aYg==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 6A8545FA47;
	Mon,  1 Jun 2026 12:22:00 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 4DA535FB09;
	Mon,  1 Jun 2026 12:22:00 +0200 (CEST)
Message-ID: <f331e0cd-9b09-49db-a17e-f80a3bf64339@tu-ilmenau.de>
Date: Mon, 1 Jun 2026 12:22:00 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] libceph: Fix out-of-bounds writes with oversized
 monitor reply messages
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <20260521121424.2869056-1-raphael.zimmer@tu-ilmenau.de>
 <41e9c36c9a05c8239177cee688cfddcebfd6455f.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <41e9c36c9a05c8239177cee688cfddcebfd6455f.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.05.26 11:58 PM, Viacheslav Dubeyko wrote:
> On Thu, 2026-05-21 at 14:14 +0200, Raphael Zimmer wrote:
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
>> index 66c0d6d6b33d..852ed0cae660 100644
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
>> +		pr_warn_ratelimited("tid %llu front %d > prealloc %d\n",
>> +				    tid, front_len,
>> +				    req->reply->front_alloc_len);
>> +		*skip = 0;
>> +		m = ceph_msg_new(type, front_len, GFP_NOFS, false);
>> +		if (m) {
>> +			ceph_msg_put(req->reply);
>> +			req->reply = m;
>> +			m = ceph_msg_get(req->reply);
>> +		}
>>  	} else if (data_len > req->reply->data_length) {
>>  		pr_warn_ratelimited("mon generic reply tid %llu data %u > preallocated %zu, skipping\n",
>>  				    tid, data_len, req->reply->data_length);
> 
> Looks good.
> 
> Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> 
> Thanks,
> Slava.

Hi,
I noticed a problem with this patch. I based it on the testing branch of
the ceph-client repository, which contains commit 2b79b1b ("libceph,
ceph: reject oversized mon and MDS data segments") that is not yet on
the master branch. This commit adds the lines:
	} else if (data_len > req->reply->data_length) {
		pr_warn_ratelimited("mon generic reply tid %llu data %u > preallocated
%zu, skipping\n",
				    tid, data_len, req->reply->data_length);
		*skip = 1;
		m = NULL;
that check for messages with oversized data segments and discard/skip
them. Due to the use of multiple else if statements, the current patch
shadows this added logic in case where both front_len >
req->reply->front_alloc_len and data_len > req->reply->data_length.
Therefore, this patch needs to be adapted to the other patch by either
reversing the order of these two checks (since skipping the message
makes reallocating a new message with a different front_len obsolete) or
reworking the logic to not use else if statements.
Would one of these options be preferred?

Best regards,
Raphael

