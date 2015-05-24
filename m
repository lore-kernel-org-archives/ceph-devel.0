From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-ci.git?
Date: Sun, 24 May 2015 08:49:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1505240848300.6462@cobra.newdream.net>
References: <alpine.DEB.2.00.1505172130440.8350@cobra.newdream.net> <556049B9.9080906@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40782 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbbEXPt4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 24 May 2015 11:49:56 -0400
In-Reply-To: <556049B9.9080906@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: ceph-devel@vger.kernel.org

On Sat, 23 May 2015, Joao Eduardo Luis wrote:
> On 18/05/15 05:40, Sage Weil wrote:
> > As the number of people contributing code grows, we've added more and more
> > people to the github ceph org who have write access to ceph.git.  Those
> > people can merge pull requests and can also push branches directly to the
> > repo.
> > 
> > We also use ceph.git as a source for the test build infrastrucure
> > (gitbuilders) to generate packages for QA or hot fixes and make check
> > tests.  This leads to an every-growing body of wip-* branches in the repo
> > (which is annoying), and also means that in order to build something to
> > test in QA you also get the ability to (say) push directly to master.
> > 
> > How about we instead
> > 
> >   - create a second repo named something like ceph-ci.git (that's the best
> > I can come up with at the moment)
> >   - add this as a second source for all gitbuilders (they can poll a list)
> >   - move all wip-* branches here
> >   - create a new github team with contributing developers who can push to
> > this repo and are trusted not to wreak havoc on the builders
> >   - remove all the cruft from ceph.git, so that it's just master, next, the
> > stable branches, release tags, and anything else similarly important.
> >   - restrict ceph.git write access to core developers
> > 
> > This will improve security somewhat and reduce the risk of an accidental
> > push to an important branch.
> > 
> > It may also reduce the risk associated with accidental force pushes
> > (something we've hemmed and hawed about recently) by limiting the circle
> > of people who can write to ceph.git and also changing workflows so that it
> > is almost never used directly...
> 
> I think this is a great idea!
> 
> 'ceph-ci' also looks like a simple enough name conveying its purpose, even
> though the 'continuous' part is not necessarily true (but it's trivial to
> type, so it gets my vote).

I've created the ceph-gi repository.  I think the next step is to redo all 
the gitbuilders to pull form both sources.

	http://tracker.ceph.com/issues/11747

And then we'll need to change up the github groups and permissions

	http://tracker.ceph.com/issues/11748

sage
