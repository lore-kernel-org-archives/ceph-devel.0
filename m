From: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Subject: RE: Specify omap path for filestore
Date: Sun, 1 Nov 2015 06:41:33 +0000
Message-ID: <6F3FA899187F0043BA1827A69DA2F7CC0363820F@shsmsx102.ccr.corp.intel.com>
References: <C8CF870384EBCF4CAB89D2041A5C80B322002AB8@SHSMSX101.ccr.corp.intel.com>
 <C8CF870384EBCF4CAB89D2041A5C80B322002D57@SHSMSX101.ccr.corp.intel.com>
 <C8CF870384EBCF4CAB89D2041A5C80B3220030ED@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:6570 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbbKAGlh convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Nov 2015 01:41:37 -0500
In-Reply-To: <C8CF870384EBCF4CAB89D2041A5C80B3220030ED@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Xue, Chendi" <chendi.xue@intel.com>, 'Samuel Just' <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

As we use submit_transaction(instead of submit_transaction_sync) in DBO=
bjectmap, and we also don't  use a kv_sync_thread for DB. Seems we need=
 to rely on the syncfs(2) at commit time for persist everything?

If that is the case, moving db out of the same FS as Data  may cause is=
sue?


> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Xue, Chendi
> Sent: Friday, October 30, 2015 10:05 AM
> To: 'Samuel Just'
> Cc: ceph-devel@vger.kernel.org
> Subject: Specify omap path for filestore
>=20
> Hi, Sam
>=20
> Last week I introduced about how we saw the benefit of moving omap to=
 a
> separate device.
>=20
> And here is the pull request:
> https://github.com/ceph/ceph/pull/6421
>=20
> I had tested redeploy and restart ceph cluster at my setup, the codes=
 works
> fine.
> one problem is do you think I should *DELETE* all the files under the
> omap_path firstly? Because I notice if old pg data leaves there, osd =
daemon
> may run into chaos. But I am not sure if it should leave to users to =
DELETE.
>=20
> Any thoughts?
>=20
> Also I paste some data I talked , which is about the rbd and osd writ=
e iops
> ratio when doing randwrite to a rbd device.
>=20
> =3D=3D=3D=3D=3D=3DHere is some data=3D=3D=3D=3D=3D
> We uses 4 clients , 35 vm each to test on rbd randwrite.
> 4 osd physical nodes, each has 10 HDD as osd and 2 ssd as journal
> 2 replica
> filestore_max_inline_xattr_xfs=3D0
> filestore_max_inline_xattr_size_xfs=3D0
>=20
> Before moving omap to separate ssd, we saw a frontend and backend iop=
s
> ratio of 1:5.8, rbd side total iops 1206, hdd total iops 7034 Like we=
 talked, 5.8
> consists of 2 replica write, inode and omap writes
> runid=A0=A0=A0=A0=A0=A0=A0=A0 op_size=A0=A0=A0 op_type=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 QD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 engine=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serverNum=A0=A0=A0=A0=A0=A0 clie
> ntNum=A0=A0=A0=A0=A0=A0=A0=A0 rbdNum=A0=A0 runtime=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 fio_iops=A0=A0=A0=A0=A0=A0=A0=A0 fio_bw=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 fio_latency
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd_iops=A0 =A0=A0=A0=A0=A0=A0=A0=A0 o=
sd_bw=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd_latency
> 332=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4k=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 randwrite=A0=A0=A0=A0=A0=A0=A0=A0 qd8=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 qemurbd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 140=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 400 sec=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1206.000=
=A0=A0=A0=A0=A0=A0=A0=A0 4.987 MB/s=A0=A0=A0=A0=A0 884.617
> msec=A0 =A0=A0=A0=A0=A0=A0=A0=A0 7034.975 =A0=A0=A0=A0=A0=A0=A0=A0 47=
=2E407 MB/s=A0=A0=A0 242.620 msec
>=20
> And after moving omap to a separate ssd, we saw a frontend vs. backen=
d
> ratio drops to 1:2.6, rbd side total iops 5006, hdd total iops 13089
> runid=A0=A0=A0=A0=A0=A0=A0=A0 op_size=A0=A0=A0 op_type=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 QD=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 engine=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 serverNum=A0=A0=A0=A0=A0=A0 clie
> ntNum=A0=A0=A0=A0=A0=A0=A0=A0 rbdNum=A0=A0 runtime=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 fio_iops=A0=A0=A0=A0=A0=A0=A0=A0 fio_bw=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 fio_latency
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd_iops=A0 =A0=A0=A0=A0=A0=A0=A0=A0 o=
sd_bw=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 osd_latency
> 326=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4k=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 randwrite=A0=A0=A0=A0=A0=A0=A0=A0 qd8=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 qemurbd=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 140=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 400 sec=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 5006.000=
=A0=A0=A0=A0=A0=A0=A0=A0 19.822 MB/s=A0=A0=A0 222.296
> msec=A0 =A0=A0=A0=A0=A0=A0=A0=A0 13089.020=A0=A0=A0=A0=A0=A0=A0 82.89=
7 MB/s=A0=A0=A0 482.203 msec
>=20
>=20
> Best regards,
> Chendi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
