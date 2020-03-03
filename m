From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v3 0/6] ceph: don't request caps for idle open files
Date: Tue, 03 Mar 2020 15:17:39 -0500
Message-ID: <523329cc1778972c17ada75b19478a1444c65638.camel@kernel.org>
References: <20200228115550.6904-1-zyan@redhat.com>
         <186bfc2278dbdd4eac21f6ce03108c53e3f574b3.camel@kernel.org>
         <a226d5b6-2371-5c94-97ee-6bc5b273b21d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730862AbgCCURm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 3 Mar 2020 15:17:42 -0500
In-Reply-To: <a226d5b6-2371-5c94-97ee-6bc5b273b21d@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, ceph-devel@vger.kernel.org
Cc: Ilya Dryomov <idryomov@gmail.com>, Patrick Donnelly <pdonnell@redhat.com>

On Wed, 2020-03-04 at 00:23 +0800, Yan, Zheng wrote:
> On 3/3/20 3:53 AM, Jeff Layton wrote:
> > On Fri, 2020-02-28 at 19:55 +0800, Yan, Zheng wrote:
> > > This series make cephfs client not request caps for open files that
> > > idle for a long time. For the case that one active client and multiple
> > > standby clients open the same file, this increase the possibility that
> > > mds issues exclusive caps to the active client.
> > > 
> > > Yan, Zheng (4):
> > >    ceph: always renew caps if mds_wanted is insufficient
> > >    ceph: consider inode's last read/write when calculating wanted caps
> > >    ceph: simplify calling of ceph_get_fmode()
> > >    ceph: remove delay check logic from ceph_check_caps()
> > > 
> > >   fs/ceph/caps.c               | 324 +++++++++++++++--------------------
> > >   fs/ceph/file.c               |  39 ++---
> > >   fs/ceph/inode.c              |  19 +-
> > >   fs/ceph/ioctl.c              |   2 +
> > >   fs/ceph/mds_client.c         |   5 -
> > >   fs/ceph/super.h              |  35 ++--
> > >   include/linux/ceph/ceph_fs.h |   1 +
> > >   7 files changed, 188 insertions(+), 237 deletions(-)
> > > 
> > > changes since v2
> > >   - make __ceph_caps_file_wanted more readable
> > >   - add patch 5 and 6, which fix hung write during testing patch 1~4
> > > 
> > 
> > This patch series causes some serious slowdown in the async dirops
> > patches that I've not yet fully tracked down, and I suspect that they
> > may also be the culprit in these bugs:
> > 
> 
> slow down which tests?
> 

Most of the simple tests I was doing to sanity check async dirops.
Basically, this script was not seeing speed gain with async dirops
enabled:

-----------------8<-------------------
#!/bin/sh

MOUNTPOINT=/mnt/cephfs
TESTDIR=$MOUNTPOINT/test-dirops.$$

mkdir $TESTDIR
stat $TESTDIR
echo "Creating files in $TESTDIR"
time for i in `seq 1 10000`; do
    echo "foobarbaz" > $TESTDIR/$i
done
echo; echo "sync"
time sync
echo "Starting rm"
time rm -f $TESTDIR/*
echo; echo "rmdir"
time rmdir $TESTDIR
echo; echo "sync"
time sync
-----------------8<-------------------

It mostly seemed like it was just not getting caps in some cases.
Cranking up dynamic_debug seemed to make the problem go away, which led
me to believe there was probably a race condition in there.

At this point, I've gone ahead and merged the async dirops patches into
testing, so if you could rebase this on top of the current testing
branch and repost, I'll test them out again.

> >      https://tracker.ceph.com/issues/44381
> 
> this is because I forgot to check if inode is snap when queue delayed 
> check. But it can't explain slow down.
>

Ok, good to know.

> >      https://tracker.ceph.com/issues/44382
> > 
> > I'm going to drop this series from the testing branch for now, until we
> > can track down the issue.
> > 
> > 

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
