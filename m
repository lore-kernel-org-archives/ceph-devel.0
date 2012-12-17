From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 8/9] rbd: fix ceph_pg_poolid_by_name()
Date: Mon, 17 Dec 2012 15:28:24 -0600
Message-ID: <50CF8E78.10701@inktank.com>
References: <50CA0915.1090801@inktank.com> <50CA0A3E.7040501@inktank.com> <alpine.DEB.2.00.1212142116220.23307@cobra.newdream.net> <50CF2DF3.1050909@inktank.com> <alpine.DEB.2.00.1212170846140.6695@cobra.newdream.net> <50CF51DE.8070604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:45883 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab2LQV2W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Dec 2012 16:28:22 -0500
Received: by mail-ie0-f174.google.com with SMTP id c11so10106824ieb.19
        for <ceph-devel@vger.kernel.org>; Mon, 17 Dec 2012 13:28:22 -0800 (PST)
In-Reply-To: <50CF51DE.8070604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 12/17/2012 11:09 AM, Alex Elder wrote:
> On 12/17/2012 10:49 AM, Sage Weil wrote:
>> On Mon, 17 Dec 2012, Alex Elder wrote:
>>> On 12/14/2012 11:17 PM, Sage Weil wrote:
>>>> Most of the code uses int64_t/__s64 for the pool id, although in a few 
>>>> cases we screwed up and limited it to 32 bits.  In reality, that's way 
>>>> overkill anyway; we could have left it at 32 bits to begin with.

I just wanted to follow up on this.  Sage and I discussed
this today.  He said that most of the other code involving
pool id's assume they are signed, so a negative pool id
indicates an error.  Rather than introduce another new
way pool id's could be (mis)interpreted I agreed to rework
this patch so that it follows that basic pattern (i.e.,
considering pool id's signed).

I haven't looked at it closely yet but I still expect to
have a revised patch, though it's possible I'll conclude
leaving things as-is is best.

Some future cleanup task can take care of unifying everything
to 64 bits (or possibly 32 bits), but that's another day.

					-Alex


>>> The differing types representing the same abstraction are precisely
>>> the point of making this change.  What really needs to happen is we
>>> need to fix *that*; that is, decide whether a pool id is 32 or 64
>>> bits, signed or not, and then make sure it's that and only that
>>> throughout the code.
>>>
>>> In the mean time, this change is defensive, making sure there's
>>> no uncertainty in what we're dealing with within rbd.  The code
>>> will guarantee some future change won't inadvertently let a
>>> wrong-sized pool id attempt to sneak through an interface
>>> unnoticed.  It may seem like overkill but this kind of bug is
>>> really hard to track down, and it's better to simply preclude
>>> it from happening.
>>>
>>>> My first instinct would be to change the return type to long long or s64 
>>>> and avoid the use magic #defines...
>>>
>>> I absolutely like using base types (like long long).  But where
>>> those types are used to represent a true abstraction (like a
>>> snapshot id, or a pool id), it is the one place I think the use
>>> of typedefs and "magic #defines" is actually a real help because
>>> it makes explicit you're working with something more than an (e.g.)
>>> an int.  A typedef makes obviously to the reader that it's restricted
>>> a bit (so, for example, it isn't meaningful to do math on it).
>>
>> Completely agreed.
>>
>>> And symbolic constants make it a lot easier to search through
>>> code for special situations like this.
>>
>> Okay with me.  Just keep in mind that most of the other code looks for a 
>> negative int64_t return value (i.e., the pool id is 63 bits).
> 
> I.e., if I do this here but not elsewhere we're subject to
> the same kind of "someday" problems...  In fact, it's just
> a different form of mismatched type--here returning an unsigned
> when elsewhere a signed value is assumed.
> 
> I still like the symbolic values, or in this case, maybe
> a macro ceph_pool_id_valid() or something.  It just makes
> it easier to make other changes later, because you can
> easily (or maybe more precisely) search for the effects
> of a proposed change.
> 
> I find the time spent searching through code is large
> enough that I tend to do things in a way that facilitates
> that.
> 
> Let's talk about this today and come to an agreement
> about the best way to resolve this.
> 
> Thanks.
> 
> 					-Alex
> 
>> The reason there is a mismatch: it used to be a 32-bit value, and at one 
>> point we thought we'd do a pool per radosgw bucket and did a huge 
>> conversion to 64-bit.  And missed a few places.  The whole transition was 
>> ill-conceived and generally a bad idea, though; we should never have that 
>> many pools.  So it's not clear it's worth the effort to spend another 
>> feature bit to fix it up.
>>
>> sage
>>
>>> This stuff is all sort of philosophical rather than technical.
>>> The code before works, and the code as I've changed it works.
>>>
>>> Anybody else have thoughts?
>>>
>>> 					-Alex
>>>>
>>>>
>>>> On Thu, 13 Dec 2012, Alex Elder wrote:
>>>>
>>>>> Currently ceph_pg_poolid_by_name() returns an int, which is used to
>>>>> encode a ceph pool id.  This could be a problem because a pool id
>>>>> (at least in some cases) is a 64-bit value.  We have a defined pool
>>>>> id value that represents "no pool," and that's a very sensible
>>>>> return value here.
>>>>>
>>>>> This patch changes ceph_pg_poolid_by_name() to return a 64-bit
>>>>> pool id value, or CEPH_NOPOOL if the named pool is not found.
>>>>>
>>>>> The patch also gratuitously renames the function, separating "pool"
>>>>> from "id" in the name by an underscore.
>>>>>
>>>>> Signed-off-by: Alex Elder <elder@inktank.com>
>>>>> ---
>>>>>  drivers/block/rbd.c         |    6 +++---
>>>>>  include/linux/ceph/osdmap.h |    2 +-
>>>>>  net/ceph/osdmap.c           |   14 ++++++++------
>>>>>  3 files changed, 12 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>>>> index 4daa400..706824b 100644
>>>>> --- a/drivers/block/rbd.c
>>>>> +++ b/drivers/block/rbd.c
>>>>> @@ -3642,11 +3642,11 @@ static ssize_t rbd_add(struct bus_type *bus,
>>>>>  	ceph_opts = NULL;	/* rbd_dev client now owns this */
>>>>>
>>>>>  	/* pick the pool */
>>>>> +	rc = -ENOENT;
>>>>>  	osdc = &rbdc->client->osdc;
>>>>> -	rc = ceph_pg_poolid_by_name(osdc->osdmap, spec->pool_name);
>>>>> -	if (rc < 0)
>>>>> +	spec->pool_id = ceph_pg_pool_id_by_name(osdc->osdmap, spec->pool_name);
>>>>> +	if (spec->pool_id == CEPH_NOPOOL)
>>>>>  		goto err_out_client;
>>>>> -	spec->pool_id = (u64) rc;
>>>>>
>>>>>  	rbd_dev = rbd_dev_create(rbdc, spec);
>>>>>  	if (!rbd_dev)
>>>>> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
>>>>> index 5ea57ba..c841396 100644
>>>>> --- a/include/linux/ceph/osdmap.h
>>>>> +++ b/include/linux/ceph/osdmap.h
>>>>> @@ -124,6 +124,6 @@ extern int ceph_calc_pg_primary(struct ceph_osdmap
>>>>> *osdmap,
>>>>>  				struct ceph_pg pgid);
>>>>>
>>>>>  extern const char *ceph_pg_pool_name_by_id(struct ceph_osdmap *map, u64
>>>>> id);
>>>>> -extern int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char
>>>>> *name);
>>>>> +extern __u64 ceph_pg_pool_id_by_name(struct ceph_osdmap *map, const
>>>>> char *name);
>>>>>
>>>>>  #endif
>>>>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>>>>> index de73214..27e904e 100644
>>>>> --- a/net/ceph/osdmap.c
>>>>> +++ b/net/ceph/osdmap.c
>>>>> @@ -485,19 +485,21 @@ const char *ceph_pg_pool_name_by_id(struct
>>>>> ceph_osdmap *map, u64 id)
>>>>>  }
>>>>>  EXPORT_SYMBOL(ceph_pg_pool_name_by_id);
>>>>>
>>>>> -int ceph_pg_poolid_by_name(struct ceph_osdmap *map, const char *name)
>>>>> +__u64 ceph_pg_pool_id_by_name(struct ceph_osdmap *map, const char *name)
>>>>>  {
>>>>>  	struct rb_node *rbp;
>>>>>
>>>>>  	for (rbp = rb_first(&map->pg_pools); rbp; rbp = rb_next(rbp)) {
>>>>> -		struct ceph_pg_pool_info *pi =
>>>>> -			rb_entry(rbp, struct ceph_pg_pool_info, node);
>>>>> +		struct ceph_pg_pool_info *pi;
>>>>> +
>>>>> +		pi = rb_entry(rbp, struct ceph_pg_pool_info, node);
>>>>>  		if (pi->name && strcmp(pi->name, name) == 0)
>>>>> -			return pi->id;
>>>>> +			return (__u64) pi->id;
>>>>>  	}
>>>>> -	return -ENOENT;
>>>>> +
>>>>> +	return CEPH_NOPOOL;
>>>>>  }
>>>>> -EXPORT_SYMBOL(ceph_pg_poolid_by_name);
>>>>> +EXPORT_SYMBOL(ceph_pg_pool_id_by_name);
>>>>>
>>>>>  static void __remove_pg_pool(struct rb_root *root, struct
>>>>> ceph_pg_pool_info *pi)
>>>>>  {
>>>>> -- 
>>>>> 1.7.9.5
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>
>>>
> 

