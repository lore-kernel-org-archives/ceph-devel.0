From: Sage Weil <sage@newdream.net>
Subject: Re: XFS lock warnings in nightly tests
Date: Wed, 15 Feb 2012 11:13:51 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1202151109430.2794@cobra.newdream.net>
References: <1329330809.3385.68.camel@doink>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48644 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab2BOTNw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2012 14:13:52 -0500
In-Reply-To: <1329330809.3385.68.camel@doink>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 15 Feb 2012, Alex Elder wrote:
> Sage brought to my attention some lockdep reports that
> were showing up due to XFS problems last night.  I
> discussed it on the XFS IRC channel and now have an
> XFS patch I would like to test to verify it fixes it.
> 
> But I am not sure what test I can run to reproduce the
> problem.

The warning came up on the testrados snap workloads, which means they are 
creating lots of snapshots/clones of objects, and probably triggering lots 
of sync(2) calls.  Other than that, it's going to be some partial file 
overwrites, sparse files, and copies, and unlinks.

We could run the test with filestore logging on to get a better picture of 
the workload, but I bet you can reproduce it with an ad hoc test (maybe 
fsx + sync in a loop?).  Maybe there's something to infer from the warning 
itself..

sage

