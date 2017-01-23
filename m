From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Standalone libcrush: call for participation
Date: Mon, 23 Jan 2017 11:29:05 -0500
Message-ID: <20170123162905.GA8639@ultraspiritum.eng.arb.redhat.com>
References: <ea88fb94-f48f-0c2c-2ffb-4019bed66fc5@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdAWQaw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Jan 2017 11:30:52 -0500
Content-Disposition: inline
In-Reply-To: <ea88fb94-f48f-0c2c-2ffb-4019bed66fc5@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/01/2017, Loic Dachary wrote:
[snip]
> The beginning of the next ceph release cycle seems like a good time
> to initiate that effort. If someone is willing to help with the
> bootstrap, now is a good time. The library will be hosted under the
> libcrush.org domain name. But that's about the only thing that
> happened so far :-)

Would the Ceph git repository continue to have its own version of
CRUSH included, or would we pull in libcrush as a submodule?

Also, does this affect the relationship between userspace CRUSH and
Linux kernel CRUSH?

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJYhi9HXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jRn4H/2D9gVl8VLKPmttqHVweCQgG
jJXDpAv80WZQJnjM+wKIl2H06IqZS5e8s9Nmr+297WTHXb0EehwReEIA7L8aTjQH
qYGoaSpSXTO4BZUAL0RNB+rtUZTH/rWlBkOaBadcbHkFtLfrqMufVTLTsgYDTf/Q
0SXPxoZR/ccCNMxpfY1FlyB+EBcZ8ZTTicr+qQgcJLK1uHVVuVZvbRl8n3pwmvc1
oeR4I6K6wkE+erx/Qt7/Cmr9/dOPBe/kuW9DLEHxb+NF4u7MX3SvGHs/zIom8pQw
q2/n87xty/dJpm56MUJTYKAX/ajn6eQ3K9CeO7rkfshQcUfehTTAfxx3dT0L9zs=
=8RsQ
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
