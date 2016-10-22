From: Sage Weil <sage@newdream.net>
Subject: Re: Possible corruption with MSSQL on RBD
Date: Sat, 22 Oct 2016 18:06:05 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610221804510.3288@piezo.us.to>
References: <262972897.5995.1476280634060@ox.pcextreme.nl> <CAJ4mKGZx+PgcqAPVB0LSFxp1z=aZiKWt-H1hjnKJU5_hxAoxWg@mail.gmail.com> <439702971.6004.1476287822395@ox.pcextreme.nl> <2126451990.6086.1476439471715@ox.pcextreme.nl>
 <CABZ+qqkw4JrLko0bjjVWXF_o3nibDzVCRitnf8GUK+pZy+4pNA@mail.gmail.com> <1370594328.6476.1477150447423@ox.pcextreme.nl> <CABZ+qqkTyhvFvbAEi96oj0jYJZZFXqfHwrweaU8KFq9H21V=dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55827 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964876AbcJVSGJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 22 Oct 2016 14:06:09 -0400
In-Reply-To: <CABZ+qqkTyhvFvbAEi96oj0jYJZZFXqfHwrweaU8KFq9H21V=dg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Wido den Hollander <wido@42on.com>, Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sat, 22 Oct 2016, Dan van der Ster wrote:
> On Sat, Oct 22, 2016 at 5:34 PM, Wido den Hollander <wido@42on.com> wrote:
> >
> >> Op 22 oktober 2016 om 17:30 schreef Dan van der Ster <dan@vanderster.com>:
> >>
> >>
> >> On Fri, Oct 14, 2016 at 12:04 PM, Wido den Hollander <wido@42on.com> wrote:
> >> >
> >> >> Op 12 oktober 2016 om 17:57 schreef Wido den Hollander <wido@42on.com>:
> >> >>
> >> >>
> >> >>
> >> >> > Op 12 oktober 2016 om 17:01 schreef Gregory Farnum <gfarnum@redhat.com>:
> >> >> >
> >> >> >
> >> >> > On Wed, Oct 12, 2016 at 7:57 AM, Wido den Hollander <wido@42on.com> wrote:
> >> >> > > Hi,
> >> >> > >
> >> >> > > I filed a issue in the tracker, but I'm looking for some feedback to diagnose this a bit further: http://tracker.ceph.com/issues/17545
> >> >> > >
> >> >> > > The situation is that with a Firefly or Hammer (haven't tested Jewel yet) a MSSQL server running on RBD will sometimes complain about corruption.
> >> >> > >
> >> >> > > Using SQLioSim we can reproduce the issue on a small Proxmox + Ceph cluster and after an hour or so it will yield:
> >> >> > >
> >> >> > > Expected FileId: 0x0
> >> >> > > Received FileId: 0x0
> >> >> > > Expected PageId: 0xCB19C
> >> >> > > Received PageId: 0xCB19A (does not match expected)
> >> >> > > Received CheckSum: 0x9F444071
> >> >> > > Calculated CheckSum: 0x89603EC9 (does not match expected)
> >> >> > > Received Buffer Length: 0x2000
> >> >> > >
> >> >> > > The issue only seems to happen with RBD caching enabled. When disabling the RBD cache or using cache=directsync we were not able to reproduce the issue.
> >> >> > >
> >> >> > > When using LVM/file based backends for Qemu the problem also didn't pop up.
> >> >> > >
> >> >> > > So this seems to be either a librbd issue or the RBD driver inside Qemu.
> >> >> > >
> >> >> > > Any hints on how to debug this further to find the root cause?
> >> >> >
> >> >> > If you've got control over the clients, try building with commit
> >> >> > 9ec6e7f608608088d51e449c9d375844631dcdde backported to them (I believe
> >> >> > it's also in the latest Hammer release, but maybe there hasn't been
> >> >> > one cut since the backport?); tracked at
> >> >> > http://tracker.ceph.com/issues/16002 but of course the web site is
> >> >> > dead so you can't look at that right now. :(
> >> >>
> >> >> I verified, but 9ec6e7 is not in v0.94.9, but it is in the Jewel release.
> >> >>
> >> >> Tests are running with Jewel now and I will probably have the results tomorrow. If Jewel doesn't break the commit you send might indeed resolve it.
> >> >>
> >> >
> >> > The tests have been running for over 24 hours and all still looks good. We will let it run for over the weekend to make sure it has been fixed.
> >>
> >> Is there still some follow up needed on this? It seems that latest
> >> hammer is still at risk for an RBD corruption bug, right?
> >>
> >> I've understood that you don't see the problem any more with jewel,
> >> but I didn't see any confirmation that 9ec6e7 is indeed the fix. Did
> >> you run any more testing of hammer + 9ec6e7?
> >>
> >
> > Oh, I updated the issues and not the ML. Yes, with hammer + that fix we no longer see the issue.
> >
> > The fix is now pending for 0.94.10
> 
> Excellent.
> 
> So, I don't really understand how this corruption is triggered. Is it
> something unique about the MSSQL workload that triggers it or is this
> a general problem that's probably going on undetected by other RBD
> use-cases?

It could affect other workloads as well.  You'll definitely want to 
upgrade once 0.94.10 is out.

sage

