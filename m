From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 00/14] fixes for MDS
Date: Tue, 11 Dec 2012 16:33:06 +0800
Message-ID: <50C6EFC2.8060309@intel.com>
References: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55350 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab2LKIdK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 11 Dec 2012 03:33:10 -0500
In-Reply-To: <1355214660-26354-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com

On 12/11/2012 04:30 PM, Yan, Zheng wrote:
> From: "Yan, Zheng" <zheng.z.yan@intel.com>
> 
> The first patch fixes a journal bug that may corrupt the rstat accounting,
> I think it should be included in the next release. The rest patches fix
> various issues I encountered when running 3 MDSs with thrash_exports==1.
> 

These patches are also in:
  git://github.com/ukernel/ceph.git wip-mds

> Regards
> Yan, Zheng
> 

