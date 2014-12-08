From: Sage Weil <sage@newdream.net>
Subject: Re: wip-claim-2
Date: Mon, 8 Dec 2014 13:59:48 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412081357370.10613@cobra.newdream.net>
References: <1732608241.235.1418075296547.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47227 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbaLHV7s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Dec 2014 16:59:48 -0500
In-Reply-To: <1732608241.235.1418075296547.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 8 Dec 2014, Matt W. Benjamin wrote:
> Hi devs,
> 
> We've created a new branch wip-claim-2, and new pull request https://github.com/linuxbox2/linuxbox-ceph/pull/3
> based on review feedback.
> 
> The big change is to replace "volatile" with "sharable", and replace "strong_claim()" with "clone_nonsharable()."
> This may not be perfect, feedback appreciated.  It does remove the overloading of "claim()", which people found
> confusing.

I made a few comments, but overall it looks okay to me.  Can you make the 
next pull request against the github.com/ceph/ceph repo instead of your 
clone?

	https://github.com/ceph/ceph/compare

Thanks!
sage

