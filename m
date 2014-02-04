From: Loic Dachary <loic@dachary.org>
Subject: Re: caching get_chunk_size()
Date: Tue, 04 Feb 2014 17:40:40 +0100
Message-ID: <52F11808.90603@dachary.org>
References: <52EE5EE6.7010904@dachary.org> <CA+4uBUYFdHQEf40-s137MnS7fFA52ddqJL_714xW0C-4yQtyQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="kkbO1Qi7LL3eoE6OFWjHRmbW4CP0I87qv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:32937 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbaBDQkn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2014 11:40:43 -0500
In-Reply-To: <CA+4uBUYFdHQEf40-s137MnS7fFA52ddqJL_714xW0C-4yQtyQA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kkbO1Qi7LL3eoE6OFWjHRmbW4CP0I87qv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

Is there a branch somewhere where you have defined a config_opts for the =
desired strip size / chunk size ?

Cheers

On 02/02/2014 23:28, Samuel Just wrote:
> That looks about right to me.  It's handy to have a "ground truth" for
> everyone to ensure that they agree with.
> -Sam
>=20
> On Sun, Feb 2, 2014 at 7:06 AM, Loic Dachary <loic@dachary.org> wrote:
>> [cc' ceph-devel]
>>
>> Hi Sam,
>>
>> Assuming https://github.com/ceph/ceph/pull/1144 gets merged, MONs can =
query the plugin for a given pool or crush ruleset conveniently:
>>
>> https://github.com/dachary/ceph/blob/15c90fbf61445063967fc80ee1c916d70=
c593a54/src/mon/OSDMonitor.cc#L2803
>>
>>       ErasureCodeInterfaceRef erasure_code;
>>       err =3D get_erasure_code(properties, &erasure_code, ss);
>>       if (err =3D=3D 0)
>>          *size =3D erasure_code->get_chunk_count();
>>
>> And OSDs can do something similar (and must whenever an erasure coded =
pool is instantiated). If I understood correctly, you would like the resu=
lt of erasure_code->get_chunk_size(some_osd_config_opt_value_defining_the=
_stripe_size) to be set as a new value in pg_pool_t https://github.com/da=
chary/ceph/blob/15c90fbf61445063967fc80ee1c916d70c593a54/src/osd/osd_type=
s.h#L700 when the pool is created.
>>
>> The benefit of having pg_pool_t::chunk_size would be
>>
>> a) the value is shared cluster wide and does not depend on the specifi=
c version of the OSD/MON
>> b) if the value is needed frequently in a context where the plugin wou=
ld have to be loaded, this will improve performances
>>
>> However, whenever an OSD instantiates a PG that belongs to a pool, it =
must assert that the get_chunk_count() returned by the plugin matches the=
 value stored in pg_pool_t::chunk_size otherwise it will encode inconsist=
ently.
>>
>> If my reasoning matches yours, I'll implement the change. Otherwise, p=
lease correct me :-)
>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--kkbO1Qi7LL3eoE6OFWjHRmbW4CP0I87qv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLxGAgACgkQ8dLMyEl6F22zfACfaG8frP9WadWdY9eJM4/z5pFm
00EAoLKgorySqPIPZU7eWbq9KCV8ON+j
=5kI6
-----END PGP SIGNATURE-----

--kkbO1Qi7LL3eoE6OFWjHRmbW4CP0I87qv--
