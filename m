From: Martin Millnert <martin@millnert.se>
Subject: Re: Hardware-config suggestions for HDD-based OSD node?
Date: Mon, 29 Mar 2010 02:29:34 +0200
Message-ID: <1269822574.7122.40.camel@hsa.vpn.anti>
References: <23450.1269815817@n20.hq.graphstream.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1637869863630618648=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <23450.1269815817@n20.hq.graphstream.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Craig Dunwoody <cdunwoody@graphstream.com>
Cc: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org


--===============1637869863630618648==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-RakNmu8To4hicMZSQ6rf"


--=-RakNmu8To4hicMZSQ6rf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2010-03-28 at 15:36 -0700, Craig Dunwoody wrote:
> I'd be interested to hear from anyone who has suggestions about
> optimizing the hardware config of an HDD-based OSD node for Ceph, using
> currently available COTS hardware components.

Craig, list,

while this does not match your G1, G2 or G3, there is a G4 absolutely
worth considering IMO:

  Maximize storage area and transfer speed divided by hardware
investment + MRU.

Then G5:
  Optimize for performance / node.

or G6:
  Optimize for performance of the storage network.

matters too.  And both must be weighed against not only the hardware
investment, but also the MRU due to space, cooling and power
consumption.

I've done some raw calculations for the G4 and what I found was that if
you don't mind installing COTS-HW not exactly of your standard data
center make and model, you stand to gain a lot by simply deploying many
quite low-power devices with 4-5 SATA ports IMO. But it wholly depends
on what you are after.  I believe it is very interesting for a
data-warehousing application of Ceph.

Potentially, I must add.  I haven't tried it.  :)=20
But for any sizable installation, I believe the storage network itself
will let, as you scale up, get sufficient performance. Ie., you might
hit some ceiling of the storage networks' performance soon enough
anyway. At least if you're using front ends to interface to it.

Unresolved in the above equation is MDS/OSD performance (and ratio) and
actual per-OSD performance. Power consumption is quite easy to get a
ball-park max/min/avg figure on.


I think you have to figure out what it is you need done for your
specific application, and back-track from there. Because there is no
single optimal configuration of a distributed file system such as Ceph,
for all applications.

Cheers,
--=20
Martin Millnert <martin@millnert.se>

--=-RakNmu8To4hicMZSQ6rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuv9GsACgkQatANZBhP8gMudACbBUfwtpx3X2x0YcChJJnu5vjq
xi8AoI7vrUkNvdsJcZKEt51xccJfnhf0
=X6VS
-----END PGP SIGNATURE-----

--=-RakNmu8To4hicMZSQ6rf--



--===============1637869863630618648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============1637869863630618648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============1637869863630618648==--
