From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-releases
Date: Mon, 23 Mar 2015 17:10:20 +0100
Message-ID: <55103AEC.209@dachary.org>
References: <550E832E.6040004@dachary.org> <1042516820.1185244.1427041005119.JavaMail.zimbra@redhat.com> <550F5FC7.3040400@dachary.org> <995426416.1709433.1427123361564.JavaMail.zimbra@redhat.com> <551033D2.2030109@dachary.org> <618219498.1762834.1427125479056.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xxncQuSFkdvOXneFlH2oixfc0rp2RcAcG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35129 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752230AbbCWQKb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 12:10:31 -0400
In-Reply-To: <618219498.1762834.1427125479056.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xxncQuSFkdvOXneFlH2oixfc0rp2RcAcG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 23/03/2015 16:44, Yuri Weinstein wrote:
>=20
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "Ceph Development" <ceph-devel@vger=
=2Ekernel.org>
> Sent: Monday, March 23, 2015 8:40:02 AM
> Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-rele=
ases
>=20
> Hi Yuri,
>=20
> On 23/03/2015 16:09, Yuri Weinstein wrote:
>> "How will that go for the next run of upgrade/giant-x ?"
>>
>> I was thinking that as soon as for example this suite passed, #11189 g=
ets resolved as thus indicates that it's ready for for the hammer release=
 cut.=20
>=20
> If the following happens:
>=20
> * hammer: upgrade/giant-x runs and passes
> * a dozen more commits are added because problems are fixed
> * hammer: upgrade/giant-x runs and passes
>=20
> That leaves us with two issues with the same name but with different up=
date dates. So if I look at the "hammer: upgrade/giant-x" issues in chron=
ological order, I have a complete history of the successive runs and I ca=
n check the latest one to see how it went. Or older ones if I need to dig=
 the history.=20
>=20
> This is good :-)
>=20
> After hammer is released, the same will presumably happen for point rel=
eases. Instead of naming them "hammer: upgrade/giant-x" which would be co=
nfusing, I guess we could name them "v0.94.1: upgrade/giant-x" instead.=20
>=20
> Does that sound right ?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Yes, we can alternatively name the set of those tasks as hammer v0.94.1=


Great !

Would you like me to add a section at http://tracker.ceph.com/projects/ce=
ph-releases/wiki/Wiki to summarize this conversation ?

>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yuri Weinstein" <yweinste@redhat.com>
>> Cc: "Sage Weil" <sweil@redhat.com>, "Ceph Development" <ceph-devel@vge=
r.kernel.org>
>> Sent: Sunday, March 22, 2015 5:35:19 PM
>> Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-rel=
eases
>>
>>
>>
>> On 22/03/2015 17:16, Yuri Weinstein wrote:
>>> Loic, I think the idea was to do more process driven approach for rel=
easing hammer, e.g. keep track of suites vs. results and open issues, so =
we can have a high level view on status at any time before the final cut =
day.
>>>
>>> Do you have any suggestions or objections?
>>
>> Reading http://tracker.ceph.com/issues/11189 I see it has one run, and=
 a run of failed tests, and got resolved because all passed. The title is=
 hammer: upgrade/giant-x. How will that go for the next run of upgrade/gi=
ant-x ?
>>
>> I use a python snippet to display the errors in a redmine format (http=
://workbench.dachary.org/dachary/ceph-workbench/issues/2)
>>
>> $ python ../fail.py teuthology-2015-03-20_17:05:02-upgrade:giant-x-ham=
mer-distro-basic-vps
>> ** *'mkdir -p -- /home/ubuntu/cephtest/mnt.1/client.1/tmp && cd -- /ho=
me/ubuntu/cephtest/mnt.1/client.1/tmp && CEPH_CLI_TEST_DUP_COMMAND=3D1 CE=
PH_REF=3Dgiant TESTDIR=3D"/home/ubuntu/cephtest" CEPH_ID=3D"1" PATH=3D$PA=
TH:/usr/sbin adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/c=
overage timeout 3h /home/ubuntu/cephtest/workunit.client.1/cls/test_cls_r=
gw.sh'*
>> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/gi=
ant.yaml 2-workload/parallel_run/{ec-rados-parallel.yaml rados_api.yaml r=
ados_loadgenbig.yaml test_cache-pool-snaps.yaml test_rbd_api.yaml test_rb=
d_python.yaml} 3-upgrade-sequence/upgrade-mon-osd-mds.yaml 4-final-worklo=
ad/{rados-snaps-few-objects.yaml rados_loadgenmix.yaml rados_mon_thrash.y=
aml rbd_cls.yaml rbd_import_export.yaml rgw_swift.yaml} distros/rhel_7.0.=
yaml}":http://pulpito.ceph.com/teuthology-2015-03-20_17:05:02-upgrade:gia=
nt-x-hammer-distro-basic-vps/814081
>> ** *"2015-03-20 23:04:51.042345 mon.0 10.214.130.49:6789/0 3 : cluster=
 [WRN] message from mon.1 was stamped 14400.248297s in the future, clocks=
 not synchronized" in cluster log*
>> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/gi=
ant.yaml 2-workload/sequential_run/test_rbd_api.yaml 3-upgrade-sequence/u=
pgrade-all.yaml 4-final-workload/{rados-snaps-few-objects.yaml rados_load=
genmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_import_export.yaml rgw=
_swift.yaml} distros/centos_6.5.yaml}":http://pulpito.ceph.com/teuthology=
-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814155
>> ** *Could not reconnect to ubuntu@vpm169.front.sepia.ceph.com*
>> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/gi=
ant.yaml 2-workload/sequential_run/ec-rados-default.yaml 3-upgrade-sequen=
ce/upgrade-mon-osd-mds.yaml 4-final-workload/{rados-snaps-few-objects.yam=
l rados_loadgenmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_import_exp=
ort.yaml rgw_swift.yaml} distros/rhel_7.0.yaml}":http://pulpito.ceph.com/=
teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/81=
4108
>> ** *Could not reconnect to ubuntu@vpm166.front.sepia.ceph.com*
>> *** "upgrade:giant-x/stress-split-erasure-code/{0-cluster/start.yaml 1=
-giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/defau=
lt.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next-mon/monb.=
yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Djerasure-k=3D3-m=3D=
1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology-2015-03=
-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814194
>> ** *'sudo adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/c=
overage daemon-helper kill ceph-mon -f -i a'*
>> *** "upgrade:giant-x/stress-split-erasure-code-x86_64/{0-cluster/start=
=2Eyaml 1-giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thr=
ash/default.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next-=
mon/monb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Disa-k=3D2=
-m=3D1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology-20=
15-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814197
>> ** *timed out waiting for admin_socket to appear after osd.13 restart*=

>> *** "upgrade:giant-x/stress-split/{0-cluster/start.yaml 1-giant-instal=
l/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/default.yaml 4-mon=
/mona.yaml 5-workload/{rbd-cls.yaml rbd-import-export.yaml readwrite.yaml=
 snaps-few-objects.yaml} 6-next-mon/monb.yaml 7-workload/{radosbench.yaml=
 rbd_api.yaml} 8-next-mon/monc.yaml 9-workload/{rbd-python.yaml rgw-swift=
=2Eyaml snaps-many-objects.yaml} distros/rhel_6.5.yaml}":http://pulpito.c=
eph.com/teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basi=
c-vps/814186
>>
>>>
>>> Thx
>>> YuriW
>>>
>>> ----- Original Message -----
>>> From: "Loic Dachary" <loic@dachary.org>
>>> To: "Sage Weil" <sweil@redhat.com>
>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>>> Sent: Sunday, March 22, 2015 1:54:06 AM
>>> Subject: hammer tasks in http://tracker.ceph.com/projects/ceph-releas=
es
>>>
>>> Hi Sage,
>>>
>>> You have created a few hammer related tasks at http://tracker.ceph.co=
m/projects/ceph-releases/issues . What did you have in mind ?
>>>
>>> Cheers
>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--xxncQuSFkdvOXneFlH2oixfc0rp2RcAcG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUQOu0ACgkQ8dLMyEl6F23eOwCfV0mll10gDoBDfBDHVk25ImGX
rxAAn3W4NzJ7gwLagz78mulON1hwQQfS
=vA0+
-----END PGP SIGNATURE-----

--xxncQuSFkdvOXneFlH2oixfc0rp2RcAcG--
