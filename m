From: Sage Weil <sage@inktank.com>
Subject: Re: Very unbalanced storage
Date: Fri, 31 Aug 2012 20:07:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208312005390.27708@cobra.newdream.net>
References: <50409BDC.5010006@gmail.com> <5040D179.5000008@aktzero.com> <alpine.DEB.2.00.1208310908520.1531@cobra.newdream.net> <5040E532.6040306@aktzero.com> <CAPYLRziEqEPphb8n5Qicj+D6Wq=R9+G4CS9ing6_1W0ztk9cMw@mail.gmail.com> <50417405.4060002@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50433 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241Ab2IADHI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Aug 2012 23:07:08 -0400
In-Reply-To: <50417405.4060002@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaopong Tran <xiaopong.tran@gmail.com>
Cc: Gregory Farnum <greg@inktank.com>, Andrew Thompson <andrewkt@aktzero.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, 1 Sep 2012, Xiaopong Tran wrote:
> On 09/01/2012 12:39 AM, Gregory Farnum wrote:
> > On Fri, Aug 31, 2012 at 9:24 AM, Andrew Thompson <andrewkt@aktzero.com>
> > wrote:
> > > On 8/31/2012 12:10 PM, Sage Weil wrote:
> > > > 
> > > > On Fri, 31 Aug 2012, Andrew Thompson wrote:
> > > > > 
> > > > > Have you been reweight-ing osds? I went round and round with my
> > > > > cluster a
> > > > > few days ago reloading different crush maps only to find that it
> > > > > re-injecting a crush map didn't seem to overwrite reweights. Take a
> > > > > look at
> > > > > `ceph osd tree` to see if the reweight column matches the weight
> > > > > column.
> > > > 
> > > > Note that the ideal situation is for reweight to be 1, regardless of
> > > > what
> > > > the crush weight is.  If you find the utilizations are skewed, I would
> > > > look for other causes before resorting to reweight-by-utilization; it is
> > > > meant to adjust the normal statistical variation you expect from a
> > > > (pseudo)random placement, but if the variance is high there is likely
> > > > another cause.
> > > 
> > > 
> > > So if someone(me, guilty) had been messing with reweight, will setting
> > > them
> > > all to 1 return it to a normal un-reweight-ed state?
> > 
> > Yep!
> > If you have OSDs with different sizes you'll want to adjust the CRUSH
> > weights, not the reweight values:
> > http://ceph.com/docs/master/ops/manage/crush/#adjusting-the-crush-weight
> 
> Thanks for the reply. Yes, this was what I did, we had 1TB and 2TB HD,
> so using 1TB as the base line, with weight being 1.0, then I'd like that
> the 2TB HD store 2x amount of data, so that the disks always have
> roughly same relative amount of data.
> 
> Originally, every osd has weight of 1.0, and I did:
> 
> ceph osd crush reweight osd.30 2.0
> 
> and all the 2TB disks.
> 
> And that's probably what caused the skew afterward. The crush map
> attached in my last message was fetched from the cluster, and
> 
> ceph osd tree
> 
> does show that the weight of the 2TB disks as 2, but reweight is 1.
> 
> Now I'm getting confused by the meaning of crush weight :)

Yes, sorry.  The left one (in osd tree) is the 'crush weight', and the 
right one is the 'reweight', which you can think of as a non-binary state 
of failure.  0 == failed (and everything remapped elsewhere), 1 == normal, 
and anything in between meaning that some fraction of the content is 
remapped elsewhere.

sage
