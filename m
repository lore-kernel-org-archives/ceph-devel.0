From: Sage Weil <sweil@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was:
 mon daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 11:43:47 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604071143000.19675@cpach.fuggernut.com>
References: <5703A7FF.2090002@suse.com> <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com> <5704C76C.2050408@suse.com> <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com> <570666AB.8090408@suse.com> <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
 <57067F56.2000705@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756497AbcDGPnw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Apr 2016 11:43:52 -0400
In-Reply-To: <57067F56.2000705@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com

On Thu, 7 Apr 2016, Owen Synge wrote:
> On 04/07/2016 04:03 PM, Sage Weil wrote:
> > On Thu, 7 Apr 2016, Owen Synge wrote:
> >> Hi Sage,
> >>
> >> On 04/07/2016 02:26 PM, Sage Weil wrote:
> >>> Hi Owen,
> >>>
> >>> I never really liked ceph-create-keys either, but it simplified the 
> >>> deployment process.  
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
> 
> Are you intending to get this into Jewel?
> 
> I had assumed this would only be done on master, and only come into the
> next release.

Yeah, too late for jewel.

> As a change to master I felt that we could just do (A) as soon as
> ceph-deploy works without the mon boot up scripts calling
> ceph-create-keys, ideally without having  ceph-create-keys in
> ceph-deploy's process.
> 
> We can then file bugs as needed against other install processes that
> depend on ceph-create-keys, and they can test against master.

That works for me.

sage
