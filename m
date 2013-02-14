From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph] Fix more performance issues found by cppcheck (#51)
Date: Thu, 14 Feb 2013 11:40:28 -0800
Message-ID: <CAPYLRzgUfbOUqM56uGegpuA-qLr2DmKB=7RkxQPFVnWQOXy9kw@mail.gmail.com>
References: <ceph/ceph/pull/51@github.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52]:37960 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934858Ab3BNTk3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Feb 2013 14:40:29 -0500
Received: by mail-qe0-f52.google.com with SMTP id 6so1240295qeb.39
        for <ceph-devel@vger.kernel.org>; Thu, 14 Feb 2013 11:40:29 -0800 (PST)
In-Reply-To: <ceph/ceph/pull/51@github.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <dalgaaf@suse.de>, Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hey Danny,
I've merged in most of these (commit
ffda2eab4695af79abdc9ed9bf001c3cd662a1f2) but had comments on a
couple:
d99764e8c72a24eaba0542944f497cc2d9e154b4 is a patch on gtest. We did
import that wholesale into our repository as that's what they
recommend,b but I'd prefer to get patches by re-importing rather than
by applying them to our tree. That patch should go upstream. :)
3fc14b3470748578840ed9374db53e9ef9926382 and
7ca6e5d8875d06aa61ce35b727ce7ee219838c69 are patches to remove the
useless definition of a declared variable in cases like:

bool success = false;
...
 // nothing that reads success
...
success = function();

where the proposed fix is just doing:
bool success;
...
 // nothing that reads success
...
success = function();

However, we'd prefer for defensive programming reasons that variables
be defined on declaration whenever possible. For these patches it's
appropriate enough to just move the declaration to the first real
definition (and I've done so), but for cases where that's not
acceptable we'd prefer to take whatever performance hit there is in
order to not have random garbage in the stack. ;)


I did opt to leave the wireshark patch alone, because...C. But if you
or Yehuda want to take another pass through that, I notice that it's
still somewhat inconsistent about variable assignments on
initialization.
-Greg


On Wed, Feb 13, 2013 at 12:47 PM, Danny Al-Gaaf
<notifications@github.com> wrote:
> Here some more patches to fix performance issues found by cppcheck. This
> should now cover - together with wip-da-sca-cppcheck-performance - the
> following issues:
>
> use empty() instead of size() to check for emptiness
> dont't pass string::c_str() to string arguments
> prevent useless value assignment
> pass some objects by reference instead of by-value
>
> ________________________________
>
> You can merge this Pull Request by running
>
>   git pull https://github.com/dalgaaf/ceph wip-da-sca-cppcheck-performance-2
>
> Or view, comment on, or merge it at:
>
>   https://github.com/ceph/ceph/pull/51
>
> Commit Summary
>
> CephxProtocol.h: pass CryptoKey by reference to decode_decrypt()
> CInode.h: use !old_inodes.empty() instead of size()
> AuthMonitor.cc: use !pending_auth.empty() instead of 'size() > 0'
> OSDMonitor.h: use !reporters.empty() instead of size()
> MonCaps.cc: use !empty() instead of size()
> Monitor.cc: use empty() instead of size()
> OSDMonitor.cc: use !empty() instead of size()
> PGMonitor.cc: use !empty() instead of size() to check for emptiness
> monmaptool.cc: use empty() instead of size() to check for emptiness
> DBObjectMap.cc: use empty() instead of size() to check for emptiness
> FileStore.cc: use empty() instead of size() to check for emptiness
> HashIndex.cc: use empty() instead of size() to check for emptiness
> LFNIndex.cc: use !holes.empty() instead of 'size() > 0'
> OSD.cc: use empty() instead of size() to check for emptiness
> PG.cc: use empty() instead of size() to check for emptiness
> ReplicatedPG.cc: use empty() instead of size() to check for emptiness
> ObjectCacher.cc: use empty() instead of !size() to check for emptiness
> Objecter.cc: use !empty() instead of size() to check for emptiness
> Objecter.cc: prevent useless value assignment
> osdmaptool.cc: : use empty() instead of 'size() < 1'
> rados.cc: use omap.empty() instead of size() to check for emptiness
> rbd.cc: use empty() instead of size() to check for emptiness
> rgw/rgw_admin.cc: prevent useless value assignment
> rgw/rgw_admin.cc: use empty() instead of size() to check for emptiness
> rgw/rgw_gc.cc: use !empty() instead of size() to check for emptiness
> rgw/rgw_log.cc: don't pass c_str() result to std::string argument
> cls/rbd/cls_rbd.cc: use !empty() instead of 'size() > 0'
> cls_refcount.cc: use empty() instead of !size() to check for emptiness
> common/WorkQueue.cc: use !empty() instead of size() to check for emptiness
> obj_bencher.cc: use empty() instead of 'size() == 0' to check for emptiness
> crush/CrushWrapper.cc: don't pass c_str() result to std::string argument
> crushtool.cc: use !empty() instead of 'size() > 0' to check for emptiness
> use empty() instead of 'size() == 0' to check for emptiness
> cls_kvs.cc: use !empty() instead of 'size() > 0' to check for emptiness
> kv_flat_btree_async.cc: use empty() instead of size() to check for emptiness
> librbd/internal.cc: use !empty() instead of size()
> mds/CDir.cc: use !empty() instead of size()
> mds/CInode.cc: use !empty() instead of size()
> mds/Locker.cc: use !empty() instead of size()
> mds/MDCache.cc: use empty() instead of size() to check for emptiness
> mds/MDS.cc: use !empty() instead of size() to check for emptiness
> mds/MDSMap.cc: use !empty() instead of size() to check for emptiness
> mds/SnapServer.cc: use !empty() instead of size() to check for emptiness
> mds/journal.cc: use !empty() instead of size() to check for emptiness
> rgw/rgw_main.cc: use empty() instead of size() to check for emptiness
> rgw/rgw_op.cc: use empty() instead of size() to check for emptiness
> rgw/rgw_rados.cc: : use empty() to check for emptiness
> rgw/rgw_rest_swift.cc: don't pass c_str() result to std::string argument
> rgw/rgw_usage.cc use empty() to check for emptiness
> rgw/rgw_user.cc: use empty() to check for emptiness
> scratchtoolpp.cc: print some more results
> test_keyvaluedb_iterators.cc: use empty() to check for emptiness
> test_object_map.cc: use empty() to check for emptiness
> FileStoreTracker.cc: use empty() to check for emptiness
> TestFileStoreState.cc: use empty() to check for emptiness
> test_mon_workloadgen.cc: use empty() to check for emptiness
> src/test/osd/RadosModel.h: use empty() to check for emptiness
> test_filejournal.cc: use empty() to check for emptiness
> tools/common.cc. use !empty() to check for non-emptiness
> rest_bench.cc: use empty() to check for emptiness
> wireshark/ceph/packet-ceph.c: fix some issues from cppcheck
>
> File Changes
>
> M src/auth/cephx/CephxProtocol.h (2)
> M src/cls/rbd/cls_rbd.cc (6)
> M src/cls/refcount/cls_refcount.cc (4)
> M src/common/WorkQueue.cc (2)
> M src/common/obj_bencher.cc (6)
> M src/crush/CrushWrapper.cc (4)
> M src/crushtool.cc (2)
> M src/gtest/test/gtest-listener_test.cc (2)
> M src/key_value_store/cls_kvs.cc (4)
> M src/key_value_store/kv_flat_btree_async.cc (6)
> M src/librbd/internal.cc (6)
> M src/mds/CDir.cc (2)
> M src/mds/CInode.cc (6)
> M src/mds/CInode.h (2)
> M src/mds/Locker.cc (4)
> M src/mds/MDCache.cc (4)
> M src/mds/MDS.cc (2)
> M src/mds/MDSMap.cc (8)
> M src/mds/SnapServer.cc (2)
> M src/mds/journal.cc (2)
> M src/mon/AuthMonitor.cc (2)
> M src/mon/MonCaps.cc (3)
> M src/mon/Monitor.cc (8)
> M src/mon/OSDMonitor.cc (2)
> M src/mon/OSDMonitor.h (2)
> M src/mon/PGMonitor.cc (2)
> M src/monmaptool.cc (4)
> M src/os/DBObjectMap.cc (14)
> M src/os/FileStore.cc (10)
> M src/os/HashIndex.cc (2)
> M src/os/LFNIndex.cc (2)
> M src/osd/OSD.cc (12)
> M src/osd/PG.cc (20)
> M src/osd/ReplicatedPG.cc (4)
> M src/osdc/ObjectCacher.cc (2)
> M src/osdc/Objecter.cc (4)
> M src/osdmaptool.cc (2)
> M src/rados.cc (4)
> M src/rbd.cc (6)
> M src/rgw/rgw_admin.cc (10)
> M src/rgw/rgw_gc.cc (2)
> M src/rgw/rgw_log.cc (2)
> M src/rgw/rgw_main.cc (2)
> M src/rgw/rgw_op.cc (6)
> M src/rgw/rgw_rados.cc (4)
> M src/rgw/rgw_rest_swift.cc (2)
> M src/rgw/rgw_usage.cc (2)
> M src/rgw/rgw_user.cc (4)
> M src/scratchtoolpp.cc (5)
> M src/test/ObjectMap/test_keyvaluedb_iterators.cc (4)
> M src/test/ObjectMap/test_object_map.cc (4)
> M src/test/filestore/FileStoreTracker.cc (6)
> M src/test/filestore/TestFileStoreState.cc (2)
> M src/test/mon/test_mon_workloadgen.cc (8)
> M src/test/osd/RadosModel.h (6)
> M src/test/test_filejournal.cc (2)
> M src/tools/common.cc (8)
> M src/tools/rest_bench.cc (4)
> M wireshark/ceph/packet-ceph.c (20)
>
> Patch Links:
>
> https://github.com/ceph/ceph/pull/51.patch
> https://github.com/ceph/ceph/pull/51.diff
