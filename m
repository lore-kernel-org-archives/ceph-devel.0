From: Loic Dachary <loic@dachary.org>
Subject: Re: backporting script
Date: Sun, 10 May 2015 12:09:50 +0200
Message-ID: <554F2E6E.6090608@dachary.org>
References: <CABNx+P820e=NOB9dvf-Pox+NaT3pL6ccveMUTzoOyqa2+ZU-4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SxLHmhHr6J0V6VbWLE0Mi0sluqFw7aEU7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60681 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752178AbbEJKJ5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 10 May 2015 06:09:57 -0400
In-Reply-To: <CABNx+P820e=NOB9dvf-Pox+NaT3pL6ccveMUTzoOyqa2+ZU-4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <presnypreklad@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SxLHmhHr6J0V6VbWLE0Mi0sluqFw7aEU7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[cc'ing ceph-devel for archive]

Hi Nathan,

I've ran into this problem also and manually fixed the title... which is =
not great. Your fix is better :-) I think you have permission to update

    http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_backport_co=
mmits

with your improvements. Let me know if that's not the case.

Cheers

On 10/05/2015 11:35, Nathan Cutler wrote:
> Hi Loic:
>=20
> In your script at
> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_backport_comm=
its
>=20
> you have this line:
>=20
> eval title=3D$(curl --silent
> 'http://tracker.ceph.com/issues/'$issue.json?key=3D$redmine_key | jq
> .issue.subject) ; echo $title
>=20
> I found that when the title string contains double-quote characters --
> like, for example, in this commit:
> https://github.com/ceph/ceph/commit/fdd7f8d83afa25c4e09aaedd90ab93f3b64=
a677b
> -- the double quote characters cause the script to break in the next
> line:
>=20
> number=3D$(curl --silent --data-binary
> '{"title":"'"$title"'","head":"'$github_user':wip-'$issue-$release'","b=
ase":"'$release'","body":"http://tracker.ceph.com/issues/'$issue'"}'
> 'https://api.github.com/repos/ceph/ceph/pulls?access_token=3D'$github_t=
oken
> | jq .number)
>=20
> because api.github.com sends back a 400 reponse (JSON not parseable).
>=20
> For now I have "fixed" this issue by changing the code to look like thi=
s:
>=20
> title=3D$(curl --silent
> 'http://tracker.ceph.com/issues/'$issue.json?key=3D$redmine_key | jq
> .issue.subject | tr -d '\\"')
> echo "Issue title: $title"
> number=3D$(curl --silent --data-binary
> '{"title":"'"$title"'","head":"'$github_repo':wip-'$issue-$release'","b=
ase":"'$release'","body":"http://tracker.ceph.com/issues/'$issue'"}'
> 'https://api.github.com/repos/ceph/ceph/pulls?access_token=3D'$github_t=
oken
> | jq .number)
> echo "Opened pull request $number"
>=20
> Sorry if the code is not readable -> here is the same code in a pastebi=
n:
>=20
> http://pastebin.com/LjfqaidV
>=20
> Regards,
> Nathan
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--SxLHmhHr6J0V6VbWLE0Mi0sluqFw7aEU7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVPLm4ACgkQ8dLMyEl6F22RKQCffzWfN6TpxcuyhAA4yvIW3Ael
1QQAmwdm5ZvKxyRcAdjOLWleOGvWv9IT
=pbve
-----END PGP SIGNATURE-----

--SxLHmhHr6J0V6VbWLE0Mi0sluqFw7aEU7--
