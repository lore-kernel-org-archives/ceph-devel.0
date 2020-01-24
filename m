From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH v3 00/10] ceph: asynchronous file create support
Date: Fri, 24 Jan 2020 12:19:12 -0500
Message-ID: <c894860b08a36191e8556afd3cf4bdb19cd5875b.camel@kernel.org>
References: <20200121192928.469316-1-jlayton@kernel.org>
         <CAAM7YAnYoCuxu2Oj3vK1ZyWyAgh_vWWTYRxE2ZqEhU9vT+YTKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbgAXRTQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:19:16 -0500
In-Reply-To: <CAAM7YAnYoCuxu2Oj3vK1ZyWyAgh_vWWTYRxE2ZqEhU9vT+YTKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, idridryomov@gmail.com, Sage Weil <sage@redhat.com>, Zheng Yan <zyan@redhat.com>

On Thu, 2020-01-23 at 01:04 +0800, Yan, Zheng wrote:
> On Wed, Jan 22, 2020 at 3:31 AM Jeff Layton <jlayton@kernel.org> wrote:
> > v3:
> > - move some cephfs-specific code into ceph.ko
> > - present and track inode numbers as u64 values
> > - fix up check for dentry and cap eligibility checks
> > - set O_CEPH_EXCL on async creates
> > - attempt to handle errors better on async create (invalidate dentries
> >   and dir completeness).
> > - ensure that fsync waits for async create to complete
> > 
> > v2:
> > - move cached layout to dedicated field in inode
> > - protect cached layout with i_ceph_lock
> > - wipe cached layout in __check_cap_issue
> > - set max_size of file to layout.stripe_unit
> > - set truncate_size to (u64)-1
> > - use dedicated CephFS feature bit instead of CEPHFS_FEATURE_OCTOPUS
> > - set cap_id to 1 in async created inode
> > - allocate inode number before submitting request
> > - rework the prep for an async create to be more efficient
> > - don't allow MDS or cap messages involving an inode until we get async
> >   create reply
> > 
> > Still not quite ready for merge, but I've cleaned up a number of warts
> > in the v2 set. Performance numbers still look about the same.
> > 
> > There is definitely still a race of some sort that causes the client to
> > try to asynchronously create a dentry that already exists. I'm still
> > working on tracking that down.
> > 
> > Jeff Layton (10):
> >   ceph: move net/ceph/ceph_fs.c to fs/ceph/util.c
> >   ceph: make ceph_fill_inode non-static
> >   ceph: make dentry_lease_is_valid non-static
> >   ceph: make __take_cap_refs non-static
> >   ceph: decode interval_sets for delegated inos
> >   ceph: add flag to designate that a request is asynchronous
> >   ceph: add infrastructure for waiting for async create to complete
> >   ceph: add new MDS req field to hold delegated inode number
> >   ceph: cache layout in parent dir on first sync create
> >   ceph: attempt to do async create when possible
> > 
> >  fs/ceph/Makefile                     |   2 +-
> >  fs/ceph/caps.c                       |  38 +++--
> >  fs/ceph/dir.c                        |  13 +-
> >  fs/ceph/file.c                       | 240 +++++++++++++++++++++++++--
> >  fs/ceph/inode.c                      |  50 +++---
> >  fs/ceph/mds_client.c                 | 123 ++++++++++++--
> >  fs/ceph/mds_client.h                 |  17 +-
> >  fs/ceph/super.h                      |  16 +-
> >  net/ceph/ceph_fs.c => fs/ceph/util.c |   4 -
> >  include/linux/ceph/ceph_fs.h         |   8 +-
> >  net/ceph/Makefile                    |   2 +-
> >  11 files changed, 443 insertions(+), 70 deletions(-)
> >  rename net/ceph/ceph_fs.c => fs/ceph/util.c (94%)
> > 
> > --
> > 2.24.1
> > 
> 
> I realized that there still are two issues:
> -  we needs to clear delegated inos when mds failover

I'm guessing we need to do this whenever any session is reconnected,
right? I think we may have bigger problems here though:

The issue is that with this set we assign out ino_t's prior to
submitting the request. We could get down into it and find that we're
reconnecting the session. At that point, that ino_t is no longer valid
for the session.

> - we needs to clear caps for async dir operations when reconnecting to
> mds. (see last commit of https://github.com/ceph/ceph/pull/32576)
> 

I guess we can use ceph_iterate_session_caps to do this. That said,
looking at your patch:

        if (in->is_dir()) {                                                     
          // remove caps for async dir operations                               
          cap.implemented &= (CEPH_CAP_ANY_SHARED | CEPH_CAP_ANY_EXCL);         
        }                                                                       

We remove all but Fsx here. That seems like quite a subtle difference
from how FILE caps work.

Given the way that we're doing the inode delegation and handling dir
caps, I think we may need to rework things such that async requests
never get queued to the s_waiting list, and instead return some sort of
distinct error that cues the caller to fall back to a synchronous
request.

That would help prevent some of the potential races here.
-- 
Jeff Layton <jlayton@kernel.org>
