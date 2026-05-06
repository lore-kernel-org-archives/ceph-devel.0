Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625E4611FC
	for <ceph-devel@vger.kernel.org>; Wed,  6 May 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072674; cv=none; b=g36PPEOZxoBn7k1npAXbbfah5kFcxdRyyIia3SztLno+r0zbhhad7eIe5ikzZy69Ubzg+Jj5YaNf0a2IF1YV3vngxjbWgngvEu9dUzTlflOdNmgRe3eFf/z3yBXcuGphYiYyIgzVgS5BK3udeiU8gECjb5mQlecR5/wnvmaS6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072674; c=relaxed/simple;
	bh=vCcL7Yxih/eJ6xYYFRWJD14ms5V49QW68H3goPdvgLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXqBtU5hu6oS61GlSvEJDJ7c8yxLnUhFjHc0rNRogpYYeaZJCaFHfQMhjDGSswZb9dBMljKgGgQaNZ2NzS0NWmuxCGsQ46lJ5IM9n0BAP8yAxYgqnFYGw03IUdE9Jx7tVWjN+5LN1rLexfCrv5TfIf5IuXZE481yFWFRoPBpVyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=Y8NOhI0c; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="Y8NOhI0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1778072660; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=vCcL7Yxih/eJ6xYYFRWJD14ms5V49QW68H3goPdvgLI=;
 b=Y8NOhI0cjy02IGR6GYibDJPTbydcnEIWT8BkLQIs3OLeTxi6G7HlMMRJy+jZ/zo+JlhGk
 z4qC7GVyRANKSce4PmO7TaXF7hN98qxOKmcST3C3sGfBWxeicoSI1p+pJcxO8WhVOlErUFe
 vCa7bUA+LnG9AFTCu/JALTUABTYuH1l+b3X+f9pjLVpaSkxdc+r9XZJsWwdE8C5mwzIBPeF
 EJ/UyEDUTfZgsww0TJQsWkC2pmr4ozvM1Qv5ujioRfvklZltjVfFkLF61+qOZvgTRNPb8Li
 vAyKcrZx+SAMW2aPNxeCuXjyGrgFncMhgBpQFTib0Ny5XdF64BW0ozZ2rBzA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id BF2545FCF7;
	Wed,  6 May 2026 15:04:20 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id A12CF5FB24;
	Wed,  6 May 2026 15:04:18 +0200 (CEST)
Message-ID: <ce329dd4-54b7-4bbd-ac9c-7ea18488e0e8@tu-ilmenau.de>
Date: Wed, 6 May 2026 15:04:18 +0200
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
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <ba35c81180e74517613e3dad41e5f5a938be4137.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.05.26 8:55 PM, Viacheslav Dubeyko wrote:
> On Tue, 2026-05-05 at 11:08 +0200, Raphael Zimmer wrote:
>> When decoding osd_state and osd_weight from an incoming osdmap in
>> osdmap_decode(), both are decoded for each osd, i.e., map->max_osd
>> times. The ceph_decode_need() check only accounts for
>> sizeof(*map->osd_weight) once. This can potentially result in an
>> out-of-bounds memory access if the incoming message is corrupted such
>> that the max_osd value exceeds the actual content of the osdmap message.
>>
>> This patch fixes the issue by changing the corresponding part in the
>> ceph_decode_need() check to account for
>> map->max_osd*sizeof(*map->osd_weight).
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>  net/ceph/osdmap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 669348d883f0..2095e73ccf6c 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -1705,7 +1705,7 @@ static int osdmap_decode(void **p, void *end, bool msgr2,
>>  	ceph_decode_need(p, end, 3*sizeof(u32) +
>>  			 map->max_osd*(struct_v >= 5 ? sizeof(u32) :
>>  						       sizeof(u8)) +
>> -				       sizeof(*map->osd_weight), e_inval);
>> +			 map->max_osd*sizeof(*map->osd_weight), e_inval);
> 
> It's too complicated computation for one string, from my point of view. I think
> we need to introduce a static inline function which will include this
> computation. Also, 3*sizeof(u32) looks very bad for my taste. We need to have
> some named constant here.
> 
> Thanks,
> Slava.
> 

Hi Slava,
for what exactly do you want to introduce a static inline function? Just
for this computation?
The computation inside the call to ceph_decode_need() is done at many
places. The 3*sizeof(u32) is a common pattern in the code, although it's
not used consistently. Sometimes plain numbers are used. I don't follow
how you want to introduce a named constant. It means we need enough
buffer space for three 32-bit values. In my opinion, creating a constant
for "size of three 32-bit values" wouldn't make it more readable.

Best regards,
Raphael

>>  	if (ceph_decode_32(p) != map->max_osd)
>>  		goto e_inval;
>>  

