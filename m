From: huang jun <hjwsm1989@gmail.com>
Subject: Re: Fixes for missing and replicated files in ceph.spec.in
Date: Sat, 22 Feb 2014 12:25:19 +0800
Message-ID: <CABAwU-bG=v1Jxy3DoknGhEOX4cMZX32ruLw6DUpFayV1c6DKWw@mail.gmail.com>
References: <CABAwU-ZCSVbkLUOvZBd8=+uHD1L6tVS5iAkpDNUS0_myP5Xndw@mail.gmail.com>
	<CAOpHjdDFygeaDfzOrB5HDOLc1tp-yvmBsnuvhYKKCDYcSWU0ww@mail.gmail.com>
	<alpine.DEB.2.00.1402211247430.17314@cobra.newdream.net>
	<CAOpHjdAvLm=+fv4FODtt75usc=+A9fWv9eXfsEE72cph7qYFgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:61807 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbaBVEZV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2014 23:25:21 -0500
Received: by mail-la0-f44.google.com with SMTP id hr13so157240lab.31
        for <ceph-devel@vger.kernel.org>; Fri, 21 Feb 2014 20:25:20 -0800 (PST)
In-Reply-To: <CAOpHjdAvLm=+fv4FODtt75usc=+A9fWv9eXfsEE72cph7qYFgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <ken.dreyer@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

we can also use test_* instead of listing all test_xx  files while
building debian package

diff --git a/debian/ceph-test.install b/debian/ceph-test.install
index bdcb75f..ac79055 100644
--- a/debian/ceph-test.install
+++ b/debian/ceph-test.install
@@ -19,63 +19,7 @@ usr/bin/ceph_smalliobenchdumb
 usr/bin/ceph_smalliobenchfs
 usr/bin/ceph_smalliobenchrbd
 usr/bin/ceph_streamtest
-usr/bin/ceph_test_cfuse_cache_invalidate
-usr/bin/ceph_test_cls_hello
-usr/bin/ceph_test_cls_lock
-usr/bin/ceph_test_cls_log
-usr/bin/ceph_test_cls_rbd
-usr/bin/ceph_test_cls_refcount
-usr/bin/ceph_test_cls_replica_log
-usr/bin/ceph_test_cls_rgw
-usr/bin/ceph_test_cls_rgw_log
-usr/bin/ceph_test_cls_rgw_meta
-usr/bin/ceph_test_cls_rgw_opstate
-usr/bin/ceph_test_cls_statelog
-usr/bin/ceph_test_cls_version
-usr/bin/ceph_test_cors
-usr/bin/ceph_test_crypto
-usr/bin/ceph_test_filejournal
-usr/bin/ceph_test_objectstore
-usr/bin/ceph_test_filestore_idempotent
-usr/bin/ceph_test_filestore_idempotent_sequence
-usr/bin/ceph_test_objectstore_workloadgen
-usr/bin/ceph_test_ioctls
-usr/bin/ceph_test_keys
-usr/bin/ceph_test_keyvaluedb_atomicity
-usr/bin/ceph_test_keyvaluedb_iterators
-usr/bin/ceph_test_libcephfs
-usr/bin/ceph_test_librbd
-usr/bin/ceph_test_librbd_fsx
-usr/bin/ceph_test_mon_workloadgen
-usr/bin/ceph_test_msgr
-usr/bin/ceph_test_mutate
-usr/bin/ceph_test_object_map
-usr/bin/ceph_test_objectcacher_stress
-usr/bin/ceph_test_rados
-usr/bin/ceph_test_rados_api_aio
-usr/bin/ceph_test_rados_api_cls
-usr/bin/ceph_test_rados_api_c_read_operations
-usr/bin/ceph_test_rados_api_c_write_operations
-usr/bin/ceph_test_rados_api_cmd
-usr/bin/ceph_test_rados_api_io
-usr/bin/ceph_test_rados_api_list
-usr/bin/ceph_test_rados_api_lock
-usr/bin/ceph_test_rados_api_misc
-usr/bin/ceph_test_rados_api_tier
-usr/bin/ceph_test_rados_api_pool
-usr/bin/ceph_test_rados_api_snapshots
-usr/bin/ceph_test_rados_api_stat
-usr/bin/ceph_test_rados_api_watch_notify
-usr/bin/ceph_test_rados_delete_pools_parallel
-usr/bin/ceph_test_rados_list_parallel
-usr/bin/ceph_test_rados_open_pools_parallel
-usr/bin/ceph_test_rados_watch_notify
-usr/bin/ceph_test_rewrite_latency
-usr/bin/ceph_test_signal_handlers
-usr/bin/ceph_test_snap_mapper
-usr/bin/ceph_test_stress_watch
-usr/bin/ceph_test_timers
-usr/bin/ceph_test_trans
+usr/bin/ceph_test_*
 usr/bin/ceph_tpbench
 usr/bin/ceph_xattr_bench
 usr/bin/ceph-monstore-tool

2014-02-22 7:04 GMT+08:00 Ken Dreyer <ken.dreyer@inktank.com>:
> On Fri, Feb 21, 2014 at 1:48 PM, Sage Weil <sage@inktank.com> wrote:
>> On Fri, 21 Feb 2014, Ken Dreyer wrote:
>>> On Fri, Feb 21, 2014 at 4:27 AM, huang jun <hjwsm1989@gmail.com> wrote:
>>> > @@ -690,6 +689,7 @@ fi
>>> >  %{_bindir}/ceph_test_rados_list_parallel
>>> >  %{_bindir}/ceph_test_rados_open_pools_parallel
>>> >  %{_bindir}/ceph_test_rados_watch_notify
>>> > +%{_bindir}/ceph_test_rgw_manifest
>>> >  %{_bindir}/ceph_test_signal_handlers
>>> >  %{_bindir}/ceph_test_snap_mapper
>>>
>>>
>>> It seems like we have to deal with this sort of thing over and over.
>>> Anyone have objections to simply using a wildcard to capture all the
>>> test files? Something like %{_bindir}/ceph_test_* ?
>>
>> Sounds good to me.  This is only stuff that 'make install' is putting in
>> place right?
>
> Yep, that's right, the wildcard will just match what 'make install' has done.
>
> Pull request is at https://github.com/ceph/ceph/pull/1287 . Huang, if
> you have time, it would be great to get your review before we merge.
>
> - Ken



-- 
thanks
huangjun
