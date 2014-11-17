From: Loic Dachary <loic@dachary.org>
Subject: Re: Question on Ceph LRC design
Date: Mon, 17 Nov 2014 11:30:12 +0100
Message-ID: <5469CE34.5060202@dachary.org>
References: <06681238D8946F44A60AA400760A1CBF01E28FBD@SHSMSX104.ccr.corp.intel.com> <06681238D8946F44A60AA400760A1CBF01E290AB@SHSMSX104.ccr.corp.intel.com>,<54694980.2010302@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE81D81C@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mC8x8LtAFu4dSo2iRno94LsRQOWbI4ECd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38133 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752016AbaKQKaP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Nov 2014 05:30:15 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE81D81C@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "Zhou, Yuan" <yuan.zhou@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mC8x8LtAFu4dSo2iRno94LsRQOWbI4ECd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


Hi Andreas,

On 17/11/2014 11:07, Andreas Joachim Peters wrote:> Hi,
>=20
> if you want to compute local parities within a plug-in library by addin=
g rows to the encoding matrix, you can still do that. If you can do LRC i=
nside the plug-in more efficienty, one should do it in the plug-in and sk=
ip the LRC layer. I have a patch to the ISA plug-in which can do LRC like=
 HDFS Xorbas encoding, but i didn't manage to express that in Loic's gene=
ric LRC layer  ... I think it is hard to formulate a generic framework to=
 define LRC as a layer on top and doing the encoding/decoding only in the=
 lowest layer.  Same problem for the shingled EC, which you cannot expres=
s in the simple LRC way ...

Could you please remind us the URL of this draft ?

>=20
> I see the current LRC layering as a generic tool to use in multi-datace=
nter setups honouring the locality of chunks because some  of the LRC opt=
imization codes break locality by cross-talk between locations, they redu=
ce the traffic but do not restrict traffic within data centers.

It certainly has its use but it would be nice to have a more specialized =
and better optimized version that implements most subtle algorithms ;-)

Cheers

>=20
> Cheers Andreas.
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 17 November 2014 02:04
> To: Zhou, Yuan; Andreas Joachim Peters
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Question on Ceph LRC design
>=20
> Hi,
>=20
> I believe Andreas has a more elaborate answer on this topic. The curren=
t implementation is not as good as what is described in the paper you men=
tion, this is correct. My incentive for chosing this path is that I was a=
ble to understand it, mainly. It is not much more than stacking layers of=
 erasure coded chunks on top of each other ;-)
>=20
> Now that we have this plugin, it would be nice to have another implemen=
tation that uses less space and possible even less network when reconstru=
cting. During the OpenStack summit we discussed this with Kevin Greenan a=
nd there are promising directions. It would help a lot to have a sample c=
ode to study so that it can be adapted to what we have currently in Ceph.=
 Do you know of such an implementation of LRC or other similar code desig=
ned to reduce the network bandwidth during reconstruction ?
>=20
> Cheers
>=20
> On 17/11/2014 01:52, Zhou, Yuan wrote:
>> Hi Loic/Anderas,
>>
>>
>>
>> I was trying to understand the LRC design in Ceph EC. Per my understan=
ding, it seems Ceph was using a slightly different design with the Micros=
oft LRC: the local parities were calculated with the global parities incl=
uded. Is there any special consideration on this change?
>>
>> I was asking because in a typical MS LRC design the global and local p=
arities could be calculated at the same time actually(I mean inside the E=
rasure Code library). But with this new design, we lost this potential op=
timization.
>>
>>
>>
>> Thanks, -Yuan
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--mC8x8LtAFu4dSo2iRno94LsRQOWbI4ECd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRpzjQACgkQ8dLMyEl6F22GuwCfeMMRd4rXvEG3LLqKdf4Bhs+a
3O8AoK7jdPtd6xBObi6Yz5UW/dMJBw92
=gFmd
-----END PGP SIGNATURE-----

--mC8x8LtAFu4dSo2iRno94LsRQOWbI4ECd--
