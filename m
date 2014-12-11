From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: wip-proxy-write branch
Date: Thu, 11 Dec 2014 05:20:53 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C5348968346@SHSMSX101.ccr.corp.intel.com>
References: <06E7D85B3BA36C4DB207FEDE871C5348968324@SHSMSX101.ccr.corp.intel.com>
 <alpine.DEB.2.00.1412102107080.15548@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60594 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755400AbaLKFVG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Dec 2014 00:21:06 -0500
In-Reply-To: <alpine.DEB.2.00.1412102107080.15548@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

My understanding is that the code in wip-promote is close to be merged into master. I don't want to delay this by pulling more stuff into this branch. So I thought a new branch would be a good idea.

-----Original Message-----
From: Sage Weil [mailto:sweil@redhat.com] 
Sent: Thursday, December 11, 2014 1:08 PM
To: Wang, Zhiqiang
Cc: ceph-devel@vger.kernel.org
Subject: Re: wip-proxy-write branch

On Thu, 11 Dec 2014, Wang, Zhiqiang wrote:
> Hi Sage,
> 
> Can you pls create a new branch based on wip-promote, so that I can 
> push my proxy write code?

Not sure what you mean... you can base your branch on the ceph.git wip-promote, and submit a pull request to merge to that branch for review.  
It may need another rebase depending on how the qa run tonight goes, but it's pretty close!

sage
