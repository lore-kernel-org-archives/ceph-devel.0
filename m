From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: make check run time
Date: Fri, 19 Jun 2015 07:34:45 -0400 (EDT)
Message-ID: <666472600.20432529.1434713685585.JavaMail.zimbra@redhat.com>
References: <5583C745.4050901@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:57609 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbbFSLfv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jun 2015 07:35:51 -0400
In-Reply-To: <5583C745.4050901@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Jason Dillaman <dillaman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>



--Jason Dillaman
Red Hat
dillaman@redhat.com
http://www.redhat.com


----- Loic Dachary <loic@dachary.org> wrote:
> Hi,
>=20
> Below is the sorted list of the longest running tests (measured by co=
mparing the .log creation and modification times after a successfully r=
un), in seconds. Note that when tests run in parallel, the longest runn=
ing test caps the total run time: make check can't run under 1205 secon=
ds =3D=3D 20 minutes because of ./src/test/run-rbd-valgrind-unit-tests.=
sh. I reality, since the parallel run is not perfect, it takes about 30=
 minutes because src/test/run-rbd-valgrind-unit-tests.sh is not the fir=
st to run.
>=20
> I'll take a look at src/test/osd/osd-scrub-repair.sh: I'm sure it can=
 run within 2 minutes instead of 8 and still provide the same coverage.=
 It would be great if you could do the same with the rbd tests. Running=
 them as part of make check has been beneficial as it revealed rare con=
ditions because they have been run many times a day, more often than te=
uthology tests. Hopefully there is a way to run them faster without sac=
rificing coverage ?
>=20
> Cheers
>=20
> 1205 ./src/test/run-rbd-valgrind-unit-tests.sh.log
> 1174 ./src/test/run-rbd-unit-tests.sh.log
> 501 ./src/test/osd/osd-scrub-repair.sh.log
> 370 ./src/unittest_erasure_code_shec_all.log
> 297 ./src/test/cephtool-test-mon.sh.log
> 247 ./src/test/test-ceph-helpers.sh.log
> 162 ./qa/workunits/erasure-code/encode-decode-non-regression.sh.log
> 145 ./src/test/ceph_objectstore_tool.py.log
> 121 ./src/test/erasure-code/test-erasure-eio.sh.log
> 80 ./src/test/erasure-code/test-erasure-code.sh.log
> 78 ./src/test/cephtool-test-mds.sh.log
> 61 ./src/unittest_erasure_code_shec_thread.log
> 52 ./src/test/mon/osd-pool-create.sh.log
> 49 ./src/test/osd/osd-bench.sh.log
> 40 ./src/test/encoding/readable.sh.log
> 38 ./src/unittest_crush.log
> 33 ./src/test/mon/osd-erasure-code-profile.sh.log
> 32 ./src/test/pybind/test_ceph_argparse.py.log
> 29 ./src/test/mon/osd-crush.sh.log
> 20 ./src/ceph-detect-init/run-tox.sh.log
> 19 ./src/test/mon/misc.sh.log
> 17 ./src/test/encoding/check-generated.sh.log
> 15 ./src/test/osd/osd-config.sh.log
> 12 ./src/unittest_crc32c.log
> 12 ./src/test/osd/osd-copy-from.sh.log
> 12 ./src/test/cephtool-test-osd.sh.log
> 7 ./src/unittest_workqueue.log
> 7 ./src/unittest_bloom_filter.log
> 6 ./src/test/mon/mon-handle-forward.sh.log
> 5 ./src/unittest_erasure_code_shec.log
> 5 ./src/unittest_admin_socket.log
> 4 ./src/unittest_crypto.log
> 4 ./src/test/mon/mkfs.sh.log
> 2 ./src/unittest_signals.log
> 2 ./src/unittest_heartbeatmap.log
> 2 ./src/unittest_erasure_code_isa.log
> 2 ./src/unittest_bufferlist.sh.log
> 2 ./src/unittest_bufferlist.log
> 1 ./src/unittest_throttle.log
> 1 ./src/unittest_osdmap.log
> 1 ./src/unittest_osd_osdcap.log
> 0 ./src/unittest_xlist.log
> 0 ./src/unittest_util.log
> 0 ./src/unittest_utf8.log
> 0 ./src/unittest_texttable.log
> 0 ./src/unittest_tableformatter.log
> 0 ./src/unittest_strtol.log
> 0 ./src/unittest_striper.log
> 0 ./src/unittest_str_map.log
> 0 ./src/unittest_str_list.log
> 0 ./src/unittest_sloppy_crc_map.log
> 0 ./src/unittest_simple_spin.log
> 0 ./src/unittest_sharedptr_registry.log
> 0 ./src/unittest_shared_cache.log
> 0 ./src/unittest_safe_io.log
> 0 ./src/unittest_run_cmd.log
> 0 ./src/unittest_readahead.log
> 0 ./src/unittest_rbd_replay.log
> 0 ./src/unittest_prioritized_queue.log
> 0 ./src/unittest_prebufferedstreambuf.log
> 0 ./src/unittest_pglog.log
> 0 ./src/unittest_perf_counters.log
> 0 ./src/unittest_osdscrub.log
> 0 ./src/unittest_osd_types.log
> 0 ./src/unittest_on_exit.log
> 0 ./src/unittest_mon_pgmap.log
> 0 ./src/unittest_mon_moncap.log
> 0 ./src/unittest_mime.log
> 0 ./src/unittest_mds_types.log
> 0 ./src/unittest_mds_authcap.log
> 0 ./src/unittest_lru.log
> 0 ./src/unittest_log.log
> 0 ./src/unittest_librados_config.log
> 0 ./src/unittest_librados.log
> 0 ./src/unittest_libcephfs_config.log
> 0 ./src/unittest_lfnindex.log
> 0 ./src/unittest_ipaddr.log
> 0 ./src/unittest_io_priority.log
> 0 ./src/unittest_hitset.log
> 0 ./src/unittest_gather.log
> 0 ./src/unittest_formatter.log
> 0 ./src/unittest_flatindex.log
> 0 ./src/unittest_escape.log
> 0 ./src/unittest_erasure_code_plugin_lrc.log
> 0 ./src/unittest_erasure_code_plugin_jerasure.log
> 0 ./src/unittest_erasure_code_plugin_isa.log
> 0 ./src/unittest_erasure_code_plugin.log
> 0 ./src/unittest_erasure_code_lrc.log
> 0 ./src/unittest_erasure_code_jerasure.log
> 0 ./src/unittest_erasure_code_example.log
> 0 ./src/unittest_erasure_code.log
> 0 ./src/unittest_encoding.log
> 0 ./src/unittest_ecbackend.log
> 0 ./src/unittest_daemon_config.log
> 0 ./src/unittest_crypto_init.log
> 0 ./src/unittest_crush_wrapper.log
> 0 ./src/unittest_context.log
> 0 ./src/unittest_confutils.log
> 0 ./src/unittest_config.log
> 0 ./src/unittest_chain_xattr.log
> 0 ./src/unittest_ceph_crypto.log
> 0 ./src/unittest_ceph_compatset.log
> 0 ./src/unittest_ceph_argparse.log
> 0 ./src/unittest_blkdev.log
> 0 ./src/unittest_bit_vector.log
> 0 ./src/unittest_base64.log
> 0 ./src/unittest_arch.log
> 0 ./src/unittest_addrs.log
> 0 ./src/test/pybind/test_ceph_daemon.py.log
>=20
>=20
> --=20
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
