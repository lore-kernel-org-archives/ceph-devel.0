From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: [PATCH v4 0/6] ceph: don't request caps for idle open files
Date: Thu, 5 Mar 2020 20:23:10 +0800
Message-ID: <CAAM7YAmWyBFjRKkAL+kGZB+=biu1=HP3FzL-_04d6U6+HRA8=A@mail.gmail.com>
References: <20200304173258.48377-1-zyan@redhat.com> <9922f9e850f52fd68bc67be675d7571fc9bb55f1.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33593 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCEMXX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Mar 2020 07:23:23 -0500
Received: by mail-qt1-f195.google.com with SMTP id d22so3951112qtn.0
        for <ceph-devel@vger.kernel.org>; Thu, 05 Mar 2020 04:23:22 -0800 (PST)
In-Reply-To: <9922f9e850f52fd68bc67be675d7571fc9bb55f1.camel@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Mar 5, 2020 at 1:50 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Thu, 2020-03-05 at 01:32 +0800, Yan, Zheng wrote:
> > This series make cephfs client not request caps for open files that
> > idle for a long time. For the case that one active client and multiple
> > standby clients open the same file, this increase the possibility that
> > mds issues exclusive caps to the active client.
> >
> > Yan, Zheng (6):
> >   ceph: always renew caps if mds_wanted is insufficient
> >   ceph: consider inode's last read/write when calculating wanted caps
> >   ceph: remove delay check logic from ceph_check_caps()
> >   ceph: simplify calling of ceph_get_fmode()
> >   ceph: update i_requested_max_size only when sending cap msg to auth mds
> >   ceph: check all mds' caps after page writeback
> >
> >  fs/ceph/caps.c               | 338 ++++++++++++++++-------------------
> >  fs/ceph/file.c               |  45 ++---
> >  fs/ceph/inode.c              |  21 +--
> >  fs/ceph/ioctl.c              |   2 +
> >  fs/ceph/mds_client.c         |   5 -
> >  fs/ceph/super.h              |  37 ++--
> >  include/linux/ceph/ceph_fs.h |   1 +
> >  7 files changed, 202 insertions(+), 247 deletions(-)
> >
> > changes since v2
> >  - make __ceph_caps_file_wanted() more readable
> >  - add patch 5 and 6, which fix hung write during testing patch 1~4
> >
> > changes since v3
> >  - don't queue delayed cap check for snap inode
> >  - initialize ci->{last_rd,last_wr} to jiffies - 3600 * HZ
> >  - make __ceph_caps_file_wanted() check inode type
> >
>
> I just tried this out, and it still seems to kill unlink performance
> with -o nowsync. From the script I posted to the other thread:
>
> --------8<--------
> $ ./test-async-dirops.sh
>   File: /mnt/cephfs/test-dirops.1401
>   Size: 0               Blocks: 0          IO Block: 65536  directory
> Device: 26h/38d Inode: 1099511627778  Links: 2
> Access: (0775/drwxrwxr-x)  Uid: ( 4447/ jlayton)   Gid: ( 4447/ jlayton)
> Context: system_u:object_r:cephfs_t:s0
> Access: 2020-03-04 12:42:03.914006772 -0500
> Modify: 2020-03-04 12:42:03.914006772 -0500
> Change: 2020-03-04 12:42:03.914006772 -0500
>  Birth: 2020-03-04 12:42:03.914006772 -0500
> Creating files in /mnt/cephfs/test-dirops.1401
>
> real    0m6.269s
> user    0m0.123s
> sys     0m0.454s
>
> sync
>
> real    0m5.358s
> user    0m0.003s
> sys     0m0.011s
> Starting rm
>
> real    0m18.932s
> user    0m0.169s
> sys     0m0.713s
>
> rmdir
>
> real    0m0.135s
> user    0m0.000s
> sys     0m0.002s
>
> sync
>
> real    0m1.725s
> user    0m0.000s
> sys     0m0.002s
> --------8<--------
>
> Create and sync parts look reasonable. Usually, the rm part finishes in
> less than a second as we end up doing most of the removes
> asynchronously, but here it didn't. I suspect that means that unlink
> didn't get caps for some reason, but I'd need to do some debugging to
> figure out what's actually happening.
>

patch 7 of version 5 should fix rm issue
> --
> Jeff Layton <jlayton@kernel.org>
>
