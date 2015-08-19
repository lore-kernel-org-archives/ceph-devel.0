From: Loic Dachary <loic@dachary.org>
Subject: Re: [Cbt] Ceph Community Lab: Understanding where the QA suites spend
 time
Date: Thu, 20 Aug 2015 00:22:40 +0200
Message-ID: <55D501B0.40303@dachary.org>
References: <55D4DD24.9010100@redhat.com> <55D4FD99.6000508@dachary.org> <55D4FE70.9010400@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="W9TlKRaNHTT2EK1PRVfTu7GvM8g3sHlUg"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:40808 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750910AbbHSWWn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Aug 2015 18:22:43 -0400
In-Reply-To: <55D4FE70.9010400@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, cbt@lists.ceph.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W9TlKRaNHTT2EK1PRVfTu7GvM8g3sHlUg
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 20/08/2015 00:08, Mark Nelson wrote:> I have no idea about the price o=
f cloud computing services, but if you can find setups that give you acce=
ss to SSDs you may be able to run through thrasher tests much faster (che=
aper?). :)

In my experience (~2 month experience, not much really ;-), VMs are twice=
 slower than bare metal on average (sometime it's only sightly slower, so=
metime it's 3 times slower). The network variance also counts : I've seen=
 providers take ~20 minutes to install the Ceph packages (it's ~2GB altog=
ether).

My 3.3 * ~2 cts ;-)

> Mark
>=20
> On 08/19/2015 05:05 PM, Loic Dachary wrote:
>> Hi,
>>
>> To help put things in perspective (please forgive me if it's a fact al=
ready known to everyone), > 95% of the teuthology jobs can run on virtual=
 machines with 8GB RAM, 40GB disk, 2 processors and no attached disks. Th=
e cost of running such virtual machines in the cloud currently is 0.033 e=
uros per hour. Running 40 teuthology jobs at all times would require an a=
verage of 80 such virtual machines (most jobs use 2 machines, some 1 or 3=
), that is 0.033 * 80 vms * 24 hours * 31 days =3D=3D ~2000 euros per mon=
th (also note that at least one cloud provider offers 50% discount if suc=
h virtual machines are reserved full time). That's 3 to 6 times cheaper t=
han AWS.
>>
>> I'm not sure how much it costs to run these 40 teuthology jobs on a ha=
nd made lab but I'd be surprised if it was cheaper, all included. Whateve=
r hardware already exists in the sepia lab can easily handle the remainin=
g 5% of jobs that require actual hardware for one reason or the other.
>>
>> My 3.3cts ;-)
>>
>> On 19/08/2015 21:46, Mark Nelson wrote:
>>> Hi Guys,
>>>
>>> About a month ago we were going through the process of trying to figu=
re out how to replace some of the hardware in the community laboratory th=
at runs all of the nightly Teuthology tests.  Given a limited budget to r=
eplace the existing nodes, we wanted to understand how the current QA sui=
tes actually spend time on the hardware.  To do this, we investigated the=
 composition of suites, the amount of time that is spent in each suite, a=
nd then a deeper dive into how the most resource intensive jobs spend the=
ir time.  We then wrote a new benchmark for CBT to run ceph-test-rados in=
 a rather naive reproduction of what the ceph task in teuthology does and=
 tested it against several different storage device configurations to see=
 how much benefit SSDs in the nodes may provide.
>>>
>>> A couple of folks at the Hackathon were interested in the paper we wr=
ote.  I thought I would share it with the community as well in case any f=
olks ever wondered what Teuthology actually spends it's time doing.
>>>
>>> http://nhm.ceph.com/community/Ceph_Community_Lab_Performance_Investig=
ation.pdf
>>>
>>> Thanks,
>>> Mark
>>> _______________________________________________
>>> Cbt mailing list
>>> Cbt@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/cbt-ceph.com
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--W9TlKRaNHTT2EK1PRVfTu7GvM8g3sHlUg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXVAbAACgkQ8dLMyEl6F22XGwCfaLsosifonKd+qW6Kwl/uynIV
wp0An0mEQq+qf3UyNOLfJlXoF66U9BtX
=th1i
-----END PGP SIGNATURE-----

--W9TlKRaNHTT2EK1PRVfTu7GvM8g3sHlUg--
