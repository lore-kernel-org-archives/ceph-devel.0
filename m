From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 1/2] rbd: define flags field, use it for exists flag
Date: Thu, 17 Jan 2013 17:16:42 -0600
Message-ID: <50F8865A.9020001@inktank.com>
References: <50F4535A.6030601@inktank.com> <50F4538B.4010106@inktank.com> <50F46B40.9010907@inktank.com> <50F4776F.2080407@inktank.com> <50F5FDA7.6040509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41227 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576Ab3AQXQv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 18:16:51 -0500
Received: by mail-ie0-f169.google.com with SMTP id c14so5696380ieb.28
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 15:16:51 -0800 (PST)
In-Reply-To: <50F5FDA7.6040509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 01/15/2013 07:08 PM, Josh Durgin wrote:
> On 01/14/2013 01:23 PM, Alex Elder wrote:
>> On 01/14/2013 02:32 PM, Dan Mick wrote:
>>> I see that set_bit is atomic, but I don't see that test_bit is.  Am I
>>> missing a subtlety?
>>
>> That's an interesting observation.  I'm certain it's safe, but
>> I needed to research it a bit, and I still haven't verified it
>> to my satisfaction.
>>
>> I *think* (but please look over the following and see if you
>> come to the same conclusion) that this operation doesn't need
>> to be made atomic, because the implementation of the routines
>> that implement the "set" operations guarantee their effects are
>> visible once they are done.
>>
>> But I'm not sure whether "visible" here means precisely that
>> another CPU will be forced to go read the updated memory when
>> it calls test_bit().
>>
>> http://www.kernel.org/doc/Documentation/atomic_ops.txt
>> The section of interest can be found by looking for the
>> sentence I'm talking about:
>>    Likewise, the atomic bit operation must be visible globally before any
>>    subsequent memory operation is made visible.
> 
> I read that differently. I think that only applies to the test_and_set
> style operations mentioned directly above, not set_bit.
> 
> Documentation/memory-barriers.txt confirms this interpretation:
> 
>     The following operations are potential problems as they do
>     _not_ imply memory barriers, but might be used for
>     implementing such things as UNLOCK-class operations:
> 
>             atomic_set();
>             set_bit();
>             clear_bit();
>             change_bit();
> 
>     With these the appropriate explicit memory barrier should be
>     used if necessary (smp_mb__before_clear_bit() for instance).
> 
> And:
> 
>     Memory operations that occur after an UNLOCK operation may appear to
>     happen before it completes.
> 
> So I think we need a memory barrier before and after set_bit for the
> removing flag, but we don't need barriers for the exists flag, since
> it's a best-effort value that can't stop already-in-flight requests.

You know, I agree with your analysis but now I'm not sure
even that's enough.

Here's the code in question (from the other patch):

Test side:
        mutex_lock_nested(&ctl_mutex, SINGLE_DEPTH_NESTING);
        if (!test_bit(rbd_dev_flag_removing, &rbd_dev->flags)) {
                (void) get_device(&rbd_dev->dev);
                set_device_ro(bdev, rbd_dev->mapping.read_only);
                rbd_dev->open_count++;
        } else {
                ret = -ENOENT;
        }
        mutex_unlock(&ctl_mutex);


Set side:
        if (rbd_dev->open_count) {
                ret = -EBUSY;
                goto done;
        }
        set_bit(rbd_dev_flag_removing, &rbd_dev->flags);

And here's the scenario I'm thinking about.  Initially,
suppose rbd_dev->open_count is 0 and the removing flag
is not set.

OPENING THREAD                  UNMAPPING THREAD
--------------                  ----------------
                                if (rbd_dev->open_count) {
                                    /* not taken, it's zero */
                                    ret = -EBUSY;
                                    goto done;
                                }
if (!test_bit(removing)) {
    /* not set yet! */          /* barrier won't help here */
                                set_bit(removing);
                                /* clean stuff up */
    rbd_dev->open_count++;      /* == kablooie == */
} else {
    ret = -ENOENT;
}

So I think we need a spinlock, or some other thing.

In any case, I'm not going to commit this change until
we've had a chance to talk about it a little more.

					-Alex
