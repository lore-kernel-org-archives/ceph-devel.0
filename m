From: Sage Weil <sweil@redhat.com>
Subject: RE: Recovery question
Date: Mon, 23 Feb 2015 13:42:32 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502231339160.23553@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F282B72DE@SACMBXIP02.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1502231258440.23553@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F282B7320@SACMBXIP02.sdcorp.global.sandisk.com>
 <alpine.DEB.2.00.1502231325300.23553@cobra.newdream.net> <755F6B91B3BE364F9BCA11EA3F9E0C6F282B7364@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59926 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331AbbBWVmg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 Feb 2015 16:42:36 -0500
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F282B7364@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 23 Feb 2015, Somnath Roy wrote:
> Got it, thanks !
> 
> << We'll serve reads and writes with just [2,3] and the pg will show up as 'degraded'
> So, the moment osd.1 is down in the map [2,3] , 2 will be designated as primary ? As my understanding is, read/write won't be served from replica OSD, right ?

The moment the mapping becomes [2,3], 2 is now the primary, and it can 
serve IO.

The slow part is here:

> If we had say
> 
>  4: [2,3,4]
> 
> then we'll get
> 
>  5: [1,2,3]
> 
> osd will realize osd.1 cannot log recovery and will install a pg_temp so that

We can't serve IO with [1,2,3] because 1 is out of date, so there is 
a lag until it installs the pg_temp record.  There is a pull request that 
will preemptively calculate new mappings and set up pg_temp records that 
should mitigate this issue, but it needs some testing, and I think 
there is still room for improvement (for example, by serving IO with a 
usable but non-optimal pg-temp record while we are waiting for it to be 
removed).

See
	https://github.com/ceph/ceph/pull/3429

There's like a bunch of similar stuff we can do to improve peering 
latency that we'll want ot spend some time on for infernalis.

sage

> 
>  6: [2,3,4]
> 
> and PG will go active (serve IO).  when backfill completes, it will remove the pg_temp and 
> 
>  7: [1,2,3]
> 
> > 3. Will the flow be similar if one of the replica OSD goes down 
> > instead of primary in the step '2' I mentioned earlier ?  Say, osd.2 
> > went down instead of osd.1 ?
> 
> Yeah, basically the same.  Who is primary doesn't really matter.
> 
> sage
> 
> 
> 
> 
> > 
> > Regards
> > Somnath
> > 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Monday, February 23, 2015 1:03 PM
> > To: Somnath Roy
> > Cc: Samuel Just (sam.just@inktank.com); Ceph Development
> > Subject: Re: Recovery question
> > 
> > On Mon, 23 Feb 2015, Somnath Roy wrote:
> > > Hi,
> > > Can anyone help me understand what will happen in the following scenarios ?
> > >
> > > 1. Current PG map : 3.5 -> OSD[1,2,3]
> > >
> > > 2. 1 is down and new map : 3.5 -> OSD[2,3,4]
> > 
> > More likely it's:
> > 
> >  1: 3.5 -> [1,2,3]
> >  2: 3.5 -> [2,3]   (osd.1 is down)
> >  3: 3.5 -> [2,3,4] (osd.1 is marked out)
> > 
> > > 3. Need to for backfill recovery for 4 and it started
> > 
> > If log recovery will work, we'll do that and it's nice and quick.  If 
> > backfill is needed, we will do
> > 
> >  4: 3.5 -> [2,3]  (up=[2,3,4]) (pg_temp record added to map to 
> > log-recoverable OSDs)
> > 
> > > 4. Meanwhile OSD 1 came up , it was down for short amount of time
> > 
> >  5: 3.5 -> [1,2,3] (osd.1 is back up and in)
> > 
> > > 5. Will pg 3.5 mapping change considering OSD 1 recovery could be 
> > > log based ?
> > 
> > It will change immediately when osd.1 is back up, regardless of what 
> > data is where.  If it's log recoverable, then no mapping changes will 
> > be needed.  If it's not, then
> > 
> >  6: 3.5 -> [2,3,4]  (up=[1,2,3]) (add pg_temp mapping while we 
> > backfill osd.1)
> >  7: 3.5 -> [1,2,3]  (pg_temp entry removed when backfill completes)
> > 
> > > 6. Also, if OSD 4 recovery could be log based, will there be any 
> > > change in pg map if OSD 1 is up during the recovery ?
> > 
> > See above
> > 
> > Hope that helps!
> > sage
> > 
> > ________________________________
> > 
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
