From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH] rbd: do not allow remove of mounted-on image
Date: Fri, 16 Nov 2012 23:22:39 -0600
Message-ID: <50A71F1F.3050708@inktank.com>
References: <50A65F15.6080807@inktank.com> <50A6BDB7.8080001@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:35681 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab2KQFWn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 00:22:43 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so2191554iay.19
        for <ceph-devel@vger.kernel.org>; Fri, 16 Nov 2012 21:22:42 -0800 (PST)
In-Reply-To: <50A6BDB7.8080001@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 11/16/2012 04:27 PM, Josh Durgin wrote:
> On 11/16/2012 07:43 AM, Alex Elder wrote:
>> There is no check in rbd_remove() to see if anybody holds ope the
>> image being removed.  That's not cool.
>>
>> Add a simple open count that goes up and down with opens and closes
>> (releases) of the device, and don't allow an rbd image to be removed
>> if the count is non-zero.  Both functions are protected by the
>> bd_mutex so there's no need for any other concurrency protection.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |    9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index fba0822..9d9a2f3 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -255,6 +255,7 @@ struct rbd_device {
>>
>>       /* sysfs related */
>>       struct device        dev;
>> +    unsigned long        open_count;
>>   };
>>
>>   static DEFINE_MUTEX(ctl_mutex);      /* Serialize
>> open/close/setup/teardown */
>> @@ -358,6 +359,7 @@ static int rbd_open(struct block_device *bdev,
>> fmode_t mode)
>>
>>       rbd_get_dev(rbd_dev);
>>       set_device_ro(bdev, rbd_dev->mapping.read_only);
>> +    rbd_dev->open_count++;
>>
>>       return 0;
>>   }
>> @@ -366,6 +368,8 @@ static int rbd_release(struct gendisk *disk, fmode_t
>> mode)
>>   {
>>       struct rbd_device *rbd_dev = disk->private_data;
>>
>> +    rbd_assert(rbd_dev->open_count > 0);
>> +    rbd_dev->open_count--;
>>       rbd_put_dev(rbd_dev);
>>
>>       return 0;
>> @@ -3764,6 +3768,11 @@ static ssize_t rbd_remove(struct bus_type *bus,
>>           goto done;
>>       }
>>
>> +    if (rbd_dev->open_count) {
>> +        ret = -EBUSY;
>> +        goto done;
>> +    }
>> +
> 
> Is this protected by bd_mutex?

No it's not, and that's a very good point.

I'll have to look at that over the weekend.
Thanks.

					-Alex


>>       rbd_remove_all_snaps(rbd_dev);
>>       rbd_bus_del_dev(rbd_dev);
>>
> 

