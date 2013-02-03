From: Sage Weil <sage@inktank.com>
Subject: Re: v0.56.2 released
Date: Sun, 3 Feb 2013 08:25:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302030824050.826@cobra.newdream.net>
References: <alpine.DEB.2.00.1301301540030.6225@cobra.newdream.net> <loom.20130203T163748-216@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38504 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab3BCQZG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Feb 2013 11:25:06 -0500
In-Reply-To: <loom.20130203T163748-216@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ArtemGr <artemciy@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Sun, 3 Feb 2013, ArtemGr wrote:
> Sage Weil <sage <at> inktank.com> writes:
> > The next bobtail point release is ready, and it's looking pretty good. 
> > This is an important update for the 0.56.x backport series that fixes a 
> > number of bugs and several performance issues. All v0.56.x users are 
> > encouraged to upgrade.
> 
> Is it just me, or is the Debian release missing?
> I have "deb http://ceph.com/debian-testing/ wheezy main" in "sources.list"
> and am not seeing the v0.56.2.

Try 'deb http://ceph.com/debian-bobtail/ wheezy main'.

It only got pushed to the bobtail repo, which is slightly awkward only 
because 0.57 isn't out yet.

sage
