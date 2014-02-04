From: Sage Weil <sage@inktank.com>
Subject: Re: firefly timing
Date: Mon, 3 Feb 2014 22:20:15 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1402032216080.17892@cobra.newdream.net>
References: <alpine.DEB.2.00.1402030819030.6345@cobra.newdream.net> <52F08535.50100@ubuntu.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35127 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaBDGUP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2014 01:20:15 -0500
In-Reply-To: <52F08535.50100@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Page <james.page@ubuntu.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 4 Feb 2014, James Page wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> On 03/02/14 18:21, Sage Weil wrote:
> > The only time dependency that I am aware of is the looming 14.04
> > freeze date.  I'm hoping that we can (worst case) put an -rc
> > release in place and update as the code stabilizes over the next
> > several weeks.  James, will this be problematic?
> 
> Pushing in an RC is a good approach; what's the likely date for the
> firefly release?  I can raise the Freeze Exception now which gives our
> release team *lots* of notice :-)  FWIW I don't think this will be a
> problem - we have a good track record with ceph in Ubuntu now.

If we take the usual 4 weeks, it will be the second week of March, and an 
-rc will come out in the last week of February.  The freeze will come 
before the trusty freeze, but an early -rc at that point will be 
relatively raw.  I assume it will be worth building, though, to minimize 
the number of hoops to jump through.  There are also several users who 
have expressed interest in an early build with EC support to star their 
testing.

sage
