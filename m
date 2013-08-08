From: Sage Weil <sage@inktank.com>
Subject: Re: github pull requests, comments and rebase
Date: Thu, 8 Aug 2013 13:46:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308081330300.29872@cobra.newdream.net>
References: <52036DAC.5040106@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56795 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966477Ab3HHUqM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Aug 2013 16:46:12 -0400
In-Reply-To: <52036DAC.5040106@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 8 Aug 2013, Loic Dachary wrote:
> Hi Sage,
> 
> During the discussions about continuous integration at the CDS this week ( http://youtu.be/cGosx5zD4FM?t=1h16m05s ) you mentionned that github was able to keep track of the successive versions of a pull request commit, even in the case of a rebase. I just tried the following:
> 
> a) comment on commit associated to https://github.com/ceph/ceph/pull/455 ( both inline and at the end of the commit )
> b) Christophe rebased the associated commit against master and git push --force to publish it
> c) The original commit  does not show up in https://github.com/ceph/ceph/pull/455  and the new commit, result of the rebase, https://github.com/kri5/ceph/commit/051b0c3e15c98714b95fca5cb7838de9614dc8e3 does not display my inline comments.
> 
> Do you to know a different workflow that would allow rebase and keep track of the different versions / comments of the pull request ? Something similar to what you have in gerrit with https://review.openstack.org/#/c/22708/ for example where you can see and compare the patch sets.

Well, blarney.  Yeah, it is not perfect.

The workflow that *does* work:

- open a pull
- comment on the rolled-up diff, e.g. 
https://github.com/ceph/ceph/pull/487/files
- re-push teh branch

and it will do a cute 'so and so commented on 3 old commits' thing.

This isn't always how people like to review, sadly.  I'm hopeful that 
github will suddenly get better and this problem will go way, but 
shouldn't hold my breath.

In my mind this isn't a deal-breaker... whatdoes everyone else think?

sage
