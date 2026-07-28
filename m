Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CEF40B0ED
	for <ceph-devel@vger.kernel.org>; Tue, 28 Jul 2026 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785227539; cv=none; b=aH/jiPOa6B35106mdnfbBLvhaMVvbCKAO4jlAlqDCTgzZxgayrYv9AZoE0t4aOOyPCIULULoLM5uf/VcAg9LrUa/au9Mybes0sPsSNaWKCi/Pa3lT/OfKlpeIMqwIKKoxUVtj+xsSh1SKLVdFrhyTHOO6yxwwBYJFDm5SoHigoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785227539; c=relaxed/simple;
	bh=GxQFZHWooOckKTeSL5W/nyqsj9J9oMPgDg/rk98oRlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFnaK30MJqRp/6BW7f+U/91e4lrUJuVH48JUvp4/jx6q4mJbcBgPsQsUJzhKp/L1GtU5rlqmkj2pao3WjwndYbcntCm0c5BX+kZFcDpDyGNEWmUSzkPxxnwhAh8uhEN3qzt9SRL+OKBLXKqlL0kB1fRfU/s69F2+AbtyfcSRq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=V3Rvz/fu; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="V3Rvz/fu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1785227528; h=message-id
 : date : mime-version : subject : to : cc : references : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=GxQFZHWooOckKTeSL5W/nyqsj9J9oMPgDg/rk98oRlQ=;
 b=V3Rvz/fu16mtxlNnqq6TTjtjoEkrfakOgdEfDRFMe22rb6OzcWl4qK7NgSgU38iWKRoLY
 qh4dsKFetsWIwf4YReMYrWH7LnNrVp+xGMNJCFQ035UX9k3ghRj9yf93qP8EOxv6xUKCSne
 DC/sDMVxn/fWVkWN5/89nUDh1AhHwcxUOxeyr6JpsumKuRcmQz7Ix2RKDbp7fWtyjXDzG86
 dJ/gSOCEv4KyTg8m9FdEHcqwt1tKKGhZhLCxFtspRAf01qv503xj4/JoGFV++IqIJ+Xb29B
 bIUOG7fkXGNYn/j0ERQjjFdIy0grxrpqhegQsTbsgwHyhhdC+foxfeMuL6rA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 42F045FC42;
	Tue, 28 Jul 2026 10:32:08 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id DFECB5FB23;
	Tue, 28 Jul 2026 10:32:07 +0200 (CEST)
Message-ID: <94b31c6f-5f41-447d-a4f0-217fc9afa8f2@tu-ilmenau.de>
Date: Tue, 28 Jul 2026 10:32:07 +0200
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
 <b027e46f-0af9-4980-b8bf-afaf1a4b4b43@tu-ilmenau.de>
 <CAOi1vP8k02Xe0MX-+uYGOsSPP2MGijUHcVEa1WGs0yrqZGFWmQ@mail.gmail.com>
Content-Language: en-US
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <CAOi1vP8k02Xe0MX-+uYGOsSPP2MGijUHcVEa1WGs0yrqZGFWmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27.07.26 7:41 PM, Ilya Dryomov wrote:
> On Mon, Jul 27, 2026 at 5:32 PM Raphael Zimmer
> <raphael.zimmer@tu-ilmenau.de> wrote:
>>
>> On 27.07.26 12:35 PM, Ilya Dryomov wrote:
>>> On Wed, Jul 1, 2026 at 5:56 PM Raphael Zimmer
>>> <raphael.zimmer@tu-ilmenau.de> wrote:
>>>>
>>>> A corrupted osdmap received from a Ceph monitor or OSD may contain
>>>> placement groups with osd indices that don't exist, i.e., that are
>>>> greater than max_osd or smaller than CEPH_HOMELESS_OSD (-1).
>>>
>>> Hi Raphael,
>>>
>>> The osdmap doesn't contain all placement group mappings -- they are
>>> produced on demand by CRUSH based off of the crushmap that is embedded
>>> in the osdmap but doesn't contain any OSD indices.  There are a few
>>> (usually small or empty) exception tables in the form of pg_temp,
>>> primary_temp, pg_upmap and pg_upmap_items where the "override" OSD
>>> indices are stored.  Are those what you have in mind wrt. osdmap
>>> corruption?
>>>
>>
>> Hi Ilya,
>>
>> Yes, it's about these. I looked into it again after submitting this
>> patch and concluded that the problematic part is specifically
>> primary_temp. In the functions called from ceph_pg_to_up_acting_osds(),
>> non-existent osds are removed from the osd sets. Therefore, the up set
>> will not contain any invalid osds afterwards and will also have a valid
>> primary, as it is always one of the osds in the set. Similarly,
>> non-existent osds are removed from the acting set. However, the primary
>> osd is directly assigned from pg->primary_temp.osd in get_temp_osds(),
>> without checking for its existence. This way, an invalid osd index can
>> be returned as target osd from calc_target().
>>
>> Therefore, it would suffice to add the check at this position (in
>> get_temp_osds()) and set the primary osd to the homeless osd in this
>> case (or perhaps to another osd from the acting set, but this doesn't
>> seem like a good solution to me, as the osdmap may be corrupted even
>> more and other osd mappings are also incorrect).
> 
> Setting the primary to the homeless OSD in get_temp_osds() would make
> the OSD set invalid as far as osds_valid() is concerned.  I don't see
> a problem with "another OSD" solution because corruptions of this kind
> shouldn't ever happen in real deployments.
> 

That sounds plausible to me.

>>
>>> If so, I'd suggest adding map->max_osd checks to the corresponding
>>> decode routines.  Munging ct_res to CALC_TARGET_NEED_RESEND as done in
>>> this patch doesn't make much sense -- you are asking the OSD client to
>>> arrange for the OSD request to be resent when there is no valid OSD to
>>> send it to (and no expectation whatsoever that the resend's invocation
>>> of calc_target() would produce a different result).
>>>
>>
>> I don't completely agree on this matter. I specifically reassign the
>> request to the homeless osd here and don't ask for resending it to an
>> invalid one. This will result in not sending it out. __submit_request()
>> only sends it if !osd_homeless(osd). The same holds true for
>> kick_requests(). For linger requests, send_linger() also ultimately
>> calls __submit_request(), leading to the same behavior. Finally,
>> recalc_linger_target() only re-links the request to the homeless osd if
>> calc_target() returns CALC_TARGET_NEED_RESEND.
>> If applying the solution described above (checking in get_temp_osds()),
>> this would furthermore only happen once.
>>
>> Adding map->max_osd checks to the corresponding decode routines would
>> also be possible. I initially decided not to do this because the
>> proposed solution needs fewer code changes and still resolves the issue
>> of a potential out-of-bounds access. If we wanted to add checks to the
>> decode functions, this should be done in all of them for consistency.
>> That would mean we need to change multiple functions, including their
>> signatures, to pass the map->max_osd into them.
>>
>> Do you still think that checks should be added to the decode functions,
>> or would a check for either ceph_osd_is_down(pg->primary_temp.osd) or
>> !ceph_osd_exists(pg->primary_temp.osd) in get_temp_osds() be an
>> acceptable option too?
> 
> If there is confidence that the potential out-of-bounds read issue is
> limited to primary_temp, I'd go with ceph_osd_is_down() check in
> get_temp_osds() and ignore the primary_temp entry if the check fires on
> the OSD in question -- the primary derived from pg_temp or the up set
> primary (if no pg_temp) might very well be actionable in case of legit
> mishap on the monitors.  I'd also warn though since this isn't supposed
> to happen normally.  Something along the lines of
> 
>     /* primary_temp? (shouldn't ever be a nonexistent or down OSD) */
>     pg = lookup_pg_mapping(&osdmap->primary_temp, pgid);
>     if (pg && !WARN_ON_ONCE(ceph_osd_is_down(osdmap,
>                                              pg->primary_temp.osd)))
>             temp->primary = pg->primary_temp.osd;
> 
> What do you think?
> 

raw_to_up_osds() checks for ceph_osd_is_down(osdmap, set->osds[i]) and
therefore removes all invalid osd indices from the up set. The primary
is only ever taken from this set afterwards. So there should be no
chance for an invalid osd index to remain in the up set. The acting set
gets filled in get_temp_osds(), and a check for ceph_osd_is_down(osdmap,
pg->pg_temp.osds[i]) is also already present there. The only unchecked
part is the primary of the acting set taken from primary_temp. So the
potential out-of-bounds read can only happen because of an invalid index
in primary_temp (at least in the trigger path I observed).

Your proposed solution looks good, I will resend a new patch with it.

Best regards,
Raphael

