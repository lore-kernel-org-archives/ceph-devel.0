Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C12369D78
	for <ceph-devel@vger.kernel.org>; Tue, 19 May 2026 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188408; cv=none; b=BnbSMuoFSshS8Mtw86Z8Jy3Hp/HbfoaP59tCllKMjx3Ej2naO3kae4K/KwGiPuMkSyI1Z+4dy33mtMpAfRQZGHLzWBUeD9E9Y+HTQ0p5mtDqor8fUHKC0ZVa0Nvl+92zZtBQ00gLjwIJyCqVx2zY5yHxNdbLzVYuVpLlVxwYhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188408; c=relaxed/simple;
	bh=tWSnATgy6TmNShp32+UgunQgo08aVNfM1W5+7AMYU/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNfyGus8xLKfu7LrhDbdnL9D/g82zXzLA+z2xNJk+y2sc6saMyJe350/SjFzhn91Y5+sz9Yg/ohv03F62cGZD+B8fCCnn/o82oiMcJINVYTX3gm+c+q3T2DJEvp78V5ZchWy3/aECZbS17l4+X5lx4d3qAGN2DAQX0h2r4ddYcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=hTuuWusr; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="hTuuWusr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1779188396; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=tWSnATgy6TmNShp32+UgunQgo08aVNfM1W5+7AMYU/o=;
 b=hTuuWusrsEc7FtHgJoxsYZAp8Z0J1sQxom03QdSFHUrlqyvVvJmvg4L2fdj3sukHsdjMJ
 AAMRxNL8nThBSE7mR/Y1+9mNSN18nwzS8icI5Xcf8I0Sarv91qoC5GEJsqlEOvwxTLoSA6C
 L1t860dMbLCXsuwa2OYrUm9rkkY5rwvAZzEA28Xr2gnzeRIZGZVZvr+jDa/w+04x6wnWniO
 bAfweBQxNIZVxndM7uBL6oGi5Kto2o1PCYvEb4eMeHDyXuBGr4RHltb/eyfpNljJgQNzd61
 quPszg//OT8PvUNfh9pFRrc2Cfnszb1lbnXXgp6eXfDUyL5LveIR+XzAko5g==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 5DCAA5FC52;
	Tue, 19 May 2026 12:59:56 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 3B36B5FA3E;
	Tue, 19 May 2026 12:59:55 +0200 (CEST)
Message-ID: <2a0ef851-3bc9-42e9-9af8-2bea3428fd28@tu-ilmenau.de>
Date: Tue, 19 May 2026 12:59:55 +0200
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
 <94daa02f-2f37-4462-94f1-518da132e063@tu-ilmenau.de>
 <59bb89377b9f4cb6d532b576e9e8fae5b88e926c.camel@ibm.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <59bb89377b9f4cb6d532b576e9e8fae5b88e926c.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18.05.26 8:38 PM, Viacheslav Dubeyko wrote:
> On Sat, 2026-05-16 at 10:46 +0200, Raphael Zimmer wrote:
>> On 5/15/26 9:05 PM, Viacheslav Dubeyko wrote:
>>> On Fri, 2026-05-15 at 10:11 +0200, Raphael Zimmer wrote:
>>>> A message of type CEPH_MSG_OSD_MAP holds an OSD map, which typically
>>>> contains a pg_upmap part at its end. When decoding this part in
>>>> __decode_pg_upmap_items(), a len value is decoded from the message to
>>>> determine the number of items and the size of the allocation needed for
>>>> them. If the len value is greater than or equal to 2^31, an overflow
>>>
>>> This phrase still sounds confusing. :) Because len is u32.
>>
>> Let's merge the discussion of both email threads here.
>>
>> I don't mean the calculation of "2 * len * sizeof(u32)". I'm 
>> specifically talking about the variable "len", as stated in the commit 
>> message. The problem arises when len >= 2^31. len is of type u32. That 
>> means, it can hold values from 0 to 2^32-1. 2 * len can lead to a 
>> multiplication overflow when len >= 2^31, because 2 * 2^31 = 2^32 -> 0 
>> when calculated in u32. Because of the left-to-right order of 
>> evaluation, this is calculated first and in the next step 0 * 
>> sizeof(u32). The first step will be calculated in 32 bit, and only the 
>> second one in the width of a size_t on the respective system. As I 
>> mentioned in the report, there are several ways to address this issue.
> 
> OK. You statement is "If the len value is greater than or equal to 2^31". We
> have len declared as u32. The u32 type variable can hold value not bigger than
> U32_MAX (0xFFFFFFFF, 4,294,967,295, or 2^31-1). The len value cannot be bigger
> than 2^31-1 in any way.
> 
> Thanks,
> Slava.
> 

U32_MAX is 2^32-1. I already explained it in the previous email.

Best regards,
Raphael

