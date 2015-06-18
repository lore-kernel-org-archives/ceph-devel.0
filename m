From: Owen Synge <osynge@suse.com>
Subject: Re: Build RPMs from git
Date: Thu, 18 Jun 2015 15:44:36 +0200
Message-ID: <5582CB44.1060001@suse.com>
References: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:58732 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbbFRNqH (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 18 Jun 2015 09:46:07 -0400
In-Reply-To: <CAANLjFqtNxo=CPwar3OYP9es-+5LgTbmiNgd_4RSCcndb_iCNA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Robert,

I have a pull request open for exactly this use case.

    https://github.com/ceph/ceph/pull/4911

I find it particularly useful for debugging spec file issues when
running on other operating systems than suse.

The pull request gives two new "make' targets.

    make srpm
    make rpm

I hope this helps.

(1) merge this pull request to make it all work.

(2) sh autogen.sh

(3) ./configure

(4) make rpm

Your done :)

best regards

Owen

On 06/09/2015 11:15 PM, Robert LeBlanc wrote:
> OK, easy question...
>=20
> Building Debian packages from git is wonderfully easy, RPMs seem ....
> not so easy.
>=20
> I got it to kind of work, but I feel like I'm doing it the "Hard Way"=
 (tm).
>=20
> mkdir -p ~/ceph && pushd ~/ceph
> git clone https://github.com/ceph/ceph.git
> ./autogen.sh
> ./configure
> echo "--- /root/ceph/ceph/ceph.spec   2015-06-09 13:03:08.240099443 -=
0600
> +++ /root/rpmbuild/SPECS/ceph.spec      2015-06-09 13:12:54.145061355=
 -0600
> @@ -464,12 +464,14 @@
>  # common
>  ####################################################################=
#############
>  %prep
> -%setup -q
> +#%setup -q
> +cd %{buildroot}
>  %if 0%{?fedora} || 0%{?rhel}
>  %patch0 -p1 -b .init
>  %endif
>=20
>  %build
> +cd %{buildroot}
>  # Find jni.h
>  for i in /usr/{lib64,lib}/jvm/java/include{,/linux}; do
>      [ -d $i ] && java_inc=3D"$java_inc -I$i"" | patch
> rpmbuild -ba ceph.spec --define 'buildroot `pwd/ceph`'
>=20
> It coughs at the install/RPM package part.
>=20
> Any help with preventing the whole tar/untar process which I can't
> seem to get exactly right either would be very helpful.
>=20
> Thanks,
>=20
> ----------------
> Robert LeBlanc
> GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

- --=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=F6rffer, HR=
B
21284 (AG
N=FCrnberg)

Maxfeldstra=DFe 5

90409 N=FCrnberg

Germany
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVgstEAAoJECe/2BuiZiboGrAH/jqGIE5yGAgrSIRGJ+TonzjY
vUNTQz9wR0P1MUWPV3WeEQaX5tiUPGJZ9i7DkLq+sUiOojHDda37sePm1vx68uiO
C1+Ea8FN7Rw4L+M2eqQbwNbOfLjLakxotudZxMWuUhm9NDKF218BLUZpyFJJfJYK
sBm4GEWp++r3cOXtzMJck4Pet4KIrr34vhS+6SyUo5inivJzw0SApF4ro2Zz13m7
WzfyxJDf83VbQvZ0jgucZZz44lBD5804lEGOBXVX6fzFI2Mr7UhL+jJqCIJ2rzOr
94zSz4vpP1Sv2dbgGXEDRJtMZZay7shPQ4hpiPwZTtdgBYPC5h6kLZUestowUfA=3D
=3DqfrD
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
