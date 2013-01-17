From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 00/29] Various fixes for MDS
Date: Wed, 16 Jan 2013 16:28:17 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301161627320.17435@cobra.newdream.net>
References: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52133 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755637Ab3AQA2S (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 16 Jan 2013 19:28:18 -0500
In-Reply-To: <1357290140-17044-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

Hi Yan,

I reviewed these on the plane last night and they look good.  There was 
one small cleanup I pushed on top of wip-mds (in ceph.git).  I'll run this 
through our (still limited) fs suite and then merge into master.

Thanks!
sage

On Fri, 4 Jan 2013, Yan, Zheng wrote:

> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> This patch series fix various issues I encountered when running 3 MDS.
> I test this patch series by runing fsstress on two clients, using the
> same test directory. The MDS and clients could survived overnight test
> at times.
> 
> This patch series are also in:
>   git://github.com/ukernel/ceph.git wip-mds
> 
> 
