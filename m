From: Sage Weil <sweil@redhat.com>
Subject: Re: Tracker 12577 repair won't fix replica with bad digest
Date: Mon, 3 Aug 2015 18:41:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508031840210.32106@cobra.newdream.net>
References: <55C007F1.3000201@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43748 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753149AbbHDBlk (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 3 Aug 2015 21:41:40 -0400
In-Reply-To: <55C007F1.3000201@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>
Cc: Samuel Just <sjust@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Loic Dachary <loic@dachary.org>

On Mon, 3 Aug 2015, David Zafman wrote:
> Sage,
> 
> I restored the branch wip-digest-repair which merged post-hammer in pull
> request #4365.  Do you think that 4365 fixes the reported bug #12577?
> 
> I cherry-picked the 9 commits off of hammer-backports-next as pull request
> #5458 and assigned to Loic.

I suspect so... and conveniently we have dozens of PGs in this 
inconsistent state on the lab cluster that we can test the backport on.  
(I would do a simple vstart test first where you either inject a 
corruption or manually edit all copies of the object so that they match 
each other.)

sage

