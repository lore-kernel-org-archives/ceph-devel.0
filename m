From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph Puppet modules (again)
Date: Mon, 10 Mar 2014 19:27:29 +0100
Message-ID: <531E0411.9080002@dachary.org>
References: <CAPUexz9vuQ7Z91i8wwR1d9heuvkmTp9=q4GSRkNZaMV2M4Tz1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7lIQBGgdS7FhjKI0gpkoQkC7v4aN4wVJT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:38652 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663AbaCJS1b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Mar 2014 14:27:31 -0400
In-Reply-To: <CAPUexz9vuQ7Z91i8wwR1d9heuvkmTp9=q4GSRkNZaMV2M4Tz1Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7lIQBGgdS7FhjKI0gpkoQkC7v4aN4wVJT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Florian,

New efforts should be directed to=20

https://github.com/stackforge/puppet-ceph (mirrored at https://github.com=
/ceph/puppet-ceph) and evolving at https://review.openstack.org/#/q/statu=
s:open+project:stackforge/puppet-ceph,n,z

I'm happily developing it with Andrew Woodward and David Simard and quite=
 happy about how its future looks like. It will eventually unite all othe=
r modules and benefit from a proper integration test environment. I've be=
en distressed far too often by the lack of integration tests when writing=
 puppet modules. It makes all the difference in the world to me, although=
 it's not currently popular among puppet module developers, to the point =
that the official tool (beaker) can't allocate a disk when creating an in=
stance (!). I wrote a tiny tool https://pypi.python.org/pypi/gerritexec t=
o listen to gerrit events, a simple one liner that actually runs the pupp=
et modules for osd/mon on cuttlefish/dumpling/emperor in various situatio=
ns.

When working on puppet-ceph, my efforts are often directed to patching Ce=
ph itself to make it more amicable to configuration management systems. "=
ceph-disk: prepare should be idempotent" is one example at http://tracker=
=2Eceph.com/issues/7475. But you will find a number of patches in Firefly=
 oriented toward this goal. I believe this will also help reduce the comp=
lexity of the Chef, Ansible, Salt, ... playcookbooks (;-), in the same wa=
y hiding osd ids from them resolved a number of unnecessary problems for =
all of them (although some of them did not evolve to take advantage of it=
 and are still overcomplex).

=46rom the point of view of someone in a hurry and no time to develop, wh=
at I'm doing it not useable at the moment. I'm under no pressure to rush =
anything and won't commit to any deadline ;-) However, if a developer is =
willing to help out, I'd be happy to spare the time to get her/him on boa=
rd and speed up the process.

Cheers

On 10/03/2014 17:21, Florian Haas wrote:
> Hi,
>=20
> Somehow I'm thinking I'm opening a can of worms, but here it goes
> anyway. I saw some discussion about this here on this list last
> (Northern Hemisphere) autumn, but not much since.
>=20
> I'd like to ask for some clarification on the current state of the
> Ceph Puppet modules. Currently there are several: one on StackForge
> (http://git.openstack.org/cgit/stackforge/puppet-ceph/), primarily
> written by Lo=C3=AFc Dachary, and one on the eNovance GitHub repo
> (https://github.com/enovance/puppet-ceph), written by S=C3=A9bastien Ha=
n
> and Fran=C3=A7ois Charlier. The eNovance repo is AGPL licensed, which I=

> find rather incomprehensible =E2=80=94 the only thing this would make s=
ense
> for would be to force providers of *public* Puppet hosts to contribute
> back upstream, but that's a really far fetched use case. The
> StackForge repo is ASL licensed, which looks a bit saner.
>=20
> Then there is a TelekomCloud fork of the eNovance repo at
> https://github.com/TelekomCloud/puppet-ceph/tree/rc/eisbrecher, with
> 55 unmerged patches. Also AGPL, as far as I can tell.
>=20
> And finally there's puppet-cephdeploy
> (https://github.com/dontalton/puppet-cephdeploy) where I like that it
> builds upon ceph-deploy, but rather dislike that it's rather closely
> interwoven with OpenStack. ASL.
>=20
> Finally, after the discussion that Lo=C3=AFc kicked off in
> https://www.mail-archive.com/ceph-devel@vger.kernel.org/msg16673.html,
> there's https://github.com/ceph/puppet-ceph which hasn't seen any
> updates in 2 months. This is a mirror of the StackForge module, as far
> as I can tell, is ASL licensed and has seen neither the eNovance work
> nor the TelekomCloud updates, presumably on account of the license
> issue.
>=20
> Neither repo seems to be universally accepted and fully complete
> (StackForge only supports mon deployment; eNovance doesn't do radosgw,
> for example), so I'm trying to understand where people should best
> direct their efforts to get things to a working state.
>=20
> All thoughts and comments appreciated. Thanks!
>=20
> Cheers,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--7lIQBGgdS7FhjKI0gpkoQkC7v4aN4wVJT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMeBBEACgkQ8dLMyEl6F22r+gCaAybOM2S/u7d1NfMUOiTRVVwv
QLcAoJ0pTqZAikPV8DFktj3DfuNJSDKG
=6x+/
-----END PGP SIGNATURE-----

--7lIQBGgdS7FhjKI0gpkoQkC7v4aN4wVJT--
