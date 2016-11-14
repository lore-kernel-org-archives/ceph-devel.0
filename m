From: Tomasz Kuzemko <tomasz.kuzemko-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
Subject: Re: Can we drop ubuntu 14.04 (trusty) for kraken and
	lumninous?
Date: Mon, 14 Nov 2016 12:08:19 +0100
Message-ID: <38a56bb7-3c9e-24b3-1d78-46e23bd580e6@corp.ovh.com>
References: <alpine.DEB.2.11.1611111837410.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0142817999=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1611111837410.29579-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0142817999==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="QjQqSlxcmBpWthatHcM0KIcaQAcuJnbti"

--QjQqSlxcmBpWthatHcM0KIcaQAcuJnbti
Content-Type: multipart/mixed; boundary="LaXNCAhh5BnUhRt1N9JwmMEwGkHM8UqUH";
 protected-headers="v1"
From: Tomasz Kuzemko <tomasz.kuzemko-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
Message-ID: <38a56bb7-3c9e-24b3-1d78-46e23bd580e6-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
Subject: Re: Can we drop ubuntu 14.04 (trusty) for kraken and lumninous?
References: <alpine.DEB.2.11.1611111837410.29579-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1611111837410.29579-ie3vfNGmdjePKud3HExfWg@public.gmane.org>

--LaXNCAhh5BnUhRt1N9JwmMEwGkHM8UqUH
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

I vote for 1. until Ubuntu 14.04 is supported.

On 11.11.2016 19:43, Sage Weil wrote:
> Currently the distros we use for upstream testing are
>=20
>  centos 7.x
>  ubuntu 16.04 (xenial)
>  ubuntu 14.04 (trusty)
>=20
> We also do some basic testing for Debian 8 and Fedora (some old version=
).
>=20
> Jewel was the first release that had native systemd and full xenial=20
> support, so it's helpful to have both 14.04 and 16.04 supported to prov=
ide=20
> an upgrade path.  But I think we can safely drop 14.04 now for kraken a=
nd=20
> luminous.  Our options are
>=20
> 1) keep testing on xenial and trusty, and keep building packages for bo=
th
>=20
> 2) stop testing trusty, but still build packages
>=20
> 3) stop testing or building for trusty
>=20
> Preferences?
> sage
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Tomasz Kuzemko
tomasz.kuzemko-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org


--LaXNCAhh5BnUhRt1N9JwmMEwGkHM8UqUH--

--QjQqSlxcmBpWthatHcM0KIcaQAcuJnbti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJYKZsmAAoJEH0wj3uDfd0nquoH/jpxi7BmWS+MI+omp50A3osu
fV+6yu/dWdhwWwgy278t0b5WFcd+1nMAsjpLG8j7IirQwE3Y2rjgD9aoC/SMojSf
2Wt8C3KROg/tskUzEG9p3sLNRhyNsPWDzOF90GCDRVdnfRwG1og/wHsmT5iEsWK3
LvYmhmicmg/kUIRURLr6BUzgJaJdHf9Oaxd2MBnVSLAqClQfy6of8XeXQckDwHcs
YCOiAbSaX7a+kpz4bjAN3QOQQJLXahSh2mkPnVv5zln4k4/J1lHCxWz8P8MjPFI9
VX0ruhq9XOld1zDbpWOogtAioLJn9qv57GDc8EZVJzOveYYBb1fglHyAL21voio=
=JTsH
-----END PGP SIGNATURE-----

--QjQqSlxcmBpWthatHcM0KIcaQAcuJnbti--

--===============0142817999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0142817999==--
