From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Standalone libcrush: call for participation
Date: Mon, 23 Jan 2017 13:02:12 -0500
Message-ID: <20170123180211.GB8639@ultraspiritum.eng.arb.redhat.com>
References: <ea88fb94-f48f-0c2c-2ffb-4019bed66fc5@dachary.org>
 <20170123162905.GA8639@ultraspiritum.eng.arb.redhat.com>
 <cdb4c456-d15b-5630-2453-af94d1de0ba7@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750738AbdAWSEE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 23 Jan 2017 13:04:04 -0500
Content-Disposition: inline
In-Reply-To: <cdb4c456-d15b-5630-2453-af94d1de0ba7@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23/01/2017, Loic Dachary wrote:
> Hi Adam, I don't know :-) Unless I'm mistaken the code in the linux
> kernel is an unmodified copy of the code from src/crush/*.[ch]. I
> however have no clue how it is tested to work as it should in both
> contexts. Other than running integration tests with teuthology.
>=20
> How do you suggest we go about it ?

I don't actually know. I just wondered, I had the vague impression
that the CRUSH from Ceph was copied into the kernel but I didn't know
who did it, if it was parallel development or a blanket copy or
what.

It /does/ mean that any changes to libcrush have to be kept as kernel
compatible C code, which isn't bad, it's just good to make sure it's
explicit.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJYhkUeXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jo4AH/A7I5AESSqZBLGnzJIrW813j
b8XNimsNN14UoFM6n+1ppyaOxLOum+7HQ1zAAxGQ12RB8rIT7YJso+IGraKXbu+3
k6t3cOINUPS7bm8hJgfp5iVdEFWgIATOHUq4QbfxG39y1dvMrE/5FfqPL+W+HzUt
bKz0J4G2ywrEKy3Zap/FDczG8tgyDZKn4hdmJR9vWjUHnT5UKgMtB9heiaDimAVF
Foruhs4Z87PSlY1ewRDKVfX+3MHD+rueqRGMjuDIHXVZkqLANj2ymqTyDfveX3tG
RwSnS62RDw1G5Z0EJRoceANDj06LggzO9VDHhsoGFBXzUT6mNRj9NsxVqurWhEw=
=gThN
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
