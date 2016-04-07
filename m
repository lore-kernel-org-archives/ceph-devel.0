From: Sage Weil <sweil@redhat.com>
Subject: Re: The fundamental evil of "magic" in computing systems -> Was:
 mon daemon makes authentication side effects on startup
Date: Thu, 7 Apr 2016 10:03:40 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604070959160.19675@cpach.fuggernut.com>
References: <5703A7FF.2090002@suse.com> <CAJ4mKGZ=jXt-szAEchxerW6iBAngpa9Rd1i-mSY_BLWXPJ7aOw@mail.gmail.com> <5704C76C.2050408@suse.com> <alpine.DEB.2.11.1604070820560.19675@cpach.fuggernut.com> <570666AB.8090408@suse.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42683 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751436AbcDGODq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Apr 2016 10:03:46 -0400
In-Reply-To: <570666AB.8090408@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ldachary@redhat.com

On Thu, 7 Apr 2016, Owen Synge wrote:
> Hi Sage,
> 
> On 04/07/2016 02:26 PM, Sage Weil wrote:
> > Hi Owen,
> > 
> > I never really liked ceph-create-keys either, but it simplified the 
> > deployment process.  
> 
> I would propose we do this in two stages.
> 
> (A) Remove calling the command from the init scripts as a side effect of
> starting the mon.
> 
> This allows us to get most of the issues solved.
> 
> (B) Remove the command.
> 
> This is the long term goal, which is not as urgent in my opinion but
> others may disagree.

Works for me.  We just need to change ceph-deploy and get the other 
install/deploy tool folks on board before A.

> > I have no problem with removing it as long as we make
> > sure the deployment process doesn't too much harder for ceph-deploy users.
> 
> The documentation for the manual process without using ceph-deploy will
> need to be changed if we remove calling ceph-create-keys from the boot
> scripts.

Yeah.

> For ceph-deploy users I think we should see if any changes to the
> process are needed, the next question is will any be wanted?

Actually, thinking about it a bit more, I don't think ceph-deploy usage 
has to change at all.  The old way was

 1. ceph-create-keys creates and installs the keys on the mons
 2. ceph-deploy gatherkeys or create-initial slurps them up

We can just change ceph-deploy so it creates and stores them locally, and 
doesn't store them on the mons at all.  Users don't get the side-effect 
that the mons have the keys installed, but that is arguably better anyway.

> https://github.com/SUSE/ceph-deploy/commit/58b030dbe0a964b32f1fbc9a3762e64dd74bf50c

Instead of this, it should do the same steps as ceph-create-keys (use the 
mon. internal key to authenticate to create the admin and bootstrap 
keys), but just write them to the local ceph-dpeloy work dir.

sage
