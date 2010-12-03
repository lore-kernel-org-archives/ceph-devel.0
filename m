From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] msgr: Correctly handle half-open connections.
Date: Fri, 3 Dec 2010 09:33:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1012030931300.1982@cobra.newdream.net>
References: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
 <1291323999.4879.198.camel@sale659.sandia.gov> <1291394903.4879.206.camel@sale659.sandia.gov>
 <AANLkTikmvnSDvOj5JZK+QmZtxQOFAeep-XyT3dm-LJ_J@mail.gmail.com>
 <1291396716.4879.219.camel@sale659.sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59039 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab0LCR25 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Dec 2010 12:28:57 -0500
In-Reply-To: <1291396716.4879.219.camel@sale659.sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: Gregory Farnum <gregf@hq.newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 3 Dec 2010, Jim Schutt wrote:
> On Fri, 2010-12-03 at 09:59 -0700, Gregory Farnum wrote:
> > On Fri, Dec 3, 2010 at 8:48 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> > > I still see lots of clients resetting osds, but it has no
> > > ill effects now.
> > This at least is expected -- we realized a few months back that
> > connections were never being removed from the OSD if the client
> > crashed (didn't send a FIN notification) and had to implement
> > timeouts. Having reasonably robust failure handling on each end meant
> > we didn't need to do anything clever with keepalives, so we just left
> > it. :)
> 
> Sure.  I only mention it because it suggests that 
> when the osds are overloaded and causing the resets,
> a little extra work is being done to handle them.

The timeouts can be disabled by mounting with '-o osdtimeout=0'.  It is 
really a bandaid to recover from OSD problems; in theory, with non-buggy 
functional osd clients, daemons, and msgr, they shouldn't be necessary.  
(Notably, the userspace osd client does not implement timeouts.)

sage
