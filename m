From: Christian Theune <ct-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org>
Subject: Re: Ceph release cadence
Date: Sat, 9 Sep 2017 22:32:16 +0200
Message-ID: <1E38E3EC-3112-4694-8F23-5FEAA19BDAB1@flyingcircus.io>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/mixed; boundary="===============7789004346988831579=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============7789004346988831579==
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EC5DC857-E1FD-424E-845E-748D95173543";
 protocol="application/pgp-signature"; micalg=pgp-sha512


--Apple-Mail=_EC5DC857-E1FD-424E-845E-748D95173543
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi,

have been using Ceph for multiple years now. It=E2=80=99s unclear to me =
which of your options fits best, but here are my preferences:

* Updates are risky in a way that we tend to rather not do them every =
year. Also, having seen jewel, we=E2=80=99ve been well off to avoid two
  major issues what would have bitten us and will upgrade from hammer in =
the next month or so.

* Non-production releases are of not much value to me, as I have to keep =
our dev/staging/prod clusters in sync to work on our stuff.
  As you can never downgrade, there=E2=80=99s no value in it for me to =
try non-production releases (without frying dev for everyone).

* I=E2=80=99d prefer stability over new features. *Specifically* that =
new features can be properly recombined with existing features (and each
  other) without leading to surprises. (E.g. cache tiering breaking with =
snapshots and then no way going back and a general notion of
  =E2=80=9Cthat combination wasn=E2=80=99t really well tested).

* I=E2=80=99d prefer versions that I have to be maintained for =
production-critical issues maybe 2 years, so I can have some time after =
a new
  production release that overlaps with the new production release =
receiving important bug fixes until I switch.

Maybe this is close to what your "Drop the odd releases, and aim for a =
~9 month cadence.=E2=80=9D would say. Waiting for a feature for a year =
is a pain, but my personal goal for Ceph is that it first has to work =
properly, meaning: not loose your data, not "stopping the show=E2=80=9D, =
and not drawing you into a corner you can=E2=80=99t get out.

That=E2=80=99s my perspective as a user. As a fellow developer I feel =
your pain about wanting to release faster and reducing maintenance load, =
so thanks for asking!

Hope this helps,
Christian

> On Sep 6, 2017, at 5:23 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>=20
> Hi everyone,
>=20
> Traditionally, we have done a major named "stable" release twice a =
year,
> and every other such release has been an "LTS" release, with fixes
> backported for 1-2 years.
>=20
> With kraken and luminous we missed our schedule by a lot: instead of
> releasing in October and April we released in January and August.
>=20
> A few observations:
>=20
> - Not a lot of people seem to run the "odd" releases (e.g., =
infernalis,
> kraken).  This limits the value of actually making them.  It also =
means
> that those who *do* run them are running riskier code (fewer users -> =
more
> bugs).
>=20
> - The more recent requirement that upgrading clusters must make a stop =
at
> each LTS (e.g., hammer -> luminous not supported, must go hammer -> =
jewel
> -> lumninous) has been hugely helpful on the development side by =
reducing
> the amount of cross-version compatibility code to maintain and =
reducing
> the number of upgrade combinations to test.
>=20
> - When we try to do a time-based "train" release cadence, there always
> seems to be some "must-have" thing that delays the release a bit.  =
This
> doesn't happen as much with the odd releases, but it definitely =
happens
> with the LTS releases.  When the next LTS is a year away, it is hard =
to
> suck it up and wait that long.
>=20
> A couple of options:
>=20
> * Keep even/odd pattern, and continue being flexible with release =
dates
>=20
>  + flexible
>  - unpredictable
>  - odd releases of dubious value
>=20
> * Keep even/odd pattern, but force a 'train' model with a more regular
> cadence
>=20
>  + predictable schedule
>  - some features will miss the target and be delayed a year
>=20
> * Drop the odd releases but change nothing else (i.e., 12-month =
release
> cadence)
>=20
>  + eliminate the confusing odd releases with dubious value
>=20
> * Drop the odd releases, and aim for a ~9 month cadence. This splits =
the
> difference between the current even/odd pattern we've been doing.
>=20
>  + eliminate the confusing odd releases with dubious value
>  + waiting for the next release isn't quite as bad
>  - required upgrades every 9 months instead of ever 12 months
>=20
> * Drop the odd releases, but relax the "must upgrade through every =
LTS" to
> allow upgrades across 2 versions (e.g., luminous -> mimic or luminous =
->
> nautilus).  Shorten release cycle (~6-9 months).
>=20
>  + more flexibility for users
>  + downstreams have greater choice in adopting an upstrema release
>  - more LTS branches to maintain
>  - more upgrade paths to consider
>=20
> Other options we should consider?  Other thoughts?
>=20
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Liebe Gr=C3=BC=C3=9Fe,
Christian Theune

--
Christian Theune =C2=B7 ct-4ImjS3E6Ur3YxmODkEiZ1Q@public.gmane.org =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 http://flyingcircus.io
Forsterstra=C3=9Fe 29 =C2=B7 06112 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick


--Apple-Mail=_EC5DC857-E1FD-424E-845E-748D95173543
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJZtE/QAAoJEKuh8lKpfGLO16UIAIlFGR4LannKcb6Ksba+0cj8
vehckEoa8P7m6u2inyk4MxdC4kj+BrEW1pY7jvcT9IswUsD1U6Eozi3hOhXwLvBS
BYg/UbrDeebKxS0gWUbp+XzhWgw+XybLaN2ytloHDYV31OKFwAljBwqdLI6YE4c2
ytXssUyqNbr2yRgMzITyIySJc1/DL5WT1zBD+UVJ8fdXUhtkQ9oTRaJ6G5pZQu5x
lS1ygp8q6Nxu4PcydYOisGGDYZPlrkgxBuaWlLqBuU9sGZIks8r8D8dAsg5GQtWq
04lxip+1yC6RZeJ2BpEM7+6wT++n2yfajTPe9IhJnIkGo5Bssoq1LyUxffBtQ9w=
=Nhzu
-----END PGP SIGNATURE-----

--Apple-Mail=_EC5DC857-E1FD-424E-845E-748D95173543--

--===============7789004346988831579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============7789004346988831579==--
