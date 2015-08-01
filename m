From: Sage Weil <sage@newdream.net>
Subject: Re: Cluster Network & Public Network w.r.t XIO ?
Date: Fri, 31 Jul 2015 18:07:43 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507311805080.22099@cobra.newdream.net>
References: <20150801001253.GE2358@pika.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58566 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbHABHo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jul 2015 21:07:44 -0400
In-Reply-To: <20150801001253.GE2358@pika.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: kernel neophyte <neophyte.hacker001@gmail.com>, mbenjamin@redhat.com, vu@mellanox.com, raju kurunkad <raju.kurunkad@sandisk.com>, ceph-devel@vger.kernel.org

On Fri, 31 Jul 2015, Marcus Watts wrote:
> I promised information on my copy of wip-address.  It's not in as
> good a shape as I promised-- got pulled onto something else, so
> the last commit I made left it not building.  And it will definitely
> need more past that.
> 
> So here's where it lives right now,
> repo
> git@github.com:linuxbox2/linuxbox-ceph.git
> branch
> xio-firefly-mpc1
> 
> This is definitely on my "todo" list, and I plan to work on it next week.
> 
> I also plan to push a copy of this or something much like it, as a wip
> branch to the main ceph git, as soon as practical.

As a first step I'd rebase on master as any cleanup work done before 
that'll probably get shredded by the rebase conflicts.  This one is 
tedious unfortunately since every encode needs that features arg.  :(

Thanks, Marcus!
sage
