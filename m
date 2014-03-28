From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 31/33] libceph: add support for osd primary affinity
Date: Fri, 28 Mar 2014 17:03:23 +0200
Message-ID: <CALFYKtC9wzxCPHC--=ueoSCEnWZu1w5UjX5HKJsiM85Vp=hQYg@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-32-git-send-email-ilya.dryomov@inktank.com>
	<5334914D.5000407@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:44431 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbaC1PDX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 11:03:23 -0400
Received: by mail-qa0-f47.google.com with SMTP id w5so5316754qac.20
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 08:03:23 -0700 (PDT)
In-Reply-To: <5334914D.5000407@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 10:59 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
>> Respond to non-default primary_affinity values accordingly.  (Primary
>> affinity allows the admin to shift 'primary responsibility' away from
>> specific osds, effectively shifting around the read side of the
>> workload and whatever overhead is incurred by peering and writes by
>> virtue of being the primary).
>
> The code looks good, I presume it matches the algorithm.
> I have a few questions below but nothing serious.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>>  net/ceph/osdmap.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 68 insertions(+)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index ed52b47d0ddb..8c596a13c60f 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -1589,6 +1589,72 @@ static int raw_to_up_osds(struct ceph_osdmap *osdmap,
>>       return len;
>>  }
>>
>> +static void apply_primary_affinity(struct ceph_osdmap *osdmap, u32 pps,
>> +                                struct ceph_pg_pool_info *pool,
>> +                                int *osds, int len, int *primary)
>> +{
>> +     int i;
>> +     int pos = -1;
>> +
>> +     /*
>> +      * Do we have any non-default primary_affinity values for these
>> +      * osds?
>> +      */
>> +     if (!osdmap->osd_primary_affinity)
>> +             return;
>> +
>> +     for (i = 0; i < len; i++) {
>> +             if (osds[i] != CRUSH_ITEM_NONE &&
>> +                 osdmap->osd_primary_affinity[i] !=
>> +                                     CEPH_OSD_DEFAULT_PRIMARY_AFFINITY) {
>> +                     break;
>> +             }
>> +     }
>> +     if (i == len)
>> +             return;
>
> So if they're all DEFAULT_AFFINITY they you don't bother.

Exactly.

>
> I'm trying to understand what happens if at least one is
> DEFAULT and at least one is not DEFAULT.
>
>> +
>> +     /*
>> +      * Pick the primary.  Feed both the seed (for the pg) and the
>> +      * osd into the hash/rng so that a proportional fraction of an
>> +      * osd's pgs get rejected as primary.
>> +      */
>> +     for (i = 0; i < len; i++) {
>> +             int o;
>> +             u32 a;
>
> Maybe "osd" and "aff" for osd number and affinity values?

Done.

>
>> +
>> +             o = osds[i];
>> +             if (o == CRUSH_ITEM_NONE)
>> +                     continue;
>> +
>> +             a = osdmap->osd_primary_affinity[o];
>> +             if (a < CEPH_OSD_MAX_PRIMARY_AFFINITY &&
>
> So CEPH_OSD_MAX_PRIMARY_AFFINITY is actually one more than
> the maximum allowed value, right?

No, like I mentioned in my reply to another patch, primary affinity is
very similar to osd weights.  Conceptually, it's a floating point
value, [0..1].  If it's 1 (DEFAULT, and also MAX) crush output is left
intact and the first osd in the up set is primary.  If it's less than
1, a different osd in the up set is "preferred" for the primary role,
with appropriate probability.  If it's 0, that osd will never be
primary, not for a single pg, if possible of course.

And, similar to osd weights, primary affinity is serialized to a fixed
point value, [0..0x10000].  0x10000 === 1, hence the if (a < MAX).

>
>> +                 (crush_hash32_2(CRUSH_HASH_RJENKINS1,
>> +                                 pps, o) >> 16) >= a) {
>> +                     /*
>> +                      * We chose not to use this primary.  Note it
>> +                      * anyway as a fallback in case we don't pick
>> +                      * anyone else, but keep looking.
>> +                      */
>> +                     if (pos < 0)
>> +                             pos = i;
>> +             } else {
>> +                     pos = i;
>> +                     break;
>> +             }
>> +     }
>> +     if (pos < 0)
>> +             return;
>> +
>> +     *primary = osds[pos];
>> +
>> +     if (ceph_can_shift_osds(pool) && pos > 0) {
>> +             /* move the new primary to the front */
>> +             for (i = pos; i > 0; i--)
>> +                     osds[i] = osds[i - 1];
>> +             osds[0] = *primary;
>> +     }
>
> So the first one *is* the primary, you just renumber them.
> I see.

Yeah, we still move it to the front, for replicated pgs.  However, if
primary_temp mapping for that pg exists, the primary will be whatever
that mapping says it is, and at that point osds won't be reshuffled no
matter what.

Thanks,

                Ilya
