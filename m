From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH] Revert "libceph: use memalloc flags for net IO"
Date: Tue, 07 Apr 2015 10:41:53 -0500
Message-ID: <5523FAC1.9050403@redhat.com>
References: <1428414024-47769-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60670 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483AbbDGPoG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Apr 2015 11:44:06 -0400
In-Reply-To: <1428414024-47769-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Mike Christie <michaelc@cs.wisc.edu>, Mel Gorman <mgorman@suse.de>, Sage Weil <sage@redhat.com>

On 04/07/2015 08:40 AM, Ilya Dryomov wrote:
> This reverts commit 89baaa570ab0b476db09408d209578cfed700e9f.
> 
> Dirty page throttling should be sufficient for us in the general case
> so there is no need to use __GFP_MEMALLOC - it would be needed only in
> the swap-over-rbd case, which we currently don't support.  (It would
> probably take approximately the commit that is being reverted to add
> that support, but we would also need the "swap" option to distinguish
> from the general case and make sure swap ceph_client-s aren't shared
> with anything else.)  See ceph-devel threads [1] and [2] for the
> details of why enabling pfmemalloc reserves for all cases is a bad
> thing.
> 
> On top of potential system lockups related to drained emergency
> reserves, this turned out to cause ceph lockups in case peers are on
> the same host and communicating via loopback due to sk_filter()
> dropping pfmemalloc skbs on the receiving side because the receiving
> loopback socket is not tagged with SOCK_MEMALLOC.
> 
> [1] "SOCK_MEMALLOC vs loopback"
>     http://www.spinics.net/lists/ceph-devel/msg22998.html
> [2] "[PATCH] libceph: don't set memalloc flags in loopback case"
>     http://www.spinics.net/lists/ceph-devel/msg23392.html
> 
> Conflicts:
> 	net/ceph/messenger.c [ context: tcp_nodelay option ]
> 
> Cc: Mike Christie <michaelc@cs.wisc.edu>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Sage Weil <sage@redhat.com>
> Cc: stable@vger.kernel.org # 3.18+, needs backporting
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Yeah, I misunderstood the memalloc flag use.

Reviewed-by: Mike Christie <michaelc@cs.wisc.edu>

