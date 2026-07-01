Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50F833120E
	for <ceph-devel@vger.kernel.org>; Wed,  1 Jul 2026 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782919729; cv=none; b=U+RUY4gBAqf37lvwTI+ZCj4FdGXZJGV3IWnecYYy8cvbfEJW49G1+2oLcBGNApJ0kv6ON6tzNHm4Ql2sEfBC7KM3B1+sZTXb6Alr3OsBvzW1EL1fX26YNf0FhBngcs0RBjOLl/QPtm31p6az5AsJ7yD94ReFsraPVFxNcQa3ZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782919729; c=relaxed/simple;
	bh=SMSAMs56Xob43KZBXWu0n32gONrscv22fvBvgMMRt2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrPlXhrZro5wLa8YxCRf0NG0JuHnB+EhOpEQp+CIPD/z3I6C3QgRhjNPOFtECQRfZw/fMXHIw6XdNaWZQcAKITN52BPJxgBdUVs4IsPeZKlLgLjFfjSj0SdVhaimO6ivOXx3i4gZp0E+cyub0Onqp8YeDYw7JHGEvjWHFLK2lEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=FNek0tKF; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="FNek0tKF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1782919724; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=SMSAMs56Xob43KZBXWu0n32gONrscv22fvBvgMMRt2Y=;
 b=FNek0tKFU7LHmyHm5NH9quBsip3NSosvFtRASj45dwiZNiSEi8A35AHrIUTT+QRe6hgkv
 junTvXgiejEbiJ5cTlsTkGamif0HgijdgOz0PIrHgObDUL6PLroObALlrZ1KgvtxeiRF0fW
 IbiDmya/ZiqQhtrg5ky7asEaj3GTBxEibFuV/9G7S4VBlkyxG4TjjYtM1Wso54wb7XKcXPR
 za9Bx0ijIFDptHig6nguaNQYFz1jLwAFoVGn94feLlsoBBCaJ2pTHL7VHd43gltFu8wX7IN
 n9a0+SVhR1EPCfGwvCt+nbrz+/RHO/fOXmoRfpyHG7MeLWCAJHl8k5DuCB0A==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 24CD55FA18;
	Wed,  1 Jul 2026 17:28:44 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id EB74E5FB29;
	Wed,  1 Jul 2026 17:28:43 +0200 (CEST)
Message-ID: <fcc3000e-66d5-4f28-b8df-9376a0c17986@tu-ilmenau.de>
Date: Wed, 1 Jul 2026 17:28:43 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Assign requests to homeless osd if calculated
 osd exceeds max_osd
To: Viacheslav Dubeyko <slava@dubeyko.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
References: <2e10a5e1-14cc-4f8f-9ef5-76a7f7c0fa9e@tu-ilmenau.de>
 <20260629084231.2892980-1-raphael.zimmer@tu-ilmenau.de>
 <3e59de30e28f37adc0f8db40357134abf2cc8572.camel@dubeyko.com>
 <03eb59cfbc8ccc7e1641b63ab2573b39f36a9e81.camel@dubeyko.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <03eb59cfbc8ccc7e1641b63ab2573b39f36a9e81.camel@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 29.06.26 7:30 PM, Viacheslav Dubeyko wrote:
> On Mon, 2026-06-29 at 09:46 -0700, Viacheslav Dubeyko wrote:
>> CC: ceph-devel@vger.kernel.org
>>
>> On Mon, 2026-06-29 at 10:42 +0200, Raphael Zimmer wrote:
>>> A corrupted osdmap received from a Ceph monitor or OSD may contain
>>> placement groups with osd indices greater than max_osd.
>>> Subsequently,
>>> this may lead to calc_target() returning such an index as target
>>> osd
>>> for
>>> a (linger) request. Because the osd_state, osd_weight, and osd_addr
>>> arrays only contain max_osd entries, this leads to out-of-bounds
>>> accesses when trying to read values from these arrays.
>>>
>>> This patch fixes the issue by adding a check to calc_target()
>>> assigning
>>> the request to the homeless osd if the target osd index read from
>>> the
>>> osdmap exceeds the maximum index of an osd.
>>>
>>> Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target,
>>> calc_target()")
>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>> ---
>>>  net/ceph/osd_client.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>>> index a4d3cbfd27a3..3ae7c51e2edc 100644
>>> --- a/net/ceph/osd_client.c
>>> +++ b/net/ceph/osd_client.c
>>> @@ -1707,6 +1707,12 @@ static enum calc_target_result
>>> calc_target(struct ceph_osd_client *osdc,
>>>  		}
>>>  	}
>>>  
>>> +	if (t->osd >= osdc->osdmap->max_osd) {
> 
> The t->osd is int, osdc->osdmap->max_osd is u32. In C, the signed
> operand is promoted to unsigned in a mixed comparison. If t->osd ==
> CEPH_HOMELESS_OSD == -1, the comparison becomes (u32)-1 >= max_osd. The
> check fires on every homeless request. I think we need to be more
> careful in this comparison:
> 
> if (t->osd >= 0 && (u32)t->osd >= osdc->osdmap->max_osd)
> 

You're right, I missed this point. I will fix it.

>>> +		t->osd = CEPH_HOMELESS_OSD;
>>> +		ct_res = CALC_TARGET_NO_ACTION;
> 
> I am not completely sure that CALC_TARGET_NO_ACTION is correct setting.
> We set req->r_t.osd == CEPH_HOMELESS_OSD while req->r_osd still points
> to the old OSD. I assume that request will be sent to the wrong OSD and
> it will never retried via the homeless path. The calc_target() has
> multiple callers. Should we set ct_res to CALC_TARGET_NEED_RESEND?

I also wasn't sure which option would be the best for ct_res in this
specific case of a corrupted osdmap. It sounds reasonable to me to
switch to CALC_TARGET_NEED_RESEND.

I will send a new version of the patch with these modifications.

Best regards,
Raphael

> 
> Thanks,
> Slava.
> 
>>> +		goto out;
>>> +	}
>>> +
>>>  	if (unpaused || legacy_change || force_resend || split)
>>>  		ct_res = CALC_TARGET_NEED_RESEND;
>>>  	else

