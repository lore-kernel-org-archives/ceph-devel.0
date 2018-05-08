From: Kai Wagner <kwagner-IBi9RG/b67k@public.gmane.org>
Subject: Re: Show and Tell: Grafana cluster dashboard
Date: Tue, 8 May 2018 07:21:04 +0200
Message-ID: <b461c88c-9789-9a17-e67d-a4913c15466f@suse.com>
References: <"H000007100119c41.1525680369.sx.f1-outsourcing.eu*"@MHS>
 <6A5C4896-0EFA-4F2E-8963-2DFA7D78C48D@focusvq.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8757245930312256700=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <6A5C4896-0EFA-4F2E-8963-2DFA7D78C48D-uHprvc9sRvVBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Reed Dier <reed.dier-uHprvc9sRvVBDgjK7y7TUQ@public.gmane.org>, jfajerski <jfajerski-IBi9RG/b67k@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============8757245930312256700==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="blI0JiU5PoSF6RML3zLTZ7tTV7LABM0Iq"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--blI0JiU5PoSF6RML3zLTZ7tTV7LABM0Iq
Content-Type: multipart/mixed; boundary="vigrUpzltbA6rgVG5XC6JU603j3S9DdyI";
 protected-headers="v1"
From: Kai Wagner <kwagner-IBi9RG/b67k@public.gmane.org>
To: Reed Dier <reed.dier-uHprvc9sRvVBDgjK7y7TUQ@public.gmane.org>, jfajerski <jfajerski-IBi9RG/b67k@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
Message-ID: <b461c88c-9789-9a17-e67d-a4913c15466f-IBi9RG/b67k@public.gmane.org>
Subject: Re: [ceph-users] Show and Tell: Grafana cluster dashboard
References: <"H000007100119c41.1525680369.sx.f1-outsourcing.eu*"@MHS>
 <6A5C4896-0EFA-4F2E-8963-2DFA7D78C48D-uHprvc9sRvVBDgjK7y7TUQ@public.gmane.org>
In-Reply-To: <6A5C4896-0EFA-4F2E-8963-2DFA7D78C48D-uHprvc9sRvVBDgjK7y7TUQ@public.gmane.org>

--vigrUpzltbA6rgVG5XC6JU603j3S9DdyI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

Looks very good. Is it anyhow possible to display the reason why a
cluster is in an error or warning state? Thinking about the output from
ceph -s if this could by shown in case there's a failure. I think this
will not be provided by default but wondering if it's possible to add.

Kai

On 05/07/2018 04:53 PM, Reed Dier wrote:
> I think supporting both paths would be the best choice.
That's the way we should go. Supporting both or in general as much as
possible (try to be generic)

--=20
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton=
, HRB 21284 (AG N=C3=BCrnberg)



--vigrUpzltbA6rgVG5XC6JU603j3S9DdyI--

--blI0JiU5PoSF6RML3zLTZ7tTV7LABM0Iq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIUhTiREAT2TdVpPQHoyRVhbjxG4FAlrxM8AACgkQHoyRVhbj
xG5BSwgAlrJTeC9A+3K0Vf9r/GoZZBl1Sq08OjrcwEgHKOMcOVB8kieCCeCkfctq
DmszhoUhw90eUb1FqZyrGKicgOCXJle3DBZ1UqEp6UxjmNZPCi4ye3Ng/Z0OB47W
aNVIjonq6lALH9bxAV2hAd74O/vF9YfW4AYHt1UrL5i8XlnxmSt7sem6FApVI0vL
vv9IJ3b23xER8qaVp2b7WwT7c0vGGTe1q7cr0AWVk+5hnyFmrNPOy/yhX/8YWBNy
UNNu4FR5sv/1VllyqU49MWmkkA6/4lqHDf2HPJV+afLO5fa9WhFRXUqvvwWPQwxw
Zl4k2tsrB07wYQY+gst3MuFKLoAknA==
=8TAQ
-----END PGP SIGNATURE-----

--blI0JiU5PoSF6RML3zLTZ7tTV7LABM0Iq--

--===============8757245930312256700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============8757245930312256700==--
