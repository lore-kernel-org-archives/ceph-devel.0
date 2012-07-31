From: Mehdi Abaakouk <sileht@sileht.net>
Subject: Re: About teuthology
Date: Tue, 31 Jul 2012 18:16:33 +0200
Message-ID: <20120731161633.GB23001@mail.sileht.net>
References: <20120731135955.GA23001@mail.sileht.net>
 <5017EB6A.5040104@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sileht.net ([178.33.111.110]:36119 "EHLO mail.sileht.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755205Ab2GaQQe (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 31 Jul 2012 12:16:34 -0400
Content-Disposition: inline
In-Reply-To: <5017EB6A.5040104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: ceph-devel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 31, 2012 at 09:27:54AM -0500, Mark Nelson wrote:
> On 7/31/12 8:59 AM, Mehdi Abaakouk wrote:
> Hi Mehdi,
>=20
> I think a number of the test related tasks should run fine without
> strictly requiring the ceph task.  You may have to change binary
> locations for things like rados, but those should be pretty minor.
>=20
> Best way to find out is to give it a try!

Thanks for your quick answer :)

I have already tried, but the code massively refers to files in
/tmp/cephtest/, it seems to me that changing the path of the=20
binaries isn't enough, some of them are built by the ceph task.

Perhaps a quicker (a bit dirty) way is to create a new task 'cephdist',
that prepares the required files in /tmp/cephtest.
ie:
- link dist binary to /tmp/cephtest/binary/usr/local/bin/...
- link /etc/ceph/ceph.conf to /tmp/cephtest/ceph.conf
- ship cephtest tool in /tmp/cephtest (like ceph task)
- make dummy script for coverage (because distributed ceph doesn't seem
  to have ceph-coverage)

What do you think about it ?

Cheers

--=20
Mehdi Abaakouk for eNovance
mail: sileht@sileht.net
irc: sileht

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQGATgAAoJEBiStC/OquvIn4cQAKVFvxQrG2FoarWGLA7lNnul
+uQxGkKd7LN1wnIhJHAq1pKMxbrW7fI0Cdzam2ZE593T75+kz1uA6iz8AUdUsKrS
KKK+Y3sCn+r9IKcpun/1lA24ZLV4K2NLlu0GgkcvAcVRj4R3f8g0zzMXTo974k8P
QMimPbhG77pRFjZiWby4tGrgyk+obWHOC8IV1RoEJnHeHvZ3+Uz7QWXJvWDr+B2U
yl5YY7CX6iRFtTIVms2HEsLZ824vEaDQH8A1Q9V0ChHf649Gk94vX+Fc0+xbmd5k
rnPIkjwH5QP0GleoSEaHV6pmO/hM20ibrU5OrFe7jRyjKXCsPcaR49/5O2bRVoSF
LHWPuD5nL9/FOs7jVbqwACj86v/05iyEMRUQeeORERdI6eeFY2BEZED9xqvcGW5J
4btNkaXT8hbnnSHLay2FzveRLyEoil3vs/32lyKyRaLigv79XPOABTO1RZn7lKaH
yaFTUqtJzcEv8ckdESKdxQY0KtQBD3xTIShxlqgOsT7AiOGTaXmm0dwVo8Bxqdti
BVnjpXgN0q/0SjkA2r5YTnYxNATr8S6v4c5utNcGeBmm3R1kztt9yvUU1f0L7vMj
evlMd7OjkxvjFKEubO6lBYOJidlsikhEiDqPAOKTirA6caMmYi6z/9lERxt0o8KW
Oktn30XqHF3hkxvYaOLn
=cMEQ
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
