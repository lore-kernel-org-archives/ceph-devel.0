From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 5/5] rbd: restore previous rbd id sequence behavior
Date: Wed, 29 Feb 2012 13:27:26 -0800
Message-ID: <4F4E983E.5070602@dreamhost.com>
References: <4F4D9DA5.8050101@dreamhost.com> <4F4D9E1D.806@dreamhost.com> <CAC-hyiFXkcp64aj5rkS4h6pdvPQr3WCrK8Xy7NbKO5N+JSWjKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40382 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932069Ab2B2V11 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 16:27:27 -0500
In-Reply-To: <CAC-hyiFXkcp64aj5rkS4h6pdvPQr3WCrK8Xy7NbKO5N+JSWjKw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 02/29/2012 12:53 PM, Yehuda Sadeh Weinraub wrote:
> On Tue, Feb 28, 2012 at 7:40 PM, Alex Elder<elder@dreamhost.com>  wrote:
>> It used to be that selecting a new unique identifier for an added
>> rbd device required searching all existing ones to find the highest
>> id is used.  A recent change made that unnecessary, but made it
>> so that id's used were monotonically non-decreasing.  It's a bit
>> more pleasant to have smaller rbd id's though, and this change
>> makes ids get allocated as they were before--each new id is one more
>> than the maximum currently in use.
>
> Oh, so ignore my previous comment, though in any case we can still
> exhaust the 31 bits:
>
> loop through:
>
> add A
> add B
> remove A
> add C
> remove B
> add A
> remove C
> add B

OK with me.  I didn't change the previous behavior.
But I'm fine with making it 64 bits.  I will implement
that and post an update.

					-Alex

>
> etc..
>
>>
>> Signed-off-by: Alex Elder<elder@dreamhost.com>
>> ---
>>   drivers/block/rbd.c |   40 ++++++++++++++++++++++++++++++++++------
>>   1 files changed, 34 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
>> index 042377b..4c5bb39 100644
>> --- a/drivers/block/rbd.c
>> +++ b/drivers/block/rbd.c
>> @@ -2171,18 +2171,46 @@ static void rbd_id_get(struct rbd_device *rbd_dev)
>>   */
>>   static void rbd_id_put(struct rbd_device *rbd_dev)
>>   {
>> -       BUG_ON(rbd_dev->id<  1);
>> +       struct list_head *tmp;
>> +       int rbd_id = rbd_dev->id;
>> +       int max_id;
>> +
>> +       BUG_ON(rbd_id<  1);
>>
>>         spin_lock(&rbd_dev_list_lock);
>>         list_del_init(&rbd_dev->node);
>> +
>> +       /*
>> +        * If the id being "put" is not the current maximum, there
>> +        * is nothing special we need to do.
>> +        */
>> +       if (rbd_id != atomic_read(&rbd_id_max)) {
>> +               spin_unlock(&rbd_dev_list_lock);
>> +               return;
>> +       }
>> +
>> +       /*
>> +        * We need to update the current maximum id.  Search the
>> +        * list to find out what it is.  We're more likely to find
>> +        * the maximum at the end, so search the list backward.
>> +        */
>> +       max_id = 0;
>> +       list_for_each_prev(tmp,&rbd_dev_list) {
>> +               struct rbd_device *rbd_dev;
>> +
>> +               rbd_dev = list_entry(tmp, struct rbd_device, node);
>> +               if (rbd_id>  max_id)
>> +                       max_id = rbd_id;
>> +       }
>>         spin_unlock(&rbd_dev_list_lock);
>
> So we still need to either use 64 bit counter, or think of a better
> scheme to allocate ids. Maybe using some sorted data structure here?
>>
>>         /*
>> -        * New id's are always one more than the current maximum.
>> -        * If the id being "put" *is* that maximum, decrement the
>> -        * maximum so the next one requested just reuses this one.
>> +        * The max id could have been updated by rbd_id_get(), in
>> +        * which case it now accurately reflects the new maximum.
>> +        * Be careful not to overwrite the maximum value in that
>> +        * case.
>>          */
>> -       atomic_cmpxchg(&rbd_id_max, rbd_dev->id, rbd_dev->id - 1);
>> +       atomic_cmpxchg(&rbd_id_max, rbd_id, max_id);
>>   }
>>
>>   static ssize_t rbd_add(struct bus_type *bus,
>> @@ -2217,7 +2245,7 @@ static ssize_t rbd_add(struct bus_type *bus,
>>         INIT_LIST_HEAD(&rbd_dev->node);
>>         INIT_LIST_HEAD(&rbd_dev->snaps);
>>
>> -       /* generate unique id: one more than highest used so far */
>> +       /* generate unique id: find highest unique id, add one */
>>         rbd_id_get(rbd_dev);
>>
>>         /* parse add command */
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

