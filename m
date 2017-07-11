From: "Robin H. Johnson" <robbat2-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: Re: autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 18:53:40 +0000
Message-ID: <robbat2-20170711T181007-461462320Z@orbis-terrarum.net>
References: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
	<alpine.DEB.2.11.1707111507220.3424@piezo.novalocal>
	<CACJqLyY0fhZJtDZ3ZS3OL=K6TcK_S2fPAE1uUGHPmnbuxDHmvw@mail.gmail.com>
	<alpine.DEB.2.11.1707111537290.3424@piezo.novalocal>
	<CABZ+qqk=kvoTdVebgJrxQ1kdVogY2g9aiSVZKXYzPqGaRAQ+5A@mail.gmail.com>
	<alpine.DEB.2.11.1707111614080.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1192222648=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1707111614080.3424-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


--===============1192222648==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fh9ZBaUqcBlFuagd"
Content-Disposition: inline


--fh9ZBaUqcBlFuagd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Trim lots of good related content).

The upcoming HAProxy 1.8 has landed further patches for improving hot
restarts/reloads of HAProxy, which previously lead to a brief gap period
when new connections were not serviced. Lots of other approaches had
been seen, including delaying TCP SYN momentarily [1]. It also notably
fixes how you needed a separate wrapper for using haproxy w/ systemd.

In the DreamHost RGW usage, I've been building additional functionality
into HAProxy via Lua, but I'm not convinced it's the best place for some
of it:
- rate-limiting by access key (with explicitly whitelisted & blacklisted
  keys), over multiple frontends [2]
- Planned: different rates for different operations/customer classes.
- Planned: issue redirects for buckets being moved (because getting
  federated metadata between existing clusters is painful) [3].
  This differs from the CERN backend-selection-by-bucket, because the
  bucket is going to be moving regions!

RGW doesn't seem like the right place for some of this functionality
either, because storing rate data in multiple places means lots of
cross-talk.

[1] https://engineeringblog.yelp.com/2015/04/true-zero-downtime-haproxy-rel=
oads.html
[2] http://blog.armbruster-it.de/2015/08/neo4j-and-haproxy-some-best-practi=
ces-and-tricks/
[3] http://docs.aws.amazon.com/AmazonS3/latest/dev/Redirects.html

> > I don't know if the bucket mapping concept is generally applicable.
> > Maybe this haproxy-agent should focus on configuring a single backend
> > populated with the radosgw's, and leave more complex configurations up
> > to their admins?
> Yeah.  (The dynamic remapping is interesting, though!  That could=20
> potentially be controlled by rgw as well to automatically isolate busy=20
> buckets or objects.)
Yes, this would fit well to populate a single HAProxy backend w/ the
available RGWs, and then that can be wrapped with whatever frontend
configuration (esp. SSL) that the admin wants.


--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--fh9ZBaUqcBlFuagd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlllHrRfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsTxVQ//Ya38/R8nc8AAQUJeGxzRj4Eq+fFrahdUWQEIxue8MK2xehg7kpXGBchf
5FInRcd3nv66LwRKKF4GE8GFmHixPiEGsUdhl//sfGgXd2G/o+XCQZRUPADAZROt
Q4w0cke2gKcj6nCddmUqR5+VXbQ0Wh9TPOs3UaPGUXr65yttXr2JGpblG/WqdLdS
CcPdf0/cMkZp7MxeC8b7Rn2nzfwOr++9rs6O7b2UOf8VHafJt4TyNKmJEUeZelgK
aExQV9xuKRVPBVAQNX9MFyXgoQcSJ7SgzTtVDWBJJGuev/GoypUIObm4U0TorP/j
0yRNRnoLvv9lUbj/8DaYevGDB1acmaaEpSnXFkRYtYQ2c8P+FcKezQv+QEO2HQnr
Fm3VSposX0qtxctm505jxZCOYYqD32ObgjnMCG3LvCeTIxWVK6EsuikAEkY/KswG
iDMRTkypZVAbUgw9wRUtdVc6OfyuFN6+G3DZHU0jBqd7EVqy1NhWwc8xXZZJhvnk
sMBTA80RBiFENUbP4F2BhMmJfeDIXHjJxdKlpbRpP2+x/hhf2znYEBsHLt/3qmXP
G+8rLCsZMXYEY6hz8AHnBC/f3bmpBUvYt84whtTzrde25BjXqtzwMKBF6Zb51Blg
S3bLJakijKxRJvleCdJLzMoLxD6JcWy2hHIKqkLq8Tt7tinQ6Gg=
=7HK6
-----END PGP SIGNATURE-----

--fh9ZBaUqcBlFuagd--

--===============1192222648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1192222648==--
