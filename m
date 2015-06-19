From: Loic Dachary <loic@dachary.org>
Subject: Re: make check run time
Date: Fri, 19 Jun 2015 16:09:50 +0200
Message-ID: <558422AE.5060608@dachary.org>
References: <5583C745.4050901@dachary.org> <CB7ACD0B-360E-414B-8CDA-C839431891DD@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lLeB4tvF4W4Ft5H95l80FIWiplaE4Gq2C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:37023 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753575AbbFSOJw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jun 2015 10:09:52 -0400
In-Reply-To: <CB7ACD0B-360E-414B-8CDA-C839431891DD@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <jdillama@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lLeB4tvF4W4Ft5H95l80FIWiplaE4Gq2C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On 19/06/2015 13:44, Jason Dillaman wrote:
>=20
> Wow, thanks for compiling this -- I had no idea the times were this slo=
w. In a perfect world, gtest would allow us to run a subset of tests via =
the command-line, but that isn't possible. However, I think we can safely=
 move the valgrind tests to the teuthology RBD suite.=20
>=20
> As for the other RBD unit test script, it's slower now that lockdep che=
cking is always running. Since it runs through the same tests multiple ti=
mes with the different features enables each time, we could definitely co=
nsolidate down to perhaps just 2 or 3. We can also perhaps only enable lo=
ckdep checking on the teuthology runs.=20
>=20

I'm glad there are easy remedies ;-)

Cheers

>> On Jun 19, 2015, at 3:41 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>> Hi,
>>
>> Below is the sorted list of the longest running tests (measured by com=
paring the .log creation and modification times after a successfully run)=
, in seconds. Note that when tests run in parallel, the longest running t=
est caps the total run time: make check can't run under 1205 seconds =3D=3D=
 20 minutes because of ./src/test/run-rbd-valgrind-unit-tests.sh. I reali=
ty, since the parallel run is not perfect, it takes about 30 minutes beca=
use src/test/run-rbd-valgrind-unit-tests.sh is not the first to run.
>>
>> I'll take a look at src/test/osd/osd-scrub-repair.sh: I'm sure it can =
run within 2 minutes instead of 8 and still provide the same coverage. It=
 would be great if you could do the same with the rbd tests. Running them=
 as part of make check has been beneficial as it revealed rare conditions=
 because they have been run many times a day, more often than teuthology =
tests. Hopefully there is a way to run them faster without sacrificing co=
verage ?
>>
>> Cheers
>>
>> 1205 ./src/test/run-rbd-valgrind-unit-tests.sh.log
>> 1174 ./src/test/run-rbd-unit-tests.sh.log
>> 501 ./src/test/osd/osd-scrub-repair.sh.log
>> 370 ./src/unittest_erasure_code_shec_all.log
>> 297 ./src/test/cephtool-test-mon.sh.log
>> 247 ./src/test/test-ceph-helpers.sh.log
>> 162 ./qa/workunits/erasure-code/encode-decode-non-regression.sh.log
>> 145 ./src/test/ceph_objectstore_tool.py.log
>> 121 ./src/test/erasure-code/test-erasure-eio.sh.log
>> 80 ./src/test/erasure-code/test-erasure-code.sh.log
>> 78 ./src/test/cephtool-test-mds.sh.log
>> 61 ./src/unittest_erasure_code_shec_thread.log
>> 52 ./src/test/mon/osd-pool-create.sh.log
>> 49 ./src/test/osd/osd-bench.sh.log
>> 40 ./src/test/encoding/readable.sh.log
>> 38 ./src/unittest_crush.log
>> 33 ./src/test/mon/osd-erasure-code-profile.sh.log
>> 32 ./src/test/pybind/test_ceph_argparse.py.log
>> 29 ./src/test/mon/osd-crush.sh.log
>> 20 ./src/ceph-detect-init/run-tox.sh.log
>> 19 ./src/test/mon/misc.sh.log
>> 17 ./src/test/encoding/check-generated.sh.log
>> 15 ./src/test/osd/osd-config.sh.log
>> 12 ./src/unittest_crc32c.log
>> 12 ./src/test/osd/osd-copy-from.sh.log
>> 12 ./src/test/cephtool-test-osd.sh.log
>> 7 ./src/unittest_workqueue.log
>> 7 ./src/unittest_bloom_filter.log
>> 6 ./src/test/mon/mon-handle-forward.sh.log
>> 5 ./src/unittest_erasure_code_shec.log
>> 5 ./src/unittest_admin_socket.log
>> 4 ./src/unittest_crypto.log
>> 4 ./src/test/mon/mkfs.sh.log
>> 2 ./src/unittest_signals.log
>> 2 ./src/unittest_heartbeatmap.log
>> 2 ./src/unittest_erasure_code_isa.log
>> 2 ./src/unittest_bufferlist.sh.log
>> 2 ./src/unittest_bufferlist.log
>> 1 ./src/unittest_throttle.log
>> 1 ./src/unittest_osdmap.log
>> 1 ./src/unittest_osd_osdcap.log
>> 0 ./src/unittest_xlist.log
>> 0 ./src/unittest_util.log
>> 0 ./src/unittest_utf8.log
>> 0 ./src/unittest_texttable.log
>> 0 ./src/unittest_tableformatter.log
>> 0 ./src/unittest_strtol.log
>> 0 ./src/unittest_striper.log
>> 0 ./src/unittest_str_map.log
>> 0 ./src/unittest_str_list.log
>> 0 ./src/unittest_sloppy_crc_map.log
>> 0 ./src/unittest_simple_spin.log
>> 0 ./src/unittest_sharedptr_registry.log
>> 0 ./src/unittest_shared_cache.log
>> 0 ./src/unittest_safe_io.log
>> 0 ./src/unittest_run_cmd.log
>> 0 ./src/unittest_readahead.log
>> 0 ./src/unittest_rbd_replay.log
>> 0 ./src/unittest_prioritized_queue.log
>> 0 ./src/unittest_prebufferedstreambuf.log
>> 0 ./src/unittest_pglog.log
>> 0 ./src/unittest_perf_counters.log
>> 0 ./src/unittest_osdscrub.log
>> 0 ./src/unittest_osd_types.log
>> 0 ./src/unittest_on_exit.log
>> 0 ./src/unittest_mon_pgmap.log
>> 0 ./src/unittest_mon_moncap.log
>> 0 ./src/unittest_mime.log
>> 0 ./src/unittest_mds_types.log
>> 0 ./src/unittest_mds_authcap.log
>> 0 ./src/unittest_lru.log
>> 0 ./src/unittest_log.log
>> 0 ./src/unittest_librados_config.log
>> 0 ./src/unittest_librados.log
>> 0 ./src/unittest_libcephfs_config.log
>> 0 ./src/unittest_lfnindex.log
>> 0 ./src/unittest_ipaddr.log
>> 0 ./src/unittest_io_priority.log
>> 0 ./src/unittest_hitset.log
>> 0 ./src/unittest_gather.log
>> 0 ./src/unittest_formatter.log
>> 0 ./src/unittest_flatindex.log
>> 0 ./src/unittest_escape.log
>> 0 ./src/unittest_erasure_code_plugin_lrc.log
>> 0 ./src/unittest_erasure_code_plugin_jerasure.log
>> 0 ./src/unittest_erasure_code_plugin_isa.log
>> 0 ./src/unittest_erasure_code_plugin.log
>> 0 ./src/unittest_erasure_code_lrc.log
>> 0 ./src/unittest_erasure_code_jerasure.log
>> 0 ./src/unittest_erasure_code_example.log
>> 0 ./src/unittest_erasure_code.log
>> 0 ./src/unittest_encoding.log
>> 0 ./src/unittest_ecbackend.log
>> 0 ./src/unittest_daemon_config.log
>> 0 ./src/unittest_crypto_init.log
>> 0 ./src/unittest_crush_wrapper.log
>> 0 ./src/unittest_context.log
>> 0 ./src/unittest_confutils.log
>> 0 ./src/unittest_config.log
>> 0 ./src/unittest_chain_xattr.log
>> 0 ./src/unittest_ceph_crypto.log
>> 0 ./src/unittest_ceph_compatset.log
>> 0 ./src/unittest_ceph_argparse.log
>> 0 ./src/unittest_blkdev.log
>> 0 ./src/unittest_bit_vector.log
>> 0 ./src/unittest_base64.log
>> 0 ./src/unittest_arch.log
>> 0 ./src/unittest_addrs.log
>> 0 ./src/test/pybind/test_ceph_daemon.py.log
>>
>>
>> --=20
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--lLeB4tvF4W4Ft5H95l80FIWiplaE4Gq2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWEIq4ACgkQ8dLMyEl6F20EJgCglIWKCjQVOvlHTsS676ln4fkn
oUMAoMZYgC4NO45iKJpkrUE1MBdVF6hH
=uXd0
-----END PGP SIGNATURE-----

--lLeB4tvF4W4Ft5H95l80FIWiplaE4Gq2C--
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
