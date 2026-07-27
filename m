Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A028376A1E
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785142180; cv=none; b=NH5p1F9gIqqVVisd+KP8OAvTC7t3GffbWuLxehc6dSjwYd2tGuZ7ZeyINQt0SjS3hR3sFsz3FWjEzWUCyyu4OM1Bn5BonuKuRXcg4n2bPlJvz77PYGRuea5TzcaPiag43Nd5HGyE6+RIt4ii0v3Z96bJyfYOsyBDe8N3M3cchaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785142180; c=relaxed/simple;
	bh=82J2lATTuJaszwWfjk8Ce2XEgLw4H1wJ7frUZvIFPvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1ud0wP8FQxKK2MxubB5qUFpnhQid7Cc05y5xscrAwNfB+cE4qVXAtj9nXfpBZl7NPL6sAKAiOS0Fh4eAc6/PyfZwlIbev7pb5ZXPVETQPbcvRrOz7dUscGUAhy7m69SowjueS74oQrgPNkegAqJIvSA0Q8yl+0cxiyZSGWXJbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=vpq64ic0; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="vpq64ic0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1785142045; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=82J2lATTuJaszwWfjk8Ce2XEgLw4H1wJ7frUZvIFPvk=;
 b=vpq64ic0th5IXLHpNd+xWGNiiz6btebHRu8fDMgBxQd2sbcA9GNmo1sCoTuM/k+heqMCg
 W3Oxj1WHj2q2wou3BvaN/rBV+V2tGA/0Y0V4EIrAZ42NdiwMOXUlqJI6VVnYhBLcsvqv09+
 0zpgRkHwgAfX98o5JzuUMvVIohtv43eEjuyHaX3swBRpiGHeDxustgpqWjIcZxJMuWw9lH2
 lDmOzRiXrFxfyJpiio/a5x8D4mK6DfG2kwtQmKgyXAJ03f0u6W9oZwZnZ1nvNwz4WzlkY0W
 GI/FwDM+/4RibMijbr5D+LCNLeFuwTPQWQuqKq3FLiPc6o/b2LG1EELP8/yA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 09CEA5FCA3;
	Mon, 27 Jul 2026 10:47:24 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id C89D05FB1D;
	Mon, 27 Jul 2026 10:47:23 +0200 (CEST)
Message-ID: <74b2b4f6-7401-4146-adb4-54d4069d1edc@tu-ilmenau.de>
Date: Mon, 27 Jul 2026 10:47:23 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] libceph: Fix multiplication overflow in
 __decode_pg_upmap_items()
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260519110130.2189287-1-raphael.zimmer@tu-ilmenau.de>
 <CAOi1vP_6WjqQp-7a_g6g=U9100cW54G-1jSjWRH3ieh4u9u-bA@mail.gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <CAOi1vP_6WjqQp-7a_g6g=U9100cW54G-1jSjWRH3ieh4u9u-bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23.07.26 10:41 PM, Ilya Dryomov wrote:
> On Tue, May 19, 2026 at 1:01 PM Raphael Zimmer
> <raphael.zimmer@tu-ilmenau.de> wrote:
>>
>> A message of type CEPH_MSG_OSD_MAP holds an OSD map, which typically
>> contains a pg_upmap part at its end. When decoding this part in
>> __decode_pg_upmap_items(), a len value is decoded from the message to
>> determine the number of items and the size of the allocation needed for
>> them. If the len value is greater than or equal to 2^31, an overflow
>> occurs in the multiplication that is performed to determine the needed
>> size of the incoming buffer to decode, as well as for the length of the
>> allocation for the ceph_pg_mapping struct. Subsequently, this results in
>> out-of-bounds writes (and reads) when decoding the incoming message
>> fields into the ceph_pg_mapping struct.
>>
>> This patch fixes the issue by splitting the computation into multiple
>> parts and storing the results in local variables of type size_t. This
>> prevents the overflow by performing the multiplication in the
>> appropriate data type and ensures that the result is calculated only
>> once.
>>
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>  net/ceph/osdmap.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 8b5b0587a0cf..076763420b1d 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -1615,13 +1615,16 @@ static struct ceph_pg_mapping *__decode_pg_upmap_items(void **p, void *end,
>>  {
>>         struct ceph_pg_mapping *pg;
>>         u32 len, i;
>> +       const size_t item_size = 2 * sizeof(u32);
>> +       size_t payload_len;
>>
>>         ceph_decode_32_safe(p, end, len, e_inval);
>> -       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
>> +       if ((size_t)len > (SIZE_MAX - sizeof(*pg)) / item_size)
> 
> Hi Raphael,
> 
> I think this can be just len > CEPH_PG_MAX_SIZE.  I have folded the
> corresponding fixup into someone else's patch that originally did that
> only for __decode_pg_temp():
> 
> https://github.com/ceph/ceph-client/commit/9f00f9cf2be293efe899db67dc5272e3a9c62717
> 
> If you agree, we can retire this patch.
> 
> Thanks,
> 
>                 Ilya

Hi Ilya,
this solution with "len > CEPH_PG_MAX_SIZE" will equally solve the
issue. Therefore, I'm fine with doing it this way.

Best regards,
Raphael

