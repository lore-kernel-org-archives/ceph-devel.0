From: Loic Dachary <loic@dachary.org>
Subject: Re: Pyramid erasure codes and replica hinted recovery
Date: Sun, 12 Jan 2014 20:37:28 +0100
Message-ID: <52D2EEF8.8020009@dachary.org>
References: <CAHxYaFMa_peMz8StZpJ=if0W4LmHBDO71vNnYnmgcNMab0-3aQ@mail.gmail.com>	<52D1F060.8050108@dachary.org> <CAHxYaFOg6N2ZP1=OuOWajXUqMFtGsq0u94DG=Ub8NcAaqFtj+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="rEF4X410qJtDOCuwvriSJ47kF8HSPuJH5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41458 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbaALThg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 12 Jan 2014 14:37:36 -0500
In-Reply-To: <CAHxYaFOg6N2ZP1=OuOWajXUqMFtGsq0u94DG=Ub8NcAaqFtj+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rEF4X410qJtDOCuwvriSJ47kF8HSPuJH5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 12/01/2014 15:31, Kyle Bader wrote:
>> If we had RS(6:3:3) 6 data chunks, 3 coding chunks, 3 local chunks, th=
e following rule could be used to spread it over 3 datacenters:
>>
>> rule erasure_ruleset {
>>         ruleset 1
>>         type erasure
>>         min_size 3
>>         max_size 20
>>         step set_chooseleaf_tries 5
>>         step take root
>>         step choose indep 3 type datacenter
>>         step choose indep 4 type device
>>         step emit
>> }
>>
>> crushtool -o /tmp/t.map --num_osds 500 --build node straw 10 datacente=
r straw 10 root straw 0
>> crushtool -d /tmp/t.map -o /tmp/t.txt # edit the ruleset as above
>> crushtool -c /tmp/t.txt -o /tmp/t.map ; crushtool -i /tmp/t.map --show=
-bad-mappings --show-statistics --test --rule 1 --x 1 --num-rep 12
>> rule 1 (erasure_ruleset), x =3D 1..1, numrep =3D 12..12
>> CRUSH rule 1 x 1 [399,344,343,321,51,78,9,12,274,263,270,213]
>> rule 1 (erasure_ruleset) num_rep 12 result size =3D=3D 12:  1/1
>>
>> 399 is in datacenter 3, node 9, device 9 etc. It shows that the first =
four are in datacenter 3, the next in datacenter zero and the last four i=
n datacenter 2.
>>
>> If the function calculating erasure code spreads local chunks evenly (=
 321, 12, 213 for instance ), they will effectively be located as you sug=
gest. Andreas may have a different view on this question though.
>>
>> In case 78 goes missing ( and assuming all other chunks are good ), it=
 can be rebuilt with 512, 9, 12 only. However, if the primary driving the=
 reconstruction is 270, data will need to cross datacenter boundaries. Wo=
uld it be cheaper to elect a primary closest ( in the sense of get_common=
_ancestor_distance https://github.com/ceph/ceph/blob/master/src/crush/Cru=
shWrapper.h#L487 ) to the OSD to be recovered ? Only Sam or David could g=
ive you an authoritative answer.
>=20

There is a typo : "rebuilt with 51, 9, 12"

> That scheme does work out, except I'm not sure how the
> recovering/remapped OSD can makes sure to read the local copies. I'll
> wait to hear what Sam and David have to say. That said, what do you
> think of this diagram of a 12,2,2:
>=20
> http://storagemojo.com/wp-content/uploads/2012/09/LRC_parity.PNG from [=
4]
>=20
> With a 12,2,2 LRC code the stripe is split into 12 units, those 12
> units are used to generate 2 global parity units. The original 12
> units are then split into 2 groups, and each group separately
> generates an additional local parity unit. Each group of 6 original
> units and 1 parity unit are passed through CRUSH for placement with a
> common ancestor (for local recovery). This would be low overhead,
> certainly less than a replicated, and be friendlier on inter-dc links
> during remapping and recovery.
>=20
> [4] http://storagemojo.com/2012/09/26/more-efficient-erasure-coding-in-=
windows-azure-storage/
>=20

How is it different from what is described above ? There must be somethin=
g I fail to understand.

In the above example

CRUSH rule 1 x 1 [399,344,343,321,51,78,9,12,274,263,270,213]

would be

datacenter 3
399 data
344 data
343 global parity
321 local parity

datacenter 0
51 data
78 data
9 global parity
12 local parity=20

datacenter 2
274 data
263 data
270 global parity
213 local parity

If 9 is missing, recovery looks for the chunks that have the closest comm=
on ancestor, finds 51, 78, 12 and since there only is one missing chunk u=
ses local parity chunk 12 to rebuild it. If 9 and 12 are missing, it need=
s all remaining data + global parity chunks to rebuild. In this example t=
he overhead of erasure coding is high but increasing the number of data c=
hunks reduces it.

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--rEF4X410qJtDOCuwvriSJ47kF8HSPuJH5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLS7vkACgkQ8dLMyEl6F21hNQCdGgjeIL4U50g6C+vKg3eRtTiF
e2cAnjhb4iC3YHP2b99ZqcEByL+AMfNo
=HXfO
-----END PGP SIGNATURE-----

--rEF4X410qJtDOCuwvriSJ47kF8HSPuJH5--
