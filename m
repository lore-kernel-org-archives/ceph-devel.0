From: Loic Dachary <loic@dachary.org>
Subject: Re: Mojette Transform implementation
Date: Thu, 30 May 2013 17:56:32 +0200
Message-ID: <51A776B0.7060209@dachary.org>
References: <51A5E408.6070104@dachary.org> <CAD8-Aea7Z0Y40d6hTti_r+MXh0ECWazp1y0m9iYvP30qpX+LbQ@mail.gmail.com> <51A77516.2040306@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB3D479AC3330EF76E7D06E30"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:32815 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933966Ab3E3P4g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 May 2013 11:56:36 -0400
In-Reply-To: <51A77516.2040306@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pierre Evenou <pierre.evenou@rozofs.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3D479AC3330EF76E7D06E30
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Pierre,

Thanks for the pointer to
https://github.com/rozofs/rozofs/blob/master/rozofs/common/transform.c
https://github.com/rozofs/rozofs/blob/master/rozofs/common/transform.h
If I understand correctly these are the core functions implementing the a=
lgorithm. Would you advise to expose these three functions so that a thir=
d party software such as ceph use it ? Or are there more high level funct=
ions that are easier to use to do something like:

 encode(char* buffer_in, char* buffer_out[])
 decode(char* buffer_in[], char* buffer_out)=20
 repair(char* buffer_in[], char* buffer_out, int indices_of_damaged_buffe=
rs[])

Cheers

On 05/30/2013 05:49 PM, Loic Dachary wrote:
> Hi Pierre,
>=20
> I took a look at https://github.com/rozofs/rozofs/blob/master/src/rozof=
smount/rozofsmount.c#L1557
> and it gave me a high level view of the fuse bindings of rozofs, thanks=
 for this :-)
>=20
> I'm now looking into the functions that could be wrapped into a library=
 implementing Mojette Transform so that it could be used by rozofs and ce=
ph. Which file would you recommend I study for bootstraping this effort ?=

>=20
> Cheers
>=20
>=20
> On 05/29/2013 05:23 PM, Pierre Evenou wrote:
>> 2013/5/29 Loic Dachary <loic@dachary.org <mailto:loic@dachary.org>>
>>
>>     Hi Pierre,
>>
>>     As discussed today over the phone, I'm very much interested in try=
ing to reuse the Mojette Transform implementation in the context of the w=
ork related to the implementation of an erasure coded backend in Ceph. Th=
e progress can be tracked from http://tracker.ceph.com/issues/5046 and th=
e sub-tickets and the original discussion from the last Ceph summit is at=
 http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding_a=
s_a_storage_backend
>>
>>
>> Thanks for the links.
>> =20
>>
>>     I was reading the code of rbs_restore_one_rb_entry at
>>     https://github.com/rozofs/rozofs/blob/master/src/storaged/rbs.c#L1=
04
>>     and assumed the implementation is in
>>     https://github.com/rozofs/rozofs/blob/master/src/storaged/rbs_tran=
sform.h
>>     https://github.com/rozofs/rozofs/blob/master/src/storaged/rbs_tran=
sform.cc
>>
>>     And also tried to understand http://en.wikipedia.org/wiki/Mojette_=
Transform and bought "The Mojette Transform: Theory and Applications" htt=
p://eu.wiley.com/WileyCDA/WileyTitle/productCd-1848210809.html in the hop=
e to get more sense out of it ;-)
>>
>>     Is there a part of the rozofs code you would advise me to read fir=
st in order to understand how it works ?
>>
>>
>> I would recommend to have a look to rozofsmount.c witch is a key part =
in RozoFS.
>> =20
>>
>>     Cheers
>>
>>     --
>>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>     All that is necessary for the triumph of evil is that good people =
do nothing.
>>
>>
>>
>>
>> --=20
>> Pierre Evenou=E2=94=82+33.7.60.09.08.80=E2=94=82pierre.evenou@rozofs.c=
om <mailto:pierre.evenou@rozofs.com>=E2=94=82www.rozofs.com <http://www.r=
ozofs.com/>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigB3D479AC3330EF76E7D06E30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGndrEACgkQ8dLMyEl6F22rWQCfV9rjgBJgz8rZc+usmfq3wmux
x7sAoLaiObes/jAnny/7EJujs53lQs9S
=TVDL
-----END PGP SIGNATURE-----

--------------enigB3D479AC3330EF76E7D06E30--
