From: Sage Weil <sage@newdream.net>
Subject: Re: High memory usage kills OSD while peering
Date: Fri, 25 Aug 2017 22:49:00 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708252248310.20435@piezo.novalocal>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com> <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com> <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com> <CAFehDbCzt=Ezffz+D7QQNM4PaPaDTJqU+dm1AhjmNHjw1W1FcA@mail.gmail.com>
 <alpine.DEB.2.11.1708222230080.17029@piezo.novalocal> <cf976b97-5173-cf89-010f-a3d492944304@gmail.com> <alpine.DEB.2.11.1708231343470.20435@piezo.novalocal> <e79cb096-bb5c-5e1c-5e03-5ca8b324b9e2@gmail.com> <alpine.DEB.2.11.1708240351220.20435@piezo.novalocal>
 <12a4771a-dab2-3e98-c925-119b09c2d2d0@gmail.com> <alpine.DEB.2.11.1708252243080.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47939 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933361AbdHYWtD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Aug 2017 18:49:03 -0400
In-Reply-To: <alpine.DEB.2.11.1708252243080.20435@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Linux Chips <linux.chips@gmail.com>
Cc: Mustafa Muhammad <mustafa1024m@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 25 Aug 2017, Sage Weil wrote:
> On Sat, 26 Aug 2017, Linux Chips wrote:
> > I read about the prune thing in the release notes, so when our attempts failed
> > to start the cluster, we tried upgrading, but it did not help. it turned out
> > that we missed the 'ceph osd require-osd-release luminous' thing. I mean we
> > was looking on the command in the release notes upgrade section, and said to
> > each other "it dose not matter, it would only restrict the old osds from
> > joining" and moved on. damn, we would be up a week ago.
> > having said that, I think the release notes should highlight this in the
> > future.
> 
> Good point--I'll update the wording to make it clear that a lot of new 
> behavior does not kick in until the switch is flipped.

Is this better?

	https://github.com/ceph/ceph/pull/17270

Thanks!
sage
