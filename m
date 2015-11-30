From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Compiling for FreeBSD
Date: Mon, 30 Nov 2015 17:04:55 +0100
Message-ID: <565C73A7.9050201@digiware.nl>
References: <565B3999.3050302@digiware.nl>
 <CACJqLyaSTqKjAQf1Nb8UE00SrF0y1fskYhExmWd3vbCvNrFBkA@mail.gmail.com>
 <565B4A7F.60301@digiware.nl>
 <CAAM7YAmmOwfyiB1jFfGLz4fDxPxHRPQQNk80qEq2-RqFiHH-3g@mail.gmail.com>
 <20151130065812.GA20205@gmail.com> <565C38D2.4080403@digiware.nl>
 <20151130141320.GB20205@gmail.com> <565C5FF8.1090003@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([31.223.170.169]:43753 "EHLO smtp.digiware.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751313AbbK3QFc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 30 Nov 2015 11:05:32 -0500
In-Reply-To: <565C5FF8.1090003@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mykola Golub <mgolub@mirantis.com>, "ceph-devel@vger.kernel.org >> Ceph Development" <ceph-devel@vger.kernel.org>

On 30-11-2015 15:40, Willem Jan Withagen wrote:
> On 30-11-2015 15:13, Mykola Golub wrote:
>> On Mon, Nov 30, 2015 at 12:53:54PM +0100, Willem Jan Withagen wrote:
>>
>>>> git clone --recursive -b wip-freebsd https://github.com/trociny/ceph.git
>>>> cd ceph
>>>> ./install-deps.sh
>>>> ./do_autogen.sh
>>>> gmake
>>>> cd src
>>>> ./vstart.sh # start dev cluster
>>>> ./ceph -s # check it works
>>>>
>>>
>>> So what backend for the OSDs are you using here?
>>
>> The default one, which is FileStore. I have not done much testing
>> though...
>>
> 
> Well,
> Cherry-picked a few of you diffs.
> Compilation is now slugging thru the tests in my tree.
> Running gmake in serial mode, so it is slow with clang.

Installed the results:
gmake install

And looked at what it delivered:
	zfs diff <fs-en>

And I have to be honest that I'm not really enjoying all the ceph-test
stuff in my /usr/local/bin....
Would prefer it to go into something like:
	/usr/local/libexec/ceph/tests
or
	/usr/local/share/ceph/tests

Not sure if this is possible without disrupting the automated testing.

--WjW

+       /sbin/mount.fuse.ceph
zfsroot/tmp
M       /tmp/
+       /tmp/fses
zfsroot/usr
M       /usr/local/sbin
M       /usr/local/bin
M       /usr/local/etc
M       /usr/local/include
M       /usr/local/lib
M       /usr/local/libexec
M       /usr/local/share
M       /usr/local/share/doc
M       /usr/local/lib/python2.7/site-packages
M       /usr/srcs/Ceph/src/ceph/src/.libs/libradosstriper.so.1
M       /usr/srcs/Ceph/src/ceph/src/.libs/librbd.so.1
+       /usr/local/share/ceph
+       /usr/local/share/ceph/known_hosts_drop.ceph.com
+       /usr/local/share/ceph/id_dsa_drop.ceph.com
+       /usr/local/share/ceph/id_dsa_drop.ceph.com.pub
+       /usr/local/lib/librados.so.2
+       /usr/local/lib/librados.so
+       /usr/local/lib/librados.la
+       /usr/srcs/Ceph/src/ceph/src/.libs/libradosstriper.so.1T
+       /usr/local/lib/libradosstriper.so.1
+       /usr/local/lib/libradosstriper.so
+       /usr/local/lib/libradosstriper.la
+       /usr/srcs/Ceph/src/ceph/src/.libs/librbd.so.1T
+       /usr/local/lib/librbd.so.1
+       /usr/local/lib/librbd.so
+       /usr/local/lib/librbd.la
+       /usr/local/lib/libcephfs.so.1
+       /usr/local/lib/libcephfs.so
+       /usr/local/lib/libcephfs.la
+       /usr/local/lib/librados.a
+       /usr/local/lib/libradosstriper.a
+       /usr/local/lib/librbd.a
+       /usr/local/lib/libcephfs.a
+       /usr/local/bin/ceph_test_ioctls
+       /usr/local/bin/ceph_erasure_code_benchmark
+       /usr/local/bin/ceph_erasure_code
+       /usr/local/bin/ceph_test_rados
+       /usr/local/bin/ceph_test_mutate
+       /usr/local/bin/ceph_smalliobench
+       /usr/local/bin/ceph_omapbench
+       /usr/local/bin/ceph_objectstore_bench
+       /usr/local/bin/ceph_multi_stress_watch
+       /usr/local/bin/ceph_test_cls_rbd
+       /usr/local/bin/ceph_test_cls_refcount
+       /usr/local/bin/ceph_test_cls_version
+       /usr/local/bin/ceph_test_cls_log
+       /usr/local/bin/ceph_test_cls_statelog
+       /usr/local/bin/ceph_test_cls_replica_log
+       /usr/local/bin/ceph_test_cls_lock
+       /usr/local/bin/ceph_test_cls_hello
+       /usr/local/bin/ceph_test_cls_numops
+       /usr/local/bin/ceph_test_cls_journal
+       /usr/local/bin/ceph_test_rados_api_cmd
+       /usr/local/bin/ceph_test_rados_api_io
+       /usr/local/bin/ceph_test_rados_api_c_write_operations
+       /usr/local/bin/ceph_test_rados_api_c_read_operations
+       /usr/local/bin/ceph_test_rados_api_aio
+       /usr/local/bin/ceph_test_rados_api_list
+       /usr/local/bin/ceph_test_rados_api_nlist
+       /usr/local/bin/ceph_test_rados_api_pool
+       /usr/local/bin/ceph_test_rados_api_stat
+       /usr/local/bin/ceph_test_rados_api_watch_notify
+       /usr/local/bin/ceph_test_rados_api_snapshots
+       /usr/local/bin/ceph_test_rados_api_cls
+       /usr/local/bin/ceph_test_rados_api_misc
+       /usr/local/bin/ceph_test_rados_api_tier
+       /usr/local/bin/ceph_test_rados_api_lock
+       /usr/local/bin/ceph_test_stress_watch
+       /usr/local/bin/ceph_smalliobenchrbd
+       /usr/local/bin/ceph_test_librbd
+       /usr/local/bin/ceph_test_librbd_api
+       /usr/local/bin/ceph_test_rados_striper_api_io
+       /usr/local/bin/ceph_test_rados_striper_api_aio
+       /usr/local/bin/ceph_test_rados_striper_api_striping
+       /usr/local/bin/ceph_test_libcephfs
+       /usr/local/bin/ceph_test_c_headers
+       /usr/local/bin/ceph_test_async_driver
+       /usr/local/bin/ceph_test_msgr
+       /usr/local/bin/ceph_streamtest
+       /usr/local/bin/ceph_test_trans
+       /usr/local/bin/ceph_test_mon_workloadgen
+       /usr/local/bin/ceph_test_mon_msg
+       /usr/local/bin/ceph_perf_objectstore
+       /usr/local/bin/ceph_perf_local
+       /usr/local/bin/ceph_perf_msgr_server
+       /usr/local/bin/ceph_perf_msgr_client
+       /usr/local/bin/ceph_test_objectstore_workloadgen
+       /usr/local/bin/ceph_test_filestore_idempotent
+       /usr/local/bin/ceph_test_filestore_idempotent_sequence
+       /usr/local/bin/ceph_xattr_bench
+       /usr/local/bin/ceph_test_filejournal
+       /usr/local/bin/ceph_test_object_map
+       /usr/local/bin/ceph_test_keyvaluedb_atomicity
+       /usr/local/bin/ceph_test_keyvaluedb_iterators
+       /usr/local/bin/ceph_smalliobenchfs
+       /usr/local/bin/ceph_smalliobenchdumb
+       /usr/local/bin/ceph_tpbench
+       /usr/local/bin/ceph_test_keys
+       /usr/local/bin/ceph_test_snap_mapper
+       /usr/local/bin/ceph_test_timers
+       /usr/local/bin/ceph_test_signal_handlers
+       /usr/local/bin/ceph_test_rewrite_latency
+       /usr/local/bin/ceph_test_crypto
+       /usr/local/bin/ceph_bench_log
+       /usr/local/bin/ceph_test_objectcacher_stress
+       /usr/local/bin/ceph_test_cfuse_cache_invalidate
+       /usr/local/bin/ceph_test_get_blkdev_size
+       /usr/local/bin/ceph_scratchtool
+       /usr/local/bin/ceph_scratchtoolpp
+       /usr/local/bin/ceph_radosacl
+       /usr/local/bin/ceph-client-debug
+       /usr/local/bin/ceph-osdomap-tool
+       /usr/local/bin/ceph-monstore-tool
+       /usr/local/bin/ceph-kvstore-tool
+       /usr/local/bin/ceph_psim
+       /usr/local/bin/ceph-dencoder
+       /usr/local/bin/rados
+       /usr/local/bin/ceph-objectstore-tool
+       /usr/local/bin/cephfs-journal-tool
+       /usr/local/bin/cephfs-table-tool
+       /usr/local/bin/cephfs-data-scan
+       /usr/local/bin/monmaptool
+       /usr/local/bin/crushtool
+       /usr/local/bin/osdmaptool
+       /usr/local/bin/ceph-conf
+       /usr/local/bin/ceph-authtool
+       /usr/local/bin/ceph-syn
+       /usr/local/bin/librados-config
+       /usr/local/bin/cephfs
+       /usr/local/bin/ceph-mon
+       /usr/local/bin/ceph-osd
+       /usr/local/bin/ceph-mds
+       /usr/local/bin/ceph-brag
+       /usr/local/bin/ceph
+       /usr/local/bin/ceph-post-file
+       /usr/local/bin/ceph-rbdnamer
+       /usr/local/bin/rbd-replay-many
+       /usr/local/bin/rbdmap
+       /usr/local/bin/ceph-run
+       /usr/local/bin/ceph-rest-api
+       /usr/local/bin/ceph-debugpack
+       /usr/local/bin/ceph-crush-location
+       /usr/local/bin/ceph-coverage
+       /usr/local/bin/ceph-clsinfo
+       /usr/local/libexec/ceph
+       /usr/local/libexec/ceph/ceph-osd-prestart.sh
+       /usr/local/etc/bash_completion.d/ceph
+       /usr/local/etc/bash_completion.d/rados
+       /usr/local/etc/bash_completion.d/radosgw-admin
+       /usr/local/etc/bash_completion.d/rbd
+       /usr/local/lib/ceph
+       /usr/local/lib/ceph/ceph-monstore-update-crush.sh
+       /usr/local/sbin/ceph-create-keys
+       /usr/local/sbin/ceph-disk
+       /usr/local/sbin/ceph-disk-udev
+
/usr/srcs/Ceph/src/ceph/src/ceph-detect-init/ceph_detect_init.egg-info
+
/usr/srcs/Ceph/src/ceph/src/ceph-detect-init/ceph_detect_init.egg-info/requires.txt
+
/usr/srcs/Ceph/src/ceph/src/ceph-detect-init/ceph_detect_init.egg-info/PKG-INFO
+
/usr/srcs/Ceph/src/ceph/src/ceph-detect-init/ceph_detect_init.egg-info/top_level.txt
+
/usr/srcs/Ceph/src/ceph/src/ceph-detect-init/ceph_detect_init.egg-info/dependency_links.txt
+
/usr/srcs/Ceph/src/ceph/src/ceph-detect-init/ceph_detect_init.egg-info/entry_points.txt
+
/usr/srcs/Ceph/src/ceph/src/ceph-detect-init/ceph_detect_init.egg-info/SOURCES.txt
+
/usr/srcs/Ceph/src/ceph/src/ceph-detect-init/build/bdist.freebsd-11.0-CURRENT-amd64
+       /usr/srcs/Ceph/src/ceph/src/ceph-detect-init/dist
+
/usr/srcs/Ceph/src/ceph/src/ceph-detect-init/dist/ceph_detect_init-1.0.1-py2.7.egg
+
/usr/local/lib/python2.7/site-packages/ceph_detect_init-1.0.1-py2.7.egg
+       /usr/local/bin/ceph-detect-init
+       /usr/local/lib/python2.7/site-packages/setuptools.pth
+       /usr/local/bin/easy_install
+       /usr/local/etc/ceph
+       /usr/local/var/log/ceph
+       /usr/local/var/lib/ceph
+       /usr/local/var/lib/ceph/tmp
+       /usr/local/share/doc/ceph
+       /usr/local/share/doc/ceph/sample.ceph.conf
+       /usr/local/share/doc/ceph/sample.fetch_config
+       /usr/local/lib/ceph/erasure-code
+       /usr/local/lib/ceph/erasure-code/libec_jerasure_generic.so
+       /usr/local/lib/ceph/erasure-code/libec_jerasure_generic.la
+       /usr/local/lib/ceph/erasure-code/libec_jerasure_sse3.so
+       /usr/local/lib/ceph/erasure-code/libec_jerasure_sse3.la
+       /usr/local/lib/ceph/erasure-code/libec_jerasure_sse4.so
+       /usr/local/lib/ceph/erasure-code/libec_jerasure_sse4.la
+       /usr/local/lib/ceph/erasure-code/libec_jerasure.so
+       /usr/local/lib/ceph/erasure-code/libec_jerasure.la
+       /usr/local/lib/ceph/erasure-code/libec_lrc.so
+       /usr/local/lib/ceph/erasure-code/libec_lrc.la
+       /usr/local/lib/ceph/erasure-code/libec_shec_generic.so
+       /usr/local/lib/ceph/erasure-code/libec_shec_generic.la
+       /usr/local/lib/ceph/erasure-code/libec_shec_sse3.so
+       /usr/local/lib/ceph/erasure-code/libec_shec_sse3.la
+       /usr/local/lib/ceph/erasure-code/libec_shec_sse4.so
+       /usr/local/lib/ceph/erasure-code/libec_shec_sse4.la
+       /usr/local/lib/ceph/erasure-code/libec_shec.so
+       /usr/local/lib/ceph/erasure-code/libec_shec.la
+       /usr/local/lib/ceph/erasure-code/libec_isa.so
+       /usr/local/lib/ceph/erasure-code/libec_isa.la
+       /usr/local/lib/ceph/erasure-code/libec_example.so.0
+       /usr/local/lib/ceph/erasure-code/libec_example.so
+       /usr/local/lib/ceph/erasure-code/libec_example.la
+       /usr/local/lib/ceph/erasure-code/libec_missing_entry_point.so.0
+       /usr/local/lib/ceph/erasure-code/libec_missing_entry_point.so
+       /usr/local/lib/ceph/erasure-code/libec_missing_entry_point.la
+       /usr/local/lib/ceph/erasure-code/libec_missing_version.so.0
+       /usr/local/lib/ceph/erasure-code/libec_missing_version.so
+       /usr/local/lib/ceph/erasure-code/libec_missing_version.la
+       /usr/local/lib/ceph/erasure-code/libec_hangs.so.0
+       /usr/local/lib/ceph/erasure-code/libec_hangs.so
+       /usr/local/lib/ceph/erasure-code/libec_hangs.la
+       /usr/local/lib/ceph/erasure-code/libec_fail_to_initialize.so.0
+       /usr/local/lib/ceph/erasure-code/libec_fail_to_initialize.so
+       /usr/local/lib/ceph/erasure-code/libec_fail_to_initialize.la
+       /usr/local/lib/ceph/erasure-code/libec_fail_to_register.so.0
+       /usr/local/lib/ceph/erasure-code/libec_fail_to_register.so
+       /usr/local/lib/ceph/erasure-code/libec_fail_to_register.la
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_neon.so.0
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_neon.so
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_neon.la
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_sse4.so.0
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_sse4.so
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_sse4.la
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_sse3.so.0
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_sse3.so
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_sse3.la
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_generic.so.0
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_generic.so
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_generic.la
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_neon.so.0
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_neon.so
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_neon.la
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_sse4.so.0
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_sse4.so
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_sse4.la
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_sse3.so.0
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_sse3.so
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_sse3.la
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_generic.so.0
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_generic.so
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_generic.la
+       /usr/local/lib/ceph/erasure-code/libec_example.a
+       /usr/local/lib/ceph/erasure-code/libec_missing_entry_point.a
+       /usr/local/lib/ceph/erasure-code/libec_missing_version.a
+       /usr/local/lib/ceph/erasure-code/libec_hangs.a
+       /usr/local/lib/ceph/erasure-code/libec_fail_to_initialize.a
+       /usr/local/lib/ceph/erasure-code/libec_fail_to_register.a
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_neon.a
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_sse4.a
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_sse3.a
+       /usr/local/lib/ceph/erasure-code/libec_test_jerasure_generic.a
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_neon.a
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_sse4.a
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_sse3.a
+       /usr/local/lib/ceph/erasure-code/libec_test_shec_generic.a
+       /usr/local/include/cephfs
+       /usr/local/include/cephfs/libcephfs.h
+       /usr/local/include/rbd
+       /usr/local/include/rbd/features.h
+       /usr/local/include/rbd/librbd.h
+       /usr/local/include/rbd/librbd.hpp
+       /usr/local/lib/python2.7/site-packages/ceph_argparse.py
+       /usr/local/lib/python2.7/site-packages/ceph_daemon.py
+       /usr/local/lib/python2.7/site-packages/rados.py
+       /usr/local/lib/python2.7/site-packages/rbd.py
+       /usr/local/lib/python2.7/site-packages/cephfs.py
+       /usr/local/lib/python2.7/site-packages/ceph_rest_api.py
+       /usr/local/lib/python2.7/site-packages/ceph_argparse.pyc
+       /usr/local/lib/python2.7/site-packages/ceph_daemon.pyc
+       /usr/local/lib/python2.7/site-packages/rados.pyc
+       /usr/local/lib/python2.7/site-packages/rbd.pyc
+       /usr/local/lib/python2.7/site-packages/cephfs.pyc
+       /usr/local/lib/python2.7/site-packages/ceph_rest_api.pyc
+       /usr/local/lib/python2.7/site-packages/ceph_argparse.pyo
+       /usr/local/lib/python2.7/site-packages/ceph_daemon.pyo
+       /usr/local/lib/python2.7/site-packages/rados.pyo
+       /usr/local/lib/python2.7/site-packages/rbd.pyo
+       /usr/local/lib/python2.7/site-packages/cephfs.pyo
+       /usr/local/lib/python2.7/site-packages/ceph_rest_api.pyo
+       /usr/local/include/rados
+       /usr/local/include/rados/librados.h
+       /usr/local/include/rados/rados_types.h
+       /usr/local/include/rados/rados_types.hpp
+       /usr/local/include/rados/librados.hpp
+       /usr/local/include/rados/buffer.h
+       /usr/local/include/rados/page.h
+       /usr/local/include/rados/crc32c.h
+       /usr/local/include/rados/memory.h
+       /usr/local/lib/rados-classes
+       /usr/local/lib/rados-classes/libcls_hello.so
+       /usr/local/lib/rados-classes/libcls_hello.la
+       /usr/local/lib/rados-classes/libcls_numops.so
+       /usr/local/lib/rados-classes/libcls_numops.la
+       /usr/local/lib/rados-classes/libcls_rbd.so
+       /usr/local/lib/rados-classes/libcls_rbd.la
+       /usr/local/lib/rados-classes/libcls_lock.so
+       /usr/local/lib/rados-classes/libcls_lock.la
+       /usr/local/lib/rados-classes/libcls_refcount.so
+       /usr/local/lib/rados-classes/libcls_refcount.la
+       /usr/local/lib/rados-classes/libcls_version.so
+       /usr/local/lib/rados-classes/libcls_version.la
+       /usr/local/lib/rados-classes/libcls_log.so
+       /usr/local/lib/rados-classes/libcls_log.la
+       /usr/local/lib/rados-classes/libcls_statelog.so
+       /usr/local/lib/rados-classes/libcls_statelog.la
+       /usr/local/lib/rados-classes/libcls_timeindex.so
+       /usr/local/lib/rados-classes/libcls_timeindex.la
+       /usr/local/lib/rados-classes/libcls_replica_log.so
+       /usr/local/lib/rados-classes/libcls_replica_log.la
+       /usr/local/lib/rados-classes/libcls_user.so
+       /usr/local/lib/rados-classes/libcls_user.la
+       /usr/local/lib/rados-classes/libcls_rgw.so
+       /usr/local/lib/rados-classes/libcls_rgw.la
+       /usr/local/lib/rados-classes/libcls_cephfs.so
+       /usr/local/lib/rados-classes/libcls_cephfs.la
+       /usr/local/lib/rados-classes/libcls_journal.so
+       /usr/local/lib/rados-classes/libcls_journal.la
+       /usr/local/include/radosstriper
+       /usr/local/include/radosstriper/libradosstriper.h
+       /usr/local/include/radosstriper/libradosstriper.hpp
+       /usr/local/lib/ceph/ceph_common.sh
M       /usr/local/etc/bash_completion.d
M       /usr/local/var/lib
M       /usr/local/var/log
M       /usr/srcs/Ceph/src/ceph/src/.libs
M       /usr/srcs/Ceph/src/ceph/src/ceph-detect-init
-       /usr/local/bin/easy_install
M       /usr/local/lib/python2.7/site-packages/easy-install.pth
M       /usr/srcs/Ceph/src/ceph/src/ceph-detect-init/build


