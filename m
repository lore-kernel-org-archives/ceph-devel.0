Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B75D3DB331
	for <ceph-devel@vger.kernel.org>; Thu,  6 Aug 2026 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786004611; cv=none; b=m2EHJNd1KZm+B1Wngxeg2KZr1Fk2jBnZycj6aoFxaRBT7eO39IwfyUZF7XJGoRCfvQ/GBB7tCDHwkNnZBBcnpWWXAA22uDpNfgMOBeQSoIgBUVFPGoGgJoWjPcCxfvDdCsGUWgh8Vwbwp+o9jHLhd5r93Q8MPwmXxs0klAA7Quo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786004611; c=relaxed/simple;
	bh=io6dZY9LlTgKzpJIow6XZ+Dc++3CenuiHSDJckZle28=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=e7LVonCwsYi7Kh3Ezh88OTm4WF2qM8F8VYYmxByARQETjvz2TcJYVO8rervYDrUetrm1z6blF/t+dS7TvMHsla3mNZansWlmYUXRN71keuk2fo7K6+hXutYF+FKGD2auiTGowBoZEXTM6OngFY4U3+z1Ke/zqRGSHULDvtQCYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=s1fpdYEk; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="s1fpdYEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1786004515; h=message-id
 : date : mime-version : subject : from : to : cc : references :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=io6dZY9LlTgKzpJIow6XZ+Dc++3CenuiHSDJckZle28=;
 b=s1fpdYEkPI7aw3EWGnfGAjT4wpFBLvBbltNijL3n84PkBKdM0E7Ua9CblehUxEKJN9hfv
 ar3vYzM5Zcw0Rd4sMWPCJ6ShP4l6jPAuF6qcCoGb4KQE/Gj53/aSXOW7q2B8i/P+cmbrQmF
 C6lRZVSLxCqTHSMY+SsdEw+q+t1FLimlSfgOOHQVc4XD36h568HySftdrNc2LBCoyIQuBgV
 y+QfrDsygI02wlsO0GYOqBcnVcgdm0r9jPKtvJtI/dMvalTanoL1qAXrWWaOoVnWKdJw4Fk
 AvpKKfr9UCBYAp2KsW0e0+PXnZ+JVgZwtS3hUZKQlfKI38lWeaDjSRWg4pZA==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id B9A875FB54;
	Thu,  6 Aug 2026 10:21:55 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 7AB695FB20;
	Thu,  6 Aug 2026 10:21:55 +0200 (CEST)
Message-ID: <f4bc94a4-a892-4cfe-83a4-9f1f5f5f294a@tu-ilmenau.de>
Date: Thu, 6 Aug 2026 10:21:55 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] libceph: Always remove requests from
 ceph_osdc_handle_map() structures
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Viacheslav Dubeyko <slava@dubeyko.com>, Ilya Dryomov
 <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>
Cc: ceph-devel@vger.kernel.org
References: <34799e8f-a24d-4967-beb6-4b7f51c3efc5@tu-ilmenau.de>
 <20260617131344.2325324-1-raphael.zimmer@tu-ilmenau.de>
 <76f6bf19173ad8b5af3c0a86e21ef8014fbac542.camel@dubeyko.com>
 <d3f84eaf1a45e3f6a4852504222ed909928d1332.camel@dubeyko.com>
 <66459849-4423-4fbf-a2ca-eb8b2b9a5969@tu-ilmenau.de>
Content-Language: en-US
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <66459849-4423-4fbf-a2ca-eb8b2b9a5969@tu-ilmenau.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30.06.26 6:06 PM, Raphael Zimmer wrote:
> On 29.06.26 6:43 PM, Viacheslav Dubeyko wrote:
>> On Mon, 2026-06-29 at 09:12 -0700, Viacheslav Dubeyko wrote:
>>> CC: ceph-devel@vger.kernel.org
>>>
>>> On Wed, 2026-06-17 at 15:13 +0200, Raphael Zimmer wrote:
>>>> ceph_osdc_handle_map() creates two local stack variables that track
>>>> (linger) requests that need to be resent. For requests, this is an
>>>> rb_root, and for linger requests, a list_head. Subsequently,
>>>> handle_one_map() is called, which calls scan_requests() for each
>>>> osd.
>>>> In scan_requests, the new target is calculated for each (linger)
>>>> request, and, in case of CALC_TARGET_NEED_RESEND, they are inserted
>>>> into
>>>> the previously created list/rbtree. All requests in these
>>>> structures
>>>> are
>>>> kicked off to their new target osd after processing all osdmaps. If
>>>> an
>>>> error occurs during processing, e.g., because an osdmap is
>>>> corrupted,
>>>> ceph_osdc_handle_map() jumps to the bad label and doesn't call
>>>> kick_requests(). Therefore, the (linger) requests are still
>>>> inserted
>>>> in
>>>> the list/rbtree, which now doesn't have a head/root anymore. This
>>>> results in requests containing invalid pointers to stack memory.
>>>> Subsequently, this can have multiple effects, ranging from not
>>>> being
>>>> able to insert linger requests again because they still have prev
>>>> and
>>>> next pointers or triggering a BUG_ON() assertion when trying to
>>>> insert a
>>>> non-empty rb_node again, to overwriting stack memory.
>>>>
>>>> This patch fixes the issue by making sure all (linger) requests are
>>>> removed from the list/rbtree in case the osdmap processing returns
>>>> an
>>>> error. This is accomplished by adding logic that is executed after
>>>> a
>>>> jump to the bad label performing the removal similar to
>>>> kick_requests.
>>>>
>>>> Fixes: 5aea3dcd5021 ("libceph: a major OSD client update")
>>>> Fixes: 922dab613417 ("libceph, rbd: ceph_osd_linger_request,
>>>> watch/notify v2")
>>>> Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
>>>> ---
>>>>  net/ceph/osd_client.c | 21 +++++++++++++++++++++
>>>>  1 file changed, 21 insertions(+)
>>>>
>>>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>>>> index 5fc79c29aab0..a4d3cbfd27a3 100644
>>>> --- a/net/ceph/osd_client.c
>>>> +++ b/net/ceph/osd_client.c
>>>> @@ -4129,6 +4129,26 @@ static void kick_requests(struct
>>>> ceph_osd_client *osdc,
>>>>  	}
>>>>  }
>>>>  
>>>> +static void clear_resend_requests(struct ceph_osd_client *osdc,
>>
>> This function is small enough. So, we can declare the function as
>> static inline.
>>
>> As far as I can see, osdc parameter hasn't been used in function at
>> all. I assume that it is not necessary.
>>
> 
> Yes, you’re right, I will fix this.
> 
>>>> +				  struct rb_root *need_resend,
>>>> +				  struct list_head
>>>> *need_resend_linger)
>>>> +{
>>>> +	struct ceph_osd_linger_request *lreq, *nlreq;
>>>> +	struct rb_node *n;
>>>> +
>>>> +	for (n = rb_first(need_resend); n; ) {
>>
>> This for() declaration looks really weird. I think you need to
>> implement something like this:
>>
>> n = rb_first(need_resend);
>>
>> while (n) {
>>     <execute logic>
>> };
>>
> 
> I have to admit that I took this from kick_requests(). For me, the
> question is rather whether we should remove this duplicate code.
> However, I didn’t want to modify kick_requests(), and it does much more
> than just this removal in an intertwined way. If we stay with this
> solution, I wouldn’t really want to introduce yet another kind of loop.
> 
>>>> +		struct ceph_osd_request *req =
>>>> +		    rb_entry(n, struct ceph_osd_request, r_node);
>>
>> I think you need to move the struct ceph_osd_request *req into
>> declaration section, then you will be able to have assignment on one
>> line:
>>
>> req = rb_entry(n, struct ceph_osd_request, r_node);
>>
> 
> This would be possible. Again, kick_requests() also uses this pattern.
> Moreover, it seems to be consistently used in the surrounding functions,
> e.g. scan_requests() or for a ceph_pg_pool_info in set_pool_was_full().
> To preserve consistency, I would prefer to either modify it everywhere
> or not at all.
> 
>>>> +
>>>> +		n = rb_next(n);
>>>> +		erase_request(need_resend, req);
>>
>> The erase_request() has BUG_ON() for empty node:
>>
>> BUG_ON(RB_EMPTY_NODE(&t->r_node));
>>
>> Are we sure that we will have not empty node always?
>>
> 
> We got this node from rb_first()/rb_entry() directly beforehand.
> Therefore, it should never be empty.
> 
> 
>> I think that we need to call the erase_request() at first and, then, to
>> call the rb_next(). It sounds more reasonable for my taste.
>>
> 
> If we call erase_request() first, the request will be erased from the
> rbtree, and we can’t call rb_next() on it anymore.
> 
>> I am guessing... Should we re-link these requests to osdc->homeless_osd
>> so they can be retried? These requests are orphaned and it will be
>> never resent. It sounds like any waiters will hang until timeout.
>>
> 
> I’m not sure. The problem occurs if the osdmap is corrupted in a way
> that a processing error occurs after at least once successfully calling
> scan_requests() from handle_one_map(). That means we will have an
> updated osdmap afterwards, but the requests will still be linked to the
> osds they were previously linked to. If the processing fails because the
> osdmap was corrupted, the other parts of it may also have been
> corrupted, and the old mapping would still be correct for some or all
> requests. Therefore, it could be a reasonable choice to leave the
> mapping as it is, until another osdmap arrives that is valid. However,
> if it was not completely corrupted, remapping to the homeless_osd could
> also be the better choice. If the changed mapping has not been corrupted
> at all, it could even be best to simply call kick_requests() and resend
> these requests to their new osds. In this case, we wouldn't need to
> introduce this new function here at all.
> 
> What do you think about it? Would you still argue for linking it to the
> homeless_osd or prefer one of the other solutions?
> 

Hi,
do you have any opinion on the open points by now so that I can create a
new version of this patch incorporating them?

Best regards,
Raphael

