From: Loic Dachary <loic@dachary.org>
Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-releases
Date: Mon, 23 Mar 2015 16:40:02 +0100
Message-ID: <551033D2.2030109@dachary.org>
References: <550E832E.6040004@dachary.org> <1042516820.1185244.1427041005119.JavaMail.zimbra@redhat.com> <550F5FC7.3040400@dachary.org> <995426416.1709433.1427123361564.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Lo7eBTCQlKoE8DjLqsu2h8Vm6hFvV6xD4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:35091 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752207AbbCWPkM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Mar 2015 11:40:12 -0400
In-Reply-To: <995426416.1709433.1427123361564.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Lo7eBTCQlKoE8DjLqsu2h8Vm6hFvV6xD4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

On 23/03/2015 16:09, Yuri Weinstein wrote:
> "How will that go for the next run of upgrade/giant-x ?"
>=20
> I was thinking that as soon as for example this suite passed, #11189 ge=
ts resolved as thus indicates that it's ready for for the hammer release =
cut.=20

If the following happens:

* hammer: upgrade/giant-x runs and passes
* a dozen more commits are added because problems are fixed
* hammer: upgrade/giant-x runs and passes

That leaves us with two issues with the same name but with different upda=
te dates. So if I look at the "hammer: upgrade/giant-x" issues in chronol=
ogical order, I have a complete history of the successive runs and I can =
check the latest one to see how it went. Or older ones if I need to dig t=
he history.=20

This is good :-)

After hammer is released, the same will presumably happen for point relea=
ses. Instead of naming them "hammer: upgrade/giant-x" which would be conf=
using, I guess we could name them "v0.94.1: upgrade/giant-x" instead.=20

Does that sound right ?

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Sage Weil" <sweil@redhat.com>, "Ceph Development" <ceph-devel@vger=
=2Ekernel.org>
> Sent: Sunday, March 22, 2015 5:35:19 PM
> Subject: Re: hammer tasks in http://tracker.ceph.com/projects/ceph-rele=
ases
>=20
>=20
>=20
> On 22/03/2015 17:16, Yuri Weinstein wrote:
>> Loic, I think the idea was to do more process driven approach for rele=
asing hammer, e.g. keep track of suites vs. results and open issues, so w=
e can have a high level view on status at any time before the final cut d=
ay.
>>
>> Do you have any suggestions or objections?
>=20
> Reading http://tracker.ceph.com/issues/11189 I see it has one run, and =
a run of failed tests, and got resolved because all passed. The title is =
hammer: upgrade/giant-x. How will that go for the next run of upgrade/gia=
nt-x ?
>=20
> I use a python snippet to display the errors in a redmine format (http:=
//workbench.dachary.org/dachary/ceph-workbench/issues/2)
>=20
> $ python ../fail.py teuthology-2015-03-20_17:05:02-upgrade:giant-x-hamm=
er-distro-basic-vps
> ** *'mkdir -p -- /home/ubuntu/cephtest/mnt.1/client.1/tmp && cd -- /hom=
e/ubuntu/cephtest/mnt.1/client.1/tmp && CEPH_CLI_TEST_DUP_COMMAND=3D1 CEP=
H_REF=3Dgiant TESTDIR=3D"/home/ubuntu/cephtest" CEPH_ID=3D"1" PATH=3D$PAT=
H:/usr/sbin adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/co=
verage timeout 3h /home/ubuntu/cephtest/workunit.client.1/cls/test_cls_rg=
w.sh'*
> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/gia=
nt.yaml 2-workload/parallel_run/{ec-rados-parallel.yaml rados_api.yaml ra=
dos_loadgenbig.yaml test_cache-pool-snaps.yaml test_rbd_api.yaml test_rbd=
_python.yaml} 3-upgrade-sequence/upgrade-mon-osd-mds.yaml 4-final-workloa=
d/{rados-snaps-few-objects.yaml rados_loadgenmix.yaml rados_mon_thrash.ya=
ml rbd_cls.yaml rbd_import_export.yaml rgw_swift.yaml} distros/rhel_7.0.y=
aml}":http://pulpito.ceph.com/teuthology-2015-03-20_17:05:02-upgrade:gian=
t-x-hammer-distro-basic-vps/814081
> ** *"2015-03-20 23:04:51.042345 mon.0 10.214.130.49:6789/0 3 : cluster =
[WRN] message from mon.1 was stamped 14400.248297s in the future, clocks =
not synchronized" in cluster log*
> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/gia=
nt.yaml 2-workload/sequential_run/test_rbd_api.yaml 3-upgrade-sequence/up=
grade-all.yaml 4-final-workload/{rados-snaps-few-objects.yaml rados_loadg=
enmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_import_export.yaml rgw_=
swift.yaml} distros/centos_6.5.yaml}":http://pulpito.ceph.com/teuthology-=
2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814155
> ** *Could not reconnect to ubuntu@vpm169.front.sepia.ceph.com*
> *** "upgrade:giant-x/parallel/{0-cluster/start.yaml 1-giant-install/gia=
nt.yaml 2-workload/sequential_run/ec-rados-default.yaml 3-upgrade-sequenc=
e/upgrade-mon-osd-mds.yaml 4-final-workload/{rados-snaps-few-objects.yaml=
 rados_loadgenmix.yaml rados_mon_thrash.yaml rbd_cls.yaml rbd_import_expo=
rt.yaml rgw_swift.yaml} distros/rhel_7.0.yaml}":http://pulpito.ceph.com/t=
euthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814=
108
> ** *Could not reconnect to ubuntu@vpm166.front.sepia.ceph.com*
> *** "upgrade:giant-x/stress-split-erasure-code/{0-cluster/start.yaml 1-=
giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/defaul=
t.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next-mon/monb.y=
aml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Djerasure-k=3D3-m=3D=
1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology-2015-03=
-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814194
> ** *'sudo adjust-ulimits ceph-coverage /home/ubuntu/cephtest/archive/co=
verage daemon-helper kill ceph-mon -f -i a'*
> *** "upgrade:giant-x/stress-split-erasure-code-x86_64/{0-cluster/start.=
yaml 1-giant-install/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash=
/default.yaml 4-mon/mona.yaml 5-workload/ec-rados-default.yaml 6-next-mon=
/monb.yaml 8-next-mon/monc.yaml 9-workload/ec-rados-plugin=3Disa-k=3D2-m=3D=
1.yaml distros/rhel_7.0.yaml}":http://pulpito.ceph.com/teuthology-2015-03=
-20_17:05:02-upgrade:giant-x-hammer-distro-basic-vps/814197
> ** *timed out waiting for admin_socket to appear after osd.13 restart*
> *** "upgrade:giant-x/stress-split/{0-cluster/start.yaml 1-giant-install=
/giant.yaml 2-partial-upgrade/firsthalf.yaml 3-thrash/default.yaml 4-mon/=
mona.yaml 5-workload/{rbd-cls.yaml rbd-import-export.yaml readwrite.yaml =
snaps-few-objects.yaml} 6-next-mon/monb.yaml 7-workload/{radosbench.yaml =
rbd_api.yaml} 8-next-mon/monc.yaml 9-workload/{rbd-python.yaml rgw-swift.=
yaml snaps-many-objects.yaml} distros/rhel_6.5.yaml}":http://pulpito.ceph=
=2Ecom/teuthology-2015-03-20_17:05:02-upgrade:giant-x-hammer-distro-basic=
-vps/814186
>=20
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Sage Weil" <sweil@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Sunday, March 22, 2015 1:54:06 AM
>> Subject: hammer tasks in http://tracker.ceph.com/projects/ceph-release=
s
>>
>> Hi Sage,
>>
>> You have created a few hammer related tasks at http://tracker.ceph.com=
/projects/ceph-releases/issues . What did you have in mind ?
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Lo7eBTCQlKoE8DjLqsu2h8Vm6hFvV6xD4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUQM9IACgkQ8dLMyEl6F22ndgCdF5E5jK7akPasgiQSsJOL3yqU
sFEAn3r8+wQOT/Vyap5ymT+e39+EaJTl
=WEkc
-----END PGP SIGNATURE-----

--Lo7eBTCQlKoE8DjLqsu2h8Vm6hFvV6xD4--
