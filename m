From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 00/39] fixes for MDS cluster recovery
Date: Mon, 01 Apr 2013 16:46:37 +0800
Message-ID: <5159496D.6040002@intel.com>
References: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31989 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021Ab3DAIqu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 1 Apr 2013 04:46:50 -0400
In-Reply-To: <1363531902-24909-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com, greg@inktank.com

On 03/17/2013 10:51 PM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> This serie fixes issues I encountered when running random MDS restart tests.
> With these patches, my 3 MDS setup that runs fsstress + thrash_exports can
> survive restarting one or two MDS dozens of times.
> 
> But there still are lots of unsolved problems, Sometimes rstat corruption,
> request hangs ...
> 
> This patch series are also in:
>   git://github.com/ukernel/ceph.git wip-mds
> 

I rebased these patches. Replaced patch 5 and patch 6 with two new patches.

[PATCH] mds: avoid sending duplicated table prepare/commit
[PATCH] mds: don't roll back prepared table updates

Regards
Yan, Zheng
