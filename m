From: Sage Weil <sage@inktank.com>
Subject: Re: Slow request in XFS
Date: Thu, 31 Jan 2013 12:00:48 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301311159460.807@cobra.newdream.net>
References: <6F3FA899187F0043BA1827A69DA2F7CC5EA81F@SHSMSX102.ccr.corp.intel.com> <alpine.DEB.2.00.1301310441590.11107@cobra.newdream.net> <510A8AA0.6000508@sandia.gov>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39243 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928Ab3AaUAt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 31 Jan 2013 15:00:49 -0500
In-Reply-To: <510A8AA0.6000508@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 31 Jan 2013, Jim Schutt wrote:
> On 01/31/2013 05:43 AM, Sage Weil wrote:
> > Hi-
> > 
> > Can you reproduce this with logs?  It looks like there are a few ops that 
> > are hanging for a very long time, but there isn't enough information here 
> > except to point to osds 610, 612, 615, and 68...
> 
> FWIW, I have a small pile of disks with bad sections in
> them - these sections aren't bad enough that writes fail,
> but they are bad enough that throughput drops by a factor
> of ~20.
> 
> Do OSDs already collect statistics on, say, op commit
> elapsed time (assuming that's the statistic most directly
> related to slow writes on only some sections of a disk),
> in a way that could be used to diagnose such disks?
> 
> If not, is there enough structure already in place that
> it would be easy to add?

They're tracking it internally, but it gets averaged into the totals 
before a user gets to see any per-request latencies.  The per-daemon 
totals are available via the admin socket 'perf dump' command.  Have you 
looked at that information yet?

sage
