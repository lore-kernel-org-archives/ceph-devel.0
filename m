From: Loic Dachary <loic@dachary.org>
Subject: Re: Firefly upgrade tests
Date: Sat, 05 Jul 2014 16:58:02 +0200
Message-ID: <53B8127A.7050506@dachary.org>
References: <53B5DBB2.90503@dachary.org>	<53B8019B.3090909@dachary.org> <CAJBxG-vZNs5nQWmP6GrSmjrEUF_u-pFT0S=V+hC1PRhafaGcSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="B9pqH8w89WScWxPpjB33TMkuCuKFhSUaf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38572 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753570AbaGEO6J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Jul 2014 10:58:09 -0400
In-Reply-To: <CAJBxG-vZNs5nQWmP6GrSmjrEUF_u-pFT0S=V+hC1PRhafaGcSA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B9pqH8w89WScWxPpjB33TMkuCuKFhSUaf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This is very kind of you. Hopefully noone will mind ;-)

On 05/07/2014 16:39, Yuri Weinstein wrote:
> I killed several runs that had been running for 2-3 days, hopefully it
> will speed up your runs.
>=20
> Thx
> YuriW
>=20
> On Sat, Jul 5, 2014 at 6:46 AM, Loic Dachary <loic@dachary.org> wrote:
>>
>> Hi,
>>
>> It looks like there is a shortage of VPS for some reason:
>>
>> http://pulpito.ceph.com/loic-2014-07-03_11:24:33-upgrade:firefly-x:str=
ess-split-wip-8475-testing-basic-vps/
>>
>> has a number of tests scheduled since ~48h and not making progress.
>>
>> Cheers
>>
>> On 04/07/2014 00:39, Loic Dachary wrote:
>>> Hi Ceph,
>>>
>>> The firefly-x test upgrade suite is designed to check that upgrading =
from Firefly to a newer version (master or a branch) works as expected. I=
t was created it by copying dumpling-x and can be browsed at https://gith=
ub.com/ceph/ceph-qa-suite/tree/master/suites/upgrade/firefly-x
>>>
>>> To establish a baseline, a run was scheduled to upgrade from firefly =
to firefly (i.e. no upgrade really ;-) and it should therefore show that =
when nothing happens all is well. It however fails in various ways as can=
 be seen here.
>>>
>>> ./virtualenv/bin/teuthology-suite --suite upgrade/firefly-x/stress-sp=
lit  --suite-dir ~/software/ceph/ceph-qa-suite  --ceph firefly --machine-=
type vps --email loic@dachary.org http://pulpito.ceph.com/loic-2014-07-02=
_23:05:05-upgrade:firefly-x:stress-split-firefly-testing-basic-vps/
>>>
>>> * Command failed on vpm105 with status 1: 'sudo yum install -y http:/=
/gitbuilder.ceph.com/kernel-rpm-redhatenterpriseserver6-x86_64-basic/sha1=
/8102ce7556a99f6348067c60583320d308f36362/kernel.x86_64.rpm'
>>>   Does that mean kernels are not ready yet for this distribution and =
the tests should be skipped ?
>>> * Command failed on vpm058 with status 1: "SWIFT_TEST_CONFIG_FILE=3D/=
home/ubuntu/cephtest/archive/testswift.client.0.conf /home/ubuntu/cephtes=
t/swift/virtualenv/bin/nosetests -w /home/ubuntu/cephtest/swift/test/func=
tional -v -a '!fails_on_rgw'"
>>>   http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:=
stress-split-firefly-testing-basic-vps/338941
>>>
>>>   Although it looks like http://tracker.ceph.com/issues/7808 which is=
 a duplicate of http://tracker.ceph.com/issues/7799 it is slightly differ=
ent and http://tracker.ceph.com/issues/8735 was created to keep track of =
it.
>>>
>>> * Command failed on vpm070 with status 1: 'sudo adjust-ulimits ceph-c=
overage /home/ubuntu/cephtest/archive/coverage daemon-helper kill ceph-os=
d -f -i 1'    http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:fi=
refly-x:stress-split-firefly-testing-basic-vps/338904/
>>>
>>>    Although the root of the error seems to be that osd 1 cannot be ki=
lled by the thrasher, I don't see meaningfull error messages. http://trac=
ker.ceph.com/issues/8736 was filed to keep track of this condition.
>>>
>>> * timed out waiting for admin_socket to appear after osd.1 restart   =
 http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:stres=
s-split-firefly-testing-basic-vps/338908/
>>>
>>>    It looks like a race : the osd is killed at the same time it is re=
started by the thrasher and http://tracker.ceph.com/issues/8737 was opene=
d for this
>>>
>>> * hang on "INFO:teuthology.task.rados:joining rados"
>>>   http://pulpito.ceph.com/loic-2014-07-02_23:05:05-upgrade:firefly-x:=
stress-split-firefly-testing-basic-vps/338915/
>>>
>>>   It looks like a bug and http://tracker.ceph.com/issues/8740 was fil=
ed
>>>
>>> When the same suite is run to upgrade from firefly to master it gives=
 http://pulpito.ceph.com/loic-2014-07-02_22:04:23-upgrade:firefly-x:stres=
s-split-master-testing-basic-vps/ which shows the following errors:
>>>
>>> * Command failed on vpm105 with status 1: 'sudo yum install -y http:/=
/gitbuilder.ceph.com/kernel-rpm-redhatenterpriseserver6-x86_64-basic/sha1=
/8102ce7556a99f6348067c60583320d308f36362/kernel.x86_64.rpm'   (same as a=
bove)
>>>
>>> * Could not reconnect to ubuntu@vpm042.front.sepia.ceph.com  : it loo=
ks like a transient timeout problem that can be ignored
>>>   http://pulpito.ceph.com/loic-2014-07-02_22:04:23-upgrade:firefly-x:=
stress-split-master-testing-basic-vps/338891/
>>>   2014-07-02T18:52:24.546 INFO:teuthology.orchestra.connection:{'user=
name': u'ubuntu', 'hostname': u'vpm042.front.sepia.ceph.com', 'timeout': =
60}
>>>
>>> * Command failed on vpm017 with status 1: "SWIFT_TEST_CONFIG_FILE=3D/=
home/ubuntu/cephtest/archive/testswift.client.0.conf /home/ubuntu/cephtes=
t/swift/virtualenv/bin/nosetests -w /home/ubuntu/cephtest/swift/test/func=
tional -v -a '!fails_on_rgw'"
>>>   One of which looks exactly as http://tracker.ceph.com/issues/7799 w=
hich was re-opened
>>>
>>> * hang on "INFO:teuthology.task.rados:joining rados" (same as above)
>>>
>>> Cheers
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--B9pqH8w89WScWxPpjB33TMkuCuKFhSUaf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO4EnoACgkQ8dLMyEl6F22KgQCghaIGyJCSplPFYtiUWLM8Ye9M
VPIAoLmdOZhy64PMgMP4H6TrdMCovNJh
=ll9u
-----END PGP SIGNATURE-----

--B9pqH8w89WScWxPpjB33TMkuCuKFhSUaf--
