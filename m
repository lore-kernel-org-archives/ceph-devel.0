From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 2/4] libceph: a per-osdc crush scratch buffer
Date: Mon, 3 Feb 2014 18:53:58 +0200
Message-ID: <CALFYKtAvJFTZHbqVBH2HYFKRo1-42WmtWF=B1UCaOqrO-0S_XA@mail.gmail.com>
References: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
	<1391435228-27874-3-git-send-email-ilya.dryomov@inktank.com>
	<alpine.DEB.2.00.1402030826431.6345@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:61490 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbaBCQx7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 11:53:59 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so11457385qcx.24
        for <ceph-devel@vger.kernel.org>; Mon, 03 Feb 2014 08:53:58 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1402030826431.6345@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 3, 2014 at 6:27 PM, Sage Weil <sage@inktank.com> wrote:
> On Mon, 3 Feb 2014, Ilya Dryomov wrote:
>> With the addition of erasure coding support in the future, scratch
>> variable-length array in crush_do_rule_ary() is going to grow to at
>> least 200 bytes on average, on top of another 128 bytes consumed by
>> rawosd/osd arrays in the call chain.  Replace it with a buffer inside
>> struct osdmap and a mutex.  This shouldn't result in any contention,
>> because all osd requests were already serialized by request_mutex at
>> that point; the only unlocked caller was ceph_ioctl_get_dataloc().
>>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>>  include/linux/ceph/osdmap.h |    3 +++
>>  net/ceph/osdmap.c           |   25 ++++++++++++++++---------
>>  2 files changed, 19 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
>> index 49ff69f0746b..8c8b3cefc28b 100644
>> --- a/include/linux/ceph/osdmap.h
>> +++ b/include/linux/ceph/osdmap.h
>> @@ -84,6 +84,9 @@ struct ceph_osdmap {
>>       /* the CRUSH map specifies the mapping of placement groups to
>>        * the list of osds that store+replicate them. */
>>       struct crush_map *crush;
>> +
>> +     struct mutex crush_scratch_mutex;
>> +     int crush_scratch_ary[CEPH_PG_MAX_SIZE * 3];
>
> There are no users for CEPH_PG_MAX_SIZE (16) in the userland code.  I
> would stick in a BUG_ON or WARN_ON just to make sure we don't get an
> OSDMap with more OSDs than that.

That IMO should be a separate patch.  This patch doesn't change
existing semantics: CEPH_PG_MAX_SIZE is used throughout libceph to size
osd arrays.  I'm not sure what happens if we get an osdmap wider than
16, but this buffer isn't overflown.  See the BUG_ON below.

>
>>  };
>>
>>  static inline void ceph_oid_set_name(struct ceph_object_id *oid,
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index aade4a5c1c07..9d1aaa24def6 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -698,7 +698,9 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
>>       map = kzalloc(sizeof(*map), GFP_NOFS);
>>       if (map == NULL)
>>               return ERR_PTR(-ENOMEM);
>> +
>>       map->pg_temp = RB_ROOT;
>> +     mutex_init(&map->crush_scratch_mutex);
>>
>>       ceph_decode_16_safe(p, end, version, bad);
>>       if (version > 6) {
>> @@ -1142,14 +1144,20 @@ int ceph_oloc_oid_to_pg(struct ceph_osdmap *osdmap,
>>  }
>>  EXPORT_SYMBOL(ceph_oloc_oid_to_pg);
>>
>> -static int crush_do_rule_ary(const struct crush_map *map, int ruleno, int x,
>> -                          int *result, int result_max,
>> -                          const __u32 *weight, int weight_max)
>> +static int do_crush(struct ceph_osdmap *map, int ruleno, int x,
>> +                 int *result, int result_max,
>> +                 const __u32 *weight, int weight_max)
>>  {
>> -     int scratch[result_max * 3];
>> +     int r;
>> +
>> +     BUG_ON(result_max > CEPH_PG_MAX_SIZE);

This BUG_ON.

Thanks,

                Ilya
