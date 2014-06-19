From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] erasure pool & crush ruleset
Date: Thu, 19 Jun 2014 18:52:10 +0200
Message-ID: <53A3153A.4080800@dachary.org>
References: <9287C0F3-A7D6-43F2-803B-7BDA1C745C00@inasan.ru> <53A30FCE.9040800@dachary.org> <17880B77-EBB1-4201-8C01-268C14ADF2B3@inasan.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pR4vXVjj7KMliIVucT9vnafpn4UcJ8GmK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:49780 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932213AbaFSQwN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Jun 2014 12:52:13 -0400
In-Reply-To: <17880B77-EBB1-4201-8C01-268C14ADF2B3@inasan.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Pavel V. Kaygorodov" <pasha@inasan.ru>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pR4vXVjj7KMliIVucT9vnafpn4UcJ8GmK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 19/06/2014 18:33, Pavel V. Kaygorodov wrote:
>=20
> This ruleset works well for replicated pools with size 6 (I have tested=
 it on data and metadata pools, which I cannot delete).=20
> The erasure pool with k=3D3 and m=3D3 must have size 6?

Yes. However, the algorithm is slightly different and depending on the nu=
mber of devices you actually have, it may fail where a replicated ruleset=
 works.

>=20
> Pavel.
>=20
>> On 19/06/2014 18:17, Pavel V. Kaygorodov wrote:
>>> Hi!
>>>
>>> I want to make erasure-coded pool with k=3D3 and m=3D3. Also, I want =
to distribute data between two hosts, having 3 osd from host1 and 3 from =
host2.
>>> I have created a ruleset:
>>>
>>> rule ruleset_3_3 {
>>>        ruleset 0
>>>        type replicated

You need:

type erasure

>>>        min_size 6
>>>        max_size 6
>>>        step take host1
>>>        step chooseleaf firstn 3 type osd
>>>        step emit
>>>        step take host2
>>>        step chooseleaf firstn 3 type osd
>>>        step emit
>>> }

Cheers

>> Hi,
>>
>> I suggest you test the ruleset created with crushtool to check if what=
 comes out of it is what you expect. It's quite convenient to use multipl=
e of 10 to visually match the result. For instance=20
>>
>>    crushtool -o /tmp/t.map --num_osds 500 --build node straw 10 datace=
nter straw 10 root straw 0
>>
>> then you can
>>
>>    crushtool -c /tmp/t.txt -o /tmp/t.map ; crushtool -i /tmp/t.map --s=
how-bad-mappings --show-statistics --test --rule 1 --x 1 --num-rep 12
>>
>> This is the general idea and you can find details about this in the cr=
ushtool help and the test scripts at
>>
>>    https://github.com/ceph/ceph/tree/master/src/test/cli/crushtool
>>
>> for instance
>>
>>    https://github.com/ceph/ceph/blob/master/src/test/cli/crushtool/bad=
-mappings.t
>>
>> which shows what happens when there is a "bad mapping", i.e. the crush=
map could not be used to get the number of OSD you want. This is most pro=
bably why pg get stuck.
>>
>> Cheers
>>
>>> I have created an erasure code profile:
>>>
>>> ceph osd erasure-code-profile set def33 k=3D3 m=3D3
>>>
>>> I have created a pool:
>>>
>>> ceph osd pool create images 2048 2048 erasure def33 ruleset_3_3
>>>
>>> Now I see 2048 pgs permanently in "creating" state.
>>>
>>> What is wrong?
>>>
>>> Pavel.
>>>
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users@lists.ceph.com
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre




--pR4vXVjj7KMliIVucT9vnafpn4UcJ8GmK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOjFTsACgkQ8dLMyEl6F20SKgCeI0qwyXGgu7vhDlkHE2Sz1P4B
y/IAoKG0eUUB/tBi4gb3kt/OraZX9rZ0
=n9Y1
-----END PGP SIGNATURE-----

--pR4vXVjj7KMliIVucT9vnafpn4UcJ8GmK--
