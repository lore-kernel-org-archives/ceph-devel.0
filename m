From: Lenz Grimmer <lgrimmer-IBi9RG/b67k@public.gmane.org>
Subject: Re: Show and Tell: Grafana cluster dashboard
Date: Mon, 4 Jun 2018 12:56:25 +0200
Message-ID: <e154f1d5-6165-7116-e999-aabd2caa6292@suse.com>
References: <"H000007100119c41.1525680369.sx.f1-outsourcing.eu*"@MHS>
 <6A5C4896-0EFA-4F2E-8963-2DFA7D78C48D@focusvq.com>
 <b461c88c-9789-9a17-e67d-a4913c15466f@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5827177859124743777=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Resent-To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Resent-Message-ID: <2b94fd58-424f-fa11-d6d4-a1428bc04035@suse.com>
In-Reply-To: <b461c88c-9789-9a17-e67d-a4913c15466f-IBi9RG/b67k@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============5827177859124743777==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8BkDO7ScdBFpsTYxZrl24aPzjAjzaojqQ"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8BkDO7ScdBFpsTYxZrl24aPzjAjzaojqQ
Content-Type: multipart/mixed; boundary="cbiGXDCIJHe3hhH8IVLmXbYTiNapC7Ndm";
 protected-headers="v1"
From: Lenz Grimmer <lgrimmer-IBi9RG/b67k@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
Message-ID: <e154f1d5-6165-7116-e999-aabd2caa6292-IBi9RG/b67k@public.gmane.org>
Subject: Re: [ceph-users] Show and Tell: Grafana cluster dashboard
References: <"H000007100119c41.1525680369.sx.f1-outsourcing.eu*"@MHS>
 <6A5C4896-0EFA-4F2E-8963-2DFA7D78C48D-uHprvc9sRvVBDgjK7y7TUQ@public.gmane.org>
 <b461c88c-9789-9a17-e67d-a4913c15466f-IBi9RG/b67k@public.gmane.org>
In-Reply-To: <b461c88c-9789-9a17-e67d-a4913c15466f-IBi9RG/b67k@public.gmane.org>

--cbiGXDCIJHe3hhH8IVLmXbYTiNapC7Ndm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05/08/2018 07:21 AM, Kai Wagner wrote:

> Looks very good. Is it anyhow possible to display the reason why a
> cluster is in an error or warning state? Thinking about the output from=

> ceph -s if this could by shown in case there's a failure. I think this
> will not be provided by default but wondering if it's possible to add.

Sorry for the late reply. We actually discussed this aspect during one
of the calls we had when discussing the Grafana dashboard integration
into the Ceph Manager Dashboard. Such kind of state information is
somewhat difficult to track and visualize using Prometheus/Grafana (or
any other TSDB, FWIW), as you can't store the actual reasons for why the
cluster is in HEALTH_WARN or HEALTH_ERR, for example.

We are therefore considering displaying this information in the form of
"native" widgets on the Manager Dashboard, and using the Grafana
dashboards for visualizing the other more suitable performance metrics.

Lenz

--=20
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 Nuernberg (Germany)
GF:Felix Imend=C3=B6rffer,Jane Smithard,Graham Norton,HRB 21284 (AG N=C3=BC=
rnberg)


--cbiGXDCIJHe3hhH8IVLmXbYTiNapC7Ndm--

--8BkDO7ScdBFpsTYxZrl24aPzjAjzaojqQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCWxUa2QAKCRBJUOEqsnKR
8gaSAJ9uit0QYBq24N7el8o9tWKScieuKgCeJScXMuJ+/8PBJ8auB1InEBdJRdo=
=g8cM
-----END PGP SIGNATURE-----

--8BkDO7ScdBFpsTYxZrl24aPzjAjzaojqQ--

--===============5827177859124743777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============5827177859124743777==--
