From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/4] rbd: allocate image requests with a slab allocator
Date: Thu, 02 May 2013 11:28:56 -0500
Message-ID: <51829448.5070500@inktank.com>
References: <51818A5C.1080903@inktank.com> <51818AA5.6070200@inktank.com> <5182921B.7000900@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f42.google.com ([209.85.212.42]:45021 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758073Ab3EBQ26 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 May 2013 12:28:58 -0400
Received: by mail-vb0-f42.google.com with SMTP id w16so632920vbf.1
        for <ceph-devel@vger.kernel.org>; Thu, 02 May 2013 09:28:57 -0700 (PDT)
In-Reply-To: <5182921B.7000900@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 05/02/2013 11:19 AM, Josh Durgin wrote:
> It looks like the GFP flags used throughout request creation
> could be cleanup up (there's a mix of ATOMIC, KERNEL, and NOIO).
> I just noticed since this changes a GFP_ATOMIC to GFP_KERNEL.
> Making them consistent can be a later patch though.

Well that was unintentional--a copy-paste with haste error.

But yes, I've already got a bug open on that.

    http://tracker.ceph.com/issues/4233

> Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
> 
> On 05/01/2013 02:35 PM, Alex Elder wrote:
>> Create a slab cache to manage rbd_img_request allocation.  Nothing
>> too fancy at this point--we'll still initialize everything at
>> allocation time (no constructor)
>>
>> This is part of:
>>      http://tracker.ceph.com/issues/3926
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |   39 ++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 34 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index a6e5fe3..005c397 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -40,6 +40,7 @@
>>   #include <linux/module.h>
>>   #include <linux/fs.h>
>>   #include <linux/blkdev.h>
>> +#include <linux/slab.h>
>>
>>   #include "rbd_types.h"
>>
>> @@ -344,6 +345,8 @@ static DEFINE_SPINLOCK(rbd_dev_list_lock);
>>   static LIST_HEAD(rbd_client_list);        /* clients */
>>   static DEFINE_SPINLOCK(rbd_client_list_lock);
>>
>> +static struct kmem_cache    *rbd_img_request_cache;
>> +
>>   static int rbd_img_request_submit(struct rbd_img_request *img_request);
>>
>>   static void rbd_dev_device_release(struct device *dev);
>> @@ -1821,7 +1824,7 @@ static struct rbd_img_request
>> *rbd_img_request_create(
>>   {
>>       struct rbd_img_request *img_request;
>>
>> -    img_request = kmalloc(sizeof (*img_request), GFP_ATOMIC);
>> +    img_request = kmem_cache_alloc(rbd_img_request_cache, GFP_KERNEL);
>>       if (!img_request)
>>           return NULL;
>>
>> @@ -1884,7 +1887,7 @@ static void rbd_img_request_destroy(struct kref
>> *kref)
>>       if (img_request_child_test(img_request))
>>           rbd_obj_request_put(img_request->obj_request);
>>
>> -    kfree(img_request);
>> +    kmem_cache_free(rbd_img_request_cache, img_request);
>>   }
>>
>>   static bool rbd_img_obj_end_request(struct rbd_obj_request
>> *obj_request)
>> @@ -4992,6 +4995,26 @@ static void rbd_sysfs_cleanup(void)
>>       device_unregister(&rbd_root_dev);
>>   }
>>
>> +static int rbd_slab_init(void)
>> +{
>> +    rbd_assert(!rbd_img_request_cache);
>> +    rbd_img_request_cache = kmem_cache_create("rbd_img_request",
>> +                    sizeof (struct rbd_img_request),
>> +                    __alignof__(struct rbd_img_request),
>> +                    0, NULL);
>> +    if (rbd_img_request_cache)
>> +        return 0;
>> +
>> +    return -ENOMEM;
>> +}
>> +
>> +static void rbd_slab_exit(void)
>> +{
>> +    rbd_assert(rbd_img_request_cache);
>> +    kmem_cache_destroy(rbd_img_request_cache);
>> +    rbd_img_request_cache = NULL;
>> +}
>> +
>>   static int __init rbd_init(void)
>>   {
>>       int rc;
>> @@ -5001,16 +5024,22 @@ static int __init rbd_init(void)
>>
>>           return -EINVAL;
>>       }
>> -    rc = rbd_sysfs_init();
>> +    rc = rbd_slab_init();
>>       if (rc)
>>           return rc;
>> -    pr_info("loaded " RBD_DRV_NAME_LONG "\n");
>> -    return 0;
>> +    rc = rbd_sysfs_init();
>> +    if (rc)
>> +        rbd_slab_exit();
>> +    else
>> +        pr_info("loaded " RBD_DRV_NAME_LONG "\n");
>> +
>> +    return rc;
>>   }
>>
>>   static void __exit rbd_exit(void)
>>   {
>>       rbd_sysfs_cleanup();
>> +    rbd_slab_exit();
>>   }
>>
>>   module_init(rbd_init);
>>
> 

