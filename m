From: Sage Weil <sage@newdream.net>
Subject: Re: HEALTH_ERR when (re)starting ceph-osd's
Date: Thu, 28 Jan 2016 10:25:23 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601281024410.6710@cpach.fuggernut.com>
References: <0ec5364ea10c41a687edca2bfe7818e6@R01UKEXCASM115.r01.fujitsu.local> <56AA0B93.8050105@42on.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35164 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144AbcA1PZM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 10:25:12 -0500
In-Reply-To: <56AA0B93.8050105@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: "Piotr.Dalek@ts.fujitsu.com" <Piotr.Dalek@ts.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 28 Jan 2016, Wido den Hollander wrote:
> On 28-01-16 11:48, Piotr.Dalek@ts.fujitsu.com wrote:
> > One solution to this would be to mark pg_stat.last_* fields to the 
> > point where it were first seen, so they will become stuck 
> > (mon_pg_stuck_threshold) seconds after first registering, and not 
> > right away.
> 
> That sounds like a good solution, you might want to take a look at:
> http://tracker.ceph.com/issues/14028

I think this makes the most sense.. most of the last_* fields should 
basically be inferred to be the creation stamp if they are empty.

sage

