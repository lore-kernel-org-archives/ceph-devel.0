From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/2] rbd: define flags field, use it for exists flag
Date: Tue, 15 Jan 2013 17:08:55 -0800
Message-ID: <50F5FDA7.6040509@inktank.com>
References: <50F4535A.6030601@inktank.com> <50F4538B.4010106@inktank.com> <50F46B40.9010907@inktank.com> <50F4776F.2080407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f41.google.com ([209.85.210.41]:58887 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756811Ab3APBKF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 20:10:05 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so302839dak.14
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 17:10:04 -0800 (PST)
In-Reply-To: <50F4776F.2080407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/14/2013 01:23 PM, Alex Elder wrote:
> On 01/14/2013 02:32 PM, Dan Mick wrote:
>> I see that set_bit is atomic, but I don't see that test_bit is.  Am I
>> missing a subtlety?
>
> That's an interesting observation.  I'm certain it's safe, but
> I needed to research it a bit, and I still haven't verified it
> to my satisfaction.
>
> I *think* (but please look over the following and see if you
> come to the same conclusion) that this operation doesn't need
> to be made atomic, because the implementation of the routines
> that implement the "set" operations guarantee their effects are
> visible once they are done.
>
> But I'm not sure whether "visible" here means precisely that
> another CPU will be forced to go read the updated memory when
> it calls test_bit().
>
> http://www.kernel.org/doc/Documentation/atomic_ops.txt
> The section of interest can be found by looking for the
> sentence I'm talking about:
>    Likewise, the atomic bit operation must be visible globally before any
>    subsequent memory operation is made visible.

I read that differently. I think that only applies to the test_and_set 
style operations mentioned directly above, not set_bit.

Documentation/memory-barriers.txt confirms this interpretation:

     The following operations are potential problems as they do
     _not_ imply memory barriers, but might be used for
     implementing such things as UNLOCK-class operations:

             atomic_set();
             set_bit();
             clear_bit();
             change_bit();

     With these the appropriate explicit memory barrier should be
     used if necessary (smp_mb__before_clear_bit() for instance).

And:

     Memory operations that occur after an UNLOCK operation may appear to
     happen before it completes.

So I think we need a memory barrier before and after set_bit for the
removing flag, but we don't need barriers for the exists flag, since
it's a best-effort value that can't stop already-in-flight requests.

Josh

> It doesn't come right and explain it though.  Please let me
> know what you think.
>
> 					-Alex
>
>
>> On 01/14/2013 10:50 AM, Alex Elder wrote:
>>> Define a new rbd device flags field, manipulated using atomic bit
>>> operations.  Replace the use of the current "exists" flag with a
>>> bit in this new "flags" field.
>>>
>>> Signed-off-by: Alex Elder <elder@inktank.com>
>>> ---
>>>    drivers/block/rbd.c |   17 ++++++++++++-----
>>>    1 file changed, 12 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index 02002b1..9eb1631 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>>> @@ -232,7 +232,7 @@ struct rbd_device {
>>>        spinlock_t        lock;        /* queue lock */
>>>
>>>        struct rbd_image_header    header;
>>> -    atomic_t        exists;
>>> +    unsigned long        flags;
>>>        struct rbd_spec        *spec;
>>>
>>>        char            *header_name;
>>> @@ -260,6 +260,12 @@ struct rbd_device {
>>>        unsigned long        open_count;
>>>    };
>>>
>>> +/* Flag bits for rbd_dev->flags */
>>> +
>>> +enum rbd_dev_flags {
>>> +    rbd_dev_flag_exists,    /* mapped snapshot has not been deleted */
>>> +};
>>> +
>>>    static DEFINE_MUTEX(ctl_mutex);      /* Serialize
>>> open/close/setup/teardown */
>>>
>>>    static LIST_HEAD(rbd_dev_list);    /* devices */
>>> @@ -756,7 +762,8 @@ static int rbd_dev_set_mapping(struct rbd_device
>>> *rbd_dev)
>>>                goto done;
>>>            rbd_dev->mapping.read_only = true;
>>>        }
>>> -    atomic_set(&rbd_dev->exists, 1);
>>> +    set_bit(rbd_dev_flag_exists, &rbd_dev->flags);
>>> +
>>>    done:
>>>        return ret;
>>>    }
>>> @@ -1654,7 +1661,7 @@ static void rbd_rq_fn(struct request_queue *q)
>>>                snapc = ceph_get_snap_context(rbd_dev->header.snapc);
>>>                up_read(&rbd_dev->header_rwsem);
>>>                rbd_assert(snapc != NULL);
>>> -        } else if (!atomic_read(&rbd_dev->exists)) {
>>> +        } else if (!test_bit(rbd_dev_flag_exists, &rbd_dev->flags)) {
>>>                rbd_assert(rbd_dev->spec->snap_id != CEPH_NOSNAP);
>>>                dout("request for non-existent snapshot");
>>>                result = -ENXIO;
>>> @@ -2270,7 +2277,7 @@ struct rbd_device *rbd_dev_create(struct
>>> rbd_client *rbdc,
>>>            return NULL;
>>>
>>>        spin_lock_init(&rbd_dev->lock);
>>> -    atomic_set(&rbd_dev->exists, 0);
>>> +    rbd_dev->flags = 0;
>>>        INIT_LIST_HEAD(&rbd_dev->node);
>>>        INIT_LIST_HEAD(&rbd_dev->snaps);
>>>        init_rwsem(&rbd_dev->header_rwsem);
>>> @@ -2902,7 +2909,7 @@ static int rbd_dev_snaps_update(struct rbd_device
>>> *rbd_dev)
>>>                /* Existing snapshot not in the new snap context */
>>>
>>>                if (rbd_dev->spec->snap_id == snap->id)
>>> -                atomic_set(&rbd_dev->exists, 0);
>>> +                set_bit(rbd_dev_flag_exists, &rbd_dev->flags);
>>>                rbd_remove_snap_dev(snap);
>>>                dout("%ssnap id %llu has been removed\n",
>>>                    rbd_dev->spec->snap_id == snap->id ?
>>>

