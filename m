From: Loic Dachary <loic@dachary.org>
Subject: Re: [PATCH] buffer::ptr::cmp only compares up to the smallest length
Date: Sun, 17 Feb 2013 09:19:06 +0100
Message-ID: <5120927A.9090307@dachary.org>
References: <1361065465-11115-1-git-send-email-loic@dachary.org> <alpine.DEB.2.00.1302161806540.25660@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC6246B4197B0CF043C71605E"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:33832 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab3BQITL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Feb 2013 03:19:11 -0500
In-Reply-To: <alpine.DEB.2.00.1302161806540.25660@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC6246B4197B0CF043C71605E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

My bad, indeed. I'll resubmit a patch.

Cheers

On 02/17/2013 03:11 AM, Sage Weil wrote:
> On Sun, 17 Feb 2013, Loic Dachary wrote:
>> When running
>>
>>   bufferptr a("A", 1);
>>   bufferptr ab("AB", 2);
>>   a.cmp(ab);
>>
>> it returned zero because cmp only compared up to the length of the
>> smallest buffer. The tests comparing the length of the buffers are
>> moved before the memcmp comparing the actual content of the buffers.
>>
>> http://tracker.ceph.com/issues/4170 refs #4170
>>
>> Signed-off-by: Loic Dachary <loic@dachary.org>
>=20
> The problem here is that for B cmp AB, we should be 1, because 'B' > 'A=
'. =20
> The length only matters if we reach the end and everything so far is=20
> equal.
>=20
>> ---
>>  src/common/buffer.cc   |    8 +-------
>>  src/test/bufferlist.cc |   14 ++++++++++++++
>>  2 files changed, 15 insertions(+), 7 deletions(-)
>>
>> diff --git a/src/common/buffer.cc b/src/common/buffer.cc
>> index e10d6c9..5a88849 100644
>> --- a/src/common/buffer.cc
>> +++ b/src/common/buffer.cc
>> @@ -368,17 +368,11 @@ bool buffer_track_alloc =3D get_env_bool("CEPH_B=
UFFER_TRACK");
>> =20
>>    int buffer::ptr::cmp(const ptr& o)
>>    {
>> -    int l =3D _len < o._len ? _len : o._len;
>> -    if (l) {
>> -      int r =3D memcmp(c_str(), o.c_str(), l);
>> -      if (!r)
>> -	return r;
>=20
> I think this is the bug.. it should be if (r) return r, and fall throug=
h=20
> below only if r =3D=3D 0 because the buffers are equal.
>=20
> sage
>=20
>> -    }
>>      if (_len < o._len)
>>        return -1;
>>      if (_len > o._len)
>>        return 1;
>> -    return 0;
>> +    return memcmp(c_str(), o.c_str(), _len);
>>    }
>> =20
>>    bool buffer::ptr::is_zero() const
>> diff --git a/src/test/bufferlist.cc b/src/test/bufferlist.cc
>> index 71c2e79..aac41c6 100644
>> --- a/src/test/bufferlist.cc
>> +++ b/src/test/bufferlist.cc
>> @@ -9,6 +9,20 @@
>> =20
>>  #define MAX_TEST 1000000
>> =20
>> +TEST(BufferPtr, cmp) {
>> +  bufferptr empty;
>> +  bufferptr a("A", 1);
>> +  bufferptr ab("AB", 2);
>> +  bufferptr af("AF", 2);
>> +  EXPECT_GE(-1, empty.cmp(a));
>> +  EXPECT_LE(1, a.cmp(empty));
>> +  EXPECT_GE(-1, a.cmp(ab));
>> +  EXPECT_LE(1, ab.cmp(a));
>> +  EXPECT_EQ(0, ab.cmp(ab));
>> +  EXPECT_GE(-1, ab.cmp(af));
>> +  EXPECT_LE(1, af.cmp(ab));
>> +}
>> +
>>  TEST(BufferList, zero) {
>>    //
>>    // void zero()
>> --=20
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enigC6246B4197B0CF043C71605E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEgknoACgkQ8dLMyEl6F20trQCgvApzSYjU9fQ/70E4dyWoAReO
hd8An0gixiZjZGwZjAE+ZFE1DQ8Wbe17
=5WU+
-----END PGP SIGNATURE-----

--------------enigC6246B4197B0CF043C71605E--
