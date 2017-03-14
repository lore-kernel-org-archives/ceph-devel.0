From: Sage Weil <sweil@redhat.com>
Subject: Re: Interpreting ceph osd pool stats output
Date: Tue, 14 Mar 2017 13:13:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703141311110.10776@piezo.novalocal>
References: <CAO=rSOsQmUYhdBxio=wEngmeXzyA7dzAJn+OG6iWMPnRVro3VQ@mail.gmail.com> <CALe9h7f7Mspny1fx2aMiXunS2C8GJrWFsp7YKdnmhu42+EVPmA@mail.gmail.com> <CAO=rSOsftK8YAA5Q3jEpuCee16ek=tA++an+weBKHgXSL7bkNw@mail.gmail.com> <CALe9h7dBSZM64NSKF6_S+74Wrv-mLfAtSbQbQvq-UXSSfUL8dA@mail.gmail.com>
 <CAO=rSOtrey4NL+P8SM8fJdoiunKFwcd+ywNniViQJxkU_akh_g@mail.gmail.com> <CALe9h7fWgrt2CM-4u7jrpgE5Xrwm0zSVamkTjShfDieWxUpiOg@mail.gmail.com> <CAO=rSOvfakqcdkQ5EC-2YqjBg8VwYGWZ8qF551MajezJ2uAZJA@mail.gmail.com> <CALe9h7dXbhdF_-_-QDWdLJLbtOPGQ87p2-iu4u8gcmJUHMnOAQ@mail.gmail.com>
 <CALe9h7eWi5mfGLVoRfgLChW7sMY9C+NdttDrS1stTfvcD9khqA@mail.gmail.com> <CAO=rSOuAdz8yzRtp7YLAOToyht4Q05oJRiZJCdmHEwHLWpS5_Q@mail.gmail.com> <CALe9h7f53kqfKWTD3OcTODdx5PcW2UJ_UX1ZUFLmJp3HvPm5FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750909AbdCNNNE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 14 Mar 2017 09:13:04 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F347B61E4D
        for <ceph-devel@vger.kernel.org>; Tue, 14 Mar 2017 13:13:04 +0000 (UTC)
In-Reply-To: <CALe9h7f53kqfKWTD3OcTODdx5PcW2UJ_UX1ZUFLmJp3HvPm5FA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Paul Cuzner <pcuzner@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 14 Mar 2017, John Spray wrote:
> On Tue, Mar 14, 2017 at 3:13 AM, Paul Cuzner <pcuzner@redhat.com> wrote:
> > First of all - thanks John for your patience!
> >
> > I guess, I still can't get past the different metrics being used -
> > client I/O is described in one way, recovery in another and yet
> > fundamentally they both send ops to the OSD's right? To me, what's
> > interesting is that the recovery_rate metrics from pool stats seems to
> > be a higher level 'product' of lower level information - for example
> > recovering_objects_per_sec : is this not a product of multiple
> > read/write ops to OSD's?
> 
> While there is data being moved around, it would be misleading to say
> it's all just ops.  The path that client ops go down is different to
> the path that recovery messages go down.  Recovery data is gathered up
> into big vectors of object extents that are sent between OSDs, client
> ops are sent individually from clients.  An OSD servicing 10 writes
> from 10 different clients is not directly comparable to an OSD
> servicing an MOSDPush message from another OSD that happens to contain
> updates to 10 objects.
> 
> Client ops are also a logically meaningful to consumers of the
> cluster, while the recovery stuff is a total implementation detail.
> The implementation of recovery could change any time, and any counter
> generated from it will only be meaningful to someone who understands
> how recovery works on that particular version of the ceph code.
> 
> > Also, don't get me wrong - the recovery_rate dict is cool and it gives
> > a great view of object level recovery - I was just hoping for common
> > metrics for the OSD ops that are shared by client and recovery
> > activity.
> >
> > Since this isn't the case, what's the recommended way to determine how
> > busy a cluster is - across recovery and client (rbd/rgw) requests?
> 
> I would say again that how busy a cluster is doing it's job (client
> IO) is a very separate thing from how busy it is doing internal
> housekeeping.  Imagine exposing this as a speedometer dial in a GUI
> (as people sometimes do) -- a cluster that was killing itself with
> recovery and completely blocking it's clients would look like it was
> going nice and fast.  In my view, exposing two separate numbers is the
> right thing to do, not a shortcoming.
> 
> If you truly want to come up with some kind of single metric then you
> can: you could take the rate of change of the objects recovered for
> example.  If you wanted to, you could think of finishing recovery of
> one object as an "op".  I would tend to think of this as the job of a
> higher level tool though, rather than a collectd plugin.  Especially
> if the collectd plugin is meant to be general purpose, it should avoid
> inventing things like this.

I think the only other option is to take a measurement at a lower layer.  
BlueStore doesn't currently but could easily have metrics for bytes read 
and written.  But again, this is a secondary product of client and 
recovery: a client write, for example, will result in 3 writes across 3 
osds (in a 3x replicated pool).

sage


 > 
> John
> 
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > .
> >
> > On Tue, Mar 14, 2017 at 11:14 AM, John Spray <jspray@redhat.com> wrote:
> >> On Mon, Mar 13, 2017 at 10:13 PM, John Spray <jspray@redhat.com> wrote:
> >>> On Mon, Mar 13, 2017 at 9:50 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
> >>>> Fundamentally, the metrics that describe the IO the OSD performs in
> >>>> response to a recovery operation should be the same as the metrics for
> >>>> client I/O.
> >>>
> >>> Ah, so the key part here I think is "describe the IO that the OSD
> >>> performs" -- the counters you've been looking at do not do that.  They
> >>> describe the ops the OSD is servicing, *not* the (disk) IO the OSD is
> >>> doing as a result.
> >>>
> >>> That's why you don't get an apples-to-apples comparison between client
> >>> IO and recovery -- if you were looking at disk IO stats from both, it
> >>> would be perfectly reasonable to combine/compare them.  When you're
> >>> looking at Ceph's own counters of client ops vs. recovery activity,
> >>> that no longer makes sense.
> >>>
> >>>> So in the context of a recovery operation, one OSD would
> >>>> report a read (recovery source) and another report a write (recovery
> >>>> target), together with their corresponding num_bytes. To my mind this
> >>>> provides transparency, and maybe helps potential automation.
> >>>
> >>> Okay, so if we were talking about disk IO counters, this would
> >>> probably make sense (one read wouldn't necessarily correspond to one
> >>> write), but if you had a counter that was telling you how many Ceph
> >>> recovery push/pull ops were "reading" (being sent) vs "writing" (being
> >>> received) the totals would just be zero.
> >>
> >> Sorry, that should have said the totals would just be equal.
> >>
> >> John
> >>
> >>>
> >>> John
> >>>
> >>>>
> >>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>> On Mon, Mar 13, 2017 at 1:13 AM, John Spray <jspray@redhat.com> wrote:
> >>>>> On Sat, Mar 11, 2017 at 9:24 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
> >>>>>> On Sun, Mar 12, 2017 at 9:49 AM, John Spray <jspray@redhat.com> wrote:
> >>>>>>> On Fri, Mar 10, 2017 at 8:52 PM, Paul Cuzner <pcuzner@redhat.com> wrote:
> >>>>>>>> Thanks John
> >>>>>>>>
> >>>>>>>> This is weird then. When I look at the data with client load I see the
> >>>>>>>> following;
> >>>>>>>> {
> >>>>>>>> "pool_name": "default.rgw.buckets.index",
> >>>>>>>> "pool_id": 94,
> >>>>>>>> "recovery": {},
> >>>>>>>> "recovery_rate": {},
> >>>>>>>> "client_io_rate": {
> >>>>>>>> "read_bytes_sec": 19242365,
> >>>>>>>> "write_bytes_sec": 0,
> >>>>>>>> "read_op_per_sec": 12514,
> >>>>>>>> "write_op_per_sec": 0
> >>>>>>>> }
> >>>>>>>>
> >>>>>>>> No object related counters - they're all block based. The plugin I
> >>>>>>>> have rolls-up the block metrics across all pools to provide total
> >>>>>>>> client load.
> >>>>>>>
> >>>>>>> Where are you getting the idea that these counters have to do with
> >>>>>>> block storage?  What Ceph is telling you about here is the number of
> >>>>>>> operations (or bytes in those operations) being handled by OSDs.
> >>>>>>>
> >>>>>>
> >>>>>> Perhaps it's my poor choice of words - apologies.
> >>>>>>
> >>>>>> read_op_per_sec is read IOP count to the OSDs from client activity
> >>>>>> against the pool
> >>>>>>
> >>>>>> My point is that client-io is expressed in these terms, but recovery
> >>>>>> activity is not. I was hoping that both recovery and client I/O would
> >>>>>> be reported in the same way so you gain a view of the activity of the
> >>>>>> system as a whole. I can sum bytes_sec from client i/o with
> >>>>>> recovery_rate bytes_sec, which is something, but I can't see inside
> >>>>>> recovery activity to see how much is read or write, or how much IOP
> >>>>>> load is coming from recovery.
> >>>>>
> >>>>> What would it mean to you for a recovery operation (one OSD sending
> >>>>> some data to another OSD) to be read vs. write?
> >>>>>
> >>>>> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
