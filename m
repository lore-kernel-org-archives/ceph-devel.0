From: Loic Dachary <loic@dachary.org>
Subject: Re: civetweb upstream/downstream divergence
Date: Fri, 30 Oct 2015 17:00:01 +0900
Message-ID: <56332381.4060204@dachary.org>
References: <5631E4A5.9020003@suse.cz>	<CADRKj5T5ZZBb+Mhut2jnzKoBEtTjw0tGWptqWVamgoLWaQfpgQ@mail.gmail.com> <20151029225738.51b8b2e5@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uq05oMCxnSXQtS0ljFrN3aheavoxLVGGK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52312 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758633AbbJ3IAG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Oct 2015 04:00:06 -0400
In-Reply-To: <20151029225738.51b8b2e5@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uq05oMCxnSXQtS0ljFrN3aheavoxLVGGK
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Pete,

On 30/10/2015 13:57, Pete Zaitcev wrote:
> On Thu, 29 Oct 2015 10:58:07 -0700
> Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:
>=20
>> We should definitely do it. We're based off civetweb 1.6, and there
>> was no official civetweb version for quite a while, but 1.7 was tagged=

>> a few months ago. I made some effort and got most of our material
>> changes upstream, however, there are some changes that might need some=

>> more work before we can get them merged, or might not make complete
>> sense at all.
>=20
> I take it Nathan is volunteering to parse the delta into logical pieces=

> and identify what upstream is willing to accept, right?

I've discussed with Nathan about this general problem a few times. The is=
sue is much less about volunteering and much more about how to track the =
progress of the delta over time.

> Dunno about SuSE, but as a Fedora packager I would prefer if we (Ceph)
> talked upstream into making regular releases and then for us to stop
> carrying it entirely. One less git submodule if nothing else.

Right now we have no method. For the jerasure / gf-complete sub-modules, =
I'm watching the delta and do the right thing but it's mostly an unwritte=
n process: someone else would do it completely differently. For other Cep=
h sub-modules I suppose each developer has his own way of dealing with th=
e delta.I remember Sage recently proposed patches upstream for rocksdb bu=
t I'm unaware of where or how. I would not be able to help him in any way=
=2E And I don't think anyone could figure out exactly how to deal with th=
e jerasure / gf-complete sub-modules either.

Do you happen to know a project that is using submodules (or copies of pr=
ojects instead of dependencies) and that is also well organized to track =
the delta ?

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--uq05oMCxnSXQtS0ljFrN3aheavoxLVGGK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYzI4EACgkQ8dLMyEl6F22UbgCfU75sBwHiLYwvbLvroD7/hhEB
1k0An1OspZ4Kq3HzBQegxzFsmBYjdt35
=6pgl
-----END PGP SIGNATURE-----

--uq05oMCxnSXQtS0ljFrN3aheavoxLVGGK--
