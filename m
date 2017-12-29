From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: RGW RFC: Multiple-Data-Pool Support for a Bucket
Date: Fri, 29 Dec 2017 05:12:25 +0000
Message-ID: <robbat2-20171229T050412-905407403Z@orbis-terrarum.net>
References: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
 <CAOi4hNcp6b-r2OqrExCoxNyBv9HtwivCm1xm+Jh=xu1_YJA3ZQ@mail.gmail.com>
 <CAFZHTOYrJ0VdjrU5Yne3ZKL1Go0Hb8uJ3Xdzk8NPkwJwPrdueA@mail.gmail.com>
 <CAOi4hNc5Romj5BMJgp6W=OOoW_08b27PDHoymu+00Ok_Mq14xA@mail.gmail.com>
 <CAFZHTOYwnOy6y4hL9mqEdcmxhmBsHWrX2eDZxsrwq-Ly21eT=g@mail.gmail.com>
 <robbat2-20171229T034038-863364066Z@orbis-terrarum.net>
 <CAFZHTOauW9JQqdAZnCE+JiWigNAEH1n+YmYN9WO9oPDu2oHejg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:44188 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750725AbdL2FM1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 29 Dec 2017 00:12:27 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id DA81234165F
        for <ceph-devel@vger.kernel.org>; Fri, 29 Dec 2017 05:12:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAFZHTOauW9JQqdAZnCE+JiWigNAEH1n+YmYN9WO9oPDu2oHejg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeegn Chen <jeegnchen@gmail.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, yuxiang fang <abcdeffyx@gmail.com>, Yehuda Sadeh-Weinraub <yehuda@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2017 at 01:01:25PM +0800, Jeegn Chen wrote:
> Hi Robin
>=20
> > Rough implementation:
> > - For writes, the RGW zone data describes which pool maps to each
> >   storage class.
> >   (corner case: multipart uploads might need each part in a consistent =
pool)
> [Jeegn]: Do you mean mean different placement polices are
> corresponding to STORAGE CLASSes?
Yes, placement_pools are already most of the way to storage class behavior,=
 but
they seemingly were modeled after Swift rather than S3.

> > - The bucket-index data already describes the RADOS POOL to _read_ from
> >   (corner case: old buckets/objects don't have this set)
> [Jeegn]: Are you referring to the tail_bucket in the RGWObjManifest,
> which is somewhat a copy of placement rule? Currently, it seems to
> support the copy across buckets with the same data pool and I have not
> found the logic to deal with different pools. But yes, maybe we can
> reuse it instead of add additional xattr to track the tail pools.
I haven't confirmed exactly where in the codebase it is, but visible in
the 'radosgw-admin bi get/list' output is the pool ID.

In the following snippet, look at entry.ver.pool. That's the ID for my
=2Ergw.data.1 pool.

$ sudo radosgw-admin --bucket CENSORED bi list --object .bash_profile
[
    {
        "type": "plain",
        "idx": ".bash_profile",
        "entry": {
            "name": ".bash_profile",
            "instance": "",
            "ver": {
                "pool": 5,
                "epoch": 100414
            },
            "locator": ".bash_profile",
            "exists": "true",
            "meta": {
                "category": 1,
                "size": 81,
                "mtime": "2015-07-02 15:31:59.000000Z",
                "etag": "8040ef233daa49c60b93cb3a45617e19",
                "owner": "CENSORED",
                "owner_display_name": "CENSORED",
                "content_type": "application\/octet-stream",
                "accounted_size": 81,
                "user_data": ""
            },
            "tag": "default.136713729.262057859",
            "flags": 0,
            "pending_map": [],
            "versioned_epoch": 0
        }
    }
]

> > - radosgw-admin already contains bucket/object rewrite functionality,
> >   that would effectively copy from an old pool into the new pool.
> >   (note: I don't think is well-documented at all)
> [Jeegn]: Are you talking about "radosgw-admin bucket rewrite"? But per
> check through RGWRados::rewrite_obj() and check_min_obj_stripe_size()
> in the master branch, the functionality is used to migrate from
> explicit-obj implementation to manifest implementation. Or you mean
> some command else or some implementation wip?
I think this functionality is close enough for slight modifications to
get what we want, of a manifest-to-manifest rewrite.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlpFzrhfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsQyTA/+LNcnaHR7p90zCZ7iyU2GedTrc56bJ5LQgXZa3is9rny5PW/MUxHhXVOc
8xvf1COWj1YduTOPpYo+S/OOjMsmQ//XOzM9URrIUe+dzhw7k9btgowqkziaj9gL
+ODJC5LZ0LergWgLx4W9CCBrAVz5uia3drHmvTISI0YGXKxD0/2vulLtsc13mDQb
Hfl9fTzxhsXFTBtWrUCDUT4JZ+LqO6lY2GqMNlMnGaRufdnVnVFzb+SEBXBRxnga
k9Py19UQ5DtvE1vWXovHROBAti5kMNWhYdJSwFGj/AXgK8zweQrCHj/xuOkWblLR
qjkHTpiUpx/mSMiAZk4ndo/9AAVp7URYMSwW5BrqBN8yBryviDBazpVoMNjVlHHo
0GN1KutD63Y3Nj2GJfjdLDUEuYI8WSgrv03V8IHDBKgVqRI4FW45wsislOHciUZo
pAcHWm9V0u+gJwv0BqcSLq1SpumFaEHd2ZaX3jpg711GLUx9uUqVLEluhaT0k47p
Iyay2Joh2OBIMN669oj6M26ohu+EMzp/yrBfdLgsKzrpJrJIge5I8ALQxxLYhdXr
5Vj/bDnatZn4xf8UHOhFBpj3uVgaffxMKY0uqo+8MfPRp2B+XKoenx4mYP6v2ZaY
aFSg0wgCj0xl1nnCFLFlI8Rjdn7BN1JOOogPLj+KSOQwd8f+KPk=
=27A3
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
