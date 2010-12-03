From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH] msgr: Correctly handle half-open connections.
Date: Fri, 3 Dec 2010 10:18:36 -0700
Message-ID: <1291396716.4879.219.camel@sale659.sandia.gov>
References: <1291318895-11879-1-git-send-email-jaschut@sandia.gov>
 <1291323999.4879.198.camel@sale659.sandia.gov>
 <1291394903.4879.206.camel@sale659.sandia.gov>
 <AANLkTikmvnSDvOj5JZK+QmZtxQOFAeep-XyT3dm-LJ_J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:56236 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000Ab0LCRSr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Dec 2010 12:18:47 -0500
In-Reply-To: <AANLkTikmvnSDvOj5JZK+QmZtxQOFAeep-XyT3dm-LJ_J@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Fri, 2010-12-03 at 09:59 -0700, Gregory Farnum wrote:
> On Fri, Dec 3, 2010 at 8:48 AM, Jim Schutt <jaschut@sandia.gov> wrote:
> > I still see lots of clients resetting osds, but it has no
> > ill effects now.
> This at least is expected -- we realized a few months back that
> connections were never being removed from the OSD if the client
> crashed (didn't send a FIN notification) and had to implement
> timeouts. Having reasonably robust failure handling on each end meant
> we didn't need to do anything clever with keepalives, so we just left
> it. :)

Sure.  I only mention it because it suggests that 
when the osds are overloaded and causing the resets,
a little extra work is being done to handle them.

> 
> Separately,
> > This combination has survived the heaviest write loads
> > (64 clients against 13 osds) that I've tested with to date.
> How is this scaling for you on the client side? We're starting to do
> more large-scale testing but haven't gotten through much yet!

Well, I haven't been paying too much attention to performance 
yet, and my disks are old and slow (40 MB/s streaming write to
a raw block device), so it doesn't take very many clients
to saturate my osds.

However, I have noticed that aggregate throughput stays
about the same once I saturate the osds, no matter how
much load I add after that.

With my disks, 13 osds (1/server right now), 2 GiB journal 
partition, and replication level 2, I max out at 100-120 MB/s on
streaming writes from lots of clients.

I know that's not exactly what you were asking for, but
it's all I've got so far....

I'm about to start running with 16 osds/server.  
Stay tuned...

-- Jim

> -Greg
> 


