From: Paul Cuzner <pcuzner@redhat.com>
Subject: Re: Interpreting ceph osd pool stats output
Date: Mon, 20 Mar 2017 21:41:02 +1300
Message-ID: <CAO=rSOtmerpzctgy24JW5d6wh_gg9wChajSRpLCDfxVeT+8r8w@mail.gmail.com>
References: <CALe9h7dBSZM64NSKF6_S+74Wrv-mLfAtSbQbQvq-UXSSfUL8dA@mail.gmail.com>
 <CAO=rSOtrey4NL+P8SM8fJdoiunKFwcd+ywNniViQJxkU_akh_g@mail.gmail.com>
 <CALe9h7fWgrt2CM-4u7jrpgE5Xrwm0zSVamkTjShfDieWxUpiOg@mail.gmail.com>
 <CAO=rSOvfakqcdkQ5EC-2YqjBg8VwYGWZ8qF551MajezJ2uAZJA@mail.gmail.com>
 <CALe9h7dXbhdF_-_-QDWdLJLbtOPGQ87p2-iu4u8gcmJUHMnOAQ@mail.gmail.com>
 <CALe9h7eWi5mfGLVoRfgLChW7sMY9C+NdttDrS1stTfvcD9khqA@mail.gmail.com>
 <CAO=rSOuAdz8yzRtp7YLAOToyht4Q05oJRiZJCdmHEwHLWpS5_Q@mail.gmail.com>
 <CALe9h7f53kqfKWTD3OcTODdx5PcW2UJ_UX1ZUFLmJp3HvPm5FA@mail.gmail.com>
 <alpine.DEB.2.11.1703141311110.10776@piezo.novalocal> <CAO=rSOuNBETd=V00oHqiFaBTFcU9036w39C8YGrKec4wqba6+A@mail.gmail.com>
 <CAF-wwdHZ8C5T_dDkBh-dLisj7ET9bZuQjSf3p7CFjFKpgSd+hA@mail.gmail.com> <CAO=rSOuF8-wV6mQR1zxykWE4RHx35kfXQnTdD5-0RAH50zhtuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f182.google.com ([209.85.128.182]:36409 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbdCTImE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Mar 2017 04:42:04 -0400
Received: by mail-wr0-f182.google.com with SMTP id u108so87038317wrb.3
        for <ceph-devel@vger.kernel.org>; Mon, 20 Mar 2017 01:41:04 -0700 (PDT)
In-Reply-To: <CAO=rSOuF8-wV6mQR1zxykWE4RHx35kfXQnTdD5-0RAH50zhtuw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sweil@redhat.com>

s/i was/i wasn't/

doh...it's late

On Mon, Mar 20, 2017 at 9:40 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
> I was suggesting inventing the data collector - more about how
> (formula's etc) and what metrics we aggregate to derive meaningful
> metrics. pcp, collectd etc give us a single component - what's the
> framework that ties all those pieces together to give us the
> cluster-wide view? If there is something out there, great...I'm not a
> fan of reinventing the wheel either :)
>
>
>
> On Mon, Mar 20, 2017 at 8:54 PM, Brad Hubbard <bhubbard@redhat.com> wrote:
>>
>>
>> On Mon, Mar 20, 2017 at 1:57 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
>>> John/Sage, thanks for the clarification and info. At this stage, I'll
>>> stick with the data I have with John's caveats.
>>>
>>> The challenge in understanding the load going on in a cluster is
>>> definitely interesting since the choke points are different depending
>>> on whether you look at the cluster through a hardware or software
>>> 'lens'.
>>>
>>> I think the interesting question is how does a customer know how
>>> 'full' their cluster is from a performance standpoint - ie. when do I
>>> need to buy more or different hardware? Holy grail type stuff :)
>>>
>>> Is there any work going on in this space, perhaps analyzing the
>>> underlying components within the cluster like cpu, ram or disk util
>>> rates across the nodes?
>>
>> Wouldn't this be reinventing the wheel since this is something that things like
>> pcp (collectd?) do very well already?
>>
>>>
>>>
>>>
>>> On Wed, Mar 15, 2017 at 2:13 AM, Sage Weil <sweil@redhat.com> wrote:
>>>> On Tue, 14 Mar 2017, John Spray wrote:
>>>>> On Tue, Mar 14, 2017 at 3:13 AM, Paul Cuzner <pcuzner@redhat.com> wrote:
>>>>> > First of all - thanks John for your patience!
>>>>> >
>>>>> > I guess, I still can't get past the different metrics being used -
>>>>> > client I/O is described in one way, recovery in another and yet
>>>>> > fundamentally they both send ops to the OSD's right? To me, what's
>>>>> > interesting is that the recovery_rate metrics from pool stats seems to
>>>>> > be a higher level 'product' of lower level information - for example
>>>>> > recovering_objects_per_sec : is this not a product of multiple
>>>>> > read/write ops to OSD's?
>>>>>
>>>>> While there is data being moved around, it would be misleading to say
>>>>> it's all just ops.  The path that client ops go down is different to
>>>>> the path that recovery messages go down.  Recovery data is gathered up
>>>>> into big vectors of object extents that are sent between OSDs, client
>>>>> ops are sent individually from clients.  An OSD servicing 10 writes
>>>>> from 10 different clients is not directly comparable to an OSD
>>>>> servicing an MOSDPush message from another OSD that happens to contain
>>>>> updates to 10 objects.
>>>>>
>>>>> Client ops are also a logically meaningful to consumers of the
>>>>> cluster, while the recovery stuff is a total implementation detail.
>>>>> The implementation of recovery could change any time, and any counter
>>>>> generated from it will only be meaningful to someone who understands
>>>>> how recovery works on that particular version of the ceph code.
>>>>>
>>>>> > Also, don't get me wrong - the recovery_rate dict is cool and it gives
>>>>> > a great view of object level recovery - I was just hoping for common
>>>>> > metrics for the OSD ops that are shared by client and recovery
>>>>> > activity.
>>>>> >
>>>>> > Since this isn't the case, what's the recommended way to determine how
>>>>> > busy a cluster is - across recovery and client (rbd/rgw) requests?
>>>>>
>>>>> I would say again that how busy a cluster is doing it's job (client
>>>>> IO) is a very separate thing from how busy it is doing internal
>>>>> housekeeping.  Imagine exposing this as a speedometer dial in a GUI
>>>>> (as people sometimes do) -- a cluster that was killing itself with
>>>>> recovery and completely blocking it's clients would look like it was
>>>>> going nice and fast.  In my view, exposing two separate numbers is the
>>>>> right thing to do, not a shortcoming.
>>>>>
>>>>> If you truly want to come up with some kind of single metric then you
>>>>> can: you could take the rate of change of the objects recovered for
>>>>> example.  If you wanted to, you could think of finishing recovery of
>>>>> one object as an "op".  I would tend to think of this as the job of a
>>>>> higher level tool though, rather than a collectd plugin.  Especially
>>>>> if the collectd plugin is meant to be general purpose, it should avoid
>>>>> inventing things like this.
>>>>
>>>> I think the only other option is to take a measurement at a lower layer.
>>>> BlueStore doesn't currently but could easily have metrics for bytes read
>>>> and written.  But again, this is a secondary product of client and
>>>> recovery: a client write, for example, will result in 3 writes across 3
>>>> osds (in a 3x replicated pool).
>>>>
>>>> sage
>>>>
>>>>
>>>>  >
>>>>> John
>>>>>
>>>>> >
>>>>> >
>>>>> >
>>>>> >
>>>>> >
>>>>> >
>>>>> >
>>>>> >
>>>>> >
>>>>> > .
>>>>> >
>>>>> > On Tue, Mar 14, 2017 at 11:14 AM, John Spray <jspray@redhat.com> wrote:
>>>>> >> On Mon, Mar 13, 2017 at 10:13 PM, John Spray <jspray@redhat.com> wrote:
>>>>> >>> On Mon, Mar 13, 2017 at 9:50 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
>>>>> >>>> Fundamentally, the metrics that describe the IO the OSD performs in
>>>>> >>>> response to a recovery operation should be the same as the metrics for
>>>>> >>>> client I/O.
>>>>> >>>
>>>>> >>> Ah, so the key part here I think is "describe the IO that the OSD
>>>>> >>> performs" -- the counters you've been looking at do not do that.  They
>>>>> >>> describe the ops the OSD is servicing, *not* the (disk) IO the OSD is
>>>>> >>> doing as a result.
>>>>> >>>
>>>>> >>> That's why you don't get an apples-to-apples comparison between client
>>>>> >>> IO and recovery -- if you were looking at disk IO stats from both, it
>>>>> >>> would be perfectly reasonable to combine/compare them.  When you're
>>>>> >>> looking at Ceph's own counters of client ops vs. recovery activity,
>>>>> >>> that no longer makes sense.
>>>>> >>>
>>>>> >>>> So in the context of a recovery operation, one OSD would
>>>>> >>>> report a read (recovery source) and another report a write (recovery
>>>>> >>>> target), together with their corresponding num_bytes. To my mind this
>>>>> >>>> provides transparency, and maybe helps potential automation.
>>>>> >>>
>>>>> >>> Okay, so if we were talking about disk IO counters, this would
>>>>> >>> probably make sense (one read wouldn't necessarily correspond to one
>>>>> >>> write), but if you had a counter that was telling you how many Ceph
>>>>> >>> recovery push/pull ops were "reading" (being sent) vs "writing" (being
>>>>> >>> received) the totals would just be zero.
>>>>> >>
>>>>> >> Sorry, that should have said the totals would just be equal.
>>>>> >>
>>>>> >> John
>>>>> >>
>>>>> >>>
>>>>> >>> John
>>>>> >>>
>>>>> >>>>
>>>>> >>>
>>>>> >>>>
>>>>> >>>>
>>>>> >>>>
>>>>> >>>>
>>>>> >>>>
>>>>> >>>> On Mon, Mar 13, 2017 at 1:13 AM, John Spray <jspray@redhat.com> wrote:
>>>>> >>>>> On Sat, Mar 11, 2017 at 9:24 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
>>>>> >>>>>> On Sun, Mar 12, 2017 at 9:49 AM, John Spray <jspray@redhat.com> wrote:
>>>>> >>>>>>> On Fri, Mar 10, 2017 at 8:52 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
>>>>> >>>>>>>> Thanks John
>>>>> >>>>>>>>
>>>>> >>>>>>>> This is weird then. When I look at the data with client load I see the
>>>>> >>>>>>>> following;
>>>>> >>>>>>>> {
>>>>> >>>>>>>> "pool_name": "default.rgw.buckets.index",
>>>>> >>>>>>>> "pool_id": 94,
>>>>> >>>>>>>> "recovery": {},
>>>>> >>>>>>>> "recovery_rate": {},
>>>>> >>>>>>>> "client_io_rate": {
>>>>> >>>>>>>> "read_bytes_sec": 19242365,
>>>>> >>>>>>>> "write_bytes_sec": 0,
>>>>> >>>>>>>> "read_op_per_sec": 12514,
>>>>> >>>>>>>> "write_op_per_sec": 0
>>>>> >>>>>>>> }
>>>>> >>>>>>>>
>>>>> >>>>>>>> No object related counters - they're all block based. The plugin I
>>>>> >>>>>>>> have rolls-up the block metrics across all pools to provide total
>>>>> >>>>>>>> client load.
>>>>> >>>>>>>
>>>>> >>>>>>> Where are you getting the idea that these counters have to do with
>>>>> >>>>>>> block storage?  What Ceph is telling you about here is the number of
>>>>> >>>>>>> operations (or bytes in those operations) being handled by OSDs.
>>>>> >>>>>>>
>>>>> >>>>>>
>>>>> >>>>>> Perhaps it's my poor choice of words - apologies.
>>>>> >>>>>>
>>>>> >>>>>> read_op_per_sec is read IOP count to the OSDs from client activity
>>>>> >>>>>> against the pool
>>>>> >>>>>>
>>>>> >>>>>> My point is that client-io is expressed in these terms, but recovery
>>>>> >>>>>> activity is not. I was hoping that both recovery and client I/O would
>>>>> >>>>>> be reported in the same way so you gain a view of the activity of the
>>>>> >>>>>> system as a whole. I can sum bytes_sec from client i/o with
>>>>> >>>>>> recovery_rate bytes_sec, which is something, but I can't see inside
>>>>> >>>>>> recovery activity to see how much is read or write, or how much IOP
>>>>> >>>>>> load is coming from recovery.
>>>>> >>>>>
>>>>> >>>>> What would it mean to you for a recovery operation (one OSD sending
>>>>> >>>>> some data to another OSD) to be read vs. write?
>>>>> >>>>>
>>>>> >>>>> John
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Cheers,
>> Brad
