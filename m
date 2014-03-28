From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 28/33] libceph: switch ceph_calc_pg_acting() to new helpers
Date: Fri, 28 Mar 2014 17:02:10 +0200
Message-ID: <CALFYKtD14erng=5LLTVMwYsSgkz9G-jxqcD-SYNC9eUnSakaAQ@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-29-git-send-email-ilya.dryomov@inktank.com>
	<53348EC6.1070504@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:52313 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839AbaC1PCL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 11:02:11 -0400
Received: by mail-qc0-f175.google.com with SMTP id e16so5974257qcx.6
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 08:02:10 -0700 (PDT)
In-Reply-To: <53348EC6.1070504@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 10:49 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
>> Switch ceph_calc_pg_acting() to new helpers: pg_to_raw_osds(),
>> raw_to_up_osds() and apply_temps().
>
> So that's why you have a temp map in each osdmap.
> The result is pretty clean and you eliminate the
> local rawosds array.
>
> Looks good.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>>  include/linux/ceph/osdmap.h |    2 +-
>>  net/ceph/osdmap.c           |   51 ++++++++++++++++++++++++++++++++-----------
>>  2 files changed, 39 insertions(+), 14 deletions(-)
>>
>> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
>> index 4e28c1e5d62f..b0c8f8490663 100644
>> --- a/include/linux/ceph/osdmap.h
>> +++ b/include/linux/ceph/osdmap.h
>> @@ -212,7 +212,7 @@ extern int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
>>
>>  extern int ceph_calc_pg_acting(struct ceph_osdmap *osdmap,
>>                              struct ceph_pg pgid,
>> -                            int *acting);
>> +                            int *osds);
>>  extern int ceph_calc_pg_primary(struct ceph_osdmap *osdmap,
>>                               struct ceph_pg pgid);
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 6d418433d80d..1963623bd488 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -1642,24 +1642,49 @@ static int apply_temps(struct ceph_osdmap *osdmap,
>>  }
>>
>>  /*
>> - * Return acting set for given pgid.
>> + * Calculate acting set for given pgid.
>> + *
>> + * Return acting set length, or error.
>>   */
>>  int ceph_calc_pg_acting(struct ceph_osdmap *osdmap, struct ceph_pg pgid,
>> -                     int *acting)
>> +                     int *osds)
>>  {
>> -     int rawosds[CEPH_PG_MAX_SIZE], *osds;
>> -     int i, o, num = CEPH_PG_MAX_SIZE;
>> +     struct ceph_pg_pool_info *pool;
>> +     u32 pps;
>> +     int len;
>> +     int primary;
>>
>> -     osds = calc_pg_raw(osdmap, pgid, rawosds, &num);
>> -     if (!osds)
>> -             return -1;
>> +     pool = __lookup_pg_pool(&osdmap->pg_pools, pgid.pool);
>> +     if (!pool)
>> +             return 0;
>>
>> -     /* primary is first up osd */
>> -     o = 0;
>> -     for (i = 0; i < num; i++)
>> -             if (ceph_osd_is_up(osdmap, osds[i]))
>> -                     acting[o++] = osds[i];
>> -     return o;
>> +     if (pool->flags & CEPH_POOL_FLAG_HASHPSPOOL) {
>> +             /* hash pool id and seed so that pool PGs do not overlap */
>> +             pps = crush_hash32_2(CRUSH_HASH_RJENKINS1,
>> +                                  ceph_stable_mod(pgid.seed, pool->pgp_num,
>> +                                                  pool->pgp_num_mask),
>> +                                  pgid.pool);
>> +     } else {
>> +             /*
>> +              * legacy ehavior: add ps and pool together.  this is
>
> Typo "behavior"

Fixed.

Thanks,

                Ilya
