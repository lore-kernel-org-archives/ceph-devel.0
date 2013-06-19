From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 0/8] misc fixes for mds
Date: Wed, 19 Jun 2013 08:33:51 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306190826160.26222@cobra.newdream.net>
References: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51759 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756689Ab3FSPdw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 11:33:52 -0400
In-Reply-To: <1371471029-10589-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi Yan-

On Mon, 17 Jun 2013, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> these patches are also in:
>   git://github.com/ukernel/ceph.git wip-mds

Aside from the minor nit on the mseq patch, this looks good!  I'll pull in 
the existing branch to wip-mds and make that change on top, then run it 
through the fs suite.

By the way, in the future, these are a bit easier to review if you include 
more detail in the changelog to describe what situations these corner 
cases can happen in.

Thanks!
sage

