From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 12/12] mds: Avoid creating unnecessary snaprealm
Date: Tue, 2 Oct 2012 17:12:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210021710360.27524@cobra.newdream.net>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com> <1349168152-13281-12-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1210021129220.19966@cobra.newdream.net> <506B7CA8.9030505@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57873 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932810Ab2JCAMW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 20:12:22 -0400
In-Reply-To: <506B7CA8.9030505@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 3 Oct 2012, Yan, Zheng wrote:
> On 10/03/2012 02:31 AM, Sage Weil wrote:
> > Hi Yan,
> > 
> > This whole series looks great!  Sticking it in wip-mds and running it 
> > through the fs qa suite before merging it.
> > 
> > How are you testing these?  If you haven't seen it yet, there is an 'mds 
> > thrash exports' option that will make MDSs random migrate subtrees to each 
> > other that is great for shaking out bugs.  That and periodic daemon 
> > restarts (one of the first things we need to do on the clustered mds front 
> > is to get daemon restarting integrated into teuthology).
> > 
> 
> The patches are fixes for problems I encountered during playing MDS shutdown.
> I setup a 2 MDS cephfs and copied some data into it, deleted some directories
> whose authority is MDS.1, then shutdown MDS.1.
> 
> Most patches in this series are obvious. The two snaprealm related patches are
> workaround for a bug: replica inode's snaprealm->open is not true. The bug triggers
> assertion in CInode::pop_projected_snaprealm() if snaprealm is involved in cross
> authority rename.

Do you mind opening a ticket at tracker.newdream.net so we don't lose 
track of it?

Fsstress on a single mds turned up this:

2012-10-02T17:09:09.359 INFO:teuthology.task.ceph.mds.a.err:*** Caught signal (Segmentation fault) **
2012-10-02T17:09:09.359 INFO:teuthology.task.ceph.mds.a.err: in thread 7f8873a41700
2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: ceph version 0.52-949-ge8df6a7 (commit:e8df6a74cae66accb6682129c9c5ad33797f458c)
2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 1: /tmp/cephtest/binary/usr/local/bin/ceph-mds() [0x812b21]
2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 2: (()+0xfcb0) [0x7f88787b3cb0]
2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 3: (Server::handle_client_rename(MDRequest*)+0xa28) [0x53dc88]
2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 4: (Server::dispatch_client_request(MDRequest*)+0x4fb) [0x54123b]
2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 5: (Server::handle_client_request(MClientRequest*)+0x51d) [0x544a6d]
2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 6: (Server::dispatch(Message*)+0x2d3) [0x5452e3]
2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 7: (MDS::handle_deferrable_message(Message*)+0x91f) [0x4bc32f]
2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 8: (MDS::_dispatch(Message*)+0x9b6) [0x4cf8b6]
2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 9: (MDS::ms_dispatch(Message*)+0x21b) [0x4d0c3b]
2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 10: (DispatchQueue::entry()+0x711) [0x7eb301]
2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 11: (DispatchQueue::DispatchThread::entry()+0xd) [0x7713dd]
2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 12: (()+0x7e9a) [0x7f88787abe9a]
2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 13: (clone()+0x6d) [0x7f8876d534bd]
2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err:2012-10-02 17:09:09.349272 7f8873a41700 -1 *** Caught signal (Segmentation fault) **
2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: in thread 7f8873a41700

I don't have time right now to hunt this down, but you should be able to 
reproduce with qa/workunits/suites/fsstress.sh on top of ceph-fuse with 1 
mds.

Thanks!
sage

