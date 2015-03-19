From: Loic Dachary <loic@dachary.org>
Subject: Re: conditions for removing experimental feature marks
Date: Thu, 19 Mar 2015 08:25:00 +0100
Message-ID: <550A79CC.1000306@dachary.org>
References: <870DE8DBB716524BAE51B2D499EC81E40AA6CEB8@g01jpexmbyt24> <54E1B57F.3070201@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA9678C@g01jpexmbyt24> <54FEFEC6.2080904@dachary.org> <870DE8DBB716524BAE51B2D499EC81E40AA9E155@g01jpexmbyt24> <550A77A4.3080709@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4tn83uIllfoGbSHTdFAcGTkGneOjBTQuJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60727 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750782AbbCSHZI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 03:25:08 -0400
In-Reply-To: <550A77A4.3080709@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Miyamae, Takeshi" <miyamae.takeshi@jp.fujitsu.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Shiozawa, Kensuke" <shiozawa.kennsu@jp.fujitsu.com>, "Nakao, Takanori" <nakao.takanori@jp.fujitsu.com>, "Kaga, Yoshihiro" <y-kaga@jp.fujitsu.com>, "Kawaguchi, Shotaro" <kawaguchi.s@jp.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4tn83uIllfoGbSHTdFAcGTkGneOjBTQuJ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 19/03/2015 08:15, Loic Dachary wrote:
> Hi,
>=20
> On 19/03/2015 03:20, Miyamae, Takeshi wrote:
>> Dear Loic,
>>
>> We are struggling with teuthology, but we must commit SHEC's recent pa=
tches
>> including Intel sse4 optimization into Hammer before that.
>=20
> I'd be happy to help, do you have specific questions ?
>=20
>> erasure code: fix shec performance/coding style issues #4083
>> https://github.com/ceph/ceph/pull/4083
>=20
> I think we need to split this pull request in three pull requests:=20
>=20
> * the performance optimization can go to master (and backported later t=
o hammer for the next point release)
> * the bug fix should be against hammer and be backported later to hamme=
r

Sorry, I meant to write :

* the bug fix should be against hammer

> * the coding style cleanup should be against master and preferably afte=
r any change that you'd like to backport to hammer because it makes it a =
little more difficult to backport code
>=20
>> Could you check the above pull request, please ?
>> Almost all of the modifications are for SHEC plugin's file except for =
some other
>> document files.
>=20
> Cheers
>=20
>>
>> Best regards,
>> Takeshi Miyamae
>>
>> -----Original Message-----
>> From: Loic Dachary [mailto:loic@dachary.org]=20
>> Sent: Tuesday, March 10, 2015 11:25 PM
>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B; ceph-devel@vger.ker=
nel.org
>> Cc: Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=BC=94; Nakao, Ta=
kanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94; Kaga, Yoshihiro/=E5=8A=A0=E8=
=B3=80 =E8=8A=B3=E5=AE=8F; Kawaguchi, Shotaro/=E5=B7=9D=E5=8F=A3 =E7=BF=94=
=E5=A4=AA=E6=9C=97
>> Subject: Re: conditions for removing experimental feature marks
>>
>> Hi !
>>
>> On 10/03/2015 11:35, Miyamae, Takeshi wrote:
>>> Dear Loic,
>>>
>>> I really apologize that our reply is too late.
>>> Since removing experimental flag from SHEC at v0.94 is our immediate =

>>> hope, we should have started any actions for that earlier.
>>
>> No worries, it's never too late to do good :-)
>>
>>> By the way, you mean we must add just the same workaround as 10887 fo=
r=20
>>> SHEC if our target is Hammer.
>>> Is my understanding correct ?
>>
>> What is needed is integration tests running during a few weeks and sho=
wing the plugin behaves well.=20
>>
>>>> Running teuthology locally is non trivial, maybe we can provide you =

>>>> with access to the community lab so that you can run teuthology=20
>>>> suites against the existing teuthology cluster (i.e. http://pulpito.=
ceph.com/). Would you like me to ask ?
>>>
>>> Thank you for your proposal.
>>> It would be greatly helpful if we were allowed to use it !
>>
>> Could you please connect to irc.oftc.net#sepia ? This is the IRC chann=
el where lab related matters are discussed. We can figure out the details=
 there.=20
>>
>> In the meantime you can try teuthology and write a single test quite e=
asily, on your local machine. The tricky part comes where we want to run =
suites with large number of jobs. You can adapt the instructions from htt=
p://dachary.org/?p=3D2204 to your local environment. All you need really =
is the ability to run two virtual machines.
>>
>> Cheers
>>
>>>
>>> Best regards,
>>> Takeshi Miyamae
>>>
>>> -----Original Message-----
>>> From: Loic Dachary [mailto:loic@dachary.org]
>>> Sent: Monday, February 16, 2015 6:17 PM
>>> To: Miyamae, Takeshi/=E5=AE=AE=E5=89=8D =E5=89=9B; ceph-devel@vger.ke=
rnel.org
>>> Cc: Shiozawa, Kensuke/=E5=A1=A9=E6=B2=A2 =E8=B3=A2=E8=BC=94; Nakao, T=
akanori/=E4=B8=AD=E5=B0=BE =E9=B7=B9=E8=A9=94
>>> Subject: Re: conditions for removing experimental feature marks
>>>
>>> Hi,
>>>
>>> On 16/02/2015 08:37, Miyamae, Takeshi wrote:
>>>> Dear Loic,
>>>>
>>>> Thank you for your help on the pull request of SHEC last week.
>>>> We believe that marking experimental feature on SHEC was inevitable =

>>>> and the way to restrict the feature is proper.
>>>>
>>>> By the way, could you let us know what are the conditions for=20
>>>> removing experimental feature marks in the future?
>>>> Are additional thorough tests required?
>>>
>>> The next step is to run integration tests with the shec plugin. The i=
ntegration tests have shown that the shec plugin does not disrupt anythin=
g. Now we should check if it works properly under stress and upgrades. I =
created two tickets for that purpose:
>>>
>>> http://tracker.ceph.com/issues/10886 : integration / theuthology=20
>>> integration / theuthology thrasher tests for the shec erasure code=20
>>> plugin
>>> http://tracker.ceph.com/issues/10887 : erasure-code: allow upgrades=20
>>> for shec plugins
>>>
>>> It would be fantastic if you could work on http://tracker.ceph.com/is=
sues/7291 : it would make the integration of new erasure code plugins eas=
ier. I realize that it is infrastructure work not directly of interest to=
 the shec plugin implementation.
>>>
>>> Running teuthology locally is non trivial, maybe we can provide you w=
ith access to the community lab so that you can run teuthology suites aga=
inst the existing teuthology cluster (i.e. http://pulpito.ceph.com/). Wou=
ld you like me to ask ?=20
>>>
>>> Cheers
>>>
>>>> Best regards,
>>>> Takeshi Miyamae
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =1D=CA=87=DA=99=
 ,j   f   h   z =1E w  =20
>>    j:+v   w j m         zZ+     =DD=A2j"  !tml=3D
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--4tn83uIllfoGbSHTdFAcGTkGneOjBTQuJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUKecwACgkQ8dLMyEl6F237qACfTO42H9c4/vlaqLjLWmf5R/2d
odEAoJsysO24E1Ch7lHbwyKm5vIbkN/X
=rG8j
-----END PGP SIGNATURE-----

--4tn83uIllfoGbSHTdFAcGTkGneOjBTQuJ--
