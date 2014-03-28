From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 21/33] libceph: primary_affinity infrastructure
Date: Fri, 28 Mar 2014 17:01:03 +0200
Message-ID: <CALFYKtCmSZZLy+k7_M25tTf3KjoZRvyZiGD1Ka-NUznYJGrV0w@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-22-git-send-email-ilya.dryomov@inktank.com>
	<53348982.9010707@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:60623 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbaC1PBF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 11:01:05 -0400
Received: by mail-qa0-f54.google.com with SMTP id w8so5276901qac.41
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 08:01:03 -0700 (PDT)
In-Reply-To: <53348982.9010707@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 10:26 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
>> Add primary_affinity infrastructure.  primary_affinity values are
>> stored in an max_osd-sized array, hanging off ceph_osdmap, similar to
>> a osd_weight array.
>>
>> Introduce {get,set}_primary_affinity() helpers, primarily to return
>> CEPH_OSD_DEFAULT_PRIMARY_AFFINITY when no affinity has been set and to
>> abstract out osd_primary_affinity array allocation and initialization.
>
> One comment about some constant definitions, but
> this looks good.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>>  include/linux/ceph/osdmap.h |    3 +++
>>  include/linux/ceph/rados.h  |    4 ++++
>>  net/ceph/debugfs.c          |    5 +++--
>>  net/ceph/osdmap.c           |   47 +++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 57 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
>> index db4fb6322aae..6e030cb3c9ca 100644
>> --- a/include/linux/ceph/osdmap.h
>> +++ b/include/linux/ceph/osdmap.h
>> @@ -88,6 +88,8 @@ struct ceph_osdmap {
>>       struct rb_root pg_temp;
>>       struct rb_root primary_temp;
>>
>> +     u32 *osd_primary_affinity;
>> +
>>       struct rb_root pg_pools;
>>       u32 pool_max;
>>
>> @@ -134,6 +136,7 @@ static inline bool ceph_osdmap_flag(struct ceph_osdmap *map, int flag)
>>  }
>>
>>  extern char *ceph_osdmap_state_str(char *str, int len, int state);
>> +extern u32 ceph_get_primary_affinity(struct ceph_osdmap *map, int osd);
>>
>>  static inline struct ceph_entity_addr *ceph_osd_addr(struct ceph_osdmap *map,
>>                                                    int osd)
>> diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
>> index 2caabef8d369..bb6f40c9cb0f 100644
>> --- a/include/linux/ceph/rados.h
>> +++ b/include/linux/ceph/rados.h
>> @@ -133,6 +133,10 @@ extern const char *ceph_osd_state_name(int s);
>>  #define CEPH_OSD_IN  0x10000
>>  #define CEPH_OSD_OUT 0
>>
>> +/* osd primary-affinity.  fixed point value: 0x10000 == baseline */
>> +#define CEPH_OSD_MAX_PRIMARY_AFFINITY 0x10000
>> +#define CEPH_OSD_DEFAULT_PRIMARY_AFFINITY 0x10000
>> +
>
> It seems like these definitions may also belong in a
> common header file.  However I know that in some cases
> it's necessary to impose limits in the kernel where
> none is enforced in user space.

They are in a common header - linux/ceph/rados.h - and come from
userspace.  Primary affinity is somewhat similar to osd_weight values.

Thanks,

                Ilya
