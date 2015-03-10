From: Loic Dachary <loic@dachary.org>
Subject: Re: conditions for removing experimental feature marks
Date: Tue, 10 Mar 2015 15:25:10 +0100
Message-ID: <54FEFEC6.2080904@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA6CEB8@g01jpexmbyt24> <54E1B57F.3070201@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA9678C@g01jpexmbyt24>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sAjlW79ciFSHdJOUpBRPvgaAXFHGt0GXP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55863 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752977AbbCJOZO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2015 10:25:14 -0400
In-Reply-To: <870DE8DBB716524BAE51B2D499EC81E40AA9678C@g01jpexmbyt24>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sAjlW79ciFSHdJOUpBRPvgaAXFHGt0GXP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi !

On 10/03/2015 11:35, Miyamae, Takeshi wrote:
> Dear Loic,
>=20
> I really apologize that our reply is too late.
> Since removing experimental flag from SHEC at v0.94 is our immediate ho=
pe, we should
> have started any actions for that earlier.

No worries, it's never too late to do good :-)

> By the way, you mean we must add just the same workaround as 10887 for =
SHEC
> if our target is Hammer.
> Is my understanding correct ?

What is needed is integration tests running during a few weeks and showin=
g the plugin behaves well.=20

>> Running teuthology locally is non trivial, maybe we can provide you wi=
th access to the
>> community lab so that you can run teuthology suites against the existi=
ng teuthology cluster
>> (i.e. http://pulpito.ceph.com/). Would you like me to ask ?
>=20
> Thank you for your proposal.
> It would be greatly helpful if we were allowed to use it !

Could you please connect to irc.oftc.net#sepia ? This is the IRC channel =
where lab related matters are discussed. We can figure out the details th=
ere.=20

In the meantime you can try teuthology and write a single test quite easi=
ly, on your local machine. The tricky part comes where we want to run sui=
tes with large number of jobs. You can adapt the instructions from http:/=
/dachary.org/?p=3D2204 to your local environment. All you need really is =
the ability to run two virtual machines.

Cheers

>=20
> Best regards,
> Takeshi Miyamae
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Monday, February 16, 2015 6:17 PM
> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B; ceph-devel@vger.kern=
el.org
> Cc: Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=BC=94; Nakao, Tak=
anori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94
> Subject: Re: conditions for removing experimental feature marks
>=20
> Hi,
>=20
> On 16/02/2015 08:37, Miyamae, Takeshi wrote:
>> Dear Loic,
>>
>> Thank you for your help on the pull request of SHEC last week.
>> We believe that marking experimental feature on SHEC was inevitable=20
>> and the way to restrict the feature is proper.
>>
>> By the way, could you let us know what are the conditions for removing=
=20
>> experimental feature marks in the future?
>> Are additional thorough tests required?
>=20
> The next step is to run integration tests with the shec plugin. The int=
egration tests have shown that the shec plugin does not disrupt anything.=
 Now we should check if it works properly under stress and upgrades. I cr=
eated two tickets for that purpose:
>=20
> http://tracker.ceph.com/issues/10886 : integration / theuthology integr=
ation / theuthology thrasher tests for the shec erasure code plugin
> http://tracker.ceph.com/issues/10887 : erasure-code: allow upgrades for=
 shec plugins
>=20
> It would be fantastic if you could work on http://tracker.ceph.com/issu=
es/7291 : it would make the integration of new erasure code plugins easie=
r. I realize that it is infrastructure work not directly of interest to t=
he shec plugin implementation.
>=20
> Running teuthology locally is non trivial, maybe we can provide you wit=
h access to the community lab so that you can run teuthology suites again=
st the existing teuthology cluster (i.e. http://pulpito.ceph.com/). Would=
 you like me to ask ?=20
>=20
> Cheers
>=20
>> Best regards,
>> Takeshi Miyamae
>>
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


--sAjlW79ciFSHdJOUpBRPvgaAXFHGt0GXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT+/sYACgkQ8dLMyEl6F20toACfdrpXw5DUm6aQPcYRHqrhLO41
Ke8AniFWUYNp2ioqlP+5t+QdhTlz0oha
=8i+E
-----END PGP SIGNATURE-----

--sAjlW79ciFSHdJOUpBRPvgaAXFHGt0GXP--
