From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH] daemons: write pid file even when told not to daemonize
Date: Thu, 28 Aug 2014 10:09:28 +0200
Message-ID: <53FEE3B8.4070902@dachary.org>
References: <or4mxyuvo4.fsf@free.home> <53D9C379.9070904@dachary.org>	<alpine.DEB.2.00.1407302129530.18917@cobra.newdream.net> <or7g1tawy9.fsf@free.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Nr2DrDQCunX7GnmuciGHif47nwPt9IHTT"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39388 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932262AbaH1IKT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Aug 2014 04:10:19 -0400
In-Reply-To: <or7g1tawy9.fsf@free.home>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@gnu.org>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nr2DrDQCunX7GnmuciGHif47nwPt9IHTT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Alexandre,

Changing this behavior is not backward compatible but it is indeed more i=
ntuitive. Has it been a significant inconvenience so far ?

Cheers

On 28/08/2014 09:35, Alexandre Oliva wrote:
> On Jul 31, 2014, Sage Weil <sweil@redhat.com> wrote:
>=20
>> On Thu, 31 Jul 2014, Loic Dachary wrote:
>>> Hi Alexandre,
>>>
>>> With this patch ceph-osd -f will try to create the default pid file :=
=20
>>> this is a non backward compatible change. Maybe there is a way for=20
>>> systemd to capture the pid of the process and store it instead of=20
>>> requiring the deamon to create the pid file ?
>=20
>> Do we need the pid file at all when we aren't using sysinit?
>=20
> My own monitoring scripts use it, and ceph stop use it as well.  I was
> surprised we were not creating them in spite of an explicit command lin=
e
> option to do so.
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Nr2DrDQCunX7GnmuciGHif47nwPt9IHTT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlP+47gACgkQ8dLMyEl6F2358wCfSNVvEAgE51BWB3QXp7HPCdVs
eNoAn334whVJ+yBkbdpXuQlVcEZzbp07
=8EFs
-----END PGP SIGNATURE-----

--Nr2DrDQCunX7GnmuciGHif47nwPt9IHTT--
