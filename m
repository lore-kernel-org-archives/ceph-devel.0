From: Gaudenz Steinlin <gaudenz.steinlin@cirrax.com>
Subject: Re: [Ceph-announce] Important security noticed regarding release	signing key
Date: Wed, 23 Sep 2015 14:56:01 +0200
Message-ID: <87twqlb8gu.fsf@meteor.durcheinandertal.bofh>
References: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vechigen.cirrax.com ([217.197.128.12]:58234 "EHLO
	mail.cirrax.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbbIWNC4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Sep 2015 09:02:56 -0400
In-Reply-To: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Sage Weil <sage@newdream.net> writes:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Last week, Red Hat investigated an intrusion on the sites of both the Cep=
h=20
> community project (ceph.com) and Inktank (download.inktank.com), which=20
> were hosted on a computer system outside of Red Hat infrastructure.
>
> Ceph.com provided Ceph community versions downloads signed with a Ceph=20
> signing key (id 7EBFDD5D17ED316D). Download.inktank.comprovided releases=
=20
> of the Red Hat Ceph product for Ubuntu and CentOS operating systems signe=
d=20
> with an Inktank signing key (id 5438C7019DCEEEAD). While the investigatio=
n=20
> into the intrusion is ongoing, our initial focus was on the integrity of=
=20
> the software and distribution channel for both sites.
>
> To date, our investigation has not discovered any compromised code or=20
> binaries available for download on these sites. However, we cannot fully=
=20
> rule out the possibility that some compromised code or binaries were=20
> available for download at some point in the past. Further, we can no=20
> longer trust the integrity of the Ceph signing key, and therefore have=20
> created a new signing key (id E84AC2C0460F3994) for verifying downloads.=
=20
> This new key is committed to the ceph.git repository and is=20
> also available from
>
> 	https://git.ceph.com/release.asc
>
> The new key should look like:
>
> pub   4096R/460F3994 2015-09-15
> uid                  Ceph.com (release key) <security@ceph.com>
>
> All future release git tags will be signed with this new key.
>
> This intrusion did not affect other Ceph sites such as download.ceph.com=
=20
> (which contained some older Ceph downloads) or git.ceph.com (which mirror=
s=20
> various source repositories), and is not known to have affected any other=
=20
> Ceph community infrastructure.  There is no evidence that build system or=
=20
> the Ceph github source repository were compromised.
>
> New hosts for ceph.com and download.ceph.com have been created and the=20
> sites have been rebuilt.  All content available on download.ceph.com as=20
> been verified, and all ceph.com URLs for package locations now redirect=20
> there.  There is still some content missing from download.ceph.com that=20
> will appear later today: source tarballs will be regenerated from git, an=
d=20
> older release packages are being resigned with the new release key DNS=20
> changes are still propogating so you may not see the new versions of the=
=20
> ceph.com and download.ceph.com sites for another hour or so.

It would be nice to have a way to verify the integrity of tarballs
downloaded from http://download.ceph.com/tarballs/. Could you please add
individual signatures or an sha256sum file signed with your release key.
This is important for people building from source tarballs and
distribution packagers baseing their packages from tarballs. Debian and
Ubuntu packages are currently built from them.

Gaudenz

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVgKhYs3PKyWkzVd5AQpXvBAAge1HOJz2CbR1pNrBVGy3eIpWTJTC/08E
DWNAz6An8JFTjhflpoQ0zrMsvF/PzDNlNJ0LheoNKjRklMVOqygiFW/BC5BjcClU
Xyc5y/SVbZNnL8x8n/mKxgRIdBaTt5dQ2LPIXO6pKW5aSKlPSZyQAKqx0XzdW0zX
dgRJ4+HJsvDGH7rZqs730tv2NqHLylDXahWQJTYCqBhmKU5ZJ5deCBT1Y3WezcV0
0kBOdqiUMK5QNIrseKZBCQ03NGNn2plyHPDni/+DOvnzkW1+KOXNruEsK6G7QiIX
0AuJGZX4UNbuPGKxj8qh8wHVk6HnibsuA9faopkrVX2+++ssbh44XKE07KceOSnX
PYJT7cfszgr1n+DcHehBmWkeUkkSm5bDX/ZCdyBUsOSzFroErUsP+/RQT2RurRhe
WrI4LAMnUEwyhakLncsCtVY1bbUR7wjHfSWlSiZcAE14O91gP9iLlB+CbZTl0jkN
3OZj8wtj53305jGzk0pj4yxdqnv93bQMCyROBipDuLOphZ5ZGuphhCq2mTFUqkIW
MCbB91RNX0j968iO7v7BHQKj9feSEetODcV7Kgp7I/BUTvod3sXaZo3lmdcpT6Cz
s/nveJpmhY89sCl7VIGGPy33aNWdtcdIJWd/zol0c4ZpVYOuy6nj7hzxGwnQWSR/
rlAg3p28K8Q=
=kO6W
-----END PGP SIGNATURE-----
--=-=-=--
