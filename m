From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology : ulimit: error
Date: Tue, 13 Aug 2013 12:54:24 +0200
Message-ID: <520A1060.3030706@dachary.org>
References: <52041335.9040009@dachary.org> <5205D12A.4090408@inktank.com> <5205FB01.5040905@dachary.org> <52099FB0.1070301@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC1074A8170F615E022B31274"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:53683 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756214Ab3HMKy2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Aug 2013 06:54:28 -0400
In-Reply-To: <52099FB0.1070301@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC1074A8170F615E022B31274
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Dan,

That was indeed the solution :-)

Thanks !

On 13/08/2013 04:53, Dan Mick wrote:
> Ah, there's another we apply universally to our test systems, apparentl=
y:
>=20
> '/etc/security/limits.d/ubuntu.conf'
>=20
> ubuntu hard nofile 16384
>=20
> and the tests run as user "ubuntu".  Line 4 of the script is the nofile=
 setting.
>=20
> On 08/10/2013 01:34 AM, Loic Dachary wrote:
>>
>>
>> On 10/08/2013 07:35, Dan Mick wrote:
>>> IIRC we had to adjust settings in /etc/security to allow ulimit adjus=
tment of at least core:
>>>
>>> sed -i 's/^#\*.*soft.*core.*0/\*                soft    core unlimite=
d/g' /etc/security/limits.conf
>>>
>>> or something like that.  That seems to apply to centos/fedora/redhat =
systems.
>>
>> Hi Dan,
>>
>> This is Ubuntu and it does work with sudo. It probably is something ab=
out how it's called rather than a system limit.
>>
>> Cheers
>>
>>>
>>>
>>> On 08/08/2013 02:52 PM, Loic Dachary wrote:
>>>> Hi,
>>>>
>>>> Trying to use Ubuntu precise virtual machines as teuthology targets =
( making sure they have 2GB of RAM because ceph-test-dbg will not even in=
stall with 1GB of RAM ;-) and installing the key with
>>>>
>>>> wget -q -O- 'https://ceph.com/git/?p=3Dceph.git;a=3Dblob_plain;f=3Dk=
eys/release.asc' | sudo apt-key add -
>>>>
>>>> teuthology runs with
>>>>
>>>> ./virtualenv/bin/teuthology job.yaml
>>>>
>>>> where job.yaml is
>>>>
>>>> check-locks: false
>>>> roles:
>>>> - - mon.a
>>>>     - mon.c
>>>>     - osd.0
>>>> - - mon.b
>>>>     - osd.1
>>>>     - client.0
>>>> tasks:
>>>> - install:
>>>>      project: ceph
>>>>      branch: wip-5510
>>>> - ceph:
>>>>      fs: ext4
>>>> - workunit:
>>>>       clients:
>>>>         all:
>>>>         - filestore/filestore.sh
>>>> targets:
>>>>      ubuntu@91.121.254.229: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDO=
Sit20EyZ2AKCvk2tnMsdQ6LmVRutvBmZb0awV9Z2EduJa0fYPrReYRb9ZhGRq2PJe0zgpFPKr=
8s4gGay+tL0+dFkju5uyABqMGeITlJCifd+RhM0MCVllgIzekDwVb0n6ydTS8k7GVFyYv8ZC0=
TPgbfcDcEtSEgqJNRJ0o1Bh8swuTn+cipanNDRVK39tOqJdfptUxak+TD+5QY8CGFdXdEQYP7=
VsYJ+jQHw73O2xbuPgfv5Shbmt+qGWLToxFqKca3owMtkvFeONgYUdujgg9qr7Q9p0+HhCFCX=
B8v4N2I7NSbWNdpGqyJLdLqwJ70gEeNlOhm5F7IsXfVxTapB
>>>>      ubuntu@91.121.254.237: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCX=
VzhedORtmEmCeZJ4Ssg8wfqpYyH9W/Aa+j6CvPHSAkzZ48zXqVBATxm6S8sIIqfKkz1hWpNss=
x6uUotbm8k/ZatMddsd932+Di136l/HUhp6O8iIFze56kjWpyDpRPw2MM0V+OKmsiHZDfMj9A=
Tt6ChgXfRsm23MUlmnoFHvtfwvFBnvBjcZPN7qxMpFHDamZzACNvnis/OINJrud9VprOgjhZZ=
7mxcTbcVZaVgcTcnyC4b9d9PRrMG2aCv0BO1eb/qnlmSogQPfoKEORJcwaUcLgabww+Taa9hJ=
SZ9l8yEQamj+XIgr6yzGKgCvlG4lTdHM2tQdpgATZvR7/pBz
>>>>
>>>> and produces the following output
>>>>
>>>> INFO:teuthology.orchestra.run.err:[91.121.254.229]: /home/ubuntu/cep=
htest/lo1308082328/adjust-ulimits: 4: ulimit: error setting limit (Operat=
ion not permitted)
>>>>
>>>> and the full output is at
>>>>
>>>> http://pastealacon.com/32957
>>
>> Refreshed with a longer timeout.
>>
>> http://pastealacon.com/32963
>>>>
>>>> as if
>>>>
>>>> /home/ubuntu/cephtest/lo1308082328/adjust-ulimits ceph-coverage /hom=
e/ubuntu/cephtest/lo1308082328/archive/coverage monmaptool --create --clo=
bber --add a 91.121.254.229:6789 --add c 91.121.254.229:6790 --add b 91.1=
21.254.237:6789 --print /home/ubuntu/cephtest/lo1308082328/monmap'
>>>>
>>>> was run without a leading sudo. I tried running sudo adjust-ulimits =
echo foo manually on the target and it works.
>>>>
>>>> I would very much appreciate a hint ;-)
>>>>
>>>> Cheers
>>>>
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigC1074A8170F615E022B31274
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlIKEGAACgkQ8dLMyEl6F23vdgCfS4EvXQ0pbvlHsqoMP3p2UTPM
8JoAn3sLtsJmXGXPp9FGR30qee/WcfEH
=TA6I
-----END PGP SIGNATURE-----

--------------enigC1074A8170F615E022B31274--
