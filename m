From: Sage Weil <sweil@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was:
 mon daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 10:39:28 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604071037380.19675@cpach.fuggernut.com>
References: <5703A7FF.2090002@suse.com> <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com> <5704C76C.2050408@suse.com> <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com> <570666AB.8090408@suse.com> <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
 <CAJ4mKGb1O5UWHoYQKaqWOeaNJkWES509Gmesxkgu4ZP+8-TSpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2068838773-1460039971=:19675"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58684 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756061AbcDGOje (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Apr 2016 10:39:34 -0400
In-Reply-To: <CAJ4mKGb1O5UWHoYQKaqWOeaNJkWES509Gmesxkgu4ZP+8-TSpQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Owen Synge <osynge@suse.com>, Ceph Development <ceph-devel@vger.kernel.org>, Loic Dachary <ldachary@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2068838773-1460039971=:19675
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 7 Apr 2016, Gregory Farnum wrote:
> On Thu, Apr 7, 2016 at 7:03 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Thu, 7 Apr 2016, Owen Synge wrote:
> >> Hi Sage,
> >>
> >> On 04/07/2016 02:26 PM, Sage Weil wrote:
> >> > Hi Owen,
> >> >
> >> > I never really liked ceph-create-keys either, but it simplified the
> >> > deployment process.
> >>
> >> I would propose we do this in two stages.
> >>
> >> (A) Remove calling the command from the init scripts as a side effect of
> >> starting the mon.
> >>
> >> This allows us to get most of the issues solved.
> >>
> >> (B) Remove the command.
> >>
> >> This is the long term goal, which is not as urgent in my opinion but
> >> others may disagree.
> >
> > Works for me.  We just need to change ceph-deploy and get the other
> > install/deploy tool folks on board before A.
> >
> >> > I have no problem with removing it as long as we make
> >> > sure the deployment process doesn't too much harder for ceph-deploy users.
> >>
> >> The documentation for the manual process without using ceph-deploy will
> >> need to be changed if we remove calling ceph-create-keys from the boot
> >> scripts.
> >
> > Yeah.
> >
> >> For ceph-deploy users I think we should see if any changes to the
> >> process are needed, the next question is will any be wanted?
> >
> > Actually, thinking about it a bit more, I don't think ceph-deploy usage
> > has to change at all.  The old way was
> >
> >  1. ceph-create-keys creates and installs the keys on the mons
> >  2. ceph-deploy gatherkeys or create-initial slurps them up
> >
> > We can just change ceph-deploy so it creates and stores them locally, and
> > doesn't store them on the mons at all.  Users don't get the side-effect
> > that the mons have the keys installed, but that is arguably better anyway.
> 
> Note that this would mean users can only run "ceph -s" from a node
> that has explicitly installed the keys — if you are debugging a
> problem and ssh into the monitor node, you'll have to run fugly
> command lines pointing to the monitor's data directory and using a
> "mon." entity name in order to get any cluster debug info. :/

Yeah.  We could make 'mon create-initial' also install the admin (and 
maybe bootstrap) keys on the mon, and make a note in the manual 
ceph-deploy sequence about this (add 'ceph-deploy admin HOST' to the 
sequence).

sage
--8323329-2068838773-1460039971=:19675--
