From: Sage Weil <sage@newdream.net>
Subject: Re: jewel -> master upgrade
Date: Tue, 28 Jun 2016 13:43:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1606281343110.8816@piezo.us.to>
References: <075b96eb-bee1-8618-74a3-a10da327fef2@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60965 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257AbcF1Nns (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2016 09:43:48 -0400
In-Reply-To: <075b96eb-bee1-8618-74a3-a10da327fef2@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 28 Jun 2016, Nathan Cutler wrote:
> I have been working on http://tracker.ceph.com/issues/14995 which has been
> causing lots of failures in the upgrade suites, and now I think I know why.
> 
> At the moment, the highest tag in jewel is v10.2.2, while in master the
> highest tag is v10.2.0 - this can be verified by doing "git describe" in both
> branches.
> 
> Since the version numbers of all the packages are derived from "git describe",
> we now have a situation where the package managers (rpm, dpkg, etc.) consider
> master packages (i.e. packages built from the master branch) to be _older_
> than jewel packages.
> 
> The solution, I guess, would be to add a v11.0.0 tag to master.

That would explain it.

We can just add a tag and not bother doing a release build for now... that 
is probably the simplest.  Any objections?

sage

