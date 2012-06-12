From: "Yan, Zheng" <zheng.z.yan@linux.intel.com>
Subject: Re: [PATCH 09/13] libceph: start tracking connection socket state
Date: Tue, 12 Jun 2012 13:02:34 +0800
Message-ID: <4FD6CD6A.9040505@linux.intel.com>
References: <4FC673FC.3060004@inktank.com> <4FC6766B.1090307@inktank.com> <CAAM7YA=4M_NQq03UCiEO=RQ=D3d3LHq1T9fbCkiqBxvv-AQyLA@mail.gmail.com> <Pine.LNX.4.64.1206112158170.10716@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20227 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283Ab2FLFCf (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jun 2012 01:02:35 -0400
In-Reply-To: <Pine.LNX.4.64.1206112158170.10716@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

On 06/12/2012 01:00 PM, Sage Weil wrote:
> Yep.  This was just fixed yesterday, in the testing-next branch, by 
> 'libceph: transition socket state prior to actual connect'.
> 
> Are you still hitting the bio null deref?
> 
No,

Cheers
Yan, Zheng


