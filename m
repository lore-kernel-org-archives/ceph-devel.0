From: Mariusz Gronczewski <mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org>
Subject: Re: cephfs survey results
Date: Tue, 4 Nov 2014 16:33:57 +0100
Message-ID: <20141104163357.400f83d1@ghroth.non.3dart.com>
References: <alpine.DEB.2.00.1411030649070.15135@cobra.newdream.net>
	<CA+z5DszyU+vDYWnLmvecZ9P6U=9uWOB28Eg7E7=vLtuUQz8Q4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0743606350=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CA+z5DszyU+vDYWnLmvecZ9P6U=9uWOB28Eg7E7=vLtuUQz8Q4w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0743606350==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/v9A=V/wOMXDZUgB1eMLlovN"; protocol="application/pgp-signature"

--Sig_/v9A=V/wOMXDZUgB1eMLlovN
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Nov 2014 10:36:07 +1100, Blair Bethwaite
<blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

>=20
> TBH I'm a bit surprised by a couple of these and hope maybe you guys
> will apply a certain amount of filtering on this...
>=20
> fsck and quotas were there for me, but multimds and snapshots are what
> I'd consider "icing" features - they're nice to have but not on the
> critical path to using cephfs instead of e.g. nfs in a production
> setting. I'd have thought stuff like small file performance and
> gateway support was much more relevant to uptake and
> positive/pain-free UX. Interested to hear others rationale here.
>=20

Those are related; if small file performance will be enough for one
MDS to handle high load with a lot of small files (typical case of
webserver), having multiple acive MDS will be less of a priority;

And if someone currently have OSD on bunch of relatively weak nodes,
again, having active-active setup with MDS will be more interesting to
him than someone that can just buy new fast machine for it.


--=20
Mariusz Gronczewski, Administrator

Efigence S. A.
ul. Wo=B3oska 9a, 02-583 Warszawa
T: [+48] 22 380 13 13
F: [+48] 22 380 13 14
E: mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org
<mailto:mariusz.gronczewski-EWQ+Go7UwTxWk0Htik3J/w@public.gmane.org>

--Sig_/v9A=V/wOMXDZUgB1eMLlovN
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWPHlAAoJEJa6WO31sS/Z+8IH/AxgE2J2oOMwJfrI3ylTfyAa
WrPangOwA+LOtABnPCW9YuI9SKI9NnlTaaiGzYZ3gjZGvsDfMjvD9qi6O6v5kdOR
TWguqXYZt8A4pVmLH5M0yn+ooSaHHyloKXRjPRa3/BnpIIbZbxXzQ63h0AESbjwG
bnAqppUKKlomvLucxH/zKYYsm7O0aZtnqqL8WGQHtQP5j/NclG1cKdnXtKkHJ2f4
E4s/DiENMkRmr8D/B32hqkVRRPqwFHmEuaFt1JbFUQ/PWZrut3gg+3moJBFAu14p
w+tgfQVpm+VCkAEOfscDVqyI7snkok+akX3DAA1cIGXiKCIpXOzCyr++KAjF7S8=
=yw7o
-----END PGP SIGNATURE-----

--Sig_/v9A=V/wOMXDZUgB1eMLlovN--

--===============0743606350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0743606350==--
