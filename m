From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 22/33] libceph: primary_affinity decode bits
Date: Fri, 28 Mar 2014 17:01:24 +0200
Message-ID: <CALFYKtDn-F4bjyj-evq+MJE1mAaGAawyVmFDx6dWyEvz_oaeZA@mail.gmail.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
	<1395944299-21970-23-git-send-email-ilya.dryomov@inktank.com>
	<53348AA1.2030806@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:37117 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760AbaC1PBq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Mar 2014 11:01:46 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so4500354qgd.15
        for <ceph-devel@vger.kernel.org>; Fri, 28 Mar 2014 08:01:45 -0700 (PDT)
In-Reply-To: <53348AA1.2030806@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Mar 27, 2014 at 10:31 PM, Alex Elder <elder@ieee.org> wrote:
> On 03/27/2014 01:18 PM, Ilya Dryomov wrote:
>> Add two helpers to decode primary_affinity (full map, vector<u32>) and
>> new_primary_affinity (inc map, map<u32, u32>) and switch to them.
>
> One comment below, but otherwise looks good.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>>
>> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
>> ---
>>  net/ceph/osdmap.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 71 insertions(+)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index 538b8dd341e8..3ac2098972ea 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -959,6 +959,59 @@ static int set_primary_affinity(struct ceph_osdmap *map, int osd, u32 aff)
>>       return 0;
>>  }
>>
>> +static int decode_primary_affinity(void **p, void *end,
>> +                                struct ceph_osdmap *map)
>> +{
>> +     u32 len, i;
>> +
>> +     ceph_decode_32_safe(p, end, len, e_inval);
>> +     if (len == 0) {
>> +             kfree(map->osd_primary_affinity);
>> +             map->osd_primary_affinity = NULL;
>> +             return 0;
>> +     }
>> +
>> +     ceph_decode_need(p, end, map->max_osd*sizeof(u32), e_inval);
>> +
>> +     BUG_ON(len != map->max_osd);
>
> BUG() here is too much; it should I think just return an error instead.
> The test could be done earlier too, prior to ceph_decode_need().

Moved the test, changed to returning -EINVAL.

Thanks,

                Ilya
