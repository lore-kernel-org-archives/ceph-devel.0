From: Sage Weil <sage@newdream.net>
Subject: Re: bug report:   in ceph-mon
Date: Fri, 17 Feb 2012 21:34:28 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202172132475.22397@cobra.newdream.net>
References: <e2d746d7b9ded9831b29f70291d916fd@pl1.haspere.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44416 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2BRFe2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Feb 2012 00:34:28 -0500
In-Reply-To: <e2d746d7b9ded9831b29f70291d916fd@pl1.haspere.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Cc: Ceph Devel <ceph-devel@vger.kernel.org>

Hi Dyweni,

I fixed this earlier today, commit 
db41bdda7e02aedc42d14be635b19075b112baf0.  This'll be included in the 
v0.42 release, which I'm just starting the build on now.

Thanks for the report!

sage


On Fri, 17 Feb 2012, Dyweni - Ceph-Devel wrote:

> Hi List,
> 
> FYI
> 
> I tripped across a bug when adding a new monitor into an existing cluster
> (see attached). I was on GIT commit
> 4b3bb5ab37a05fa001d59f24da7d9c30d650321b.
> 
> I found that the function 'bool Paxos::is_consistent()' was added in commit
> 0bd545f5d6beb790e67fe2ee61f57d2ed6332531.
> 
> I reset back to commit 3a7bb9999b49641ee28cac91e493aa4c231ede54 (it's
> parent) and it has gone away.
> 
> -- 
> Thanks,
> Dyweni
