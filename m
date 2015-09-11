From: Sebastien Han <seb@redhat.com>
Subject: Re: osd: new pool flags: noscrub, nodeep-scrub
Date: Fri, 11 Sep 2015 15:11:24 +0200
Message-ID: <E94976F6-E5E7-4BC6-BC6D-FB6E1BAA3754@redhat.com>
References: <20150911064256.GA12899@gmail.com> <CAJ4mKGZPXnH+z=aBp7vLY35pj4JXq6c_Sq1PFknWj5y0fs2-zQ@mail.gmail.com> <20150911124704.GB12899@gmail.com> <alpine.DEB.2.00.1509110559300.7527@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: multipart/signed; boundary="Apple-Mail=_12D08022-6532-407E-AC33-20C2FC6687C7"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46614 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbbIKNL2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 11 Sep 2015 09:11:28 -0400
In-Reply-To: <alpine.DEB.2.00.1509110559300.7527@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, Gregory Farnum <gfarnum@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--Apple-Mail=_12D08022-6532-407E-AC33-20C2FC6687C7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I like the idea of being able to control on which pool we want to run =
scrub on.
Some data might deserve better protection than others, it=E2=80=99s =
really up to the admin.

The default behaviour will be to apply scrub to default pool and every =
new created pools.
The operator can change this behaviour either with a config flag or =
directly with a ceph mon command.

> On 11 Sep 2015, at 14:59, Sage Weil <sweil@redhat.com> wrote:
>=20
> On Fri, 11 Sep 2015, Mykola Golub wrote:
>> On Fri, Sep 11, 2015 at 11:08:29AM +0100, Gregory Farnum wrote:
>>> On Fri, Sep 11, 2015 at 7:42 AM, Mykola Golub <mgolub@mirantis.com> =
wrote:
>>>> Hi,
>>>>=20
>>>> I would like to add new pool flags: noscrub and nodeep-scrub, to be
>>>> able to control scrubbing on per pool basis. In our case it could =
be
>>>> helpful in order to disable scrubbing on cache pools, which does =
not
>>>> work well right now, but I can imagine other scenarios where it =
could
>>>> be useful too.
>>>=20
>>> Can you talk more about this? It sounds to me like maybe you dislike
>>> the performance impact of scrubbing, but it's fairly important in
>>> terms of data integrity. I don't think we want to permanently =
disable
>>> them. A corruption in the cache pool isn't any less important than =
in
>>> the backing pool ? it will eventually get flushed, and it's where =
all
>>> the reads will be handled!
>>=20
>> I was talking about this:
>>=20
>> http://tracker.ceph.com/issues/8752
>>=20
>> (false-negative on a caching pool). Although the best solution is
>> definitely to fix the bug, I am not sure it will be resolved soon =
(the
>> bug is open for a year). Still these false-negatives are annoying, as
>> they complicate monitoring for real inconsistent pgs. In this case I
>> might want to disable periodic scrub for caching pools, as a
>> workaround (I could do scrub for them manually though).
>>=20
>> This might be not the best example where these flags could be helpful
>> (I just came to the idea when thinking about a workaround for that
>> problem, and this looked useful to me in general). We already have
>> 'ceph osd set no[deep-]scrub', and users use it to temporary resolve
>> high I/O load. Being able to do this per pool looks useful too.
>>=20
>> You might have pools of different importance for you, and disabling
>> scrub for some of them might be ok.
>=20
> I wonder if, in addition, we should also allow scrub and deep-scrub
> intervals to be set on a per-pool basis?
>=20
> sage
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers.
=E2=80=93=E2=80=93=E2=80=93=E2=80=93
S=C3=A9bastien Han
Senior Cloud Architect

"Always give 100%. Unless you're giving blood."

Mail: seb@redhat.com
Address: 11 bis, rue Roqu=C3=A9pine - 75008 Paris


--Apple-Mail=_12D08022-6532-407E-AC33-20C2FC6687C7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJV8tL9AAoJELTV9b7anxYRfUMQALNpMA1aBA0yWdEYExdJZuUP
wJ8T2emBG5zkNIcCVOyBmeqAhfD+4CZQ6GMiQBV6IP6kqfxV+kHdMSvl2hKqklb5
nAlCdxmqNF/awvIOqi+OhIGVmzRHehdKYDU9aCktQ5aTNA2W6GZAkYDcWjvBOqZp
ZLGhCrd8KjcMKgqI1k6rFgBOLQoyeBTrIp8oRmdVOcnWfDSJiYTmyLC93kkKckxa
1fFjupBSQ0OkjZiIB1znlrz70Jck3TBp+5EG2kKHDjeQ7qTn2y4OcNN+i4EACd2s
nkz50GqRrLC5AEB64OrW+vyTtiTgMAhYw4LL690H7yqA9pe1BOchILXSf9mB8/T9
7hIhcCH0ez/3SWDmDQGNF1Qq6RrSxWj2I6qZyk+5QDIx366lnAHiJ4nW5GqOpbEK
Kirqz3/uwzTz3z5XwHgKa56GnO4wtooSfdyUhI2GoNeG5Wmg2qP0KtZ7dhkiJ49P
N2kOQE9pwI8vry7RMkJvJb0xn4vxEaixYU7DXzLTQzoU6+KuFv1XdVQu5Vy9kAu1
wh9TS66jdbVHx5/2oKD/NL9MZQ39iGyDnLkWv3W9ov7UA9d0FzuFm4Apm72uiFdK
z49+6TaZn9VFu9cqh2Lm/7e7WJO59/sSwjGBKMSZhctzzqeAe+gRsM8xaWu1Wx7P
BZSmyBsDuoibTUYLYJ1i
=gaEh
-----END PGP SIGNATURE-----

--Apple-Mail=_12D08022-6532-407E-AC33-20C2FC6687C7--
