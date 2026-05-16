Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0822C21EE
	for <ceph-devel@vger.kernel.org>; Sat, 16 May 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778921202; cv=none; b=Rgu18KQPSTDl6/WJOCK1XAuLaheR3nO30g59i+PstwF/SpAaHo1wEcEUnJsdCk3wsGtRL4cmsvhdIuS0P+OECVIbtSyO7sJMtwIB/wNUOqcchE0TPRLnsj6iFu5pV2CtqxoHoTLgqw/HXOokXwlIG+Kwk9hLVve53arP2wua6rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778921202; c=relaxed/simple;
	bh=glw8X7XfUSlmwDJLypiXp0fotGNYJTLcZGnL/UfwSpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXTD7UJ/w5sEIjn1GpEc2l60wea1vepn5VRlG7MBr0GvylfdK3G+/uutXMVCon6drdbSAYI9Q253GmdPhwIMEJ/DScOZA/7fvee/l08URScqHfC9e1CCj2afpYYDif41j+5LH9B4JnGBiHHkS42C7wm6bsp5276BNmM2+weSMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=uoUmbyOf; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="uoUmbyOf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1778921189; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=glw8X7XfUSlmwDJLypiXp0fotGNYJTLcZGnL/UfwSpA=;
 b=uoUmbyOfTJAyLpG6t/hqFi+rScU9D5qr1rJPZ8mFrO1b4ZaL2d7I+WKo5eazn64sEgRXS
 R6VeCSrJ1ypj9cKNdWl3CK8ylF0ViJb8TSjbOq5O7j4tbmC+FLwlPEW+9Yk1/JWz7XzYsTm
 r9et18yT+IF1qEPSfGaFwGyaX34t/k2UNF7Y7aCg7Qoo3LTBmrFoawltO9fKZlyT3La1Kel
 /btFdWNHlrXT5F74JnHbFNT2KVraw3bXVwiITPj+4ZF3B81ZV2Wsgfjcxar3uw67gmvrtvK
 x4Z95oUKjyJawnnY/hD6I6BqI59xuuFxmPx3N/uZubj3BskOoez/daf7vptQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id A5F745FC0D;
	Sat, 16 May 2026 10:46:29 +0200 (CEST)
Received: from [192.168.178.114] (unknown [217.252.212.162])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 78E715FC51;
	Sat, 16 May 2026 10:46:26 +0200 (CEST)
Message-ID: <94daa02f-2f37-4462-94f1-518da132e063@tu-ilmenau.de>
Date: Sat, 16 May 2026 10:46:25 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "idryomov@gmail.com" <idryomov@gmail.com>, Alex Markuze
 <amarkuze@redhat.com>, "slava@dubeyko.com" <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
References: <20260515081132.1570541-1-raphael.zimmer@tu-ilmenau.de>
 <9011b6c7ed764ef48b4bf7a10d16957e8135e18a.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
In-Reply-To: <9011b6c7ed764ef48b4bf7a10d16957e8135e18a.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/26 9:05 PM, Viacheslav Dubeyko wrote:
> On Fri, 2026-05-15 at 10:11 +0200, Raphael Zimmer wrote:
>> A message of type CEPH_MSG_OSD_MAP holds an OSD map, which typically
>> contains a pg_upmap part at its end. When decoding this part in
>> __decode_pg_upmap_items(), a len value is decoded from the message to
>> determine the number of items and the size of the allocation needed for
>> them. If the len value is greater than or equal to 2^31, an overflow
> 
> This phrase still sounds confusing. :) Because len is u32.

Let's merge the discussion of both email threads here.

I don't mean the calculation of "2 * len * sizeof(u32)". I'm 
specifically talking about the variable "len", as stated in the commit 
message. The problem arises when len >= 2^31. len is of type u32. That 
means, it can hold values from 0 to 2^32-1. 2 * len can lead to a 
multiplication overflow when len >= 2^31, because 2 * 2^31 = 2^32 -> 0 
when calculated in u32. Because of the left-to-right order of 
evaluation, this is calculated first and in the next step 0 * 
sizeof(u32). The first step will be calculated in 32 bit, and only the 
second one in the width of a size_t on the respective system. As I 
mentioned in the report, there are several ways to address this issue.

> 
>> occurs in the multiplication that is performed to determine the needed
>> size of the incoming buffer to decode, as well as for the length of the
>> allocation for the ceph_pg_mapping struct. Subsequently, this results in
>> out-of-bounds writes (and reads) when decoding the incoming message
>> fields into the ceph_pg_mapping struct.
>>
>> This patch fixes the issue by adding a UL suffix to the literal in the
>> multiplication to perform it as an unsigned long multiplication.
>> Furthermore, the result is stored in a local variable to only perform
>> the multiplication once.
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>   net/ceph/osdmap.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 8b5b0587a0cf..d416a11ce0ca 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -1615,13 +1615,15 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
>>   {
>>   	struct ceph_pg_mapping *pg;
>>   	u32 len, i;
> 
> What about size_t len, i; declaration?
> 
> How do you feel about this?

I'm not really convinced by this. len is decoded from a 32-bit message 
field with ceph_decode_32_safe(). This is meant to decode a 32-bit value 
into a 32-bit variable. I don't think that changing this would be the 
best idea, as it introduces another implicit conversion, and the reason 
will probably not be obvious later.

> 
> const size_t item_size = 2UL * sizeof(u32);
> 

This looks good to me. The UL suffix is not needed, as the calculation 
is performed in a size_t anyway (and also has a fixed result much 
smaller than 2^32). Furthermore, this would already solve the problem 
later, because item_size * len will also be evaluated in a size_t.

>> +	size_t payload_len;
>>   
>>   	ceph_decode_32_safe(p, end, len, e_inval);
>>   	if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
> 
> if (len > (SIZE_MAX - sizeof(*pg)) / item_size)
> 
>>   		return ERR_PTR(-EINVAL);
>>   
>> -	ceph_decode_need(p, end, 2 * len * sizeof(u32), e_inval);
>> -	pg = alloc_pg_mapping(2 * len * sizeof(u32));
>> +	payload_len = 2UL * len * sizeof(u32);
> 
> payload_len = item_size * len;
> 
> So, size_t can keep 2^64 -1 on 64-bit system but it can keep only 2^32 - 1 on
> 32-bit systems. So, potentially, this calculation 2UL * len * sizeof(u32) can go
> out of available representation. However, alloc_pg_mapping() expect size_t as
> argument. As far as I can see, this calculation could be still problematic on
> 32-bit system. Am I right here?
> 
> Thanks,
> Slava.
> 

For 32-bit systems, there is the
     if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
check. It accounts not only for this calculation, but also for the 
additional sizeof(*pg) that will be added in alloc_pg_mapping(). On 
64-bit systems, this condition will always be false, because "(SIZE_MAX 
- sizeof(*pg)) / (2 * sizeof(u32)" is far greater than 2^32 there. On 
32-bit systems, there isn't any chance for len to be greater than or 
equal to 2^31 after passing this check.

In conclusion, I would prefer to keep len, i as u32, and therefore stay with
     if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / item_size)
and add
     const size_t item_size = 2 * sizeof(u32);

Best regards,
Raphael

>> +	ceph_decode_need(p, end, payload_len, e_inval);
>> +	pg = alloc_pg_mapping(payload_len);
>>   	if (!pg)
>>   		return ERR_PTR(-ENOMEM);
>>   

