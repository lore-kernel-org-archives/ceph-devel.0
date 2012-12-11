From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 00/14] fixes for MDS
Date: Tue, 11 Dec 2012 09:11:12 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212110909380.32154@cobra.newdream.net>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com> <50C6EFC2.8060309@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49242 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754150Ab2LKRLN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Dec 2012 12:11:13 -0500
In-Reply-To: <50C6EFC2.8060309@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 11 Dec 2012, Yan, Zheng wrote:
> On 12/11/2012 04:30 PM, Yan, Zheng wrote:
> > From: "Yan, Zheng" <zheng.z.yan@intel.com>
> > 
> > The first patch fixes a journal bug that may corrupt the rstat accounting,
> > I think it should be included in the next release. The rest patches fix
> > various issues I encountered when running 3 MDSs with thrash_exports==1.
> > 

Applied to next, thanks!

> These patches are also in:
>   git://github.com/ukernel/ceph.git wip-mds

Ah, much easier than git-am.  :)

sage

> 
> > Regards
> > Yan, Zheng
> > 
> 
> 
