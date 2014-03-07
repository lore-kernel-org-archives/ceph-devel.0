From: Sage Weil <sage@inktank.com>
Subject: Re: contraining crush placement possibilities
Date: Thu, 6 Mar 2014 21:03:05 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1403062055200.24219@cobra.newdream.net>
References: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net> <5319423B.7030402@ubuntukylin.com> <531942CF.2010202@ubuntukylin.com> <53194C79.20304@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36868 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbaCGFDH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Mar 2014 00:03:07 -0500
In-Reply-To: <53194C79.20304@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 7 Mar 2014, Li Wang wrote:
> Sorry, it is (n/3)*(n/3)*(n/3)/Cn3 = n^3/(27*Cn3)

Cn3 is "n choose 3"?

> > > > Last night it occurred to me that this is almost just having 
> > > > pgp_num < pg_num, but I think that's not quite right either.

Actually, maybe it is.  Basically, say there are X combinations of 3 disks 
= n choose 3.  Some fraction of these, say Y, are actually used by CRUSH.  
If we are to reduce that number, that implies that there are some PGs that 
are overlapping on the same set of disks.  Which more or less reduces to 
the case where pgp_num < pg_num, or the hashpspool flag isn't set, or any 
other behavior that makes more than one PG line up on the same disk.  
Just using fewer PGs in the system, in fact, would help here.  The main 
problem is that doing this tends to make the distribution less uniform, so 
there is a tradeoff.

There is a reliability model in ceph-tools.git at

	https://github.com/ceph/ceph-tools/tree/master/models/reliability

that Mark Kampe built last year.  Sadly I haven't looked at it closely so 
I'm not sure if it captures this.

sage
