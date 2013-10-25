From: Sage Weil <sage@inktank.com>
Subject: Re: Removing disks / OSDs
Date: Fri, 25 Oct 2013 08:58:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310250856310.9031@cobra.newdream.net>
References: <52655309.8070500@dachary.org> <CAPYLRzjBmdewVvNVQd5JwnAAF2dv+q7Qk4qtzwQO7jVtpDGDRg@mail.gmail.com> <52661776.20803@dachary.org> <CAPYLRzgxWEi1s0=-EtcbhpdS8H96KDm-NhxhScKOn18Y72DY5Q@mail.gmail.com> <alpine.DEB.2.00.1310221029580.29488@cobra.newdream.net>
 <5267D30D.9080201@dachary.org> <526A6DED.8090202@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48406 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab3JYP6d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Oct 2013 11:58:33 -0400
In-Reply-To: <526A6DED.8090202@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, 25 Oct 2013, Loic Dachary wrote:
> Hi,
> 
> If a disk containing an OSD is moved to another host, it is entirely 
> possible that the objects it contains are violating a crush rule 
> imposing that no object is replicated on the same host. Will this be 
> taken care of as a side effect of updating the place of the OSD in the 
> map ( 
> https://github.com/ceph/ceph/blob/v0.61.9/src/upstart/ceph-osd.conf#L29 
> ) ?

Exactly.  In general, in the simlest case, plugging an OSD into a 
different part of the CRUSH map will mean that the data will move. The 
benefit is that we retain that copy so there is no spike in the 
probability of losing additional replicas and all your data.

There are some tricks we could play if a host is being replaced wholesale 
(all drives moved together) by resuing the internal CRUSH ids and 
preventing movement, but that isn't done yet.

sage


> 
> Cheers
> 
> On 23/10/2013 15:45, Loic Dachary wrote:
> > Hi,
> > 
> > As a conclusion to this thread and also because I realized that most people are unaware of the level of automation provided by ceph / udev, I just posted a quick summary : http://dachary.org/?p=2428
> > 
> > Cheers
> > 
> > On 22/10/2013 19:31, Sage Weil wrote:
> >> On Tue, 22 Oct 2013, Gregory Farnum wrote:
> >>> On Mon, Oct 21, 2013 at 11:13 PM, Loic Dachary <loic@dachary.org> wrote:
> >>>>
> >>>>
> >>>> On 21/10/2013 18:49, Gregory Farnum wrote:
> >>>>> I'm not quite sure what questions you're actually asking here...
> >>>>> In general, the OSD is not removed from the system without explicit
> >>>>> admin intervention. When it is removed, all traces of it should be
> >>>>> zapped (including its key), so it can't reconnect.
> >>>>> If it hasn't been removed, then indeed it will continue working
> >>>>> properly even if moved to a different box.
> >>>>
> >>>> If there is an external journal, the device containing the journal needs to be moved with the device containing the data. If I read ceph/src/upstart/ceph-osd.conf correctly, when the data device is plugged in the new machine it will fail to start because the journal is not there yet. When the journal device is plugged in, the ceph-osd.conf would be called because udev rule in ceph/udev/95-ceph-osd.rules call ceph-disk activate-journal.
> >>>>
> >>>> Is my understanding correct ?
> >>>
> >>> Well, after being wrong last time I'm a little reluctant to make
> >>> pronouncements from memory, but that definitely sounds correct to me.
> >>
> >> Yep, that's how it's supposed to work.  The activate-journal piece is 
> >> somewhat recent though (I think maybe it wasn't in place for cuttlefish?).
> >>
> >>> :) If I were doing an audit I'd want to look at what happens if there
> >>> is a wrong journal in the correct location, etc.
> >>
> >> The ceph-osd will fail on start because the uuid/fsid doesn't match.
> >>
> >> sage
> >>
> > 
> 
> -- 
> Lo?c Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do nothing.
> 
> 
