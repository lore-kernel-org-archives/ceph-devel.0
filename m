From: Lenz Grimmer <lenz-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Introducing DeepSea: A tool for deploying Ceph
	using Salt
Date: Thu, 3 Nov 2016 13:23:06 +0100
Message-ID: <67699503-6fc3-5039-082c-f0fdc7b5a65e@grimmer.com>
References: <0c7928bb-947a-23c9-5770-e588dbffb6af@suse.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0957237726=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <0c7928bb-947a-23c9-5770-e588dbffb6af-IBi9RG/b67k@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0957237726==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4uDxO1tOKBX0LmwfdwEhwhoQcgaU50cWB"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4uDxO1tOKBX0LmwfdwEhwhoQcgaU50cWB
Content-Type: multipart/mixed; boundary="E065AK8v1GXwDPDnNjVGB7RBDva93JJUX";
 protected-headers="v1"
From: Lenz Grimmer <lenz-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Message-ID: <67699503-6fc3-5039-082c-f0fdc7b5a65e-L588LILoNhJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Introducing DeepSea: A tool for deploying Ceph using Salt
References: <0c7928bb-947a-23c9-5770-e588dbffb6af-IBi9RG/b67k@public.gmane.org>
In-Reply-To: <0c7928bb-947a-23c9-5770-e588dbffb6af-IBi9RG/b67k@public.gmane.org>

--E065AK8v1GXwDPDnNjVGB7RBDva93JJUX
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2016 06:52 AM, Tim Serong wrote:

> I thought I should make a little noise about a project some of us at
> SUSE have been working on, called DeepSea.  It's a collection of Salt
> states, runners and modules for orchestrating deployment of Ceph
> clusters.  To help everyone get a feel for it, I've written a blog post=

> which walks through using DeepSea to set up a small test cluster:
>=20
>   http://ourobengr.com/2016/11/hello-salty-goodness/
>=20
> If you'd like to try it out yourself, the code is on GitHub:
>=20
>   https://github.com/SUSE/DeepSea
>=20
> More detailed documentation can be found at:
>=20
>   https://github.com/SUSE/DeepSea/wiki/intro
>   https://github.com/SUSE/DeepSea/wiki/management
>   https://github.com/SUSE/DeepSea/wiki/policy
>=20
> Usual story: feedback, issues, pull requests are all welcome ;)

Thanks for sharing, Tim!

FWIW, the openATTIC-Team [http://openattic.org/] is working on an
integration of DeepSea into our framework, to provide a friendly UI and
REST API on top of this.

We currently provide mostly read-only support (e.g. list all minions and
their roles in a Ceph cluster, extracting the pillar data and the
content of policy.cfg). Configuring Minions and executing the DeepSea
stages is work in progress.

Be we too would love to get your feedback, bug reports or pull requests :=
)

Thanks,

Lenz


--E065AK8v1GXwDPDnNjVGB7RBDva93JJUX--

--4uDxO1tOKBX0LmwfdwEhwhoQcgaU50cWB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iFgEARECABgFAlgbLC0RHGxlbnpAZ3JpbW1lci5jb20ACgkQSVDhKrJykfJtcQCc
DWTbun87tjJTpxNHImMMKxUqxjgAnjCoPVhuxSbs9qa2fsJcOK+d0vDk
=SvDl
-----END PGP SIGNATURE-----

--4uDxO1tOKBX0LmwfdwEhwhoQcgaU50cWB--

--===============0957237726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0957237726==--
