From: Karol Mroz <kmroz@suse.com>
Subject: Re: rgw/civetweb privileged port bind
Date: Thu, 26 Nov 2015 13:11:56 -0800
Message-ID: <20151126211153.GA30089@oak.lan>
References: <20151126192548.GA27729@oak.lan>
 <alpine.DEB.2.00.1511261136380.12118@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:51449 "EHLO
	smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753508AbbKZVMF (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 26 Nov 2015 16:12:05 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1511261136380.12118@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2015 at 11:38:26AM -0800, Sage Weil wrote:
> On Thu, 26 Nov 2015, Karol Mroz wrote:
> > Hello,
> >=20
> > As I understand it, with the release of infernalis, ceph
> > daemons are no longer being run as root. Thus, rgw/civetweb
> > is unable to bind to privileged ports:
> >=20
> > http://tracker.ceph.com/issues/13600
> >=20
> > We encountered this problem as well in our downstream (hammer
> > based) product, where we run rgw/civetweb as "wwwuser". To allow
> > privileged port binding, we used file caps (setcap from the spec file).
> > Going forward, however, we were thinking of taking one of two
> > approaches:
> >=20
> > 1. Start rgw/civetweb as root and utilize an existing civetweb
> > config option (run_as_user) to drop permissions _after_
> > the port bind and after certificate files have been read.
> >
> > 2. Utilize systemd socket activation, and allow systemd to bind
> > to the necessary port. Once rgw/civetweb is started, civetweb
> > can pull the listening socket from systemd.
> >=20
> > Is this something you folks upstream have given some thought to?
>=20
> I haven't. #2 sounds like it's harder, and I'm not sure it brings a lot f=
o=20
> benefit. Making #1 work is probably super simple (replace our set user=20
> option with the civetweb one?)...
>=20
> What do you suggest?

Hi Sage,

I agree with you that #2 would be more work. I expect there may be some gai=
ns
in startup time associated with socket activation along with the other
systemd benefits (cgroups, etc), which we may already be taking advantage o=
f?

A couple months ago, I played around with option #1 in one of our downstream
branches. Basically something like this: https://github.com/SUSE/ceph/pull/=
22
Further, we'd best pull in a couple civetweb upstream commits into the
maintained civetweb submodule. Namely:

https://github.com/civetweb/civetweb/commit/5e753cc
  - civetweb.c: fix setgroups() -Wimplicit-function-declaration
https://github.com/civetweb/civetweb/commit/a3c460c
  - call setgroups() to avoid supplemental group leakage

So, option #1 is perhaps a decent solution for rgw/civetweb for the time be=
ing.
Later on, we might want to examine the prospect of leveraging socket activa=
tion
for all of ceph. I don't think the permissions drop in rgw/civetweb would n=
egatively
impact such a plan in the future.

--=20
Regards,
Karol

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWV3WXAAoJECp28bThgzatX9IIALne51NBaT/MBSy3oSO4u22y
x3vwEGVsQxjchAAGr1DIRIgDP7lEhroYD2H/AdGrsFDwYsphuP2STnN4omdcuYnF
H0vPHycj1gaUknfCIEB+kbBk0x3xPn9VJgCaxMTyMVdPz4tboAiEgOiyCgDrbQAn
aopzKMqQJ8O2MSjQcScUwbenO5dzoa9Z7PRSSf/LsIsAYXrr+IZBZ+BNyBZeHyP4
T7ScQYatroCfuDKx3XZQuibpttoWwO1q5fEAWUIcE/yy8SWnpmlsejvbGbaXDW9M
cFdvrvemRhho1Oyr3mTeuK9xao6xbrritIHOye1KGfqJF33EisnEJIHvq69HqVs=
=5F9l
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
