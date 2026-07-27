Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A03AFD07
	for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2026 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166382; cv=none; b=j7UURkfYnCaVOq9UP0xELnfxjjmzmPTywz42woX75o67yjIu9leUed1aKo01QiEtjCnfi0MdWTHX8TcVpKUVNNqhY8fO15s2esT0vRWjv/uwRnZEzB+6bqTnL2R7B7hpozVZPFNKwaOVVJFSQes2u8ap+uvVF/VCF75DTiZTemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166382; c=relaxed/simple;
	bh=NgwhvutaOnRZMa/LGmXDdlwB2CKu/pOYKfnEfRLey74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2re4cJPIX4pQnvbLvjLCepOsJUTCuEFV1YQJ2KRrhsV9tCMmH16QmuZwg+qPFWpYZRgI5EYcc7Cg42s5jNjIb3sERcyXcNaWdexuak4h7VyvR+1oy32Sg0QkYuZJUbzzkU57CIfW2+dcha7ttZNZ4NyhBZ3CeiyAfUhcxtGOKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=eVSUlVYv; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="eVSUlVYv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1785166376; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=NgwhvutaOnRZMa/LGmXDdlwB2CKu/pOYKfnEfRLey74=;
 b=eVSUlVYv9jhG0/81TbxDlnGVoW195pzmUjxZHeLRj7n8G/hf42AwTbTQFZU4Pl/WfWQZm
 dEY9g4lXnMsJ9EzZqnz98kNPlFvJeaWwAPx4GAGYNi5Myat6imuqQT7EWGweYUoEV1vYxQ7
 Wggc+eSVL7CLzZ1b6PMAAHIB7IS/gLDjAS1HasueDnujc7MhAwz3mUgjIx829IifgNGTcBA
 nnLgtEXWHw7sXGQDpHjUql0nAqNXNBbqrQG4N0HzwQgOaNqHcWEFWSLyQ+BU+MrNWRMC6Do
 yR8MTv/43yJNFqfNhzi58Y5yo/NSgDY28/kwEFX8GCa/J1xEevkFLcuKVf3w==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 3D47D5FB0C;
	Mon, 27 Jul 2026 17:32:56 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 20CFF5FA5F;
	Mon, 27 Jul 2026 17:32:55 +0200 (CEST)
Message-ID: <b027e46f-0af9-4980-b8bf-afaf1a4b4b43@tu-ilmenau.de>
Date: Mon, 27 Jul 2026 17:32:54 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] libceph: Assign requests to homeless osd if calculated
 osd exceeds max_osd
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>, ceph-devel@vger.kernel.org
References: <20260701155610.3133868-1-raphael.zimmer@tu-ilmenau.de>
 <CAOi1vP9jaHW2Eixk6i0gemBnWUgcybciFv025sXykPxk19ojpw@mail.gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <CAOi1vP9jaHW2Eixk6i0gemBnWUgcybciFv025sXykPxk19ojpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.07.26 12:35 PM, Ilya Dryomov wrote:
> On Wed, Jul 1, 2026 at 5:56 PM Raphael Zimmer
> <raphael.zimmer@tu-ilmenau.de> wrote:
>>
>> A corrupted osdmap received from a Ceph monitor or OSD may contain
>> placement groups with osd indices that don't exist, i.e., that are
>> greater than max_osd or smaller than CEPH_HOMELESS_OSD (-1).
> 
> Hi Raphael,
> 
> The osdmap doesn't contain all placement group mappings -- they are
> produced on demand by CRUSH based off of the crushmap that is embedded
> in the osdmap but doesn't contain any OSD indices.  There are a few
> (usually small or empty) exception tables in the form of pg_temp,
> primary_temp, pg_upmap and pg_upmap_items where the "override" OSD
> indices are stored.  Are those what you have in mind wrt. osdmap
> corruption?
> 

Hi Ilya,

Yes, it's about these. I looked into it again after submitting this
patch and concluded that the problematic part is specifically
primary_temp. In the functions called from ceph_pg_to_up_acting_osds(),
non-existent osds are removed from the osd sets. Therefore, the up set
will not contain any invalid osds afterwards and will also have a valid
primary, as it is always one of the osds in the set. Similarly,
non-existent osds are removed from the acting set. However, the primary
osd is directly assigned from pg->primary_temp.osd in get_temp_osds(),
without checking for its existence. This way, an invalid osd index can
be returned as target osd from calc_target().

Therefore, it would suffice to add the check at this position (in
get_temp_osds()) and set the primary osd to the homeless osd in this
case (or perhaps to another osd from the acting set, but this doesn't
seem like a good solution to me, as the osdmap may be corrupted even
more and other osd mappings are also incorrect).

> If so, I'd suggest adding map->max_osd checks to the corresponding
> decode routines.  Munging ct_res to CALC_TARGET_NEED_RESEND as done in
> this patch doesn't make much sense -- you are asking the OSD client to
> arrange for the OSD request to be resent when there is no valid OSD to
> send it to (and no expectation whatsoever that the resend's invocation
> of calc_target() would produce a different result).
> 

I don't completely agree on this matter. I specifically reassign the
request to the homeless osd here and don't ask for resending it to an
invalid one. This will result in not sending it out. __submit_request()
only sends it if !osd_homeless(osd). The same holds true for
kick_requests(). For linger requests, send_linger() also ultimately
calls __submit_request(), leading to the same behavior. Finally,
recalc_linger_target() only re-links the request to the homeless osd if
calc_target() returns CALC_TARGET_NEED_RESEND.
If applying the solution described above (checking in get_temp_osds()),
this would furthermore only happen once.

Adding map->max_osd checks to the corresponding decode routines would
also be possible. I initially decided not to do this because the
proposed solution needs fewer code changes and still resolves the issue
of a potential out-of-bounds access. If we wanted to add checks to the
decode functions, this should be done in all of them for consistency.
That would mean we need to change multiple functions, including their
signatures, to pass the map->max_osd into them.

Do you still think that checks should be added to the decode functions,
or would a check for either ceph_osd_is_down(pg->primary_temp.osd) or
!ceph_osd_exists(pg->primary_temp.osd) in get_temp_osds() be an
acceptable option too?

I can send a new patch with the preferred solution.

Best regards,
Raphael

> Thanks,
> 
>                 Ilya
> 
>> Subsequently, this may lead to calc_target() returning such an index as
>> target osd for a (linger) request. Because the osd_state, osd_weight,
>> and osd_addr arrays only contain max_osd entries (with indices 0 to
>> max_osd -1), this leads to out-of-bounds accesses when trying to read
>> values from these arrays.
>>
>> This patch fixes the issue by adding a check to calc_target() assigning
>> the request to the homeless osd if the target osd index read from the
>> osdmap falls outside the valid osd index range.
>>
>> Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target, calc_target()")
>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>> ---
>>  net/ceph/osd_client.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index a4d3cbfd27a3..3d13226a5d1f 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -1707,6 +1707,12 @@ static enum calc_target_result calc_target(struct ceph_osd_client *osdc,
>>                 }
>>         }
>>
>> +       if (t->osd != CEPH_HOMELESS_OSD && (u32)t->osd >= osdc->osdmap->max_osd) {
>> +               t->osd = CEPH_HOMELESS_OSD;
>> +               ct_res = CALC_TARGET_NEED_RESEND;
>> +               goto out;
>> +       }
>> +
>>         if (unpaused || legacy_change || force_resend || split)
>>                 ct_res = CALC_TARGET_NEED_RESEND;
>>         else
>> --
>> 2.47.3
>>

