From: Loic Dachary <loic@dachary.org>
Subject: Re: testing the teuthology OpenStack backend
Date: Fri, 21 Aug 2015 18:45:39 +0200
Message-ID: <55D755B3.6090507@dachary.org>
References: <55C377B3.7050500@dachary.org> <55C6108C.7010803@ubuntukylin.com> <55C61F0C.3000903@dachary.org> <55D44D1A.10607@ubuntukylin.com> <55D4592D.9060704@dachary.org> <06681238D8946F44A60AA400760A1CBF0209224D@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="V83f7ikVPdmVXj7s443TMSGJAFt7b1w0M"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:41936 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751344AbbHUQpv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Aug 2015 12:45:51 -0400
In-Reply-To: <06681238D8946F44A60AA400760A1CBF0209224D@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhou, Yuan" <yuan.zhou@intel.com>, Li Wang <liwang@ubuntukylin.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V83f7ikVPdmVXj7s443TMSGJAFt7b1w0M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for sharing, it helps :-)

Cheers

On 21/08/2015 08:09, Zhou, Yuan wrote:
> Hi Loic/Li,
>=20
> We have a local Ceph binary repo for our local teuthology testing. I'm =
using some modified Ceph gitbuilder (https://github.com/ceph/gitbuilder) =
to create the repo. The things I've changed are:
>=20
> 1. modify branch-local to watch our branchs only, otherwise there'll be=
 too many branches to build
> 2. modify make-debs.sh to add *test-dbg packages  (https://gist.github.=
com/zhouyuan/f4c1c671c1659ece04e1)
> 2. modify autobuilder.sh to make a proper directory and move the binari=
es there  (https://gist.github.com/zhouyuan/2a2c4d1b20ff42efc351)
>=20
> It's still very simple (e,g, only Ubuntu Trusty included) but enough fo=
r our tests now. Hope this can help.
>=20
> Thanks, -yuan
>=20
>=20
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.ke=
rnel.org] On Behalf Of Loic Dachary
> Sent: Wednesday, August 19, 2015 6:24 PM
> To: Li Wang
> Cc: Ceph Development
> Subject: Re: testing the teuthology OpenStack backend
>=20
> Hi,
>=20
> [cc'ing the ceph-devel list for Zack or Andrew's input]
>=20
> On 19/08/2015 11:32, Li Wang wrote:
>> Hi Loic,
>>   we did a test, the results are attached. We found that the network=20
>> may be the bottleneck, it seems it will fetch all the packages from=20
>> ceph website on the fly, that does take time and cause many failed=20
>> jobs, and there are also many dead jobs, what do those mean? Do you=20
>> have some suggestions, if possible to enable it fetch the packages=20
>> from configurable mirror or even private package repositories?
>=20
> You can ssh to the teuthology instance (the host that runs pulpito) and=
 modify the ~/.teuthology.yaml with
>=20
>    gitbuilder_host: gitbuilder.ubuntukylin.com
>=20
> which will override the default of=20
>=20
>    gitbuilder_host: gitbuilder.ceph.com
>=20
> I've never done that however and maybe Zack or Andrew have advices on h=
ow to establish a mirror properly.
>=20
> I think having a private package repository that is useable by teutholo=
gy is complicated because the package locations, naming conventions and b=
uild methods are difficult to reproduce (and I don't fully understand wha=
t they are right now).
>=20
> Cheers
>=20
>>
>> Cheers,
>> Li Wang
>>
>> On 2015/8/8 23:23, Loic Dachary wrote:
>>>
>>>
>>> On 08/08/2015 16:22, Li Wang wrote:
>>>> Hi Loic,
>>>>    Glad to talk with you on IRC about setting up the teuthology=20
>>>> OpenStack backend. Once it is ready to run the test in private=20
>>>> cloud, and the results could be exported and uploaded to a public=20
>>>> place, please let me know asap :)
>>>
>>> I'm working on it, should be ready RSN.
>>>
>>>>
>>>> Cheers,
>>>> Li Wang
>>>>
>>>>
>>>> On 2015/8/6 23:05, Loic Dachary wrote:
>>>>> Hi,
>>>>>
>>>>> I'm looking into testing the OpenStack backend for teuthology on a =
new cluster to verify it's portable. I think it is but ... ;-) I'm told y=
ou have an OpenStack cluster and would be interested in running teutholog=
y workloads on it. Does it have a public facing API ?
>>>>>
>>>>> Cheers
>>>>>
>>>
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=BD=EF=
=BF=BD=EF=BF=BD{ay=EF=BF=BD=1D=CA=87=DA=99=EF=BF=BD,j=07=EF=BF=BD=EF=BF=BD=
f=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1E=EF=BF=
=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=0C=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=BD=
=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=07=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=DD=A2j"=EF=BF=BD=EF=BF=BD!tml=3D
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--V83f7ikVPdmVXj7s443TMSGJAFt7b1w0M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXXVbMACgkQ8dLMyEl6F22zbgCgqVt9JqO/UUeHjgXUMS1G6gbQ
tDEAnRQ6Eojjo3SJWmZSwaZ/fINYnZv2
=2g4e
-----END PGP SIGNATURE-----

--V83f7ikVPdmVXj7s443TMSGJAFt7b1w0M--
