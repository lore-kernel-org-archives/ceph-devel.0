From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 12/12] mds: Avoid creating unnecessary snaprealm
Date: Wed, 03 Oct 2012 19:44:00 +0800
Message-ID: <506C2500.5010905@intel.com>
References: <1349168152-13281-1-git-send-email-zheng.z.yan@intel.com> <1349168152-13281-12-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1210021129220.19966@cobra.newdream.net> <506B7CA8.9030505@intel.com> <alpine.DEB.2.00.1210021710360.27524@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26715 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753273Ab2JCLoD (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Oct 2012 07:44:03 -0400
In-Reply-To: <alpine.DEB.2.00.1210021710360.27524@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/03/2012 08:12 AM, Sage Weil wrote:
> On Wed, 3 Oct 2012, Yan, Zheng wrote:
>> On 10/03/2012 02:31 AM, Sage Weil wrote:
>>> Hi Yan,
>>>
>>> This whole series looks great!  Sticking it in wip-mds and running it 
>>> through the fs qa suite before merging it.
>>>
>>> How are you testing these?  If you haven't seen it yet, there is an 'mds 
>>> thrash exports' option that will make MDSs random migrate subtrees to each 
>>> other that is great for shaking out bugs.  That and periodic daemon 
>>> restarts (one of the first things we need to do on the clustered mds front 
>>> is to get daemon restarting integrated into teuthology).
>>>
>>
>> The patches are fixes for problems I encountered during playing MDS shutdown.
>> I setup a 2 MDS cephfs and copied some data into it, deleted some directories
>> whose authority is MDS.1, then shutdown MDS.1.
>>
>> Most patches in this series are obvious. The two snaprealm related patches are
>> workaround for a bug: replica inode's snaprealm->open is not true. The bug triggers
>> assertion in CInode::pop_projected_snaprealm() if snaprealm is involved in cross
>> authority rename.
> 
> Do you mind opening a ticket at tracker.newdream.net so we don't lose 
> track of it?

will do
> 
> Fsstress on a single mds turned up this:
> 
> 2012-10-02T17:09:09.359 INFO:teuthology.task.ceph.mds.a.err:*** Caught signal (Segmentation fault) **
> 2012-10-02T17:09:09.359 INFO:teuthology.task.ceph.mds.a.err: in thread 7f8873a41700
> 2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: ceph version 0.52-949-ge8df6a7 (commit:e8df6a74cae66accb6682129c9c5ad33797f458c)
> 2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 1: /tmp/cephtest/binary/usr/local/bin/ceph-mds() [0x812b21]
> 2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 2: (()+0xfcb0) [0x7f88787b3cb0]
> 2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 3: (Server::handle_client_rename(MDRequest*)+0xa28) [0x53dc88]
> 2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 4: (Server::dispatch_client_request(MDRequest*)+0x4fb) [0x54123b]
> 2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 5: (Server::handle_client_request(MClientRequest*)+0x51d) [0x544a6d]
> 2012-10-02T17:09:09.361 INFO:teuthology.task.ceph.mds.a.err: 6: (Server::dispatch(Message*)+0x2d3) [0x5452e3]
> 2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 7: (MDS::handle_deferrable_message(Message*)+0x91f) [0x4bc32f]
> 2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 8: (MDS::_dispatch(Message*)+0x9b6) [0x4cf8b6]
> 2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 9: (MDS::ms_dispatch(Message*)+0x21b) [0x4d0c3b]
> 2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 10: (DispatchQueue::entry()+0x711) [0x7eb301]
> 2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 11: (DispatchQueue::DispatchThread::entry()+0xd) [0x7713dd]
> 2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 12: (()+0x7e9a) [0x7f88787abe9a]
> 2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: 13: (clone()+0x6d) [0x7f8876d534bd]
> 2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err:2012-10-02 17:09:09.349272 7f8873a41700 -1 *** Caught signal (Segmentation fault) **
> 2012-10-02T17:09:09.362 INFO:teuthology.task.ceph.mds.a.err: in thread 7f8873a41700
> 
> I don't have time right now to hunt this down, but you should be able to 
> reproduce with qa/workunits/suites/fsstress.sh on top of ceph-fuse with 1 
> mds.
> 

this is a old stray reintegration bug, I just sent a patch to fix it.

Regards
Yan, Zheng
 

> Thanks!
> sage
> 

