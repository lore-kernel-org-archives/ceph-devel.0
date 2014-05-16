From: Sage Weil <sage@inktank.com>
Subject: Re: XioMessenger (RDMA) Status Update
Date: Fri, 16 May 2014 12:15:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405161206240.32477@cobra.newdream.net>
References: <624098295.166.1400015293897.JavaMail.root@thunderbeast.private.linuxbox.com> <alpine.DEB.2.00.1405161058010.32477@cobra.newdream.net> <CAPYLRzjBSarp_u4mKcgKrFeF9yHYxo=KZKjxhfurvu6vFskNLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60381 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756626AbaEPTP3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 May 2014 15:15:29 -0400
In-Reply-To: <CAPYLRzjBSarp_u4mKcgKrFeF9yHYxo=KZKjxhfurvu6vFskNLg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "Matt W. Benjamin" <matt@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 16 May 2014, Gregory Farnum wrote:
> On Fri, May 16, 2014 at 11:21 AM, Sage Weil <sage@inktank.com> wrote:
> > Hi Matt,
> >
> > I've rebased this branch on top of master and pushed it to wip-xio in
> > ceph.git, and then opened a pull request to capture review:
> >
> >         https://github.com/ceph/ceph/pull/1819
> >
> > I would like to get some of the preliminary pieces into master sooner
> > rather than later so we can start cutting down on the size of the branch.
> > I've started by looking just first few patches that modify the Messenger
> > and made a few clean ups:
> >
> >  - use SimplePolicyMessage for SimpleMessenger, too, to avoid dup code
> >  - move PipeConnection into a separate header and tweak a few things to
> >    remove it from the generic Messenger/Message/Connection interface
> >  - cleaned up a bit of cruft from the original patch
> >  - resolved a few merge conflicts between firefly and master
> >
> > Before I get too far into this can you take a look?  I'd like to pull
> > *all* of the non-xio stuff to the top of the branch and get it in good
> > shape first.
> >
> > I think the next step for me is to look at how you've instantiated the
> > alternate xio messenger and clean up that interface.  This is probably
> > also a good time for us to get the entity_addr_t and entity_name_t stuff
> > sorted out.
> 
> Unfortunately, I think we need to get farther along before pulling any
> of this into master.

I agree. I'm just trying to get this cleaned up and ordered so that it can 
be sanely reviewed.  :)

> In particular, unless it's been updated since I looked at it last, the 
> SimplePolicyMessenger doesn't do anything right now and we're not sure 
> of whether the interface is actually helpful. We can perhaps do some of 
> the multi-messenger support bits, but the internal interface changes 
> really need to wait until we've verified that it's possible to implement 
> a non-TCP messenger with them before it's worth making the TCP stuff 
> follow their rules.

The SimplePolicyMessenger piece just pull the get/set Policy stuff out of 
SimpleMessenger into a parent class; nothing more.  The multiplexer is 
something else (which I can't find in that branch at the moment!).

So far everything I've looked at has been a nice cleanup of the abstract 
interface.  The next thing I'm concerned about is something akin to a sane 
factory method so that (hopefully) the explicit SimpleMessenger references 
can be dropped from other parts of the code.  I'm not touching the xio 
bits yet, although it looks like that will quickly lead us to some 
other core pieces like buffer support for xio.

Don't worry--none of this will get merged until it is cleaned up, 
reviewed, and tested!

sage

