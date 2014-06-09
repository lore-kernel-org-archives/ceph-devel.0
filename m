From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology and erasure code pool creation
Date: Mon, 09 Jun 2014 19:27:54 +0200
Message-ID: <5395EE9A.2030800@dachary.org>
References: <539488A3.3070507@dachary.org> <CAMfdg1PhTWuL1LKCZuOV5GwhNMehsY1HNeBPtWkJwy01_7Q42g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="95jh9N0wChSlxM63eGcP5wvtkHTmH2O92"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:38666 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873AbaFIR15 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jun 2014 13:27:57 -0400
In-Reply-To: <CAMfdg1PhTWuL1LKCZuOV5GwhNMehsY1HNeBPtWkJwy01_7Q42g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack.cerza@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--95jh9N0wChSlxM63eGcP5wvtkHTmH2O92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 09/06/2014 19:15, Zack Cerza wrote:
> Hi Loic,
>=20
> Without spending too much time investigating, it seems to me it would
> be preferable to just add the missing arguments to the functions you
> pointed out. That way they could even be fully documented! ;)

Ok, I'll do that, thanks !

>=20
> Zack
>=20
> On Sun, Jun 8, 2014 at 11:00 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Zack,
>>
>> In order to test locally repairable codes ( described at https://wiki.=
ceph.com/Planning/Blueprints/Giant/Pyramid_Erasure_Code and documented at=
 https://github.com/dachary/ceph/commit/2ae645438243232392c11fd80fd960f62=
21fd2a0#diff-5518964bc98a094a784ce2d17a5b0cc1R20 ) it would be a convenie=
nt to set the erasure code profile without modifying the teuthology code.=

>>
>> There are not too many instances of hardcoded parameters:
>>
>>   https://github.com/ceph/teuthology/blob/master/teuthology/task_util/=
rados.py#L27
>>   https://github.com/ceph/teuthology/blob/master/teuthology/task/ceph_=
manager.py#L732
>>
>> and it could be generalized. In a nutshell, the definition of an erasu=
re coded profile is a set of key value which should default to:
>>
>>   k: 2
>>   m: 1
>>   plugin: jerasure
>>   ruleset-failure-domain: osd
>>
>> and
>>
>>   self.raw_cluster_cmd('osd', 'erasure-code-profile', 'set', 'teutholo=
gyprofile', 'ruleset-failure-domain=3Dosd', 'm=3D'+str(ec_m), 'k=3D'+str(=
ec_k))
>>
>> could be replaced with:
>>
>>    self.raw_cluster_cmd('osd', 'erasure-code-profile', 'set', 'teuthol=
ogyprofile', **kwargs)
>>
>> assuming kwargs is the above map parsed from the yaml.
>>
>> Any advice you may have on the implementation would be very welcome :-=
)
>>
>> Cheers
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--95jh9N0wChSlxM63eGcP5wvtkHTmH2O92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOV7poACgkQ8dLMyEl6F22gYgCgosqG/K4oZ7FDVsWCwtxKQI+x
fBcAn1NO5kMouN5zdlcGa/yP3woR4FHB
=S5Xw
-----END PGP SIGNATURE-----

--95jh9N0wChSlxM63eGcP5wvtkHTmH2O92--
