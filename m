From: Sage Weil <sage@inktank.com>
Subject: Re: Fwd: 4 failed, 298 passed in
 dzafman-2013-09-23_17:50:06-rados-wip-5862-testing-basic-plana
Date: Tue, 24 Sep 2013 12:03:37 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309241202150.25142@cobra.newdream.net>
References: <20130924054800.98114281785@teuthology.front.sepia.ceph.com> <5C49DD20-37BB-4462-9DE1-E9CBE94076E5@inktank.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-563867174-1380049417=:25142"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45252 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab3IXTDi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Sep 2013 15:03:38 -0400
In-Reply-To: <5C49DD20-37BB-4462-9DE1-E9CBE94076E5@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <david.zafman@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-563867174-1380049417=:25142
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Sep 2013, David Zafman wrote:
>=20
> Rados suite test run results for wip-5862. =A02 "scrub mismatch" from m=
on
> (known problem). =A02 are valgrind issues found with mds and osd.=A0

What is the osd valgrind failure?  And the osd.4 crash on 13443?

(Note that the teuthology.log will include message about valgrind issues=20
found in the mds log, but does not generate an actual error about it.)

Thanks!
sage


>=20
> David Zafman
> Senior Developer
> http://www.inktank.com
>=20
> Begin forwarded message:
>=20
>       From: teuthworker@teuthology.front.sepia.ceph.com
> Subject: 4 failed, 298 passed in
> dzafman-2013-09-23_17:50:06-rados-wip-5862-testing-basic-plana
> Date: September 23, 2013 10:48:00 PM PDT
> To: david.zafman@inktank.com
>=20
> Test Run:
> dzafman-2013-09-23_17:50:06-rados-wip-5862-testing-basic-plana
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> logs:=A0=A0http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:50=
:06-rados-wip
> -5862-testing-basic-plana/
> failed: 4
> hung: =A0=A00
> passed: 298
>=20
> Failed
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [13187] =A0rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml
> thrashers/force-sync-many.yaml workloads/snaps-few-objects.yaml}
> -----------------------------------------------------------------
> time: =A0=A02095s
> log:=A0=A0=A0http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:=
50:06-rados-wi
> p-5862-testing-basic-plana/13187/
>=20
> =A0=A0=A0"2013-09-23 18:22:37.805204 mon.0 10.214.132.24:6789/0 514 : [=
ERR]
> scrub
> =A0=A0=A0mismatch" in cluster log
>=20
> [13449] =A0rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_api_tests.yaml
> validater/valgrind.yaml}
> -----------------------------------------------------------------
> time: =A0=A01067s
> log:=A0=A0=A0http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:=
50:06-rados-wi
> p-5862-testing-basic-plana/13449/
>=20
> =A0=A0=A0saw valgrind issues
>=20
> [13443] =A0rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_api_tests.yaml
> validater/valgrind.yaml}
> -----------------------------------------------------------------
> time: =A0=A01307s
> log:=A0=A0=A0http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:=
50:06-rados-wi
> p-5862-testing-basic-plana/13443/
>=20
> =A0=A0=A0timed out waiting for admin_socket to appear after osd.4 resta=
rt
>=20
> [13227] =A0rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml
> thrashers/force-sync-many.yaml workloads/snaps-few-objects.yaml}
> -----------------------------------------------------------------
> time: =A0=A02374s
> log:=A0=A0=A0http://qa-proxy.ceph.com/teuthology/dzafman-2013-09-23_17:=
50:06-rados-wi
> p-5862-testing-basic-plana/13227/
>=20
> =A0=A0=A0"2013-09-23 18:41:57.370588 mon.0 10.214.132.34:6789/0 20 : [E=
RR]
> scrub
> =A0=A0=A0mismatch" in cluster log
>=20
>=20
> Passed
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [13329] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01327s
>=20
> [13414] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01926s
>=20
> [13278] rados/singleton/{all/mon-thrasher.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0811s
>=20
> [13368] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0322s
>=20
> [13359] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01529s
>=20
> [13403] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01651s
>=20
> [13402] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01878s
>=20
> [13405] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0836s
>=20
> [13404] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0243s
>=20
> [13407] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01249s
>=20
> [13358] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A03144s
>=20
> [13360] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01994s
>=20
> [13361] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01894s
>=20
> [13362] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0276s
>=20
> [13363] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0966s
>=20
> [13364] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02300s
>=20
> [13365] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml workloads/readwrite.yaml}
> time: =A0=A0=A01374s
>=20
> [13366] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02202s
>=20
> [13367] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01945s
>=20
> [13386] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0279s
>=20
> [13387] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0988s
>=20
> [13295] rados/singleton-nomsgr/{all/objectcacher-stress.yaml}
> time: =A0=A0=A01144s
>=20
> [13243] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02400s
>=20
> [13242] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0445s
>=20
> [13168] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0200s
>=20
> [13169] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01455s
>=20
> [13247] rados/multimon/{clusters/21.yaml msgr-failures/many.yaml
> tasks/mon_clock_no_skews.yaml}
> time: =A0=A0=A0186s
>=20
> [13246] rados/multimon/{clusters/21.yaml msgr-failures/few.yaml
> tasks/mon_recovery.yaml}
> time: =A0=A0=A0888s
>=20
> [13245] rados/multimon/{clusters/21.yaml msgr-failures/few.yaml
> tasks/mon_clock_with_skews.yaml}
> time: =A0=A0=A0191s
>=20
> [13244] rados/multimon/{clusters/21.yaml msgr-failures/few.yaml
> tasks/mon_clock_no_skews.yaml}
> time: =A0=A0=A0171s
>=20
> [13162] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/many.yaml tasks/rados_workunit_loadgen_mix.yaml}
> time: =A0=A0=A01454s
>=20
> [13163] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/many.yaml tasks/rados_workunit_loadgen_mostlyread.yaml}
> time: =A0=A0=A06072s
>=20
> [13160] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/many.yaml tasks/rados_stress_watch.yaml}
> time: =A0=A0=A0469s
>=20
> [13161] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/many.yaml tasks/rados_workunit_loadgen_big.yaml}
> time: =A0=A0=A02034s
>=20
> [13166] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0795s
>=20
> [13167] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02350s
>=20
> [13164] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0271s
>=20
> [13165] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01082s
>=20
> [13199] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02158s
>=20
> [13412] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02124s
>=20
> [13413] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml workloads/readwrite.yaml}
> time: =A0=A0=A01461s
>=20
> [13410] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0285s
>=20
> [13198] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0378s
>=20
> [13416] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0261s
>=20
> [13417] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0912s
>=20
> [13389] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01405s
>=20
> [13415] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01909s
>=20
> [13319] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A02043s
>=20
> [13323] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01258s
>=20
> [13419] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01244s
>=20
> [13318] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01883s
>=20
> [13157] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/many.yaml tasks/rados_api_tests.yaml}
> time: =A0=A0=A01056s
>=20
> [13156] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml tasks/rados_workunit_loadgen_mostlyread.yaml}
> time: =A0=A0=A06006s
>=20
> [13155] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml tasks/rados_workunit_loadgen_mix.yaml}
> time: =A0=A0=A01477s
>=20
> [13154] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml tasks/rados_workunit_loadgen_big.yaml}
> time: =A0=A0=A02115s
>=20
> [13153] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml tasks/rados_stress_watch.yaml}
> time: =A0=A0=A0449s
>=20
> [13152] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml tasks/rados_python.yaml}
> time: =A0=A0=A0461s
>=20
> [13151] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml tasks/rados_cls_all.yaml}
> time: =A0=A0=A0360s
>=20
> [13150] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml tasks/rados_api_tests.yaml}
> time: =A0=A0=A01063s
>=20
> [13248] rados/multimon/{clusters/21.yaml msgr-failures/many.yaml
> tasks/mon_clock_with_skews.yaml}
> time: =A0=A0=A0203s
>=20
> [13314] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0286s
>=20
> [13317] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml workloads/readwrite.yaml}
> time: =A0=A0=A01199s
>=20
> [13316] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02858s
>=20
> [13311] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01359s
>=20
> [13310] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02978s
>=20
> [13159] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/many.yaml tasks/rados_python.yaml}
> time: =A0=A0=A0545s
>=20
> [13158] rados/basic/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/many.yaml tasks/rados_cls_all.yaml}
> time: =A0=A0=A0537s
>=20
> [13395] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01420s
>=20
> [13193] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01305s
>=20
> [13397] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01918s
>=20
> [13396] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01910s
>=20
> [13258] rados/multimon/{clusters/6.yaml msgr-failures/few.yaml
> tasks/mon_recovery.yaml}
> time: =A0=A0=A0400s
>=20
> [13259] rados/multimon/{clusters/6.yaml msgr-failures/many.yaml
> tasks/mon_clock_no_skews.yaml}
> time: =A0=A0=A0171s
>=20
> [13393] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0876s
>=20
> [13219] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02475s
>=20
> [13254] rados/multimon/{clusters/3.yaml msgr-failures/many.yaml
> tasks/mon_clock_with_skews.yaml}
> time: =A0=A0=A0152s
>=20
> [13255] rados/multimon/{clusters/3.yaml msgr-failures/many.yaml
> tasks/mon_recovery.yaml}
> time: =A0=A0=A0404s
>=20
> [13256] rados/multimon/{clusters/6.yaml msgr-failures/few.yaml
> tasks/mon_clock_no_skews.yaml}
> time: =A0=A0=A0162s
>=20
> [13257] rados/multimon/{clusters/6.yaml msgr-failures/few.yaml
> tasks/mon_clock_with_skews.yaml}
> time: =A0=A0=A0177s
>=20
> [13250] rados/multimon/{clusters/3.yaml msgr-failures/few.yaml
> tasks/mon_clock_no_skews.yaml}
> time: =A0=A0=A0173s
>=20
> [13251] rados/multimon/{clusters/3.yaml msgr-failures/few.yaml
> tasks/mon_clock_with_skews.yaml}
> time: =A0=A0=A0153s
>=20
> [13252] rados/multimon/{clusters/3.yaml msgr-failures/few.yaml
> tasks/mon_recovery.yaml}
> time: =A0=A0=A0410s
>=20
> [13253] rados/multimon/{clusters/3.yaml msgr-failures/many.yaml
> tasks/mon_clock_no_skews.yaml}
> time: =A0=A0=A0149s
>=20
> [13322] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02535s
>=20
> [13398] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0308s
>=20
> [13288] rados/singleton/{all/rest-api.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0203s
>=20
> [13409] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01692s
>=20
> [13313] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01892s
>=20
> [13429] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0842s
>=20
> [13408] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02001s
>=20
> [13427] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01642s
>=20
> [13315] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0857s
>=20
> [13425] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01208s
>=20
> [13312] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01905s
>=20
> [13423] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0862s
>=20
> [13422] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0256s
>=20
> [13421] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01793s
>=20
> [13420] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01926s
>=20
> [13442] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_api_tests.yaml
> validater/lockdep.yaml}
> time: =A0=A0=A0877s
>=20
> [13451] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_cls_all.yaml
> validater/valgrind.yaml}
> time: =A0=A0=A0396s
>=20
> [13308] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0241s
>=20
> [13309] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0744s
>=20
> [13306] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01787s
>=20
> [13307] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01836s
>=20
> [13304] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02162s
>=20
> [13305] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml workloads/readwrite.yaml}
> time: =A0=A0=A01282s
>=20
> [13302] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0261s
>=20
> [13303] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0718s
>=20
> [13300] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01910s
>=20
> [13301] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01772s
>=20
> [13229] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01458s
>=20
> [13228] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0221s
>=20
> [13384] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02184s
>=20
> [13385] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01953s
>=20
> [13382] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02330s
>=20
> [13383] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01607s
>=20
> [13380] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0304s
>=20
> [13381] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01147s
>=20
> [13221] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01125s
>=20
> [13220] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0299s
>=20
> [13223] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02388s
>=20
> [13222] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0433s
>=20
> [13225] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml
> thrashers/force-sync-many.yaml workloads/rados_api_tests.yaml}
> time: =A0=A0=A01084s
>=20
> [13224] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml
> thrashers/force-sync-many.yaml workloads/rados_5925.yaml}
> time: =A0=A0=A0277s
>=20
> [13388] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A03196s
>=20
> [13226] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml
> thrashers/force-sync-many.yaml workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0458s
>=20
> [13392] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0223s
>=20
> [13438] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01898s
>=20
> [13439] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01833s
>=20
> [13430] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02315s
>=20
> [13431] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01446s
>=20
> [13432] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01941s
>=20
> [13433] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01854s
>=20
> [13434] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0239s
>=20
> [13435] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0889s
>=20
> [13436] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02498s
>=20
> [13437] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01365s
>=20
> [13339] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0759s
>=20
> [13338] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0234s
>=20
> [13369] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0944s
>=20
> [13333] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0760s
>=20
> [13332] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0232s
>=20
> [13331] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01724s
>=20
> [13330] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01860s
>=20
> [13337] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01645s
>=20
> [13336] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01897s
>=20
> [13335] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01322s
>=20
> [13334] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A03000s
>=20
> [13238] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0421s
>=20
> [13239] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02525s
>=20
> [13232] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0254s
>=20
> [13233] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01515s
>=20
> [13230] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0481s
>=20
> [13231] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A03058s
>=20
> [13236] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0308s
>=20
> [13237] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01161s
>=20
> [13234] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0440s
>=20
> [13235] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A03006s
>=20
> [13406] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02481s
>=20
> [13440] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml
> validater/lockdep.yaml}
> time: =A0=A0=A0392s
>=20
> [13324] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01913s
>=20
> [13325] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01742s
>=20
> [13326] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0333s
>=20
> [13327] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0761s
>=20
> [13320] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0249s
>=20
> [13321] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0801s
>=20
> [13289] rados/singleton/{all/rest-api.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0180s
>=20
> [13279] rados/singleton/{all/mon-thrasher.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0820s
>=20
> [13287] rados/singleton/{all/peer.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0309s
>=20
> [13286] rados/singleton/{all/peer.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0162s
>=20
> [13285] rados/singleton/{all/osd-recovery.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0258s
>=20
> [13284] rados/singleton/{all/osd-recovery.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0242s
>=20
> [13283] rados/singleton/{all/osd-recovery-incomplete.yaml
> fs/btrfs.yaml msgr-failures/many.yaml}
> time: =A0=A0=A01303s
>=20
> [13282] rados/singleton/{all/osd-recovery-incomplete.yaml
> fs/btrfs.yaml msgr-failures/few.yaml}
> time: =A0=A0=A01347s
>=20
> [13281] rados/singleton/{all/osd-backfill.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0201s
>=20
> [13280] rados/singleton/{all/osd-backfill.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0263s
>=20
> [13207] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02241s
>=20
> [13206] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0508s
>=20
> [13205] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01202s
>=20
> [13204] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/force-sync-many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0304s
>=20
> [13203] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02039s
>=20
> [13202] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0675s
>=20
> [13201] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01177s
>=20
> [13200] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0278s
>=20
> [13445] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_cls_all.yaml
> validater/valgrind.yaml}
> time: =A0=A0=A0440s
>=20
> [13444] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_cls_all.yaml
> validater/lockdep.yaml}
> time: =A0=A0=A0348s
>=20
> [13447] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml
> validater/valgrind.yaml}
> time: =A0=A0=A0525s
>=20
> [13446] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml
> validater/lockdep.yaml}
> time: =A0=A0=A0454s
>=20
> [13441] rados/verify/{1thrash/default.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/mon_recovery.yaml
> validater/valgrind.yaml}
> time: =A0=A0=A0549s
>=20
> [13241] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01274s
>=20
> [13209] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01526s
>=20
> [13208] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0241s
>=20
> [13411] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/pggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0802s
>=20
> [13240] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0318s
>=20
> [13371] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01508s
>=20
> [13428] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/morepggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0257s
>=20
> [13401] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml workloads/readwrite.yaml}
> time: =A0=A0=A01265s
>=20
> [13450] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_cls_all.yaml
> validater/lockdep.yaml}
> time: =A0=A0=A0272s
>=20
> [13298] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A03243s
>=20
> [13299] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01422s
>=20
> [13353] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml workloads/readwrite.yaml}
> time: =A0=A0=A01460s
>=20
> [13352] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02159s
>=20
> [13355] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01724s
>=20
> [13354] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01957s
>=20
> [13357] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0859s
>=20
> [13356] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/morepggrow.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0244s
>=20
> [13290] rados/singleton/{all/thrash-rados.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0791s
>=20
> [13291] rados/singleton/{all/thrash-rados.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0821s
>=20
> [13292] rados/singleton-nomsgr/{all/filejournal.yaml}
> time: =A0=A0=A0181s
>=20
> [13293]
> rados/singleton-nomsgr/{all/filestore-idempotent-aio-journal.yaml}
> time: =A0=A0=A07518s
>=20
> [13294] rados/singleton-nomsgr/{all/filestore-idempotent.yaml}
> time: =A0=A0=A08612s
>=20
> [13249] rados/multimon/{clusters/21.yaml msgr-failures/many.yaml
> tasks/mon_recovery.yaml}
> time: =A0=A0=A0881s
>=20
> [13296] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0253s
>=20
> [13297] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0816s
>=20
> [13210] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0391s
>=20
> [13211] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A03040s
>=20
> [13212] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0225s
>=20
> [13213] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01384s
>=20
> [13214] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0418s
>=20
> [13215] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02987s
>=20
> [13216] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0294s
>=20
> [13217] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01265s
>=20
> [13218] rados/monthrash/{ceph/ceph.yaml clusters/9-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0405s
>=20
> [13192] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0462s
>=20
> [13191] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02665s
>=20
> [13190] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0382s
>=20
> [13197] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01144s
>=20
> [13196] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/sync-many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0547s
>=20
> [13195] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02714s
>=20
> [13194] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/one.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0399s
>=20
> [13391] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01956s
>=20
> [13448] rados/verify/{1thrash/none.yaml clusters/fixed-2.yaml
> fs/btrfs.yaml msgr-failures/few.yaml tasks/rados_api_tests.yaml
> validater/lockdep.yaml}
> time: =A0=A0=A0720s
>=20
> [13426] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01833s
>=20
> [13346] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A03037s
>=20
> [13347] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01379s
>=20
> [13400] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02830s
>=20
> [13394] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A03258s
>=20
> [13418] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02363s
>=20
> [13344] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0261s
>=20
> [13345] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0927s
>=20
> [13390] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02411s
>=20
> [13184] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml
> thrashers/force-sync-many.yaml workloads/rados_5925.yaml}
> time: =A0=A0=A0271s
>=20
> [13185] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml
> thrashers/force-sync-many.yaml workloads/rados_api_tests.yaml}
> time: =A0=A0=A01361s
>=20
> [13186] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml
> thrashers/force-sync-many.yaml workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0389s
>=20
> [13341] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01393s
>=20
> [13180] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0505s
>=20
> [13181] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01314s
>=20
> [13182] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0479s
>=20
> [13183] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02152s
>=20
> [13348] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01911s
>=20
> [13349] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/default.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A02113s
>=20
> [13188] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0210s
>=20
> [13189] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/mon-delay.yaml thrashers/many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01403s
>=20
> [13276] rados/singleton/{all/mon-config-keys.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0466s
>=20
> [13342] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01833s
>=20
> [13424] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02304s
>=20
> [13277] rados/singleton/{all/mon-config-keys.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0451s
>=20
> [13265] rados/multimon/{clusters/9.yaml msgr-failures/many.yaml
> tasks/mon_clock_no_skews.yaml}
> time: =A0=A0=A0176s
>=20
> [13264] rados/multimon/{clusters/9.yaml msgr-failures/few.yaml
> tasks/mon_recovery.yaml}
> time: =A0=A0=A0545s
>=20
> [13267] rados/multimon/{clusters/9.yaml msgr-failures/many.yaml
> tasks/mon_recovery.yaml}
> time: =A0=A0=A0515s
>=20
> [13266] rados/multimon/{clusters/9.yaml msgr-failures/many.yaml
> tasks/mon_clock_with_skews.yaml}
> time: =A0=A0=A0173s
>=20
> [13261] rados/multimon/{clusters/6.yaml msgr-failures/many.yaml
> tasks/mon_recovery.yaml}
> time: =A0=A0=A0466s
>=20
> [13260] rados/multimon/{clusters/6.yaml msgr-failures/many.yaml
> tasks/mon_clock_with_skews.yaml}
> time: =A0=A0=A0167s
>=20
> [13263] rados/multimon/{clusters/9.yaml msgr-failures/few.yaml
> tasks/mon_clock_with_skews.yaml}
> time: =A0=A0=A0177s
>=20
> [13262] rados/multimon/{clusters/9.yaml msgr-failures/few.yaml
> tasks/mon_clock_no_skews.yaml}
> time: =A0=A0=A0191s
>=20
> [13269] rados/singleton/{all/admin-socket.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0117s
>=20
> [13268] rados/singleton/{all/admin-socket.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0117s
>=20
> [13343] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01701s
>=20
> [13379] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01767s
>=20
> [13378] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A01967s
>=20
> [13377] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/readwrite.yaml}
> time: =A0=A0=A01301s
>=20
> [13376] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A03180s
>=20
> [13375] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0905s
>=20
> [13374] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0318s
>=20
> [13373] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/snaps-many-objects.yaml}
> time: =A0=A0=A01913s
>=20
> [13372] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02092s
>=20
> [13340] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/pggrow.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02672s
>=20
> [13370] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/osd-delay.yaml thrashers/default.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A02708s
>=20
> [13351] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0921s
>=20
> [13399] rados/thrash/{clusters/fixed-2.yaml fs/xfs.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A0753s
>=20
> [13328] rados/thrash/{clusters/fixed-2.yaml fs/btrfs.yaml
> msgr-failures/osd-delay.yaml thrashers/mapgap.yaml
> workloads/radosbench.yaml}
> time: =A0=A0=A03182s
>=20
> [13350] rados/thrash/{clusters/fixed-2.yaml fs/ext4.yaml
> msgr-failures/few.yaml thrashers/mapgap.yaml
> workloads/admin_socket_objecter_requests.yaml}
> time: =A0=A0=A0275s
>=20
> [13179] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02196s
>=20
> [13178] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0413s
>=20
> [13274] rados/singleton/{all/lost-unfound.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0186s
>=20
> [13275] rados/singleton/{all/lost-unfound.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0215s
>=20
> [13272] rados/singleton/{all/dump-stuck.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0222s
>=20
> [13273] rados/singleton/{all/dump-stuck.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0240s
>=20
> [13270] rados/singleton/{all/cephtool.yaml fs/btrfs.yaml
> msgr-failures/few.yaml}
> time: =A0=A0=A0347s
>=20
> [13271] rados/singleton/{all/cephtool.yaml fs/btrfs.yaml
> msgr-failures/many.yaml}
> time: =A0=A0=A0367s
>=20
> [13171] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02857s
>=20
> [13170] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/many.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0724s
>=20
> [13173] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01300s
>=20
> [13172] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0216s
>=20
> [13175] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
> workloads/snaps-few-objects.yaml}
> time: =A0=A0=A02867s
>=20
> [13174] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/one.yaml
> workloads/rados_mon_workunits.yaml}
> time: =A0=A0=A0699s
>=20
> [13177] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
> workloads/rados_api_tests.yaml}
> time: =A0=A0=A01168s
>=20
> [13176] rados/monthrash/{ceph/ceph.yaml clusters/3-mons.yaml
> fs/xfs.yaml msgr-failures/few.yaml thrashers/sync-many.yaml
> workloads/rados_5925.yaml}
> time: =A0=A0=A0527s
>=20
>=20
>=20
>=20
--557981400-563867174-1380049417=:25142--
