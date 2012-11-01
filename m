From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 6/6] rbd: probe the parent of an image if present
Date: Thu, 01 Nov 2012 07:26:39 -0500
Message-ID: <50926A7F.6080309@inktank.com>
References: <509081C4.3050402@inktank.com> <509083D0.1060003@inktank.com> <5091D954.70708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38632 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab2KAM0l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 08:26:41 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3476572iea.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 05:26:41 -0700 (PDT)
In-Reply-To: <5091D954.70708@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 10/31/2012 09:07 PM, Josh Durgin wrote:
> This all makes sense, but it reminds me of another issue we'll need to
> address:
> 
> http://www.tracker.newdream.net/issues/2533

I was not aware of that one.  That's no good.

> We don't need to watch the header of a parent snapshot, since it's
> immutable and guaranteed not to be deleted out from under us.
> This avoids the bug referenced above. So I guess rbd_dev_probe{_finish}
> can take a parameter telling them whether to watch the header or not.

Yes, I've been holding off fixing this for the time being, keeping
all types of image equal as much as possible and then refining it
after I've got more functionality completed.

I was thinking of having the parent image rbd_dev have a pointer
to the child for this purpose (as well as helping debug in the
event of a crash).  This pointer would become a list (empty for
the initially-mapped image) at the point we implement shared
parent images.

> We should check whether multiple mapped rbds (without layering) hit
> this issue as well, and if so, default to not sharing the ceph_client
> until the bug is fixed.

I'm not sure what precisely a rados_cluster_t represents but if
you can help me get a test defined for this I could check it out.

In the mean time we can hold off on committing this last patch
if you like.

					-Alex

> On 10/30/2012 06:50 PM, Alex Elder wrote:
>> Call the probe function for the parent device.
>>
>> Signed-off-by: Alex Elder <elder@inktank.com>
>> ---
>>   drivers/block/rbd.c |   79
>> +++++++++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 76 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 04062c1..8ef13f72 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -222,6 +222,7 @@ struct rbd_device {
>>
>>       struct rbd_spec        *parent_spec;
>>       u64            parent_overlap;
>> +    struct rbd_device    *parent;
>>
>>       /* protects updating the header */
>>       struct rw_semaphore     header_rwsem;
>> @@ -255,6 +256,7 @@ static ssize_t rbd_add(struct bus_type *bus, const
>> char *buf,
>>                  size_t count);
>>   static ssize_t rbd_remove(struct bus_type *bus, const char *buf,
>>                 size_t count);
>> +static int rbd_dev_probe(struct rbd_device *rbd_dev);
>>
>>   static struct bus_attribute rbd_bus_attrs[] = {
>>       __ATTR(add, S_IWUSR, NULL, rbd_add),
>> @@ -378,6 +380,13 @@ out_opt:
>>       return ERR_PTR(ret);
>>   }
>>
>> +static struct rbd_client *__rbd_get_client(struct rbd_client *rbdc)
>> +{
>> +    kref_get(&rbdc->kref);
>> +
>> +    return rbdc;
>> +}
>> +
>>   /*
>>    * Find a ceph client with specific addr and configuration.  If
>>    * found, bump its reference count.
>> @@ -393,7 +402,8 @@ static struct rbd_client *rbd_client_find(struct
>> ceph_options *ceph_opts)
>>       spin_lock(&rbd_client_list_lock);
>>       list_for_each_entry(client_node, &rbd_client_list, node) {
>>           if (!ceph_compare_options(ceph_opts, client_node->client)) {
>> -            kref_get(&client_node->kref);
>> +            __rbd_get_client(client_node);
>> +
>>               found = true;
>>               break;
>>           }
>> @@ -3311,6 +3321,11 @@ static int rbd_dev_image_id(struct rbd_device
>> *rbd_dev)
>>       void *response;
>>       void *p;
>>
>> +    /* If we already have it we don't need to look it up */
>> +
>> +    if (rbd_dev->spec->image_id)
>> +        return 0;
>> +
>>       /*
>>        * When probing a parent image, the image id is already
>>        * known (and the image name likely is not).  There's no
>> @@ -3492,6 +3507,9 @@ out_err:
>>
>>   static int rbd_dev_probe_finish(struct rbd_device *rbd_dev)
>>   {
>> +    struct rbd_device *parent = NULL;
>> +    struct rbd_spec *parent_spec = NULL;
>> +    struct rbd_client *rbdc = NULL;
>>       int ret;
>>
>>       /* no need to lock here, as rbd_dev is not registered yet */
>> @@ -3536,6 +3554,31 @@ static int rbd_dev_probe_finish(struct rbd_device
>> *rbd_dev)
>>        * At this point cleanup in the event of an error is the job
>>        * of the sysfs code (initiated by rbd_bus_del_dev()).
>>        */
>> +    /* Probe the parent if there is one */
>> +
>> +    if (rbd_dev->parent_spec) {
>> +        /*
>> +         * We need to pass a reference to the client and the
>> +         * parent spec when creating the parent rbd_dev.
>> +         * Images related by parent/child relationships
>> +         * always share both.
>> +         */
>> +        parent_spec = rbd_spec_get(rbd_dev->parent_spec);
>> +        rbdc = __rbd_get_client(rbd_dev->rbd_client);
>> +
>> +        parent = rbd_dev_create(rbdc, parent_spec);
>> +        if (!parent) {
>> +            ret = -ENOMEM;
>> +            goto err_out_spec;
>> +        }
>> +        rbdc = NULL;        /* parent now owns reference */
>> +        parent_spec = NULL;    /* parent now owns reference */
>> +        ret = rbd_dev_probe(parent);
>> +        if (ret < 0)
>> +            goto err_out_parent;
>> +        rbd_dev->parent = parent;
>> +    }
>> +
>>       down_write(&rbd_dev->header_rwsem);
>>       ret = rbd_dev_snaps_register(rbd_dev);
>>       up_write(&rbd_dev->header_rwsem);
>> @@ -3554,6 +3597,12 @@ static int rbd_dev_probe_finish(struct rbd_device
>> *rbd_dev)
>>           (unsigned long long) rbd_dev->mapping.size);
>>
>>       return ret;
>> +
>> +err_out_parent:
>> +    rbd_dev_destroy(parent);
>> +err_out_spec:
>> +    rbd_spec_put(parent_spec);
>> +    rbd_put_client(rbdc);
>>   err_out_bus:
>>       /* this will also clean up rest of rbd_dev stuff */
>>
>> @@ -3717,6 +3766,12 @@ static void rbd_dev_release(struct device *dev)
>>       module_put(THIS_MODULE);
>>   }
>>
>> +static void __rbd_remove(struct rbd_device *rbd_dev)
>> +{
>> +    rbd_remove_all_snaps(rbd_dev);
>> +    rbd_bus_del_dev(rbd_dev);
>> +}
>> +
>>   static ssize_t rbd_remove(struct bus_type *bus,
>>                 const char *buf,
>>                 size_t count)
>> @@ -3743,8 +3798,26 @@ static ssize_t rbd_remove(struct bus_type *bus,
>>           goto done;
>>       }
>>
>> -    rbd_remove_all_snaps(rbd_dev);
>> -    rbd_bus_del_dev(rbd_dev);
>> +    while (rbd_dev->parent_spec) {
>> +        struct rbd_device *first = rbd_dev;
>> +        struct rbd_device *second = first->parent;
>> +        struct rbd_device *third;
>> +
>> +        /*
>> +         * Follow to the parent with no grandparent and
>> +         * remove it.
>> +         */
>> +        while (second && (third = second->parent)) {
>> +            first = second;
>> +            second = third;
>> +        }
>> +        __rbd_remove(second);
>> +        rbd_spec_put(first->parent_spec);
>> +        first->parent_spec = NULL;
>> +        first->parent_overlap = 0;
>> +        first->parent = NULL;
>> +    }
>> +    __rbd_remove(rbd_dev);
>>
>>   done:
>>       mutex_unlock(&ctl_mutex);
>>
> 

