From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC PATCH v2 00/10] ceph: asynchronous file create support
Date: Thu, 16 Jan 2020 09:15:57 -0500
Message-ID: <8fd8baf4cd6f5abc5d848a36e648f67dc1414b30.camel@kernel.org>
References: <20200115205912.38688-1-jlayton@kernel.org>
         <bf9f8483-c00f-4c2f-aadd-f9ca02757ae5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAPOP7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:15:59 -0500
In-Reply-To: <bf9f8483-c00f-4c2f-aadd-f9ca02757ae5@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: sage@redhat.com, idryomov@gmail.com, pdonnell@redhat.com, xiubli@redhat.com

On Thu, 2020-01-16 at 21:10 +0800, Yan, Zheng wrote:
> On 1/16/20 4:59 AM, Jeff Layton wrote:
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
> >    create reply
> > 
> > A lot of changes in this set, mostly based on Zheng and Xiubo's
> > comments. Performance is pretty similar to the previous set:
> > 
> > Untarring a kernel tarball into a cephfs takes about 98s with
> > async dirops disabled. With them enabled, it takes around 78s,
> > which is about a 25% improvement.
> > 
> > This is not quite ready for merge. Error handling could still be
> > improved. With xfstest generic/531, I see some messages like this pop
> > up in the ring buffer:
> > 
> >      [ 7331.393110] ceph: ceph_async_create_cb: inode number mismatch! err=0 deleg_ino=0x100001232d9 target=0x100001232b9
> > 
> 
> how about always set O_EXCL flag in async create request. It may help to 
> debug this issue.
> 

I was just thinking the same thing yesterday. I'll do that and we can
see what that turns up. Thanks!

> > Basically, we went to do an async create and got a different inode
> > number back than expected. That still needs investigation, but I
> > didn't see any test failures due to it.
> > 
> > Jeff Layton (10):
> >    libceph: export ceph_file_layout_is_valid
> >    ceph: make ceph_fill_inode non-static
> >    ceph: make dentry_lease_is_valid non-static
> >    ceph: make __take_cap_refs a public function
> >    ceph: decode interval_sets for delegated inos
> >    ceph: add flag to designate that a request is asynchronous
> >    ceph: add infrastructure for waiting for async create to complete
> >    ceph: add new MDS req field to hold delegated inode number
> >    ceph: cache layout in parent dir on first sync create
> >    ceph: attempt to do async create when possible
> > 
> >   fs/ceph/caps.c               |  34 ++++--
> >   fs/ceph/dir.c                |  13 ++-
> >   fs/ceph/file.c               | 218 +++++++++++++++++++++++++++++++++--
> >   fs/ceph/inode.c              |  50 ++++----
> >   fs/ceph/mds_client.c         | 126 ++++++++++++++++++--
> >   fs/ceph/mds_client.h         |   9 +-
> >   fs/ceph/super.h              |  16 ++-
> >   include/linux/ceph/ceph_fs.h |   8 +-
> >   net/ceph/ceph_fs.c           |   1 +
> >   9 files changed, 410 insertions(+), 65 deletions(-)
> > 

-- 
Jeff Layton <jlayton@kernel.org>
