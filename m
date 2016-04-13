From: Sage Weil <sage@newdream.net>
Subject: Re: ceph-qa-suite branching (merge it into ceph.git?)
Date: Wed, 13 Apr 2016 08:45:06 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604130844430.29593@cpach.fuggernut.com>
References: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45000 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759953AbcDMMpJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 08:45:09 -0400
In-Reply-To: <CALe9h7fp=qaio8npS0naXjCp9bbg-kkB6bXG9PcGXGftvD4puA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, ceph-qa <ceph-qa@ceph.com>

On Wed, 13 Apr 2016, John Spray wrote:
> Lately, we've instances where ceph.git and ceph-qa-suite.git got
> slightly out of sync, as we were adding new stuff and interface
> changes to ceph (especially in cephfs).
> 
> We used to have two repos (ceph and teuthology), now we have three
> (ceph, ceph-qa-suite and teuthology).  Splitting tests out of
> teuthology was a good thing, but maybe they should have gone into the
> ceph tree instead of a new repo?  The ceph-qa-suite branching seems to
> pretty much mirror what we do with ceph, with master vs jewel etc.
> 
> Historically we had a comparatively static set of workloads in the qa
> suite (e.g. kernel-untar-build, fsstresss, pjd), which didn't change
> much with ceph changes.  But these days we're adding much more
> detailed tests, so there's more effort to keep the two in sync.
> 
> I would personally love to be able to have a single PR that contained
> my code and the tests for it.  What if after Jewel we pulled all of
> ceph-qa-suite into the ceph repo?
> 
> We could still enable folks running test changes without having to
> rebuild ceph packages: the suite sha1 selected when running a
> teuthology suite could still be different from that used for
> installing ceph, it's just that it would fetch that sha1 from the ceph
> repo instead of from a separate repo.

This sounds pretty appealing to me...

sage
