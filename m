From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] Fix for corrupted ceph cluster
Date: Wed, 5 Mar 2014 15:12:45 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1403051512030.3593@cobra.newdream.net>
References: <52F9C7A1.3060705@b1-systems.de> <5317AD58.1060705@b1-systems.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40275 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756732AbaCEXMq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Mar 2014 18:12:46 -0500
In-Reply-To: <5317AD58.1060705@b1-systems.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Poelzleithner <poelzleithner@b1-systems.de>
Cc: ceph-devel@vger.kernel.org

On Thu, 6 Mar 2014, Daniel Poelzleithner wrote:
> On 02/11/2014 07:48 AM, Daniel Poelzleithner wrote:
> 
> > I wrote a small patch that ignores object_trim requests when he does not
> > find the context of this request.
> > We have a node that fails to start permanently and there is no way to
> > get all nodes back up.
> [...]
> > This is regarding bug http://tracker.ceph.com/issues/6101
> 
> The patch now ran for 2 weeks and the 4th node is working again.
> I think this patch is safe to apply, but not fixing the underlying problem.
> Some state in ceph causes the delete event to be triggered every some
> seconds and causes a log entry to be generated.
> 
> Do you need more informations to find the cause ? This definitely is
> some wired internal state and is no race condition.

Can you try, instead of the discard_event, to do

    post_event(SnapTrim());
    return transit< WaitingOnReplicas >();

and see if that lets it move past the bad entry?

Thanks-
sage
