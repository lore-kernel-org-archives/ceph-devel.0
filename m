From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 1/3] ceph-test: give binaries from ceph-test package useful
 names
Date: Wed, 06 Feb 2013 01:05:46 -0800
Message-ID: <51121CEA.7010602@inktank.com>
References: <1359998564-27004-1-git-send-email-danny.al-gaaf@bisect.de> <1359998564-27004-2-git-send-email-danny.al-gaaf@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f52.google.com ([209.85.210.52]:46829 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab3BFJFu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 04:05:50 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so544408dak.39
        for <ceph-devel@vger.kernel.org>; Wed, 06 Feb 2013 01:05:49 -0800 (PST)
In-Reply-To: <1359998564-27004-2-git-send-email-danny.al-gaaf@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org, Danny Al-Gaaf <dalgaaf@suse.de>, Sage Weil <sage@inktank.com>

On 02/04/2013 09:22 AM, Danny Al-Gaaf wrote:
> The files from the ceph-test subpackage are installed to /usr/bin,
> give them more useful names to make sure that the user know they
> belong to ceph. add a 'ceph_' prefix and change some test* binaries
> to ceph_test_*.
>
> Signed-off-by: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
> ---
>   .gitignore                               |   5 +-
>   ceph.spec.in                             | 122 +++----
>   debian/ceph-test.install                 | 118 +++----
>   qa/workunits/cls/test_cls_lock.sh        |   2 +-
>   qa/workunits/cls/test_cls_rbd.sh         |   2 +-
>   qa/workunits/cls/test_cls_refcount.sh    |   2 +-
>   qa/workunits/cls/test_cls_rgw.sh         |   2 +-
>   qa/workunits/libcephfs/test.sh           |   2 +-
>   qa/workunits/mon/workloadgen.sh          |   4 +-
>   qa/workunits/osdc/stress_objectcacher.sh |   2 +-
>   qa/workunits/rados/stress_watch.sh       |   2 +-
>   qa/workunits/rados/test.sh               |  24 +-
>   qa/workunits/rbd/smalliobench.sh         |   2 +-
>   qa/workunits/rbd/test_librbd.sh          |   2 +-
>   src/.gitignore                           |  98 ++++--
>   src/Makefile.am                          | 586 +++++++++++++++----------------
>   src/client/test_ioctls.c                 |   2 +-
>   src/dupstore.cc                          |   2 +-
>   src/psim.cc                              |   2 +-
>   src/test/filestore/TestFileStoreState.cc |   2 +-
>   src/test/filestore/run_seed_to.sh        |  10 +-
>   src/test/run-rbd-tests                   |   8 +-
>   src/test/test_filejournal.cc             |   2 +-
>   src/test/test_mutate.cc                  |   2 +-
>   24 files changed, 514 insertions(+), 491 deletions(-)
>
> diff --git a/.gitignore b/.gitignore
> index 502f018..b6c6eb0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -59,9 +59,10 @@ core
>   *.generated.dot
>   src/ocf/ceph
>   src/ocf/rbd
> -src/omapbench
> -src/kvstorebench
> +src/ceph_omapbench
> +src/ceph_kvstorebench
>   ar-lib
> +.dirstamp
>
>   # temporary directory used by e.g. "make distcheck", e.g. ceph-0.42
>   /ceph-[0-9]*/
> diff --git a/ceph.spec.in b/ceph.spec.in
> index 7efb988..d49bf48 100644
> --- a/ceph.spec.in
> +++ b/ceph.spec.in
> @@ -516,68 +516,68 @@ fi
>   #################################################################################
>   %files -n ceph-test
>   %defattr(-,root,root,-)
> -%{_bindir}/bench_log
> -%{_bindir}/dupstore
> -%{_bindir}/kvstorebench
> -%{_bindir}/multi_stress_watch
> -%{_bindir}/omapbench
> -%{_bindir}/psim
> -%{_bindir}/radosacl
>   %{_bindir}/rest-bench
> -%{_bindir}/rgw_jsonparser
> -%{_bindir}/rgw_multiparser
> -%{_bindir}/scratchtool
> -%{_bindir}/scratchtoolpp
> -%{_bindir}/smalliobench
> -%{_bindir}/smalliobenchdumb
> -%{_bindir}/smalliobenchfs
> -%{_bindir}/smalliobenchrbd
> -%{_bindir}/ceph-filestore-dump
> -%{_bindir}/streamtest
> -%{_bindir}/test_cfuse_cache_invalidate
> -%{_bindir}/test_cls_lock
> -%{_bindir}/test_cls_rbd
> -%{_bindir}/test_cls_refcount
> -%{_bindir}/test_cls_rgw
> -%{_bindir}/test_filejournal
> -%{_bindir}/test_filestore
> -%{_bindir}/test_filestore_idempotent
> -%{_bindir}/test_filestore_idempotent_sequence
> -%{_bindir}/test_filestore_workloadgen
> -%{_bindir}/test_ioctls
> -%{_bindir}/test_keyvaluedb_atomicity
> -%{_bindir}/test_keyvaluedb_iterators
> -%{_bindir}/test_libcephfs
> -%{_bindir}/test_librbd
> -%{_bindir}/test_librbd_fsx
> -%{_bindir}/test_mon_workloadgen
> -%{_bindir}/test_mutate
> -%{_bindir}/test_object_map
> -%{_bindir}/test_objectcacher_stress
> -%{_bindir}/test_rados_api_aio
> -%{_bindir}/test_rados_api_cls
> -%{_bindir}/test_rados_api_io
> -%{_bindir}/test_rados_api_list
> -%{_bindir}/test_rados_api_misc
> -%{_bindir}/test_rados_api_pool
> -%{_bindir}/test_rados_api_snapshots
> -%{_bindir}/test_rados_api_stat
> -%{_bindir}/test_rados_api_watch_notify
> -%{_bindir}/test_rewrite_latency
> -%{_bindir}/test_stress_watch
> -%{_bindir}/test_trans
> -%{_bindir}/testcrypto
> -%{_bindir}/testkeys
> -%{_bindir}/testmsgr
> -%{_bindir}/testrados
> -%{_bindir}/testrados_delete_pools_parallel
> -%{_bindir}/testrados_list_parallel
> -%{_bindir}/testrados_open_pools_parallel
> -%{_bindir}/testrados_watch_notify
> -%{_bindir}/testsignal_handlers
> -%{_bindir}/testtimers
> -%{_bindir}/tpbench
> -%{_bindir}/xattr_bench
> +%{_bindir}/ceph_bench_log
> +%{_bindir}/ceph_dupstore
> +%{_bindir}/ceph_kvstorebench
> +%{_bindir}/ceph_multi_stress_watch
> +%{_bindir}/ceph_omapbench
> +%{_bindir}/ceph_psim
> +%{_bindir}/ceph_radosacl
> +%{_bindir}/ceph_rgw_jsonparser
> +%{_bindir}/ceph_rgw_multiparser
> +%{_bindir}/ceph_scratchtool
> +%{_bindir}/ceph_scratchtoolpp
> +%{_bindir}/ceph_smalliobench
> +%{_bindir}/ceph_smalliobenchdumb
> +%{_bindir}/ceph_smalliobenchfs
> +%{_bindir}/ceph_smalliobenchrbd
> +%{_bindir}/ceph_filestore_dump
> +%{_bindir}/ceph_streamtest
> +%{_bindir}/ceph_test_cfuse_cache_invalidate
> +%{_bindir}/ceph_test_cls_lock
> +%{_bindir}/ceph_test_cls_rbd
> +%{_bindir}/ceph_test_cls_refcount
> +%{_bindir}/ceph_test_cls_rgw
> +%{_bindir}/ceph_test_filejournal
> +%{_bindir}/ceph_test_filestore
> +%{_bindir}/ceph_test_filestore_idempotent
> +%{_bindir}/ceph_test_filestore_idempotent_sequence
> +%{_bindir}/ceph_test_filestore_workloadgen
> +%{_bindir}/ceph_test_ioctls
> +%{_bindir}/ceph_test_keyvaluedb_atomicity
> +%{_bindir}/ceph_test_keyvaluedb_iterators
> +%{_bindir}/ceph_test_libcephfs
> +%{_bindir}/ceph_test_librbd
> +%{_bindir}/ceph_test_librbd_fsx
> +%{_bindir}/ceph_test_mon_workloadgen
> +%{_bindir}/ceph_test_mutate
> +%{_bindir}/ceph_test_object_map
> +%{_bindir}/ceph_test_objectcacher_stress
> +%{_bindir}/ceph_test_rados_api_aio
> +%{_bindir}/ceph_test_rados_api_cls
> +%{_bindir}/ceph_test_rados_api_io
> +%{_bindir}/ceph_test_rados_api_list
> +%{_bindir}/ceph_test_rados_api_misc
> +%{_bindir}/ceph_test_rados_api_pool
> +%{_bindir}/ceph_test_rados_api_snapshots
> +%{_bindir}/ceph_test_rados_api_stat
> +%{_bindir}/ceph_test_rados_api_watch_notify
> +%{_bindir}/ceph_test_rewrite_latency
> +%{_bindir}/ceph_test_stress_watch
> +%{_bindir}/ceph_test_trans
> +%{_bindir}/ceph_test_crypto
> +%{_bindir}/ceph_test_keys
> +%{_bindir}/ceph_test_msgr
> +%{_bindir}/ceph_test_rados
> +%{_bindir}/ceph_test_rados_delete_pools_parallel
> +%{_bindir}/ceph_test_rados_list_parallel
> +%{_bindir}/ceph_test_rados_open_pools_parallel
> +%{_bindir}/ceph_test_rados_watch_notify
> +%{_bindir}/ceph_test_signal_handlers
> +%{_bindir}/ceph_test_timers
> +%{_bindir}/ceph_tpbench
> +%{_bindir}/ceph_xattr_bench
>
>   %files -n libcephfs_jni1
>   %defattr(-,root,root,-)
> diff --git a/debian/ceph-test.install b/debian/ceph-test.install
> index 7bda9ed..bc5137b 100644
> --- a/debian/ceph-test.install
> +++ b/debian/ceph-test.install
> @@ -1,59 +1,59 @@
> -usr/bin/bench_log
> -usr/bin/dupstore
> -usr/bin/kvstorebench
> -usr/bin/multi_stress_watch
> -usr/bin/omapbench
> -usr/bin/psim
> -usr/bin/radosacl
> -usr/bin/rest-bench

rest-bench wasn't renamed (now I see this is handled in patch 3)

> -usr/bin/rgw_multiparser
> -usr/bin/scratchtool
> -usr/bin/scratchtoolpp
> -usr/bin/smalliobench
> -usr/bin/smalliobenchdumb
> -usr/bin/smalliobenchfs
> -usr/bin/smalliobenchrbd
> -usr/bin/ceph-filestore-dump
> -usr/bin/streamtest
> -usr/bin/test_cfuse_cache_invalidate
> -usr/bin/test_cls_lock
> -usr/bin/test_cls_rbd
> -usr/bin/test_cls_refcount
> -usr/bin/test_cls_rgw
> -usr/bin/test_filejournal
> -usr/bin/test_filestore
> -usr/bin/test_filestore_idempotent
> -usr/bin/test_filestore_idempotent_sequence
> -usr/bin/test_filestore_workloadgen
> -usr/bin/test_ioctls
> -usr/bin/test_keyvaluedb_atomicity
> -usr/bin/test_keyvaluedb_iterators
> -usr/bin/test_libcephfs
> -usr/bin/test_librbd
> -usr/bin/test_librbd_fsx
> -usr/bin/test_mutate
> -usr/bin/test_object_map
> -usr/bin/test_rados_api_aio
> -usr/bin/test_rados_api_cls
> -usr/bin/test_rados_api_io
> -usr/bin/test_rados_api_list
> -usr/bin/test_rados_api_misc
> -usr/bin/test_rados_api_pool
> -usr/bin/test_rados_api_snapshots
> -usr/bin/test_rados_api_stat
> -usr/bin/test_rados_api_watch_notify
> -usr/bin/test_rewrite_latency
> -usr/bin/test_stress_watch
> -usr/bin/test_trans
> -usr/bin/testcrypto
> -usr/bin/testkeys
> -usr/bin/testmsgr
> -usr/bin/testrados
> -usr/bin/testrados_delete_pools_parallel
> -usr/bin/testrados_list_parallel
> -usr/bin/testrados_open_pools_parallel
> -usr/bin/testrados_watch_notify
> -usr/bin/testsignal_handlers
> -usr/bin/testtimers
> -usr/bin/tpbench
> -usr/bin/xattr_bench
> +usr/bin/ceph_bench_log
> +usr/bin/ceph_dupstore
> +usr/bin/ceph_kvstorebench
> +usr/bin/ceph_multi_stress_watch
> +usr/bin/ceph_omapbench
> +usr/bin/ceph_psim
> +usr/bin/ceph_radosacl
> +usr/bin/ceph_rest-bench
> +usr/bin/ceph_rgw_multiparser
> +usr/bin/ceph_scratchtool
> +usr/bin/ceph_scratchtoolpp
> +usr/bin/ceph_smalliobench
> +usr/bin/ceph_smalliobenchdumb
> +usr/bin/ceph_smalliobenchfs
> +usr/bin/ceph_smalliobenchrbd
> +usr/bin/ceph_filestore_dump
> +usr/bin/ceph_streamtest
> +usr/bin/ceph_test_cfuse_cache_invalidate
> +usr/bin/ceph_test_cls_lock
> +usr/bin/ceph_test_cls_rbd
> +usr/bin/ceph_test_cls_refcount
> +usr/bin/ceph_test_cls_rgw
> +usr/bin/ceph_test_filejournal
> +usr/bin/ceph_test_filestore
> +usr/bin/ceph_test_filestore_idempotent
> +usr/bin/ceph_test_filestore_idempotent_sequence
> +usr/bin/ceph_test_filestore_workloadgen
> +usr/bin/ceph_test_ioctls
> +usr/bin/ceph_test_keyvaluedb_atomicity
> +usr/bin/ceph_test_keyvaluedb_iterators
> +usr/bin/ceph_test_libcephfs
> +usr/bin/ceph_test_librbd
> +usr/bin/ceph_test_librbd_fsx
> +usr/bin/ceph_test_mutate
> +usr/bin/ceph_test_object_map
> +usr/bin/ceph_test_rados_api_aio
> +usr/bin/ceph_test_rados_api_cls
> +usr/bin/ceph_test_rados_api_io
> +usr/bin/ceph_test_rados_api_list
> +usr/bin/ceph_test_rados_api_misc
> +usr/bin/ceph_test_rados_api_pool
> +usr/bin/ceph_test_rados_api_snapshots
> +usr/bin/ceph_test_rados_api_stat
> +usr/bin/ceph_test_rados_api_watch_notify
> +usr/bin/ceph_test_rewrite_latency
> +usr/bin/ceph_test_stress_watch
> +usr/bin/ceph_test_trans
> +usr/bin/ceph_test_crypto
> +usr/bin/ceph_test_keys
> +usr/bin/ceph_test_msgr
> +usr/bin/ceph_test_rados
> +usr/bin/ceph_test_rados_delete_pools_parallel
> +usr/bin/ceph_test_rados_list_parallel
> +usr/bin/ceph_test_rados_open_pools_parallel
> +usr/bin/ceph_test_rados_watch_notify
> +usr/bin/ceph_test_signal_handlers
> +usr/bin/ceph_test_timers
> +usr/bin/ceph_tpbench
> +usr/bin/ceph_xattr_bench
> diff --git a/qa/workunits/cls/test_cls_lock.sh b/qa/workunits/cls/test_cls_lock.sh
> index 1f767ed..c145270 100755
> --- a/qa/workunits/cls/test_cls_lock.sh
> +++ b/qa/workunits/cls/test_cls_lock.sh
> @@ -1,5 +1,5 @@
>   #!/bin/sh -e
>
> -test_cls_lock
> +ceph_test_cls_lock
>
>   exit 0
> diff --git a/qa/workunits/cls/test_cls_rbd.sh b/qa/workunits/cls/test_cls_rbd.sh
> index 06f1421..b973fd0 100755
> --- a/qa/workunits/cls/test_cls_rbd.sh
> +++ b/qa/workunits/cls/test_cls_rbd.sh
> @@ -1,5 +1,5 @@
>   #!/bin/sh -e
>
> -test_cls_rbd
> +ceph_test_cls_rbd
>
>   exit 0
> diff --git a/qa/workunits/cls/test_cls_refcount.sh b/qa/workunits/cls/test_cls_refcount.sh
> index 69f721a..d722f5a 100755
> --- a/qa/workunits/cls/test_cls_refcount.sh
> +++ b/qa/workunits/cls/test_cls_refcount.sh
> @@ -1,5 +1,5 @@
>   #!/bin/sh -e
>
> -test_cls_refcount
> +ceph_test_cls_refcount
>
>   exit 0
> diff --git a/qa/workunits/cls/test_cls_rgw.sh b/qa/workunits/cls/test_cls_rgw.sh
> index a8998f5..b1f6621 100755
> --- a/qa/workunits/cls/test_cls_rgw.sh
> +++ b/qa/workunits/cls/test_cls_rgw.sh
> @@ -1,5 +1,5 @@
>   #!/bin/sh -e
>
> -test_cls_rgw
> +ceph_test_cls_rgw
>
>   exit 0
> diff --git a/qa/workunits/libcephfs/test.sh b/qa/workunits/libcephfs/test.sh
> index ddaab18..4a501e0 100755
> --- a/qa/workunits/libcephfs/test.sh
> +++ b/qa/workunits/libcephfs/test.sh
> @@ -1,5 +1,5 @@
>   #!/bin/sh -e
>
> -test_libcephfs
> +ceph_test_libcephfs
>
>   exit 0
> diff --git a/qa/workunits/mon/workloadgen.sh b/qa/workunits/mon/workloadgen.sh
> index 33f7630..490875c 100755
> --- a/qa/workunits/mon/workloadgen.sh
> +++ b/qa/workunits/mon/workloadgen.sh
> @@ -9,7 +9,7 @@ d() {
>
>   d "check for required binaries"
>
> -required_bins="ceph crushtool test_mon_workloadgen"
> +required_bins="ceph crushtool ceph_test_mon_workloadgen"
>   for b in $required_bins; do
>     which $b >& /dev/null
>     if [[ $? -ne 0 ]]; then
> @@ -28,7 +28,7 @@ do_run=0
>   num_osds=0
>
>   # Assume the test is in PATH
> -bin_test=test_mon_workloadgen
> +bin_test=ceph_test_mon_workloadgen
>
>   num_osds=10
>   if [[ "$LOADGEN_NUM_OSDS" != "" ]]; then
> diff --git a/qa/workunits/osdc/stress_objectcacher.sh b/qa/workunits/osdc/stress_objectcacher.sh
> index 03a5c95..e6b9ec1 100755
> --- a/qa/workunits/osdc/stress_objectcacher.sh
> +++ b/qa/workunits/osdc/stress_objectcacher.sh
> @@ -14,7 +14,7 @@ do
>                       do
>                           for MAX_DIRTY in 0 25165824
>                           do
> -                            test_objectcacher_stress --ops $OPS --percent-read $READS --delay-ns $DELAY --objects $OBJECTS --max-op-size $OP_SIZE --client-oc-max-dirty $MAX_DIRTY > /dev/null 2>&1
> +                            ceph_test_objectcacher_stress --ops $OPS --percent-read $READS --delay-ns $DELAY --objects $OBJECTS --max-op-size $OP_SIZE --client-oc-max-dirty $MAX_DIRTY > /dev/null 2>&1
>                           done
>                       done
>                   done
> diff --git a/qa/workunits/rados/stress_watch.sh b/qa/workunits/rados/stress_watch.sh
> index d547207..275414b 100755
> --- a/qa/workunits/rados/stress_watch.sh
> +++ b/qa/workunits/rados/stress_watch.sh
> @@ -1,5 +1,5 @@
>   #!/bin/sh -e
>
> -test_stress_watch
> +ceph_test_stress_watch
>
>   exit 0
> diff --git a/qa/workunits/rados/test.sh b/qa/workunits/rados/test.sh
> index 1671a90..b18519a 100755
> --- a/qa/workunits/rados/test.sh
> +++ b/qa/workunits/rados/test.sh
> @@ -1,17 +1,17 @@
>   #!/bin/sh -e
>
> -test_rados_api_aio
> -test_rados_api_io
> -test_rados_api_list
> -test_rados_api_misc
> -test_rados_api_pool
> -test_rados_api_snapshots
> -test_rados_api_stat
> -test_rados_api_watch_notify
> +ceph_test_rados_api_aio
> +ceph_test_rados_api_io
> +ceph_test_rados_api_list
> +ceph_test_rados_api_misc
> +ceph_test_rados_api_pool
> +ceph_test_rados_api_snapshots
> +ceph_test_rados_api_stat
> +ceph_test_rados_api_watch_notify
>
> -testrados_list_parallel
> -testrados_open_pools_parallel
> -testrados_delete_pools_parallel
> -testrados_watch_notify
> +ceph_test_rados_list_parallel
> +ceph_test_rados_open_pools_parallel
> +ceph_test_rados_delete_pools_parallel
> +ceph_test_rados_watch_notify
>
>   exit 0
> diff --git a/qa/workunits/rbd/smalliobench.sh b/qa/workunits/rbd/smalliobench.sh
> index 5cedc78..f25fae4 100755
> --- a/qa/workunits/rbd/smalliobench.sh
> +++ b/qa/workunits/rbd/smalliobench.sh
> @@ -10,7 +10,7 @@ DUR="$3"
>
>   for n in `seq 1 $NUM`; do
>       echo "Starting $n of $NUM ..."
> -    smalliobenchrbd --pool rbd --duration $DUR --disable-detailed-ops 1 &
> +    ceph_smalliobenchrbd --pool rbd --duration $DUR --disable-detailed-ops 1 &
>       sleep $GAP
>   done
>   echo "Waiting..."
> diff --git a/qa/workunits/rbd/test_librbd.sh b/qa/workunits/rbd/test_librbd.sh
> index 6212357..d35cfaf 100755
> --- a/qa/workunits/rbd/test_librbd.sh
> +++ b/qa/workunits/rbd/test_librbd.sh
> @@ -1,5 +1,5 @@
>   #!/bin/sh -e
>
> -test_librbd
> +ceph_test_librbd
>
>   exit 0
> diff --git a/src/.gitignore b/src/.gitignore
> index f05c939..3a5ab91 100644
> --- a/src/.gitignore
> +++ b/src/.gitignore
> @@ -5,7 +5,7 @@
>   /ceph-osd
>   /ceph-syn
>   /ceph-dencoder
> -/dupstore
> +/ceph_dupstore
>   /fakefuse
>   /fakesyn
>   /mkmonmap
> @@ -19,23 +19,12 @@
>   /osdmaptool
>   /rados
>   /rados_sync
> -/radosacl
>   /radosgw
>   /radosgw-admin
>   /rbdtool
> -/rgw_jsonparser
> -/rgw_multiparser
> -/streamtest
> -/bench_log
> -/test_ioctls
> -/test_trans
> +/ceph_bench_log
>   /testceph
> -/testcrypto
> -/testkeys
> -/testmsgr
> -/testrados
> -/testrados_delete_pool_while_open
> -/testrados_watch_notify
> +ceph_test_msgr
>   /testradospp
>   /testdout_streambuf
>   /testsignal_handlers
> @@ -46,8 +35,7 @@
>   /test_librgw_build
>   /testrados
>   /test_str_list
> -/test_stress_watch
> -/multi_stress_watch
> +/ceph_multi_stress_watch
>   /test_store
>   /test_libcommon_build
>   /test_mutate
> @@ -79,7 +67,6 @@ acconfig.h
>   /init-ceph
>   /librados-config
>   /rbd
> -/psim
>   /sample.fetch_config
>
>   Makefile
> @@ -97,24 +84,59 @@ Makefile
>   /ceph.conf
>   /keyring
>   /massif.out.*
> -/testrados_list_parallel
> -/testrados_open_pools_parallel
> -/testrados_delete_pools_parallel
> -/test_rados_api_aio
> -/test_rados_api_io
> -/test_rados_api_list
> -/test_rados_api_pool
> -/test_rados_api_stat
> -/test_rados_api_watch_notify
> -/test_rados_api_snapshots
> -/test_rados_api_misc
> -/test_librbd
> -/test_librbd_fsx
> -/scratchtool
> -/scratchtoolpp
> -/ceph-filestore-dump
> -/smalliobench
> -/smalliobenchdumb
> -/smalliobenchfs
> -/smalliobenchrbd
> -/tpbench
> +ceph_psim
> +ceph_radosacl
> +ceph_rgw_jsonparser
> +ceph_rgw_multiparser
> +ceph_streamtest
> +ceph_test_ioctls
> +ceph_test_cfuse_cache_invalidate
> +ceph_test_cls_lock
> +ceph_test_cls_rbd
> +ceph_test_cls_refcount
> +ceph_test_cls_rgw
> +ceph_test_crypto
> +ceph_test_filejournal
> +ceph_test_filestore
> +ceph_test_filestore_idempotent
> +ceph_test_filestore_idempotent_sequence
> +ceph_test_filestore_workloadgen
> +ceph_test_keys
> +ceph_test_keyvaluedb_atomicity
> +ceph_test_keyvaluedb_iterators
> +ceph_test_libcephfs
> +ceph_test_libhadoopcephfs_build
> +ceph_test_librbd
> +ceph_test_librbd_fsx
> +ceph_test_mon_workloadgen
> +ceph_test_mutate
> +ceph_test_object_map
> +ceph_test_objectcacher_stress
> +ceph_test_rados
> +ceph_test_rados_api_aio
> +ceph_test_rados_api_cls
> +ceph_test_rados_api_io
> +ceph_test_rados_api_list
> +ceph_test_rados_api_misc
> +ceph_test_rados_api_pool
> +ceph_test_rados_api_snapshots
> +ceph_test_rados_api_stat
> +ceph_test_rados_api_watch_notify
> +ceph_test_rados_delete_pools_parallel
> +ceph_test_rados_list_parallel
> +ceph_test_rados_open_pools_parallel
> +ceph_test_rados_watch_notify
> +ceph_test_rewrite_latency
> +ceph_test_signal_handlers
> +ceph_test_stress_watch
> +ceph_test_timers
> +ceph_test_trans
> +ceph_tpbench
> +ceph_xattr_bench
> +ceph_scratchtool
> +ceph_scratchtoolpp
> +ceph_filestore_dump
> +ceph_smalliobench
> +ceph_smalliobenchdumb
> +ceph_smalliobenchfs
> +ceph_smalliobenchrbd
> diff --git a/src/Makefile.am b/src/Makefile.am
> index efff334..abd5092 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -115,7 +115,7 @@ ceph_filestore_dump_LDADD = libosd.a $(LIBOS_LDA) $(LIBGLOBAL_LDA) -lboost_progr
>   if LINUX
>   ceph_filestore_dump_LDADD += -ldl
>   endif
> -bin_PROGRAMS += ceph ceph-conf ceph-authtool ceph-filestore-dump
> +bin_PROGRAMS += ceph ceph-conf ceph-authtool ceph_filestore_dump
>
>   monmaptool_SOURCES = monmaptool.cc
>   monmaptool_LDADD = $(LIBGLOBAL_LDA)
> @@ -198,106 +198,106 @@ ceph_mon_SOURCES += perfglue/disabled_heap_profiler.cc
>   endif # WITH_TCMALLOC
>
>   # debug targets
> -psim_SOURCES = psim.cc
> -psim_LDADD = $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += psim
> -
> -test_mutate_SOURCES = test/test_mutate.cc
> -test_mutate_LDADD = libglobal.la librados.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -bin_DEBUGPROGRAMS += test_mutate
> -
> -test_rewrite_latency_SOURCES = test/test_rewrite_latency.cc
> -test_rewrite_latency_LDADD = libcommon.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -bin_DEBUGPROGRAMS += test_rewrite_latency
> -
> -testmsgr_SOURCES = testmsgr.cc
> -testmsgr_LDADD = $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += testmsgr
> -
> -test_ioctls_SOURCES = client/test_ioctls.c
> -bin_DEBUGPROGRAMS += test_ioctls
> -
> -dupstore_SOURCES = dupstore.cc
> -dupstore_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> -dupstore_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -streamtest_SOURCES = streamtest.cc
> -streamtest_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> -streamtest_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += dupstore streamtest
> -
> -test_trans_SOURCES = test_trans.cc
> -test_trans_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> -test_trans_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += test_trans
> -
> -testrados_SOURCES = test/osd/TestRados.cc test/osd/TestOpStat.cc test/osd/Object.cc  test/osd/RadosModel.cc
> -testrados_LDADD = librados.la $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += testrados
> -
> -smalliobench_SOURCES = test/bench/small_io_bench.cc test/bench/rados_backend.cc test/bench/detailed_stat_collector.cc test/bench/bencher.cc
> -smalliobench_LDADD = librados.la -lboost_program_options $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += smalliobench
> -
> -smalliobenchfs_SOURCES = test/bench/small_io_bench_fs.cc test/bench/filestore_backend.cc test/bench/detailed_stat_collector.cc test/bench/bencher.cc
> -smalliobenchfs_LDADD = librados.la -lboost_program_options $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -smalliobenchfs_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> -bin_DEBUGPROGRAMS += smalliobenchfs
> -
> -smalliobenchdumb_SOURCES = test/bench/small_io_bench_dumb.cc test/bench/dumb_backend.cc test/bench/detailed_stat_collector.cc test/bench/bencher.cc
> -smalliobenchdumb_LDADD = librados.la -lboost_program_options $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -smalliobenchdumb_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> -bin_DEBUGPROGRAMS += smalliobenchdumb
> -
> -smalliobenchrbd_SOURCES = test/bench/small_io_bench_rbd.cc test/bench/rbd_backend.cc test/bench/detailed_stat_collector.cc test/bench/bencher.cc
> -smalliobenchrbd_LDADD = librados.la librbd.la -lboost_program_options $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += smalliobenchrbd
> -
> -tpbench_SOURCES = test/bench/tp_bench.cc test/bench/detailed_stat_collector.cc
> -tpbench_LDADD = librados.la -lboost_program_options $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += tpbench
> -
> -omapbench_SOURCES = test/omap_bench.cc
> -omapbench_LDADD = librados.la $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += omapbench
> -
> -kvstorebench_SOURCES = test/kv_store_bench.cc key_value_store/kv_flat_btree_async.cc
> -kvstorebench_LDADD = librados.la $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += kvstorebench
> -
> -multi_stress_watch_SOURCES = test/multi_stress_watch.cc test/librados/test.cc
> -multi_stress_watch_LDADD = librados.la $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += multi_stress_watch
> +ceph_psim_SOURCES = psim.cc
> +ceph_psim_LDADD = $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_psim
> +
> +ceph_test_mutate_SOURCES = test/test_mutate.cc
> +ceph_test_mutate_LDADD = libglobal.la librados.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +bin_DEBUGPROGRAMS += ceph_test_mutate
> +
> +ceph_test_rewrite_latency_SOURCES = test/test_rewrite_latency.cc
> +ceph_test_rewrite_latency_LDADD = libcommon.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +bin_DEBUGPROGRAMS += ceph_test_rewrite_latency
> +
> +ceph_test_msgr_SOURCES = testmsgr.cc
> +ceph_test_msgr_LDADD = $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_test_msgr
> +
> +ceph_test_ioctls_SOURCES = client/test_ioctls.c
> +bin_DEBUGPROGRAMS += ceph_test_ioctls
> +
> +ceph_dupstore_SOURCES = dupstore.cc
> +ceph_dupstore_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> +ceph_dupstore_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_streamtest_SOURCES = streamtest.cc
> +ceph_streamtest_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> +ceph_streamtest_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_dupstore ceph_streamtest
> +
> +ceph_test_trans_SOURCES = test_trans.cc
> +ceph_test_trans_CXXFLAGS= ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> +ceph_test_trans_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_test_trans
> +
> +ceph_test_rados_SOURCES = test/osd/TestRados.cc test/osd/TestOpStat.cc test/osd/Object.cc  test/osd/RadosModel.cc
> +ceph_test_rados_LDADD = librados.la $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_test_rados
> +
> +ceph_smalliobench_SOURCES = test/bench/small_io_bench.cc test/bench/rados_backend.cc test/bench/detailed_stat_collector.cc test/bench/bencher.cc
> +ceph_smalliobench_LDADD = librados.la -lboost_program_options $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_smalliobench
> +
> +ceph_smalliobenchfs_SOURCES = test/bench/small_io_bench_fs.cc test/bench/filestore_backend.cc test/bench/detailed_stat_collector.cc test/bench/bencher.cc
> +ceph_smalliobenchfs_LDADD = librados.la -lboost_program_options $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_smalliobenchfs_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_smalliobenchfs
> +
> +ceph_smalliobenchdumb_SOURCES = test/bench/small_io_bench_dumb.cc test/bench/dumb_backend.cc test/bench/detailed_stat_collector.cc test/bench/bencher.cc
> +ceph_smalliobenchdumb_LDADD = librados.la -lboost_program_options $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_smalliobenchdumb_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_smalliobenchdumb
> +
> +ceph_smalliobenchrbd_SOURCES = test/bench/small_io_bench_rbd.cc test/bench/rbd_backend.cc test/bench/detailed_stat_collector.cc test/bench/bencher.cc
> +ceph_smalliobenchrbd_LDADD = librados.la librbd.la -lboost_program_options $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_smalliobenchrbd
> +
> +ceph_tpbench_SOURCES = test/bench/tp_bench.cc test/bench/detailed_stat_collector.cc
> +ceph_tpbench_LDADD = librados.la -lboost_program_options $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_tpbench
> +
> +ceph_omapbench_SOURCES = test/omap_bench.cc
> +ceph_omapbench_LDADD = librados.la $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_omapbench
> +
> +ceph_kvstorebench_SOURCES = test/kv_store_bench.cc key_value_store/kv_flat_btree_async.cc
> +ceph_kvstorebench_LDADD = librados.la $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_kvstorebench
> +
> +ceph_multi_stress_watch_SOURCES = test/multi_stress_watch.cc test/librados/test.cc
> +ceph_multi_stress_watch_LDADD = librados.la $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_multi_stress_watch
>
>   if WITH_BUILD_TESTS
> -test_libcommon_build_SOURCES = test/test_libcommon_build.cc $(libcommon_files)
> -test_libcommon_build_LDADD = $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -bin_DEBUGPROGRAMS += test_libcommon_build
> +ceph_test_libcommon_build_SOURCES = test/test_libcommon_build.cc $(libcommon_files)
> +ceph_test_libcommon_build_LDADD = $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +bin_DEBUGPROGRAMS += ceph_test_libcommon_build
>
> -test_librados_build_SOURCES = test/test_libcommon_build.cc $(libcommon_files) $(librados_SOURCES)
> -test_librados_build_LDADD = $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -test_librados_build_CXXFLAGS = $(AM_CXXFLAGS)
> -bin_DEBUGPROGRAMS += test_librados_build
> +ceph_test_librados_build_SOURCES = test/test_libcommon_build.cc $(libcommon_files) $(librados_SOURCES)
> +ceph_test_librados_build_LDADD = $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +ceph_test_librados_build_CXXFLAGS = $(AM_CXXFLAGS)
> +bin_DEBUGPROGRAMS += ceph_test_librados_build
>
> -test_librgw_build_SOURCES = test/test_libcommon_build.cc $(libcommon_files) \
> +ceph_test_librgw_build_SOURCES = test/test_libcommon_build.cc $(libcommon_files) \
>   			    $(librados_SOURCES) $(librgw_la_SOURCES)
> -test_librgw_build_LDADD = -lexpat $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -test_librgw_build_CXXFLAGS = $(AM_CXXFLAGS)
> -bin_DEBUGPROGRAMS += test_librgw_build
> +ceph_test_librgw_build_LDADD = -lexpat $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +ceph_test_librgw_build_CXXFLAGS = $(AM_CXXFLAGS)
> +bin_DEBUGPROGRAMS += ceph_test_librgw_build
>
> -test_libcephfs_build_SOURCES = test/test_libcommon_build.cc $(libcommon_files) \
> +ceph_test_libcephfs_build_SOURCES = test/test_libcommon_build.cc $(libcommon_files) \
>   			    $(libosdc_la_SOURCES)
> -test_libcephfs_build_LDADD = libcephfs.la -lexpat $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -test_libcephfs_build_CXXFLAGS = $(AM_CXXFLAGS)
> -bin_DEBUGPROGRAMS += test_libcephfs_build
> +ceph_test_libcephfs_build_LDADD = libcephfs.la -lexpat $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +ceph_test_libcephfs_build_CXXFLAGS = $(AM_CXXFLAGS)
> +bin_DEBUGPROGRAMS += ceph_test_libcephfs_build
>   endif
>
>   if WITH_HADOOPCLIENT
> -test_libhadoopcephfs_build_SOURCES = test/test_libcommon_build.cc \
> +ceph_test_libhadoopcephfs_build_SOURCES = test/test_libcommon_build.cc \
>            $(libhadoopcephfs_la_SOURCES) \
>   	 $(libosdc_la_SOURCES) $(libcommon_files)
> -test_libhadoopcephfs_build_LDADD = libcephfs.la -lexpat $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -test_libhadoopcephfs_build_CXXFLAGS = $(AM_CXXFLAGS)
> -bin_DEBUGPROGRAMS += test_libhadoopcephfs_build
> +ceph_test_libhadoopcephfs_build_LDADD = libcephfs.la -lexpat $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +ceph_test_libhadoopcephfs_build_CXXFLAGS = $(AM_CXXFLAGS)
> +bin_DEBUGPROGRAMS += ceph_test_libhadoopcephfs_build
>   endif
>
>   ##########
> @@ -316,13 +316,13 @@ libcephfs_la_LDFLAGS =  $(PTHREAD_LIBS) $(CRYPTO_LIBS) $(EXTRALIBS) \
>               ${AM_LDFLAGS} -version-info 1:0:0 -export-symbols-regex '^ceph_.*'
>   lib_LTLIBRARIES += libcephfs.la
>
> -testtimers_SOURCES = test/TestTimers.cc
> -testtimers_LDADD = $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += testtimers
> +ceph_test_timers_SOURCES = test/TestTimers.cc
> +ceph_test_timers_LDADD = $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_test_timers
>
> -testsignal_handlers_SOURCES = test/TestSignalHandlers.cc
> -testsignal_handlers_LDADD = $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += testsignal_handlers
> +ceph_test_signal_handlers_SOURCES = test/TestSignalHandlers.cc
> +ceph_test_signal_handlers_LDADD = $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_test_signal_handlers
>
>   # librados
>   librados_SOURCES = \
> @@ -392,15 +392,15 @@ radosgw_admin_CXXFLAGS = ${AM_CXXFLAGS}
>   radosgw_admin_LDADD = $(my_radosgw_ldadd)
>   bin_PROGRAMS += radosgw-admin
>
> -rgw_multiparser_SOURCES = rgw/rgw_multiparser.cc
> -rgw_multiparser_CXXFLAGS = ${AM_CXXFLAGS}
> -rgw_multiparser_LDADD = $(my_radosgw_ldadd)
> -bin_DEBUGPROGRAMS += rgw_multiparser
> +ceph_rgw_multiparser_SOURCES = rgw/rgw_multiparser.cc
> +ceph_rgw_multiparser_CXXFLAGS = ${AM_CXXFLAGS}
> +ceph_rgw_multiparser_LDADD = $(my_radosgw_ldadd)
> +bin_DEBUGPROGRAMS += ceph_rgw_multiparser
>
> -rgw_jsonparser_SOURCES = rgw/rgw_jsonparser.cc
> -rgw_jsonparser_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> -rgw_jsonparser_LDADD = $(my_radosgw_ldadd)
> -bin_DEBUGPROGRAMS += rgw_jsonparser
> +ceph_rgw_jsonparser_SOURCES = rgw/rgw_jsonparser.cc
> +ceph_rgw_jsonparser_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> +ceph_rgw_jsonparser_LDADD = $(my_radosgw_ldadd)
> +bin_DEBUGPROGRAMS += ceph_rgw_jsonparser
>
>   endif
>
> @@ -448,13 +448,13 @@ endif
>
>   endif
>
> -scratchtool_SOURCES = scratchtool.c
> -scratchtool_LDADD = librados.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -scratchtoolpp_SOURCES = scratchtoolpp.cc
> -scratchtoolpp_LDADD = librados.la $(PTHREAD_LIBS) -lm
> -radosacl_SOURCES = radosacl.cc
> -radosacl_LDADD = librados.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -bin_DEBUGPROGRAMS += scratchtool scratchtoolpp radosacl
> +ceph_scratchtool_SOURCES = scratchtool.c
> +ceph_scratchtool_LDADD = librados.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +ceph_scratchtoolpp_SOURCES = scratchtoolpp.cc
> +ceph_scratchtoolpp_LDADD = librados.la $(PTHREAD_LIBS) -lm
> +ceph_radosacl_SOURCES = radosacl.cc
> +ceph_radosacl_LDADD = librados.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +bin_DEBUGPROGRAMS += ceph_scratchtool ceph_scratchtoolpp ceph_radosacl
>
>   rbd_SOURCES = rbd.cc common/fiemap.cc common/secret.c common/TextTable.cc common/util.cc
>   rbd_CXXFLAGS = ${AM_CXXFLAGS}
> @@ -464,20 +464,20 @@ bin_PROGRAMS += rbd
>   endif
>
>
> -testcrypto_SOURCES = testcrypto.cc
> -testcrypto_LDADD =  $(LIBGLOBAL_LDA)
> -testcrypto_CXXFLAGS = ${AM_CXXFLAGS}
> -bin_DEBUGPROGRAMS += testcrypto
> +ceph_test_crypto_SOURCES = testcrypto.cc
> +ceph_test_crypto_LDADD =  $(LIBGLOBAL_LDA)
> +ceph_test_crypto_CXXFLAGS = ${AM_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_crypto
>
> -testkeys_SOURCES = testkeys.cc
> -testkeys_LDADD = libmon.a $(LIBGLOBAL_LDA)
> -testkeys_CXXFLAGS = ${AM_CXXFLAGS}
> -bin_DEBUGPROGRAMS += testkeys
> +ceph_test_keys_SOURCES = testkeys.cc
> +ceph_test_keys_LDADD = libmon.a $(LIBGLOBAL_LDA)
> +ceph_test_keys_CXXFLAGS = ${AM_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_keys
>
>   if WITH_TCMALLOC
> -testkeys_LDADD += -ltcmalloc
> -testkeys_CXXFLAGS += ${tcmalloc_safety_flags}
> -testkeys_SOURCES += perfglue/heap_profiler.cc
> +ceph_test_keys_LDADD += -ltcmalloc
> +ceph_test_keys_CXXFLAGS += ${tcmalloc_safety_flags}
> +ceph_test_keys_SOURCES += perfglue/heap_profiler.cc
>   endif
>
>
> @@ -583,41 +583,41 @@ libsystest_la_SOURCES = \
>   libsystest_la_LIBADD = libglobal.la
>   noinst_LTLIBRARIES += libsystest.la
>
> -testrados_list_parallel_SOURCES = \
> +ceph_test_rados_list_parallel_SOURCES = \
>   	test/system/rados_list_parallel.cc \
>   	test/system/st_rados_create_pool.cc \
>   	test/system/st_rados_list_objects.cc
> -testrados_list_parallel_LDADD = libsystest.la librados.la
> -bin_DEBUGPROGRAMS += testrados_list_parallel
> +ceph_test_rados_list_parallel_LDADD = libsystest.la librados.la
> +bin_DEBUGPROGRAMS += ceph_test_rados_list_parallel
>
> -testrados_open_pools_parallel_SOURCES = \
> +ceph_test_rados_open_pools_parallel_SOURCES = \
>   	test/system/rados_open_pools_parallel.cc \
>   	test/system/st_rados_create_pool.cc
> -testrados_open_pools_parallel_LDADD = libsystest.la librados.la
> -bin_DEBUGPROGRAMS += testrados_open_pools_parallel
> +ceph_test_rados_open_pools_parallel_LDADD = libsystest.la librados.la
> +bin_DEBUGPROGRAMS += ceph_test_rados_open_pools_parallel
>
> -testrados_delete_pools_parallel_SOURCES = \
> +ceph_test_rados_delete_pools_parallel_SOURCES = \
>   	test/system/rados_delete_pools_parallel.cc \
>   	test/system/st_rados_create_pool.cc \
>   	test/system/st_rados_delete_pool.cc \
>   	test/system/st_rados_list_objects.cc
> -testrados_delete_pools_parallel_LDADD = libsystest.la librados.la
> -bin_DEBUGPROGRAMS += testrados_delete_pools_parallel
> +ceph_test_rados_delete_pools_parallel_LDADD = libsystest.la librados.la
> +bin_DEBUGPROGRAMS += ceph_test_rados_delete_pools_parallel
>
> -testrados_watch_notify_SOURCES = \
> +ceph_test_rados_watch_notify_SOURCES = \
>   	test/system/rados_watch_notify.cc \
>   	test/system/st_rados_create_pool.cc \
>   	test/system/st_rados_delete_pool.cc \
>   	test/system/st_rados_delete_objs.cc \
>   	test/system/st_rados_watch.cc \
>   	test/system/st_rados_notify.cc
> -testrados_watch_notify_LDADD = libsystest.la librados.la
> -bin_DEBUGPROGRAMS += testrados_watch_notify
> +ceph_test_rados_watch_notify_LDADD = libsystest.la librados.la
> +bin_DEBUGPROGRAMS += ceph_test_rados_watch_notify
>
> -bench_log_SOURCES = \
> +ceph_bench_log_SOURCES = \
>   	test/bench_log.cc
> -bench_log_LDADD = libcommon.la libglobal.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> -bin_DEBUGPROGRAMS += bench_log
> +ceph_bench_log_LDADD = libcommon.la libglobal.la $(PTHREAD_LIBS) -lm $(CRYPTO_LIBS) $(EXTRALIBS)
> +bin_DEBUGPROGRAMS += ceph_bench_log
>
>   ## unit tests
>
> @@ -834,193 +834,193 @@ unittest_texttable_LDADD = librados.la ${UNITTEST_LDADD}
>   unittest_texttable_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
>   check_PROGRAMS += unittest_texttable
>
> -test_librbd_SOURCES = test/librbd/test_librbd.cc test/librados/test.cc
> -test_librbd_LDADD =  librbd.la librados.la ${UNITTEST_STATIC_LDADD}
> -test_librbd_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_librbd
> +ceph_test_librbd_SOURCES = test/librbd/test_librbd.cc test/librados/test.cc
> +ceph_test_librbd_LDADD =  librbd.la librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_librbd_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_librbd
>
> -test_librbd_fsx_SOURCES = test/librbd/fsx.c
> -test_librbd_fsx_LDADD =  librbd.la librados.la -lm
> -test_librbd_fsx_CFLAGS = ${AM_CFLAGS} -Wno-format
> -bin_DEBUGPROGRAMS += test_librbd_fsx
> +ceph_test_librbd_fsx_SOURCES = test/librbd/fsx.c
> +ceph_test_librbd_fsx_LDADD =  librbd.la librados.la -lm
> +ceph_test_librbd_fsx_CFLAGS = ${AM_CFLAGS} -Wno-format
> +bin_DEBUGPROGRAMS += ceph_test_librbd_fsx
>
> -test_cls_rbd_SOURCES = test/cls_rbd/test_cls_rbd.cc \
> +ceph_test_cls_rbd_SOURCES = test/cls_rbd/test_cls_rbd.cc \
>   	test/librados/test.cc \
>   	cls/rbd/cls_rbd_client.cc \
>   	cls/lock/cls_lock_client.cc \
>   	cls/lock/cls_lock_types.cc \
>   	cls/lock/cls_lock_ops.cc
> -test_cls_rbd_LDADD = librados.la ${UNITTEST_STATIC_LDADD}
> -test_cls_rbd_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_cls_rbd
> +ceph_test_cls_rbd_LDADD = librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_cls_rbd_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_cls_rbd
>
> -test_cls_refcount_SOURCES = test/cls_refcount/test_cls_refcount.cc \
> +ceph_test_cls_refcount_SOURCES = test/cls_refcount/test_cls_refcount.cc \
>   	test/librados/test.cc
> -test_cls_refcount_LDADD = librados.la libcls_refcount_client.a ${UNITTEST_STATIC_LDADD}
> -test_cls_refcount_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_cls_refcount
> +ceph_test_cls_refcount_LDADD = librados.la libcls_refcount_client.a ${UNITTEST_STATIC_LDADD}
> +ceph_test_cls_refcount_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_cls_refcount
>
> -test_cls_lock_SOURCES = test/cls_lock/test_cls_lock.cc test/librados/test.cc
> -test_cls_lock_LDFLAGS = ${AM_LDFLAGS}
> -test_cls_lock_LDADD =  libcls_lock_client.a librados.la ${UNITTEST_STATIC_LDADD}
> -test_cls_lock_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_cls_lock
> +ceph_test_cls_lock_SOURCES = test/cls_lock/test_cls_lock.cc test/librados/test.cc
> +ceph_test_cls_lock_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_cls_lock_LDADD =  libcls_lock_client.a librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_cls_lock_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_cls_lock
>
>   if WITH_RADOSGW
>
> -test_cls_rgw_SOURCES = test/cls_rgw/test_cls_rgw.cc \
> +ceph_test_cls_rgw_SOURCES = test/cls_rgw/test_cls_rgw.cc \
>   	test/librados/test.cc
> -test_cls_rgw_LDADD = librados.la libcls_rgw_client.a ${UNITTEST_STATIC_LDADD}
> -test_cls_rgw_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_cls_rgw
> +ceph_test_cls_rgw_LDADD = librados.la libcls_rgw_client.a ${UNITTEST_STATIC_LDADD}
> +ceph_test_cls_rgw_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_cls_rgw
>
>   endif
>
> -test_mon_workloadgen_SOURCES = \
> +ceph_test_mon_workloadgen_SOURCES = \
>        test/mon/test_mon_workloadgen.cc \
>   		 osdc/Objecter.cc \
>   		 osdc/Striper.cc
> -test_mon_workloadgen_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -test_mon_workloadgen_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_mon_workloadgen
> -
> -test_rados_api_io_SOURCES = test/librados/io.cc test/librados/test.cc
> -test_rados_api_io_LDFLAGS = ${AM_LDFLAGS}
> -test_rados_api_io_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_rados_api_io_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_rados_api_io
> -
> -test_rados_api_aio_SOURCES = test/librados/aio.cc test/librados/test.cc
> -test_rados_api_aio_LDFLAGS = ${AM_LDFLAGS}
> -test_rados_api_aio_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_rados_api_aio_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_rados_api_aio
> -
> -test_rados_api_list_SOURCES = test/librados/list.cc test/librados/test.cc
> -test_rados_api_list_LDFLAGS = ${AM_LDFLAGS}
> -test_rados_api_list_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_rados_api_list_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_rados_api_list
> -
> -test_rados_api_pool_SOURCES = test/librados/pool.cc test/librados/test.cc
> -test_rados_api_pool_LDFLAGS = ${AM_LDFLAGS}
> -test_rados_api_pool_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_rados_api_pool_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_rados_api_pool
> -
> -test_rados_api_stat_SOURCES = test/librados/stat.cc test/librados/test.cc
> -test_rados_api_stat_LDFLAGS = ${AM_LDFLAGS}
> -test_rados_api_stat_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_rados_api_stat_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_rados_api_stat
> -
> -test_rados_api_watch_notify_SOURCES = test/librados/watch_notify.cc test/librados/test.cc
> -test_rados_api_watch_notify_LDFLAGS = ${AM_LDFLAGS}
> -test_rados_api_watch_notify_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_rados_api_watch_notify_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_rados_api_watch_notify
> -
> -test_rados_api_snapshots_SOURCES = test/librados/snapshots.cc test/librados/test.cc
> -test_rados_api_snapshots_LDFLAGS = ${AM_LDFLAGS}
> -test_rados_api_snapshots_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_rados_api_snapshots_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_rados_api_snapshots
> -
> -test_rados_api_cls_SOURCES = test/librados/cls.cc test/librados/test.cc
> -test_rados_api_cls_LDFLAGS = ${AM_LDFLAGS}
> -test_rados_api_cls_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_rados_api_cls_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_rados_api_cls
> -
> -test_rados_api_misc_SOURCES = test/librados/misc.cc test/librados/test.cc
> -test_rados_api_misc_LDFLAGS = ${AM_LDFLAGS}
> -test_rados_api_misc_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_rados_api_misc_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_rados_api_misc
> -
> -test_libcephfs_SOURCES = test/libcephfs/test.cc test/libcephfs/readdir_r_cb.cc test/libcephfs/caps.cc
> -test_libcephfs_LDFLAGS = $(PTHREAD_CFLAGS) ${AM_LDFLAGS}
> -test_libcephfs_LDADD =  ${UNITTEST_STATIC_LDADD} libcephfs.la
> -test_libcephfs_CXXFLAGS = $(AM_CXXFLAGS) ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_libcephfs
> -
> -test_filestore_SOURCES = test/filestore/store_test.cc
> -test_filestore_LDFLAGS = ${AM_LDFLAGS}
> -test_filestore_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -test_filestore_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS} $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_filestore
> -
> -test_filestore_workloadgen_SOURCES = \
> +ceph_test_mon_workloadgen_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_test_mon_workloadgen_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_mon_workloadgen
> +
> +ceph_test_rados_api_io_SOURCES = test/librados/io.cc test/librados/test.cc
> +ceph_test_rados_api_io_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_rados_api_io_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_rados_api_io_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_rados_api_io
> +
> +ceph_test_rados_api_aio_SOURCES = test/librados/aio.cc test/librados/test.cc
> +ceph_test_rados_api_aio_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_rados_api_aio_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_rados_api_aio_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_rados_api_aio
> +
> +ceph_test_rados_api_list_SOURCES = test/librados/list.cc test/librados/test.cc
> +ceph_test_rados_api_list_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_rados_api_list_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_rados_api_list_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_rados_api_list
> +
> +ceph_test_rados_api_pool_SOURCES = test/librados/pool.cc test/librados/test.cc
> +ceph_test_rados_api_pool_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_rados_api_pool_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_rados_api_pool_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_rados_api_pool
> +
> +ceph_test_rados_api_stat_SOURCES = test/librados/stat.cc test/librados/test.cc
> +ceph_test_rados_api_stat_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_rados_api_stat_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_rados_api_stat_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_rados_api_stat
> +
> +ceph_test_rados_api_watch_notify_SOURCES = test/librados/watch_notify.cc test/librados/test.cc
> +ceph_test_rados_api_watch_notify_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_rados_api_watch_notify_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_rados_api_watch_notify_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_rados_api_watch_notify
> +
> +ceph_test_rados_api_snapshots_SOURCES = test/librados/snapshots.cc test/librados/test.cc
> +ceph_test_rados_api_snapshots_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_rados_api_snapshots_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_rados_api_snapshots_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_rados_api_snapshots
> +
> +ceph_test_rados_api_cls_SOURCES = test/librados/cls.cc test/librados/test.cc
> +ceph_test_rados_api_cls_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_rados_api_cls_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_rados_api_cls_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_rados_api_cls
> +
> +ceph_test_rados_api_misc_SOURCES = test/librados/misc.cc test/librados/test.cc
> +ceph_test_rados_api_misc_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_rados_api_misc_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_rados_api_misc_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_rados_api_misc
> +
> +ceph_test_libcephfs_SOURCES = test/libcephfs/test.cc test/libcephfs/readdir_r_cb.cc test/libcephfs/caps.cc
> +ceph_test_libcephfs_LDFLAGS = $(PTHREAD_CFLAGS) ${AM_LDFLAGS}
> +ceph_test_libcephfs_LDADD =  ${UNITTEST_STATIC_LDADD} libcephfs.la
> +ceph_test_libcephfs_CXXFLAGS = $(AM_CXXFLAGS) ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_libcephfs
> +
> +ceph_test_filestore_SOURCES = test/filestore/store_test.cc
> +ceph_test_filestore_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_filestore_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_test_filestore_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS} $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_filestore
> +
> +ceph_test_filestore_workloadgen_SOURCES = \
>        test/filestore/workload_generator.cc \
>        test/filestore/TestFileStoreState.cc
> -test_filestore_workloadgen_LDFLAGS = ${AM_LDFLAGS}
> -test_filestore_workloadgen_LDADD =  $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -test_filestore_workloadgen_CXXFLAGS =  ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_filestore_workloadgen
> +ceph_test_filestore_workloadgen_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_filestore_workloadgen_LDADD =  $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_test_filestore_workloadgen_CXXFLAGS =  ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_filestore_workloadgen
>
> -test_filestore_idempotent_SOURCES = test/filestore/test_idempotent.cc test/filestore/FileStoreTracker.cc test/common/ObjectContents.cc
> -test_filestore_idempotent_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -test_filestore_idempotent_CXXFLAGS = $(AM_CXXFLAGS) $(LEVELDB_INCLUDE)
> -bin_DEBUGPROGRAMS += test_filestore_idempotent
> +ceph_test_filestore_idempotent_SOURCES = test/filestore/test_idempotent.cc test/filestore/FileStoreTracker.cc test/common/ObjectContents.cc
> +ceph_test_filestore_idempotent_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_test_filestore_idempotent_CXXFLAGS = $(AM_CXXFLAGS) $(LEVELDB_INCLUDE)
> +bin_DEBUGPROGRAMS += ceph_test_filestore_idempotent
>
> -test_filestore_idempotent_sequence_SOURCES = \
> +ceph_test_filestore_idempotent_sequence_SOURCES = \
>        test/filestore/test_idempotent_sequence.cc \
>        test/filestore/DeterministicOpSequence.cc \
>        test/filestore/TestFileStoreState.cc \
>        test/filestore/FileStoreDiff.cc
> -test_filestore_idempotent_sequence_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> -test_filestore_idempotent_sequence_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -bin_DEBUGPROGRAMS += test_filestore_idempotent_sequence
> -
> -xattr_bench_SOURCES = test/xattr_bench.cc
> -xattr_bench_LDFLAGS = ${AM_LDFLAGS}
> -xattr_bench_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -xattr_bench_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}  $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> -bin_DEBUGPROGRAMS += xattr_bench
> -
> -test_filejournal_SOURCES = test/test_filejournal.cc
> -test_filejournal_LDFLAGS = ${AM_LDFLAGS}
> -test_filejournal_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -test_filejournal_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_filejournal
> -
> -test_stress_watch_SOURCES = test/test_stress_watch.cc test/librados/test.cc
> -test_stress_watch_LDFLAGS = ${AM_LDFLAGS}
> -test_stress_watch_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> -test_stress_watch_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_stress_watch
> -
> -test_objectcacher_stress_SOURCES = test/osdc/object_cacher_stress.cc test/osdc/FakeWriteback.cc osdc/ObjectCacher.cc
> -test_objectcacher_stress_LDFLAGS = ${AM_LDFLAGS}
> -test_objectcacher_stress_LDADD = $(LIBGLOBAL_LDA)
> -test_objectcacher_stress_CXXFLAGS = ${AM_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_objectcacher_stress
> -
> -test_object_map_SOURCES = test/ObjectMap/test_object_map.cc test/ObjectMap/KeyValueDBMemory.cc os/DBObjectMap.cc os/LevelDBStore.cc
> -test_object_map_LDFLAGS = ${AM_LDFLAGS}
> -test_object_map_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -test_object_map_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS} $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_object_map
> -
> -test_keyvaluedb_atomicity_SOURCES = test/ObjectMap/test_keyvaluedb_atomicity.cc os/LevelDBStore.cc
> -test_keyvaluedb_atomicity_LDFLAGS = ${AM_LDFLAGS}
> -test_keyvaluedb_atomicity_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -test_keyvaluedb_atomicity_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS} $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_keyvaluedb_atomicity
> -
> -test_keyvaluedb_iterators_SOURCES = test/ObjectMap/test_keyvaluedb_iterators.cc \
> +ceph_test_filestore_idempotent_sequence_CXXFLAGS = ${CRYPTO_CXXFLAGS} ${AM_CXXFLAGS}
> +ceph_test_filestore_idempotent_sequence_LDADD = $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +bin_DEBUGPROGRAMS += ceph_test_filestore_idempotent_sequence
> +
> +ceph_xattr_bench_SOURCES = test/xattr_bench.cc
> +ceph_xattr_bench_LDFLAGS = ${AM_LDFLAGS}
> +ceph_xattr_bench_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_xattr_bench_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}  $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_xattr_bench
> +
> +ceph_test_filejournal_SOURCES = test/test_filejournal.cc
> +ceph_test_filejournal_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_filejournal_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_test_filejournal_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_filejournal
> +
> +ceph_test_stress_watch_SOURCES = test/test_stress_watch.cc test/librados/test.cc
> +ceph_test_stress_watch_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_stress_watch_LDADD =  librados.la ${UNITTEST_STATIC_LDADD}
> +ceph_test_stress_watch_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_stress_watch
> +
> +ceph_test_objectcacher_stress_SOURCES = test/osdc/object_cacher_stress.cc test/osdc/FakeWriteback.cc osdc/ObjectCacher.cc
> +ceph_test_objectcacher_stress_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_objectcacher_stress_LDADD = $(LIBGLOBAL_LDA)
> +ceph_test_objectcacher_stress_CXXFLAGS = ${AM_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_objectcacher_stress
> +
> +ceph_test_object_map_SOURCES = test/ObjectMap/test_object_map.cc test/ObjectMap/KeyValueDBMemory.cc os/DBObjectMap.cc os/LevelDBStore.cc
> +ceph_test_object_map_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_object_map_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_test_object_map_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS} $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_object_map
> +
> +ceph_test_keyvaluedb_atomicity_SOURCES = test/ObjectMap/test_keyvaluedb_atomicity.cc os/LevelDBStore.cc
> +ceph_test_keyvaluedb_atomicity_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_keyvaluedb_atomicity_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_test_keyvaluedb_atomicity_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS} $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_keyvaluedb_atomicity
> +
> +ceph_test_keyvaluedb_iterators_SOURCES = test/ObjectMap/test_keyvaluedb_iterators.cc \
>                                       test/ObjectMap/KeyValueDBMemory.cc \
>                                       os/LevelDBStore.cc
> -test_keyvaluedb_iterators_LDFLAGS = ${AM_LDFLAGS}
> -test_keyvaluedb_iterators_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> -test_keyvaluedb_iterators_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS} $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_keyvaluedb_iterators
> -
> -test_cfuse_cache_invalidate_SOURCES = test/test_cfuse_cache_invalidate.cc
> -test_cfuse_cache_invalidate_LDFLAGS = ${AM_LDFLAGS}
> -test_cfuse_cache_invalidate_LDADD =
> -test_cfuse_cache_invalidate_CXXFLAGS = ${AM_CXXFLAGS}
> -bin_DEBUGPROGRAMS += test_cfuse_cache_invalidate
> +ceph_test_keyvaluedb_iterators_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_keyvaluedb_iterators_LDADD =  ${UNITTEST_STATIC_LDADD} $(LIBOS_LDA) $(LIBGLOBAL_LDA)
> +ceph_test_keyvaluedb_iterators_CXXFLAGS = ${AM_CXXFLAGS} ${UNITTEST_CXXFLAGS} $(LEVELDB_INCLUDE) ${CRYPTO_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_keyvaluedb_iterators
> +
> +ceph_test_cfuse_cache_invalidate_SOURCES = test/test_cfuse_cache_invalidate.cc
> +ceph_test_cfuse_cache_invalidate_LDFLAGS = ${AM_LDFLAGS}
> +ceph_test_cfuse_cache_invalidate_LDADD =
> +ceph_test_cfuse_cache_invalidate_CXXFLAGS = ${AM_CXXFLAGS}
> +bin_DEBUGPROGRAMS += ceph_test_cfuse_cache_invalidate
>
>   # shell scripts
>   editpaths = sed \
> diff --git a/src/client/test_ioctls.c b/src/client/test_ioctls.c
> index f510cd2..23fa835 100644
> --- a/src/client/test_ioctls.c
> +++ b/src/client/test_ioctls.c
> @@ -24,7 +24,7 @@ int main(int argc, char **argv)
>   	struct ceph_ioctl_dataloc dl;
>
>   	if (argc < 3) {
> -		printf("usage: test_ioctls <filename> <offset>\n");
> +		printf("usage: ceph_test_ioctls <filename> <offset>\n");
>   		return 1;
>   	}
>   	fn = argv[1];
> diff --git a/src/dupstore.cc b/src/dupstore.cc
> index 3326902..c7f5319 100644
> --- a/src/dupstore.cc
> +++ b/src/dupstore.cc
> @@ -77,7 +77,7 @@ int dupstore(ObjectStore* src, ObjectStore* dst)
>
>   void usage()
>   {
> -  cerr << "usage: dupstore filestore SRC filestore DST" << std::endl;
> +  cerr << "usage: ceph_dupstore filestore SRC filestore DST" << std::endl;
>     exit(0);
>   }
>
> diff --git a/src/psim.cc b/src/psim.cc
> index b089876..89d261a 100644
> --- a/src/psim.cc
> +++ b/src/psim.cc
> @@ -52,7 +52,7 @@ int main(int argc, char **argv)
>   	int x = H(oid);
>   	x = ceph_stable_mod(x, 1023, 1023);
>   	int s = crush_hash32(x) % 15;
> -	//cout << "psim: x = " << x << " s = " << s << std::endl;
> +	//cout << "ceph_psim: x = " << x << " s = " << s << std::endl;
>   	//osds[0] = s;
>         }
>   #endif
> diff --git a/src/test/filestore/TestFileStoreState.cc b/src/test/filestore/TestFileStoreState.cc
> index 728d6e4..e4a7162 100644
> --- a/src/test/filestore/TestFileStoreState.cc
> +++ b/src/test/filestore/TestFileStoreState.cc
> @@ -27,7 +27,7 @@
>
>   #define dout_subsys ceph_subsys_filestore
>   #undef dout_prefix
> -#define dout_prefix *_dout << "test_filestore_state "
> +#define dout_prefix *_dout << "ceph_test_filestore_state "
>
>   const coll_t TestFileStoreState::META_COLL("meta");
>   const coll_t TestFileStoreState::TEMP_COLL("temp");
> diff --git a/src/test/filestore/run_seed_to.sh b/src/test/filestore/run_seed_to.sh
> index f79874e..fdf5614 100755
> --- a/src/test/filestore/run_seed_to.sh
> +++ b/src/test/filestore/run_seed_to.sh
> @@ -1,7 +1,7 @@
>   #!/bin/bash
>   # vim: ts=8 sw=2 smarttab
>   #
> -# run_seed_to.sh - Run test_filestore_idempotent_sequence up until an
> +# run_seed_to.sh - Run ceph_test_filestore_idempotent_sequence up until an
>   # injection point, generating a sequence of operations based on a
>   # provided seed.
>   #
> @@ -244,13 +244,13 @@ do
>     fi
>
>     do_rm $tmp_name_a $tmp_name_a.fail $tmp_name_a.recover
> -  $v test_filestore_idempotent_sequence run-sequence-to $to \
> +  $v ceph_test_filestore_idempotent_sequence run-sequence-to $to \
>       $tmp_name_a $tmp_name_a/journal \
>       --filestore-xattr-use-omap --test-seed $seed --osd-journal-size 100 \
>       --filestore-kill-at $killat $tmp_opts_a \
>       --log-file $tmp_name_a.fail --debug-filestore 20 || true
>
> -  stop_at=`test_filestore_idempotent_sequence get-last-op \
> +  stop_at=`ceph_test_filestore_idempotent_sequence get-last-op \
>       $tmp_name_a $tmp_name_a/journal \
>       --filestore-xattr-use-omap --log-file $tmp_name_a.recover \
>       --debug-filestore 20 --debug-journal 20`
> @@ -263,12 +263,12 @@ do
>     echo stopped at $stop_at
>
>     do_rm $tmp_name_b $tmp_name_b.clean
> -  $v test_filestore_idempotent_sequence run-sequence-to \
> +  $v ceph_test_filestore_idempotent_sequence run-sequence-to \
>       $stop_at $tmp_name_b $tmp_name_b/journal \
>       --filestore-xattr-use-omap --test-seed $seed --osd-journal-size 100 \
>       --log-file $tmp_name_b.clean --debug-filestore 20 $tmp_opts_b
>
> -  if $v test_filestore_idempotent_sequence diff \
> +  if $v ceph_test_filestore_idempotent_sequence diff \
>       $tmp_name_a $tmp_name_a/journal $tmp_name_b $tmp_name_b/journal \
>       --filestore-xattr-use-omap; then
>         echo OK
> diff --git a/src/test/run-rbd-tests b/src/test/run-rbd-tests
> index fe8fa4d..d7a2b1b 100755
> --- a/src/test/run-rbd-tests
> +++ b/src/test/run-rbd-tests
> @@ -25,12 +25,12 @@ run_api_tests() {
>       recreate_pool rbd
>       # skip many_snaps since it takes several minutes
>       # skip remove_with_watcher until #2533 is fixed
> -    nosetests -v test_rbd -e '.*many_snaps' -e '.*remove_with_watcher'
> -    # test_librbd creates its own pools
> -    test_librbd
> +    nosetests -v ceph_test_rbd -e '.*many_snaps' -e '.*remove_with_watcher'

test_rbd is a python test that wasn't (and doesn't need to be) renamed,
since it's neither an executable nor installed.

> +    # ceph_test_librbd creates its own pools
> +    ceph_test_librbd
>   }
>
> -test_cls_rbd
> +ceph_test_cls_rbd
>   run_api_tests
>   run_cli_tests
>
> diff --git a/src/test/test_filejournal.cc b/src/test/test_filejournal.cc
> index 5b7576d..5c6a4fc 100644
> --- a/src/test/test_filejournal.cc
> +++ b/src/test/test_filejournal.cc
> @@ -74,7 +74,7 @@ int main(int argc, char **argv) {
>       strcpy(path, args[0]);
>     } else {
>       srand(getpid()+time(0));
> -    snprintf(path, sizeof(path), "/tmp/test_filejournal.tmp.%d", rand());
> +    snprintf(path, sizeof(path), "/tmp/ceph_test_filejournal.tmp.%d", rand());
>     }
>     cout << "path " << path << std::endl;
>
> diff --git a/src/test/test_mutate.cc b/src/test/test_mutate.cc
> index f2feda1..b9e0d71 100644
> --- a/src/test/test_mutate.cc
> +++ b/src/test/test_mutate.cc
> @@ -48,7 +48,7 @@ int main(int argc, const char **argv)
>     common_init_finish(g_ceph_context);
>
>     string val;
> -  string oid("test_object");
> +  string oid("ceph_test_object");
>     string pool_name("test_pool");
>     for (std::vector<const char*>::iterator i = args.begin(); i != args.end(); ) {
>       if (ceph_argparse_double_dash(args, i)) {
>

