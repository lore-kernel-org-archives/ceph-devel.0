From: "Yan, Zheng" <zyan@redhat.com>
Subject: Re: [PATCH 0/4] ceph: allow ceph_d_revalidate to handle some cases under LOOKUP_RCU
Date: Wed, 6 Jul 2016 09:55:41 +0800
Message-ID: <E195472F-5AB6-45A8-83AF-AA1798207E9C@redhat.com>
References: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47346 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbcGFBzq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jul 2016 21:55:46 -0400
In-Reply-To: <1467736069-27140-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>


> On Jul 6, 2016, at 00:27, Jeff Layton <jlayton@redhat.com> wrote:
> 
> The basic idea with this set is to allow the kernel client to allow the
> client to do more d_revalidate functionality under the rcu_read_lock.
> The idea is basically to do what we can there while not blocking, and
> then return -ECHILD for the rest.
> 
> The only really questionable bit is the part where we need to take the
> d_lock in ceph_d_release. I think it should be largely uncontended, but
> it's still less than ideal. Maybe there is some way to handle that
> locklessly?
> 
> Also, it would be nice to not have to drop out of rcuwalk mode in order
> to run the lease renewal. It seems like the kind of thing that would be
> ideal to queue to a workqueue, but I don't see a way to do that without
> introducing a potential deadlock.
> 
> My teuthology run with it passed all but one test, which seems to have
> been an unrelated problem (though I could be wrong there).
> 
> Jeff Layton (4):
>  ceph: remove ceph_mdsc_lease_release
>  ceph: clear d_fsinfo pointer under d_lock
>  ceph: allow dentry_lease_is_valid to work under RCU walk
>  ceph: handle LOOKUP_RCU in ceph_d_revalidate
> 
> fs/ceph/dir.c        | 67 +++++++++++++++++++++++++++++++++++-----------------
> fs/ceph/mds_client.c | 41 --------------------------------
> fs/ceph/mds_client.h |  4 ----
> 3 files changed, 45 insertions(+), 67 deletions(-)

Reviewed-by: Yan, Zheng <zyan@redhat.com>


> 
> -- 
> 2.5.5
> 

