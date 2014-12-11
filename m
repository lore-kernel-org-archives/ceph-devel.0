From: Sage Weil <sweil@redhat.com>
Subject: RE: wip-proxy-write branch
Date: Wed, 10 Dec 2014 22:40:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412102239050.15548@cobra.newdream.net>
References: <06E7D85B3BA36C4DB207FEDE871C5348968324@SHSMSX101.ccr.corp.intel.com> <alpine.DEB.2.00.1412102107080.15548@cobra.newdream.net> <06E7D85B3BA36C4DB207FEDE871C5348968346@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55318 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933824AbaLKGk2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 11 Dec 2014 01:40:28 -0500
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C5348968346@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 11 Dec 2014, Wang, Zhiqiang wrote:
> My understanding is that the code in wip-promote is close to be merged 
> into master. I don't want to delay this by pulling more stuff into this 
> branch. So I thought a new branch would be a good idea.

That's fine.  You can still submit a pull request from your branch to 
wip-promote (so that github only shows the new commits) for review.  
We've been putting DNM in the subject (do not merge) as a reminder that it 
shouldn't be merged in that state.

sage
