From: Sage Weil <sweil@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 13:06:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512031303010.19170@cobra.newdream.net>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com> <CAN=+7FU1z9w=dDZ8+qbvKu-_ucYEU8K0eKS99Pd6Ku=A=t2gWg@mail.gmail.com> <CO1PR02MB208B0C5A0B6995CC4EE87F5F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
 <1575682875.28391996.1449169755619.JavaMail.zimbra@redhat.com> <20151203191233.GA17144@ultraspiritum.redhat.com> <CAN=+7FVC5QU7Gz6qq9PPeVv3Nvkq0c0cbVNNcC+Rz-j7OcnHxQ@mail.gmail.com> <1928144476.28418457.1449170995351.JavaMail.zimbra@redhat.com>
 <CAN=+7FV1aFxmT8E_-=G4+OuOG=VotWV7PQv45zL3v3+mjDYbrQ@mail.gmail.com> <291788535.28463587.1449173661550.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48749 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754517AbbLCVG5 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 16:06:57 -0500
In-Reply-To: <291788535.28463587.1449173661550.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, Somnath Roy <Somnath.Roy@sandisk.com>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, ceph-devel@vger.kernel.org

On Thu, 3 Dec 2015, Casey Bodley wrote:
> > Well, yeah we are, it's just the actual Transaction structure which
> > wouldn't be dynamic -- the buffers and many other fields would still
> > hit the allocator.
> > -Sam
> 
> Sure. I was looking specifically at the tradeoffs between allocating
> and moving the Transaction object itself.
> 
> As it currently stands, the caller of ObjectStore can choose whether to
> allocate its Transactions on the heap, embed them in other objects, or
> put them on the stack for use with apply_transactions(). Switching to an
> interface built around unique_ptr forces all callers to use the heap. I'm
> advocating for an interface that doesn't.

That leaves us with either std::move or.. the raw Transaction* we have 
now.  Right?

> > > It's true that the move ctor has to do work. I counted 18 fields, half of
> > > which are integers, and the rest have move ctors themselves. But the cpu
> > > is good at integers. The win here is that you're not hitting the allocator
> > > in the fast path.

To be fair, many of these are also legacy that we can remove... possibly 
even now.  IIRC the only exposure to legacy encoded transactions (that use 
the tbl hackery) are journal items from an upgrade pre-hammer OSD that 
aren't flushed on upgrade.  We should have made the osd flush the journal 
before recording the 0_94_4 ondisk feature.  We could add another one to 
enforce that and rip all that code out now instead of waiting until 
after jewel... that would be satisfying (and I think an ondisk ceph-osd 
feature is enough here, then document that users should upgrade to 
hammer 0.94.6 or infernalis 9.2.1 before moving to jewel).

sage
