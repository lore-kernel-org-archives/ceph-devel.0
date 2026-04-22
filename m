Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FD3BF666
	for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2026 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776846634; cv=none; b=Yf3zb30F8+dwBdLiiHz7scPQ1tJaRFT195rRok1tbDT2WqaC2Y/l8ur3mJtQaCNiNEvIAgBkhAYXG/lHtM2OGYrK7CZkH3768LetpLerAtLzUZ+HMhUXqCu83WmagtgAxkg6+dBnGcnFbIOKFvJlRiStFFS0zIS0DpHl5Of/dvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776846634; c=relaxed/simple;
	bh=GeOfvFmSON4oUxALhz61TnBe4eYRw4Yml4/5lLjbIfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMlfkFNFe9liE6eJCHvUruCC9dzh33+6DH+flrWPiWMttSzgwAPtvMZEPs5JPZfORHYJLMpsTnqEIcyCq5GONzUIcD5qnhDlAfM/APcbUH0AxF7Z5wNkm7Ws1iaG4CGUS0avs+QOmb6coNqER0B31tG5YdEVYpx/Z7Xx/AuxMak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=Z/DfJfEU; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="Z/DfJfEU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1776846624; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=GeOfvFmSON4oUxALhz61TnBe4eYRw4Yml4/5lLjbIfE=;
 b=Z/DfJfEUO9Cxcu/ur/zDmXF+0kNfy9Gnq2ojBCNe3ja1zmxLUMgVlzBWJ7b0W9g3boGR/
 IFs50avk5SJluomGPhn5Us0VscgQ1l9IvCm2u653I8z5dvi6nXz39rZs+z0nmEuXWONnihT
 CM2QFuRImupIWnnVE7YGceIH4n3DLXP8g7PdHG0wP4uSyBq/IN+nYyyf83W0sOS0m3lNjzU
 p11PxCT+dEFv4h5QOHhNAWodJsYchqTwN3gw7/6eCr8D99+UZbCsPrqlMoE9DXf/xcP+kg2
 vEHlZBiOat+xTDKMtcCybCBJDBhLKjIlAzBaLatXZVQvY5fCyHPUeIvQO2uA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 1F81960174;
	Wed, 22 Apr 2026 10:30:24 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id BB2055FB7B;
	Wed, 22 Apr 2026 10:30:23 +0200 (CEST)
Message-ID: <18550c65-3c96-4b22-a958-99be8ab9ee6e@tu-ilmenau.de>
Date: Wed, 22 Apr 2026 10:30:23 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libceph: Fix potential out-of-bounds access in
 crush_decode()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260402071524.3766233-1-raphael.zimmer@tu-ilmenau.de>
 <CAOi1vP9N9n26HEXPFpNniRtR5qc_nvxuim02J26psKpW-6iXbQ@mail.gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <CAOi1vP9N9n26HEXPFpNniRtR5qc_nvxuim02J26psKpW-6iXbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 21.04.26 11:17 PM, Ilya Dryomov wrote:
> On Thu, Apr 2, 2026 at 9:16 AM Raphael Zimmer
> <raphael.zimmer@tu-ilmenau.de> wrote:
>>
>> A message of type CEPH_MSG_OSD_MAP containing a crush map with at least
>> one bucket has two fields holding the bucket algorithm. If the values
>> in these two fields differ, an out-of-bounds access can occur. This is
>> the case because the first algorithm field (alg) is used to allocate
>> the correct amount of memory for a bucket of this type, while the second
>> algorithm field inside the bucket (b->alg) is used in the subsequent
>> processing.
>>
>> This patch fixes the issue by adding a check that compares alg and
>> b->alg and aborts the processing in case they differ. Furthermore,
>> b->alg is set to 0 in this case, because the destruction of the crush
>> map also uses this field to determine the bucket type, which can again
>> result in an out-of-bounds access when trying to free the memory pointed
>> to by the fields of the bucket.
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>  net/ceph/osdmap.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index c89e66d4fcb7..a87268058e61 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -516,6 +516,10 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
>>                 b->id = ceph_decode_32(p);
>>                 b->type = ceph_decode_16(p);
>>                 b->alg = ceph_decode_8(p);
>> +               if (b->alg != alg) {
>> +                       b->alg = 0;
> 
> Hi Raphael,
> 
> Wouldn't setting b->alg to 0 result in leaking the chunk of memory
> allocated for the bucket a few lines above due to crush_destroy_bucket()
> basically becoming a no-op?  To be able to set b->alg to 0, it looks
> like kfree(b) that each crush_destroy_bucket_*() helper ends with would
> needs to be factored out into crush_destroy_bucket().
> 
> Thanks,
> 
>                 Ilya

Hi Ilya,
yes, you're right, this leads to leaking the memory allocated for the
bucket. I will fix this.

Best regards,
Raphael
