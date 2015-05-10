From: Loic Dachary <loic@dachary.org>
Subject: Re: Analyzing the nightlies
Date: Sun, 10 May 2015 10:25:02 +0200
Message-ID: <554F15DE.40401@dachary.org>
References: <554DD3D7.7090407@dachary.org> <950294072.16669358.1431217671812.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IjMB6Kd78EWSVSF1jbuO7kUOek1qSksNd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60653 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752072AbbEJIZF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 May 2015 04:25:05 -0400
In-Reply-To: <950294072.16669358.1431217671812.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IjMB6Kd78EWSVSF1jbuO7kUOek1qSksNd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yuri,

On 10/05/2015 02:27, Yuri Weinstein wrote:
> Loic=20
>=20
> You description on high level is correct.  There are, of cause, more de=
tails when someone actually goes thru the nightlies results.
>=20
> As far as you question "Is there a time like bug scrubbing or sprint pl=
anning when developers say "Let's analyze QA results and dig bugs" ?" - I=
 surely hope so and do see updates and triages on bugs in the tracker, bu=
t not 100% sure what exactly our process is, so Sage and development lead=
s are better persons to ask this.
>=20
> Also when you say "What I'm not sure about is if it's best effort ? "  =
- do you have something in mind instead or in addition to what we do now?=

> ( I hope something that can lighten the burden :) )

It would make sense for the "Stable releases and backports" team to monit=
or the nightlies. Not on a daily basis because it would be too much work =
(there are only a few of us right now). But after merges to the stable br=
anch, I think we should monitor the nightlies that could be impacted. Her=
e is an example:

* 20 pull requests from rgw, rbd, fs, rados are merged in the integration=
 branch (the nightlies don't see it)
* the rgw, rbd, fs, rados suites run on the integration branch and succee=
d
* the 20 pull requests are merged (after approval by the original develop=
er and the lead if it was backported by someone from the "Stable releases=
 and backports" team). This typically happens withink two or three days.
* the nightlies will run on a stable branch in which 20 pull requests hav=
e been merged
* if a jobs fails because of on of these 20 pull requests, the person in =
charge of the stable branch is likely to be in a good position to figure =
out where it comes from

I keep an eye on your comments on a daily basis, but I think I should pay=
 attention more closely. I guess the amount of output is intimidating and=
 it's difficult to figure out how to contribute usefully when you only ha=
ve one or two hours a week to devote to this.=20

What do you think ?

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Saturday, May 9, 2015 2:31:03 AM
> Subject: Analyzing the nightlies
>=20
> Hi Yuri,
>=20
> It would be useful to add more information bout how the nightlies are a=
nalyzed at
>=20
>    http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_monitor_th=
e_automated_tests_AKA_nightlies
>=20
> At this point my understanding is that you look over all of them and yo=
u carry the burden of=20
>=20
> * sorting out the environmental noise
> * creating new bugs for errors for which there is no match in the track=
er
> * add a link to the failed job in pre-existing issues found in the trac=
ker (useful to figure out the frequency and helps with debug when there a=
re multiple outputs / logs)
>=20
> You do so by using tools such as https://github.com/jcsp/scrape/blob/ma=
ster/scrape.py and maybe others and you also format your mail messages so=
 that they can be parsed by a program (although such a program does not e=
xist yet, it could go over all your messages and build a database from th=
e mails you sent).
>=20
> In the http://lists.ceph.com/private.cgi/ceph-qa-ceph.com/ archives, I =
see that Greg also regularly goes over the errors and other developers al=
so do. What I'm not sure about is if it's best effort ? Is there a time l=
ike bug scrubbing or sprint planning when developers say "Let's analyze Q=
A results and dig bugs" ?
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IjMB6Kd78EWSVSF1jbuO7kUOek1qSksNd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVPFd4ACgkQ8dLMyEl6F23w2QCfefkOlkJSfpMTx2T3dafBosoz
GJgAn2I0VtmhCOryxiypHALFVz6QKqzG
=VtqZ
-----END PGP SIGNATURE-----

--IjMB6Kd78EWSVSF1jbuO7kUOek1qSksNd--
