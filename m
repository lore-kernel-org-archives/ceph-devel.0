From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] rbd: __rbd_init_snaps_header() bug
Date: Mon, 30 Jul 2012 16:49:51 -0700
Message-ID: <50171D9F.9080508@inktank.com>
References: <50119685.4010106@inktank.com> <5017132C.9010407@inktank.com> <501715BA.70407@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:34954 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2G3Xty (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jul 2012 19:49:54 -0400
Received: by pbbrp8 with SMTP id rp8so10638122pbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jul 2012 16:49:54 -0700 (PDT)
In-Reply-To: <501715BA.70407@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/30/2012 04:16 PM, Alex Elder wrote:
> On 07/30/2012 06:05 PM, Josh Durgin wrote:
>> On 07/26/2012 12:12 PM, Alex Elder wrote:
>>> There is a bug in the way __rbd_init_snaps_header() handles newly-
>>> discovered snapshots, in the unusual case where the new snapshot id
>>> is less than an existing rbd snapshot id.
>>>
>>>
>>> When a new snapshot for an rbd image is created it is assigned a new
>>> snapshot id.  The client requests the id from a monitor, and later
>>> updates the osds with information about the snapshot.  The sequence
>>> of snapshot ids is monotonically increasing, which guarantees each
>>> is unique.  And typically all new snapshots will have higher ids
>>> than any others a client has encountered.
>>>
>>> Because of the delay between getting assigned a snapshot id and
>>> recording the snapshot, there is a possible race between two clients
>>> requesting new snapshots on the same rbd image.  It's possible in
>>> this case for the client granted a higher id to be the first to
>>> update the set of snapshots for the rbd image.  This leaves a sort
>>> of gap in the set of snapshots until the other client's update gets
>>> recorded.
>>>
>>> This is an unlikely scenario, but it appears to be possible.  I'm
>>> not sure whether we even support multiple concurrent clients for the
>>> same rbd image.  However there is code in place to handle this case
>>> and it's wrong, so it needs to be fixed.
>>
>> To fully handle this race, we'd need to sort the snapshot context and
>> set its seq to the maximum id, instead of the lower id set by the race.
>
> I had assumed both of these were true.  In fact, I was under the
> impression that the value of "seq" was precisely that--the maximum
> snapshot id issued for this rbd image by the server.

Yes, these are both true except when bugs like this race condition
occur. Sorting and finding the max id would be a workaround for
this bug, but is never necessary otherwise.

Josh

>> If we don't do this, the race makes the image unwritable since the
>> non-sorted snapshot context would be rejected by the osds.
>
> Looking at the kernel client only (which was how I found this bug,
> via inspection), this code is still buggy and could cause a kernel
> fault if it were to be hit.
>
> The risk is low right now, though.  So I'll just set this patch
> aside now until we can get a chance to discuss the best course
> of action.
>
> 					-Alex
>
>> This would complicate things a bunch, so I'm not sure if we should
>> try to handle this bug on the client side. I've got a fix to prevent
>> it from happening in the first place, and as you said, it's rare,
>> and requires you to be taking snapshots of the same image from multiple
>> clients at once, which is generally not a good idea (that is, writing
>> to the image from multiple clients).
>>
>>> The job of __rbd_init_snaps_header() is to compare an rbd's existing
>>> list of snapshots to a new set, and remove any existing snapshots
>>> that are not present in the new set and create any new ones not
>>> present in the existing set.
>>>
>>> If any new snapshots exist after the entire list of existing ones
>>> has been examined, all the new ones that remain need to be created.
>>> The logic for handling these last snapshots correct.
>>>
>>> However, if a new snapshot is found whose id is less than an
>>> existing one, the logic for handling this is wrong.  The basic
>>> problem is that the name and current id used here are taken from
>>> a place one position beyond where they should be.  In the event
>>> this block of code is executed the first pass through the outer
>>> loop, for example, these values will refer to invalid memory.
>>>
>>> The fix is to make this block of code more closely match the
>>> block that handles adding new snapshots at the end.  There are
>>> three differences:
>>>       - we use a do..while loop because we know we initially have an
>>>         entry to process.
>>>       - we insert the new entry at a position within the list instead
>>>         of at the beginning
>>>       - because we use it in the loop condition, we need to update
>>>         our notion of "current id" each pass through.
>>>
>>> Signed-off-by: Alex Elder <elder@inktank.com>
>>> ---
>>>    drivers/block/rbd.c |   55
>>> +++++++++++++++++++++++++++++----------------------
>>>    1 file changed, 31 insertions(+), 24 deletions(-)
>>>
>>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>>> index 71e3f3b..da09c0d 100644
>>> --- a/drivers/block/rbd.c
>>> +++ b/drivers/block/rbd.c
>>> @@ -2090,13 +2090,14 @@ static int __rbd_init_snaps_header(struct
>>> rbd_device *rbd_dev)
>>>    {
>>>        const char *name, *first_name;
>>>        int i = rbd_dev->header.total_snaps;
>>> -    struct rbd_snap *snap, *old_snap = NULL;
>>> +    struct rbd_snap *snap;
>>>        struct list_head *p, *n;
>>>
>>>        first_name = rbd_dev->header.snap_names;
>>>        name = first_name + rbd_dev->header.snap_names_len;
>>>
>>>        list_for_each_prev_safe(p, n, &rbd_dev->snaps) {
>>> +        struct rbd_snap *old_snap;
>>>            u64 cur_id;
>>>
>>>            old_snap = list_entry(p, struct rbd_snap, node);
>>> @@ -2104,12 +2105,16 @@ static int __rbd_init_snaps_header(struct
>>> rbd_device *rbd_dev)
>>>            if (i)
>>>                cur_id = rbd_dev->header.snapc->snaps[i - 1];
>>>
>>> +        /*
>>> +         * If old id is not present in the new context, or
>>> +         * if there are no more snapshots in the new
>>> +         * context, this snapshot should be removed.
>>> +         */
>>>            if (!i || old_snap->id < cur_id) {
>>>                /*
>>> -             * old_snap->id was skipped, thus was
>>> -             * removed.  If this rbd_dev is mapped to
>>> -             * the removed snapshot, record that it no
>>> -             * longer exists, to prevent further I/O.
>>> +             * If this rbd_dev is mapped to the removed
>>> +             * snapshot, record that it no longer exists,
>>> +             * to prevent further I/O.
>>>                 */
>>>                if (rbd_dev->snap_id == old_snap->id)
>>>                    rbd_dev->snap_exists = false;
>>> @@ -2122,34 +2127,36 @@ static int __rbd_init_snaps_header(struct
>>> rbd_device *rbd_dev)
>>>                name = rbd_prev_snap_name(name, first_name);
>>>                continue;
>>>            }
>>> -        for (; i > 0;
>>> -             i--, name = rbd_prev_snap_name(name, first_name)) {
>>> -            if (!name) {
>>> -                WARN_ON(1);
>>> +
>>> +        /*
>>> +         * A new snapshot (or possibly more than one)
>>> +         * appeared in the middle of our set of snapshots.
>>> +         * This could happen of two hosts raced while
>>
>> of -> if, and hosts -> clients (could be the same host, i.e. via the
>> rbd snap create).
>>
>>> +         * creating snapshots, and the one that was granted
>>> +         * a higher snapshot id managed to get its snapshot
>>> +         * saved before the other.
>>> +         */
>>> +        do {
>>> +            i--;
>>> +            name = rbd_prev_snap_name(name, first_name);
>>> +            if (WARN_ON(!name))
>>>                    return -EINVAL;
>>> -            }
>>> -            cur_id = rbd_dev->header.snapc->snaps[i];
>>> -            /* snapshot removal? handle it above */
>>> -            if (cur_id >= old_snap->id)
>>> -                break;
>>> -            /* a new snapshot */
>>> -            snap = __rbd_add_snap_dev(rbd_dev, i - 1, name);
>>> +            snap = __rbd_add_snap_dev(rbd_dev, i, name);
>>>                if (IS_ERR(snap))
>>>                    return PTR_ERR(snap);
>>> -
>>>                /* note that we add it backward so using n and not p */
>>>                list_add(&snap->node, n);
>>> -            p = &snap->node;
>>> -        }
>>> +
>>> +            cur_id = rbd_dev->header.snapc->snaps[i];
>>> +        } while (i && cur_id < old_snap->id);
>>>        }
>>>        /* we're done going over the old snap list, just add what's left */
>>> -    for (; i > 0; i--) {
>>> +    while (i) {
>>> +        i--;
>>>            name = rbd_prev_snap_name(name, first_name);
>>> -        if (!name) {
>>> -            WARN_ON(1);
>>> +        if (WARN_ON(!name))
>>>                return -EINVAL;
>>> -        }
>>> -        snap = __rbd_add_snap_dev(rbd_dev, i - 1, name);
>>> +        snap = __rbd_add_snap_dev(rbd_dev, i, name);
>>>            if (IS_ERR(snap))
>>>                return PTR_ERR(snap);
>>>            list_add(&snap->node, &rbd_dev->snaps);
>>>
>>
>>
>>
>

