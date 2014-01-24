From: Loic Dachary <loic@dachary.org>
Subject: Re: creation of the puppet-ceph repository
Date: Fri, 24 Jan 2014 18:11:28 +0100
Message-ID: <52E29EC0.4030405@dachary.org>
References: <52AC97E2.8080907@dachary.org> <CAJH6TXjCRiomcpt=QoSrdCsn8KSKUwW4hf9MHQtfk5yv7n_CUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bPkogkeMigvKHNNWMstxj1PeA4QXRRuwf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:52165 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaAXRLa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jan 2014 12:11:30 -0500
In-Reply-To: <CAJH6TXjCRiomcpt=QoSrdCsn8KSKUwW4hf9MHQtfk5yv7n_CUw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bPkogkeMigvKHNNWMstxj1PeA4QXRRuwf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

At the moment the module can only be used to deploy mons. It's making slo=
w progress but a number of patches went in Ceph and should significantly =
simplify writing the puppet module, starting in Firefly.=20

Cheers

On 24/01/2014 14:57, Gandalf Corvotempesta wrote:
> 2013/12/14 Loic Dachary <loic@dachary.org>:
>> Hi,
>>
>> Could someone with sufficient permission please create the puppet-ceph=
 repository (empty, no README or .gitignore) at http://github.com/ceph/ ?=

>>
>> A few weeks ago it was decided to host the development of the module o=
n stackforge ( https://github.com/stackforge/puppet-ceph ) and also to es=
tablish a mirror under the ceph github namespace.
>=20
> Any usage guide for these puppet recipes?
> I would like to follow this:
> https://github.com/ceph/puppet-ceph/blob/master/USECASES.md
> "I want to operate a production cluster"
>=20
> But it's not clear how to add OSD nodes and how to specify journal
> disks and size.
> For example, in my environment I have 12 spinning disks to be used
> (with discovery, if possible) as OSD storage, 1 SSD to be used as
> operating system (that obviously must not be formatted) and 2 OSD to
> be used as journal with 1 partitions (15GB each) for each OSD.
>=20
> Should I configure somethinghin the recipe ?
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--bPkogkeMigvKHNNWMstxj1PeA4QXRRuwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLinsAACgkQ8dLMyEl6F21USQCfQ7ISm+9NUKtouyyB1uDi4lGi
/OwAniaupwuPANcJyJorLb338eUez4oP
=ohQJ
-----END PGP SIGNATURE-----

--bPkogkeMigvKHNNWMstxj1PeA4QXRRuwf--
