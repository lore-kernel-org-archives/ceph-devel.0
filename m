From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: fix a bug in resizing a mapping
Date: Tue, 30 Apr 2013 11:48:35 -0700
Message-ID: <51801203.4050406@inktank.com>
References: <517BC21F.4030002@inktank.com> <517BC6EE.7020502@inktank.com> <517EB308.6020503@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:40608 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760835Ab3D3Sta (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 14:49:30 -0400
Received: by mail-pb0-f50.google.com with SMTP id um15so400374pbc.37
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 11:49:29 -0700 (PDT)
In-Reply-To: <517EB308.6020503@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 04/29/2013 10:51 AM, Alex Elder wrote:
> On 04/27/2013 07:39 AM, Alex Elder wrote:
>> On 04/27/2013 07:18 AM, Alex Elder wrote:
>>> When a snapshot context update occurs, rbd_update_mapping_size() is
>>> called to set the capacity of the disk to record the updated
>>> size of the image in case it has changed.

This patch looks good.
Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

>>> There's a bug though.  The mapping size is in units of *bytes*.  The
>>> code that updates the mapping size field is assigning a value that
>>> has been scaled down to *sectors*.
>>>
>>> Fix that.  Also, check to see if the size has actually changed, and
>>> don't bother updating things (specifically, calling set_capacity())
>>> if it has not.
>>>
>>> This resolves:
>>>      http://tracker.ceph.com/issues/4833
>>>
>>> Signed-off-by: Alex Elder <elder@inktank.com>
>>> ---
>>>   drivers/block/rbd.c |   14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index 5918e0b..37d9349 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>>> @@ -3034,15 +3034,17 @@ static void rbd_remove_all_snaps(struct
>>> rbd_device *rbd_dev)
>>>
>>>   static void rbd_update_mapping_size(struct rbd_device *rbd_dev)
>>>   {
>>> -	sector_t size;
>>> -
>>>   	if (rbd_dev->spec->snap_id != CEPH_NOSNAP)
>>>   		return;
>>>
>>> -	size = (sector_t) rbd_dev->header.image_size / SECTOR_SIZE;
>>> -	dout("setting size to %llu sectors", (unsigned long long) size);
>>> -	rbd_dev->mapping.size = (u64) size;
>>> -	set_capacity(rbd_dev->disk, size);
>>> +	if (rbd_dev->mapping.size != rbd_dev->header.image_size) {
>>> +		sector_t size;
>>> +
>>> +		rbd_dev->mapping.size = rbd_dev->header.image_size;
>>> +		size = (sector_t)rbd_dev->mapping.size / SECTOR_SIZE;
>>> +		dout("setting size to %llu sectors", (unsigned long long)size);
>>> +		set_capacity(rbd_dev->disk, size);
>>> +	}
>>>   }
>>>
>>>   /*
>>>
>>
>

