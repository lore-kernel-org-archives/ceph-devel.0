From: Loic Dachary <loic@dachary.org>
Subject: Re: Analyzing the nightlies
Date: Sun, 10 May 2015 21:33:24 +0200
Message-ID: <554FB284.203@dachary.org>
References: <554DD3D7.7090407@dachary.org> <950294072.16669358.1431217671812.JavaMail.zimbra@redhat.com> <554F15DE.40401@dachary.org> <66830824.16753637.1431283933813.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NRSHhEFSSKdnsdcm04s841E4VtNtcdwhi"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60805 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751469AbbEJTd1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 May 2015 15:33:27 -0400
In-Reply-To: <66830824.16753637.1431283933813.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NRSHhEFSSKdnsdcm04s841E4VtNtcdwhi
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 10/05/2015 20:52, Yuri Weinstein wrote:
> See inline
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Sunday, May 10, 2015 1:25:02 AM
> Subject: Re: Analyzing the nightlies
>=20
> Hi Yuri,
>=20
> On 10/05/2015 02:27, Yuri Weinstein wrote:
>> Loic=20
>>
>> You description on high level is correct.  There are, of cause, more d=
etails when someone actually goes thru the nightlies results.
>>
>> As far as you question "Is there a time like bug scrubbing or sprint p=
lanning when developers say "Let's analyze QA results and dig bugs" ?" - =
I surely hope so and do see updates and triages on bugs in the tracker, b=
ut not 100% sure what exactly our process is, so Sage and development lea=
ds are better persons to ask this.
>>
>> Also when you say "What I'm not sure about is if it's best effort ? " =
 - do you have something in mind instead or in addition to what we do now=
?
>> ( I hope something that can lighten the burden :) )
>=20
> It would make sense for the "Stable releases and backports" team to mon=
itor the nightlies. Not on a daily basis because it would be too much wor=
k (there are only a few of us right now). But after merges to the stable =
branch, I think we should monitor the nightlies that could be impacted. H=
ere is an example:
>=20
> * 20 pull requests from rgw, rbd, fs, rados are merged in the integrati=
on branch (the nightlies don't see it)
> * the rgw, rbd, fs, rados suites run on the integration branch and succ=
eed
> * the 20 pull requests are merged (after approval by the original devel=
oper and the lead if it was backported by someone from the "Stable releas=
es and backports" team). This typically happens withink two or three days=
=2E
> * the nightlies will run on a stable branch in which 20 pull requests h=
ave been merged
> * if a jobs fails because of on of these 20 pull requests, the person i=
n charge of the stable branch is likely to be in a good position to figur=
e out where it comes from
>=20
> I keep an eye on your comments on a daily basis, but I think I should p=
ay attention more closely. I guess the amount of output is intimidating a=
nd it's difficult to figure out how to contribute usefully when you only =
have one or two hours a week to devote to this.=20
>=20
> What do you think ?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I Think it's a good idea.
>=20
> Two points for consideration:
>=20
> - we need to coordinate those activities in such a way so we use our la=
bs resources very conservatively

I don't think we plan to add anything to the nightlies.

> - (related go the point above) - we tend to have "stable" related sched=
uled in the Octo lab, how will that work out for the "Stable releases and=
 backports" team?

We would just help with analyzing the existing nightlies.

Cheers

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =20
>=20
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yuri Weinstein" <yweinste@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Saturday, May 9, 2015 2:31:03 AM
>> Subject: Analyzing the nightlies
>>
>> Hi Yuri,
>>
>> It would be useful to add more information bout how the nightlies are =
analyzed at
>>
>>    http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_monitor_t=
he_automated_tests_AKA_nightlies
>>
>> At this point my understanding is that you look over all of them and y=
ou carry the burden of=20
>>
>> * sorting out the environmental noise
>> * creating new bugs for errors for which there is no match in the trac=
ker
>> * add a link to the failed job in pre-existing issues found in the tra=
cker (useful to figure out the frequency and helps with debug when there =
are multiple outputs / logs)
>>
>> You do so by using tools such as https://github.com/jcsp/scrape/blob/m=
aster/scrape.py and maybe others and you also format your mail messages s=
o that they can be parsed by a program (although such a program does not =
exist yet, it could go over all your messages and build a database from t=
he mails you sent).
>>
>> In the http://lists.ceph.com/private.cgi/ceph-qa-ceph.com/ archives, I=
 see that Greg also regularly goes over the errors and other developers a=
lso do. What I'm not sure about is if it's best effort ? Is there a time =
like bug scrubbing or sprint planning when developers say "Let's analyze =
QA results and dig bugs" ?
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--NRSHhEFSSKdnsdcm04s841E4VtNtcdwhi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVPsoQACgkQ8dLMyEl6F20wsACdE3oVLMYU91FWfqUkEtFryOPt
BVQAn2d7u6WTjMHmMXSIm38qDeWm9vI9
=4Lvj
-----END PGP SIGNATURE-----

--NRSHhEFSSKdnsdcm04s841E4VtNtcdwhi--
