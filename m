From: Alexey Kurnosov <alexey@kurnosov.spb.ru>
Subject: Re: incomplete PG
Date: Mon, 9 Jun 2014 17:10:11 +0400
Message-ID: <20140609131011.GC17468@unsen.q53.spb.ru>
References: <20140606132000.GA17468@unsen.q53.spb.ru>
 <alpine.DEB.2.00.1406060856330.31587@cobra.newdream.net>
 <20140606191851.GB17468@unsen.q53.spb.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 94.19.218.213.pool.sknt.ru ([94.19.218.213]:44923 "EHLO
	q53.spb.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932758AbaFINKT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 9 Jun 2014 09:10:19 -0400
Content-Disposition: inline
In-Reply-To: <20140606191851.GB17468@unsen.q53.spb.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Guys, what should i do to erase an incomplete PG?
Use special utils,  hexedit, any methods?


On Fri, Jun 06, 2014 at 11:18:51PM +0400, Alexey Kurnosov wrote:
> On Fri, Jun 06, 2014 at 08:57:46AM -0700, Sage Weil wrote:
> > On Fri, 6 Jun 2014, Alexey Kurnosov wrote:
> > > Hi all.
> > >=20
> > > Sorry for a rude offtop, but looks like nobody can help me at ceph-us=
ers.
> > > Here is the link to my email:
> > > http://lists.ceph.com/pipermail/ceph-users-ceph.com/2014-June/040383.=
html
> > > Here some additional data:
> > > http://pastebin.com/Nc4y3S1U
> > >=20
> > > During read requests i can see in logs:
> > > 2014-06-06 13:28:08.586262 7f335f29f700 10 osd.7 21942 dequeue_op 0x3=
56cb40 prio 127 cost 0 latency 0.000352 osd_op(client.11324.1:436 rb.0.1465=
=2E2ae8944a.000000000bb1 [read 0~131072] 4.b940a077 e21942) v4 pg pg[4.77( =
empty local-les=3D0 n=3D0 ec=3D144 les/c 19162/16786 21941/21941/21941) [7,=
2] r=3D0 lpr=3D21941 pi=3D8764-21940/115 mlcod 0'0 incomplete]
> > >=20
> > >=20
> > > Any help would be appreciated.=20
> >=20
> > This looks like a hangup somewhere in teh osd/osd communication that is=
=20
> > preventing the peering/probing from happening.  Since you're running=20
> > emperor and we stopped testing and backporting fixes there a while back=
=20
> > I'm not sure offhand what bug fix is missing.  My suggestion is to upgr=
ade=20
> > to 0.80.1 firefly as a first step.
> Upgrade has been performed. I do not see any changes.
>=20
>=20
> >=20
> > FWIW simply restartin the OSDs involved in those PGs will probably also=
=20
> > get things rolling, but this bug will still be present.
> I restarted it many times. Looks like PG copies all are incomplete.
>=20
>=20
> >=20
> > sage
> >=20
> >=20
> >  >=20
> > >=20
> > > (Somebody hit similar issue here: http://lists.ceph.com/pipermail/cep=
h-users-ceph.com/2014-February/007948.html)
> > >=20
> > > --
> > > Alexey Kurnosov
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
>=20
> --
> Alexey Kurnosov
>=20



--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJTlbIzAAoJEOvtiXwvSWEqw5UH/0uGydGd/PA5wdpeeHqAsHt/
lYYGQFIHqshv9KjwSMuN6EzsNT37ueIOu4EUuLJCfkFaOHqUuW1v1z/HfCc/SaZE
T8lPlGRclOL27h8c0jk+xGRNbiNA/t7/PdZ98Dgjk0neyddHXMWDbVV7CSK0qcVo
Aoo45lY4L2bchMx1z31hAsTKJKF71ylNtv4200jsn1isXFVU5Wf3ZILpxz+94ouk
CYNl5B6R6/CyyVTBNKybocfS5ZKn+eKUKEDT5tR773qzeCpMeTH61ytkN5IRc+py
7GaFNgi3skwSeJcL9Mq/byUDXorEjjOOFBxgGa5Ll5RJUpifSEBdq7ouCXpFStg=
=r58L
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
