From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Mon, 25 Jan 2016 12:22:53 -0500
Message-ID: <20160125172252.GA2818@ultraspiritum.redhat.com>
References: <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <56A368C1.8000508@digiware.nl>
 <747915460.23855157.1453580447803.JavaMail.zimbra@redhat.com>
 <20160123215543.GA8011@ultraspiritum.redhat.com>
 <56A4BB20.1040305@digiware.nl>
 <56A4C8D2.6020303@digiware.nl>
 <20160125000337.GA19230@ultraspiritum.redhat.com>
 <56A5E61E.80705@digiware.nl>
 <2002283349.16405061.1453715910495.JavaMail.zimbra@redhat.com>
 <56A5FF84.8080107@digiware.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43617 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932071AbcAYRWz (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 25 Jan 2016 12:22:55 -0500
Content-Disposition: inline
In-Reply-To: <56A5FF84.8080107@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Erwan Velu <evelu@redhat.com>, Matt Benjamin <mbenjamin@redhat.com>, Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 25/01/2016, Willem Jan Withagen wrote:
> I would even keep it in the code so that somebody looking at it understan=
ds
> that the system default for a reason to slower POSIX.
> Especially in porting circumstances this is important.
> And even more so, now it is almost impossible to detect this compiletime.
[snip]
> Come to think of it, it might even warrant a #warning line in the POSIX
> case,
> to suggest to look into the 'man clock_gettime' page and see if the new OS
> has
> something better.

All right, I have pushed another version with comments and warnings.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWplnkXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jv2kH/3eiPlNcijb8GmdRnPhRqYdO
k2jNzfWatmuXVXPoAZQFjcIkj2puX1J/RUADvQsXVgrAPTBc34d6DyitpZLiGkoE
azV5uxQfL+ENaeDy8/YkJLJu1BicVKgxTi/AqdWsXGfAIpqZMN5DDVs3XF1Ibkjo
gBIjYLE+9iQTYLfu4GShUBiuzPoCKONPiUxA7DdhK3MiJkKJbNvKjwPwX98nAKQp
w4LKE6cUTO4lSH4QAFrP9kbBZWiVgDEOYgl98ezSotiCA+k6jb78a/KcFtAqnDZD
AEhwhzBeyoZDHnHd8XwLbpAE5nNMcU0H0eQQS/Ds+P4MGLs8ZbU9J2PsnO4+ncA=
=FKhs
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
