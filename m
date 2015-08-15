From: Loic Dachary <loic@dachary.org>
Subject: Re: creating the issue for the v0.94.4 release
Date: Sat, 15 Aug 2015 18:17:11 +0200
Message-ID: <55CF6607.8010808@dachary.org>
References: <55CF14CB.1040900@dachary.org> <CAP3mxSyGkYz6vfbE4sNkV2K6iS4waBrptQ+Vnfprqc75Uc2CHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IELk7fJvn3FQOnoTdoGrIxIANlc4lMxhr"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38578 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751408AbbHOQRP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Aug 2015 12:17:15 -0400
In-Reply-To: <CAP3mxSyGkYz6vfbE4sNkV2K6iS4waBrptQ+Vnfprqc75Uc2CHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek Varshney <abhishek.varshney@flipkart.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IELk7fJvn3FQOnoTdoGrIxIANlc4lMxhr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15/08/2015 17:49, Abhishek Varshney wrote:> Hi Loic,
>=20
> Thanks for the detailed explanation. I have created an issue to keep tr=
ack of hammer v0.94.4 release here : http://tracker.ceph.com/issues/12701=
=2E  I guess the HOWTO page (http://tracker.ceph.com/projects/ceph-releas=
es/wiki/HOWTO) would be updated with this tracker issue once v0.94.3 is r=
eleased? Please correct me if I am wrong.

You are correct.

Could you also update the header http://tracker.ceph.com/issues/12701#teu=
thology-run-commit to mimic http://tracker.ceph.com/issues/11990#teutholo=
gy-run-commit-1e841b08cc9534e654de50967f06113fb7383b0chammer-backports-Ju=
ly-20 ? It should be

=2Eh3 teuthology run commit e1dadd3da9e39daf669f94715c7833d2b280bbed
(hammer backports August-14)

Because $ git rev-parse ceph/hammer-backports
e1dadd3da9e39daf669f94715c7833d2b280bbed

which is the branch you populated and that was compiled by http://ceph.co=
m/gitbuilder.cgi.

The content of this h3. section should the the output of the command=20

git --no-pager log --format=3D'%H %s' --graph ceph/hammer..ceph/hammer-ba=
ckports | perl -p -e 's/"/ /g; if (/\w+\s+Merge (\d+)/) { s|\w+\s+Merge (=
\d+).*|"Pull request $1":https://github.com/ceph/ceph/pull/$1|; } else { =
s|(\w+)\s+(.*)|"$2":https://github.com/ceph/ceph/commit/$1|; } s/\*/+/; s=
/^/* /;'

it starts with:

* +   "Pull request 5202":https://github.com/ceph/ceph/pull/5202
* |\ =20
* | + "rpm: add missing Java conditionals":https://github.com/ceph/ceph/c=
ommit/6417e8eff942dbbf6cd231ffb73136b7bdcd837f
* +   "Pull request 5203":https://github.com/ceph/ceph/pull/5203
* |\ =20
* | + "Add rpm conditionals : cephfs_java":https://github.com/ceph/ceph/c=
ommit/37284773a754ef4b91d2b5436d46a5fd2be4f67e
* +   "Pull request 5204":https://github.com/ceph/ceph/pull/5204
=2E..

and should render nicely.

This should then be followed by h4. section, one per test suite we are go=
ing to run.

h4. rbd

<pre>
=2E/virtualenv/bin/teuthology-suite --priority 1000 --suite rbd --subset =
$(expr $RANDOM % 5)/5 --suite-branch hammer --distro ubuntu --email loic@=
dachary.org --ceph hammer-backports --machine-type plana,burnupi,mira=20
</pre>

etc.

Once this is done, I will copy paste the command to actually schedule the=
 test. And then we'll have to wait a few days for it to complete.

Cheers

>=20
> Regards
> Abhishek Varshney
>=20
> On Sat, Aug 15, 2015 at 4:00 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
>=20
>     Hi Abhishek,
>=20
>     I'll be driving the next hammer point release (v0.94.4) and theanal=
yst will participate as I did for v0.94.3 (i.e. helping and mentoring whe=
n there is a need). During the v0.94.4 release you will have the opportun=
ity to participate in all the steps. When we move to v0.94.5 you'll hopef=
ully know all you need to drive it, should you want to. As you discovered=
 over the past few weeks, it's not a complex process, but there are a lot=
 of details.
>=20
>     Contrary to what I told you the other day
>=20
>     http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_bac=
kporting_a_stable_release/diff?utf8=3D%E2%9C%93&version=3D7&version_from=3D=
6&commit=3DView+differences
>=20
>     is not the documentation you need to create a new ticket for v0.94.=
4 and I removed this chapter to avoid further confusion. There is a more =
detailed explanation at:
>=20
>     http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_wor=
king_on_a_new_point_release
>=20
>     A section was added as a reminder that someone has to volunteer to =
drive the release.
>=20
>     http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_start_wor=
king_on_a_new_point_release/diff?utf8=3D%E2%9C%93&version=3D9&version_fro=
m=3D8&commit=3DView+differences
>=20
>     Let me know if you need anything else to create the issue vor v0.94=
=2E4.
>=20
>     Cheers
>     --
>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
>=20
> -----------------------------------------------------------------------=
-------------------------------------------------------------------
>=20
> This email and any files transmitted with it are confidential and inten=
ded solely for the use of the individual or entity to whom they are addre=
ssed. If you have received this email in error please notify the system m=
anager. This message contains confidential information and is intended on=
ly for the individual named. If you are not the named addressee you shoul=
d not disseminate, distribute or copy this e-mail. Please notify the send=
er immediately by e-mail if you have received this e-mail by mistake and =
delete this e-mail from your system. If you are not the intended recipien=
t you are notified that disclosing, copying, distributing or taking any a=
ction in reliance on the contents of this information is strictly prohibi=
ted. Although Flipkart has taken reasonable precautions to ensure no viru=
ses are present in this email, the company cannot accept responsibility f=
or any loss or damage arising from the use of this email or attachments
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IELk7fJvn3FQOnoTdoGrIxIANlc4lMxhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXPZggACgkQ8dLMyEl6F23FhwCfTd4orwj3Qg77bzBia8UUh5tf
WwgAnRkaNsTF9XBbYJlY7Y11n7v7HhQL
=jWOn
-----END PGP SIGNATURE-----

--IELk7fJvn3FQOnoTdoGrIxIANlc4lMxhr--
