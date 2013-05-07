From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 2/6] rbd: kill rbd_update_mapping_size()
Date: Tue, 07 May 2013 10:41:11 -0500
Message-ID: <51892097.3050407@inktank.com>
References: <51885A97.9070005@inktank.com> <51885AE4.1030209@inktank.com> <5189161C.9070604@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:46918 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143Ab3EGPlO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 May 2013 11:41:14 -0400
Received: by mail-vc0-f173.google.com with SMTP id ht11so648707vcb.32
        for <ceph-devel@vger.kernel.org>; Tue, 07 May 2013 08:41:13 -0700 (PDT)
In-Reply-To: <5189161C.9070604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 05/07/2013 09:56 AM, Josh Durgin wrote:
> Alex Elder <elder@inktank.com> wrote:
> 
>> Since rbd_update_mapping_size() is now a trivial wrapper, just open
>> code it in its two callers.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>> drivers/block/rbd.c |   17 ++++++-----------
>> 1 file changed, 6 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index a0f1fe5..0a24cdf 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -3118,15 +3118,6 @@ static int rbd_read_header(struct rbd_device
>> *rbd_dev,
>>     return ret;
>> }
>>
>> -static void rbd_update_mapping_size(struct rbd_device *rbd_dev)
>> -{
>> -    if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
>> -        return;
>> -
>> -    if (rbd_dev->mapping.size != rbd_dev->header.image_size)
>> -        rbd_dev->mapping.size = rbd_dev->header.image_size;
>> -}
>> -
>> /*
>> * only read the first part of the ondisk header, without the snaps info
>>  */
>> @@ -3143,7 +3134,9 @@ static int rbd_dev_v1_refresh(struct rbd_device
>> *rbd_dev)
>>
>>     /* Update image size, and check for resize of mapped image */
>>     rbd_dev->header.image_size = h.image_size;
>> -    rbd_update_mapping_size(rbd_dev);
>> +    if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
>> +        if (rbd_dev->mapping.size != rbd_dev->header.image_size)
>> +            rbd_dev->mapping.size = rbd_dev->header.image_size;
> 
> Using && instead of two conditions would be a bit cleaner. Maybe you
> have later patches that depend on this though. Open coding looks fine to
> me in any case.

Honestly, that's the way I had it, but I looked at both
and liked this better, I think because the lines ended up
long or something.

I'll take another look before I commit it.

					-Alex


> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
> 
>>
>>     /* rbd_dev->header.object_prefix shouldn't change */
>>     kfree(rbd_dev->header.snap_sizes);
>> @@ -4074,7 +4067,9 @@ static int rbd_dev_v2_refresh(struct rbd_device
>> *rbd_dev)
>>     ret = rbd_dev_v2_image_size(rbd_dev);
>>     if (ret)
>>         goto out;
>> -    rbd_update_mapping_size(rbd_dev);
>> +    if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
>> +        if (rbd_dev->mapping.size != rbd_dev->header.image_size)
>> +            rbd_dev->mapping.size = rbd_dev->header.image_size;
>>
>>     ret = rbd_dev_v2_snap_context(rbd_dev);
>>     dout("rbd_dev_v2_snap_context returned %d\n", ret);
> 

