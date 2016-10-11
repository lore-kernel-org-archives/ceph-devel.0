From: Sage Weil <sage@newdream.net>
Subject: Re: mempool update
Date: Tue, 11 Oct 2016 19:21:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610111920080.18626@piezo.us.to>
References: <alpine.DEB.2.11.1610101848410.18626@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33603 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbcJKTV4 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2016 15:21:56 -0400
In-Reply-To: <alpine.DEB.2.11.1610101848410.18626@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: allen.samuels@sandisk.com

On Mon, 10 Oct 2016, Sage Weil wrote:
> Here's the latest iteration:
> 
> 	https://github.com/liewegas/ceph/blob/wip-mempool/src/include/mempool.h

I've cleaned this up and it's ready for review and test.

	https://github.com/ceph/ceph/pull/11331

- fixed linking (libglobal now)
- generic asok command and config mempool_debug option (default false)
- can safely enable/disable debug at runtime

and a bunch of small fixes and cleanups!

sage
