From: Loic Dachary <loic@dachary.org>
Subject: Re: rbd: default map options, new options, misc (Re: creating the
 issue for the v0.94.4 release)
Date: Mon, 17 Aug 2015 19:41:02 +0200
Message-ID: <55D21CAE.10601@dachary.org>
References: <91df434f-d3ac-49b1-98b6-b7c2a966a4e0@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="QENmr46NsJf13wPmxFcdDGmLsaE1jfmkw"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39305 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750764AbbHQRlL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Aug 2015 13:41:11 -0400
In-Reply-To: <91df434f-d3ac-49b1-98b6-b7c2a966a4e0@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QENmr46NsJf13wPmxFcdDGmLsaE1jfmkw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17/08/2015 18:31, Josh Durgin wrote:
> Yes, this would make sense in firefly too, since it's useful for newer =
kernels regardless of ceph userspace versions.

Ok, I'll schedule it for backport. Is there an issue associated to this p=
ull request ?

> *From:* Loic Dachary <loic@dachary.org>
> *Sent:* Aug 17, 2015 12:10 PM
> *To:* Josh Durgin
> *Cc:* Alexandre DERUMIER; ceph-devel
> *Subject:* rbd: default map options, new options, misc (Re: creating th=
e issue for the v0.94.4 release)
>=20
>     Hi Josh,
>=20
>     Do you think it would make sense to backport https://github.com/cep=
h/ceph/pull/3979 to hammer ?
>=20
>     Cheers
>=20
>     On 17/08/2015 15:51, Alexandre DERUMIER wrote:
>     > Hi Loic,
>     >
>     > I wonder if we could backport
>     >
>     > https://github.com/ceph/ceph/pull/3979
>     >
>     > to hammer.
>     >
>     > It's mainly to add support to last kernels to cephx_require_signa=
ture and tcp_nodelay mount options.
>     >
>     >
>     > For example since kernel 3.19, cephx_require_signatures is the de=
fault,
>     > and they are no way to mount a rbd device without cephx_require_s=
ignature, with current hammer "rbd map ..."
>     >
>     > Regards,
>     >
>     > alexandre
>     >
>     >
>     > ----- Mail original -----
>     > De: "Loic Dachary" <loic@dachary.org>
>     > =C3=80: "Abhishek Varshney" <abhishek.varshney@flipkart.com>
>     > Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
>     > Envoy=C3=A9: Samedi 15 Ao=C3=BBt 2015 22:15:21
>     > Objet: Re: creating the issue for the v0.94.4 release
>     >
>     > Hi,
>     >
>     > On 15/08/2015 19:54, Abhishek Varshney wrote:
>     >> Done ! Let me know if it is fine.
>     >
>     > Perfect ! I have run the commands for you and the corresponding s=
uite can be seen at http://pulpito.ceph.com/. We usually add a link to ea=
ch h4. with something like:
>     >
>     > * *running* http://pulpito.ceph.com/loic-2015-08-15_22:00:55-rado=
s-hammer-backports---basic-multi
>     >
>     > etc. I expect teuthology will do something similar eventually but=
 right now we have to do that manually.
>     >
>     > As much as I like to be your command line proxy, things will be e=
asier if you can run those yourself in the future ;-) I opened an issue t=
o that end at http://tracker.ceph.com/issues/12705. The staff in charge o=
f the sepia lab is extremely busy and it may take a few weeks before you =
actually have access.
>     >
>     > Cheers
>     >
>     >>
>     >> Thanks
>     >> Abhishek
>     >>
>     >> On Sat, Aug 15, 2015 at 9:47 PM, Loic Dachary <loic@dachary.org =
<mailto:loic@dachary.org>> wrote:
>     >>
>     >>
>     >>
>     >> On 15/08/2015 17:49, Abhishek Varshney wrote:> Hi Loic,
>     >>>
>     >>> Thanks for the detailed explanation. I have created an issue to=
 keep track of hammer v0.94.4 release here : http://tracker.ceph.com/issu=
es/12701. I guess the HOWTO page (http://tracker.ceph.com/projects/ceph-r=
eleases/wiki/HOWTO) would be updated with this tracker issue once v0.94.3=
 is released? Please correct me if I am wrong.
>     >>
>     >> You are correct.
>     >>
>     >> Could you also update the header http://tracker.ceph.com/issues/=
12701#teuthology-run-commit to mimic http://tracker.ceph.com/issues/11990=
#teuthology-run-commit-1e841b08cc9534e654de50967f06113fb7383b0chammer-bac=
kports-July-20 ? It should be
>     >>
>     >> .h3 teuthology run commit e1dadd3da9e39daf669f94715c7833d2b280bb=
ed
>     >> (hammer backports August-14)
>     >>
>     >> Because $ git rev-parse ceph/hammer-backports
>     >> e1dadd3da9e39daf669f94715c7833d2b280bbed
>     >>
>     >> which is the branch you populated and that was compiled by http:=
//ceph.com/gitbuilder.cgi.
>     >>
>     >> The content of this h3. section should the the output of the com=
mand
>     >>
>     >> git --no-pager log --format=3D'%H %s' --graph ceph/hammer..ceph/=
hammer-backports | perl -p -e 's/"/ /g; if (/\w+\s+Merge (\d+)/) { s|\w+\=
s+Merge (\d+).*|"Pull request $1":https://github.com/ceph/ceph/pull/$1|; =
} else { s|(\w+)\s+(.*)|"$2":https://github.com/ceph/ceph/commit/$1|; } s=
/\*/+/; s/^/* /;'
>     >>
>     >> it starts with:
>     >>
>     >> * + "Pull request 5202":https://github.com/ceph/ceph/pull/5202
>     >> * |\
>     >> * | + "rpm: add missing Java conditionals":https://github.com/ce=
ph/ceph/commit/6417e8eff942dbbf6cd231ffb73136b7bdcd837f
>     >> * + "Pull request 5203":https://github.com/ceph/ceph/pull/5203
>     >> * |\
>     >> * | + "Add rpm conditionals : cephfs_java":https://github.com/ce=
ph/ceph/commit/37284773a754ef4b91d2b5436d46a5fd2be4f67e
>     >> * + "Pull request 5204":https://github.com/ceph/ceph/pull/5204
>     >> ...
>     >>
>     >> and should render nicely.
>     >>
>     >> This should then be followed by h4. section, one per test suite =
we are going to run.
>     >>
>     >> h4. rbd
>     >>
>     >> <pre>
>     >> ./virtualenv/bin/teuthology-suite --priority 1000 --suite rbd --=
subset $(expr $RANDOM % 5)/5 --suite-branch hammer --distro ubuntu --emai=
l loic@dachary.org <mailto:loic@dachary.org> --ceph hammer-backports --ma=
chine-type plana,burnupi,mira
>     >> </pre>
>     >>
>     >> etc.
>     >>
>     >> Once this is done, I will copy paste the command to actually sch=
edule the test. And then we'll have to wait a few days for it to complete=
=2E
>     >>
>     >> Cheers
>     >>
>     >>>
>     >>> Regards
>     >>> Abhishek Varshney
>     >>>
>     >>> On Sat, Aug 15, 2015 at 4:00 PM, Loic Dachary <loic@dachary.org=
 <mailto:loic@dachary.org> <mailto:loic@dachary.org <mailto:loic@dachary.=
org>>> wrote:
>     >>>
>     >>> Hi Abhishek,
>     >>>
>     >>> I'll be driving the next hammer point release (v0.94.4) and the=
analyst will participate as I did for v0.94.3 (i.e. helping and mentoring=
 when there is a need). During the v0.94.4 release you will have the oppo=
rtunity to participate in all the steps. When we move to v0.94.5 you'll h=
opefully know all you need to drive it, should you want to. As you discov=
ered over the past few weeks, it's not a complex process, but there are a=
 lot of details.
>     >>>
>     >>> Contrary to what I told you the other day
>     >>>
>     >>> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start=
_backporting_a_stable_release/diff?utf8=3D%E2%9C%93&version=3D7&version_f=
rom=3D6&commit=3DView+differences
>     >>>
>     >>> is not the documentation you need to create a new ticket for v0=
=2E94.4 and I removed this chapter to avoid further confusion. There is a=
 more detailed explanation at:
>     >>>
>     >>> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start=
_working_on_a_new_point_release
>     >>>
>     >>> A section was added as a reminder that someone has to volunteer=
 to drive the release.
>     >>>
>     >>> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start=
_working_on_a_new_point_release/diff?utf8=3D%E2%9C%93&version=3D9&version=
_from=3D8&commit=3DView+differences
>     >>>
>     >>> Let me know if you need anything else to create the issue vor v=
0.94.4.
>     >>>
>     >>> Cheers
>     >>> --
>     >>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     >>>
>     >>>
>     >>>
>     >>> ---------------------------------------------------------------=
-------------------------------------------------------------------------=
--
>     >>>
>     >>> This email and any files transmitted with it are confidential a=
nd intended solely for the use of the individual or entity to whom they a=
re addressed. If you have received this email in error please notify the =
system manager. This message contains confidential information and is int=
ended only for the individual named. If you are not the named addressee y=
ou should not disseminate, distribute or copy this e-mail. Please notify =
the sender immediately by e-mail if you have received this e-mail by mist=
ake and delete this e-mail from your system. If you are not the intended =
recipient you are notified that disclosing, copying, distributing or taki=
ng any action in reliance on the contents of this information is strictly=
 prohibited. Although Flipkart has taken reasonable precautions to ensure=
 no viruses are present in this email, the company cannot accept responsi=
bility for any loss or damage arising from the use of this email or attac=
hments
>     >>>
>     >>
>     >> --
>     >> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>     >>
>     >>
>     >>
>     >> ----------------------------------------------------------------=
-------------------------------------------------------------------------=
-
>     >>
>     >> This email and any files transmitted with it are confidential an=
d intended solely for the use of the individual or entity to whom they ar=
e addressed. If you have received this email in error please notify the s=
ystem manager. This message contains confidential information and is inte=
nded only for the individual named. If you are not the named addressee yo=
u should not disseminate, distribute or copy this e-mail. Please notify t=
he sender immediately by e-mail if you have received this e-mail by mista=
ke and delete this e-mail from your system. If you are not the intended r=
ecipient you are notified that disclosing, copying, distributing or takin=
g any action in reliance on the contents of this information is strictly =
prohibited. Although Flipkart has taken reasonable precautions to ensure =
no viruses are present in this email, the company cannot accept responsib=
ility for any loss or damage arising from the use of this email or attach=
ments
>     >>
>     >
>=20
>     --=20
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--QENmr46NsJf13wPmxFcdDGmLsaE1jfmkw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXSHK4ACgkQ8dLMyEl6F20I5ACeOjLnq+ZdSGs22wV9kcSeAwMv
IS4An2Jz7eCT1h1EDWVmcS20d2wnoCwU
=oh44
-----END PGP SIGNATURE-----

--QENmr46NsJf13wPmxFcdDGmLsaE1jfmkw--
