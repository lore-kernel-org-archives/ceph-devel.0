From: Sage Weil <sage@inktank.com>
Subject: Re: ceph data store size
Date: Tue, 7 Aug 2012 15:06:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208071503490.19501@cobra.newdream.net>
References: <5018E379.4030208@lanning.cc> <50193021.7070009@widodh.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42239 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437Ab2HGWGw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 18:06:52 -0400
In-Reply-To: <50193021.7070009@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: lanning@lanning.cc, ceph development <ceph-devel@vger.kernel.org>

On Wed, 1 Aug 2012, Wido den Hollander wrote:
> On 08/01/2012 10:06 AM, Robert Hajime Lanning wrote:
> > Anyone using ceph on multi petabyte data stores?
> 
> I don't think so

DreamHost is!

> > For example, a cluster of 12 systems with a combined storage of 2.3P.
> > 
> 
> With 12 systems, you mean 12 servers with a lot of disks? That's roughly 200TB
> per server.
> 
> On that scale I don't think Ceph would work, it would mean you would need a
> HUGE amount of CPU and memory on those boxes to run the OSD's.
> 
> If you want to scale to 2.3P you should be looking in the direction of
> hunderds of small machines all storing a couple of TB.

You can also put ceph-osd daemons in front of large disk arrays, but that 
is a configuration we have less experience with to date.  That being the 
case, some users are actively evaluating that now, so we'll know soon how 
well it works out...

sage
