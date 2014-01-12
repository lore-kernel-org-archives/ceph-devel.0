From: Loic Dachary <loic@dachary.org>
Subject: Re: Pyramid erasure codes and replica hinted recovery
Date: Sun, 12 Jan 2014 02:31:12 +0100
Message-ID: <52D1F060.8050108@dachary.org>
References: <CAHxYaFMa_peMz8StZpJ=if0W4LmHBDO71vNnYnmgcNMab0-3aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s6FGhmjuD2T2oJFMLu8MtstXuMssHFN9m"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:41133 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbaALBbW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Jan 2014 20:31:22 -0500
In-Reply-To: <CAHxYaFMa_peMz8StZpJ=if0W4LmHBDO71vNnYnmgcNMab0-3aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kyle Bader <kyle@inktank.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s6FGhmjuD2T2oJFMLu8MtstXuMssHFN9m
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 11/01/2014 00:40, Kyle Bader wrote:
> I've been researching what features might be necessary in Ceph to
> build multi-site RADOS clusters, whether for purposes of scale or to
> meet SLA requirements more stringent than is achievable with a single
> datacenter. According to [1], "typical [datacenter] availability
> estimates used in the industry range from 99.7% for tier II to 99.98
> and 99.995% for tiers II and IV respectively". Combine the possibility
> of border and/or core networking meltdown and it's all but impossible
> to achieve a Ceph service SLA that requires 3-5 nines of availability
> in a single facility.
>=20
> When we start looking at multi-site network configurations we need to
> make sure there is sufficient cluster level bandwidth for the
> following activities:
>=20
> 1. Write fan-out from replication on ingest
> 2. Backfills from OSD recovery
> 3. Backfills from OSD remapping
>=20
> Number 1 can be estimated based on historical usage with some
> additional padding for traffic spikes. Recovery backfills can be
> roughly estimated based on the size of the disk population in each
> facility and the OSD annualized failure rate. Number 3 makes
> multi-site configurations extremely challenging unless the
> organization building the cluster is willing to pay 7 zeros for 5
> nines.
>=20
> Consider the following:
>=20
> 1x 16x40GbE switch with 8x used for access ports, 8x used for
> inter-site (x4 10GbE breakout per port)
> 32x Ceph OSD nodes with a 10GbE cluster link (working out to ~3PB raw)
>=20
> Topology:
>=20
> [A]-----[B]
>   \       /
>    \     /
>     [C]
>=20
> Since 40GbE is likely only an option if running over dark fiber,
> non-blocking multi-site would require a total of 12 leased 10GbE
> lines, 6 for 2:1, and 3 for 4:1. These lines will be extremely
> stressed each and every time capacity is added to the cluster due to
> the fact that pgs will be remapped and the OSD that is new to the PG
> needing to be backfilled by the primary at another site (for 3x
> replication). Erasure coding with regular MDS codes or even pyramid
> codes will exhibit similar issues, as described in [2] and [3]. It
> would be fantastic to see Ceph have a facility similar to what I
> describe in this bug for replication:
>=20
> http://tracker.ceph.com/issues/7114
>=20
> For erasure coding, something similar to Facebook's LRC as described
> in [2] would be advantageous. For example:
>=20
> RS(8:4:2)
>=20
> [k][k][k][k][k][k][k][k] -> [k][k][k][k][k][k][k][k][m][m][m][m]
>=20
> Split over 3 sites
>=20
> [k][k][k][k]      [k][k][k][k]      [k][k][k][k]
>=20
> Generate 2 more parity units
>=20
> [k][k][k][k][m][m]  [k][k][k][k][m][m]   [k][k][k][k][m][m]
>=20
> Now if each *set* of units could be placed such that they share a
> common ancestor in the CRUSH hierarchy then local unit sets from the
> lower level of the pyramid could be remapped/recovered without
> consuming inter-site bandwidth (maybe treat each set as a "replica"
> instead of treating each individual unit as a "replica").
>=20
> Thoughts?

If we had RS(6:3:3) 6 data chunks, 3 coding chunks, 3 local chunks, the f=
ollowing rule could be used to spread it over 3 datacenters:

rule erasure_ruleset {
	ruleset 1
	type erasure
	min_size 3
	max_size 20
	step set_chooseleaf_tries 5
	step take root
	step choose indep 3 type datacenter
	step choose indep 4 type device
	step emit
}

crushtool -o /tmp/t.map --num_osds 500 --build node straw 10 datacenter s=
traw 10 root straw 0
crushtool -d /tmp/t.map -o /tmp/t.txt # edit the ruleset as above
crushtool -c /tmp/t.txt -o /tmp/t.map ; crushtool -i /tmp/t.map --show-ba=
d-mappings --show-statistics --test --rule 1 --x 1 --num-rep 12
rule 1 (erasure_ruleset), x =3D 1..1, numrep =3D 12..12
CRUSH rule 1 x 1 [399,344,343,321,51,78,9,12,274,263,270,213]
rule 1 (erasure_ruleset) num_rep 12 result size =3D=3D 12:	1/1

399 is in datacenter 3, node 9, device 9 etc. It shows that the first fou=
r are in datacenter 3, the next in datacenter zero and the last four in d=
atacenter 2.=20

If the function calculating erasure code spreads local chunks evenly ( 32=
1, 12, 213 for instance ), they will effectively be located as you sugges=
t. Andreas may have a different view on this question though.

In case 78 goes missing ( and assuming all other chunks are good ), it ca=
n be rebuilt with 512, 9, 12 only. However, if the primary driving the re=
construction is 270, data will need to cross datacenter boundaries. Would=
 it be cheaper to elect a primary closest ( in the sense of get_common_an=
cestor_distance https://github.com/ceph/ceph/blob/master/src/crush/CrushW=
rapper.h#L487 ) to the OSD to be recovered ? Only Sam or David could give=
 you an authoritative answer.

Cheers

>=20
> [1] http://www.morganclaypool.com/doi/abs/10.2200/S00516ED2V01Y201306CA=
C024
> [2] http://arxiv.org/pdf/1301.3791.pdf
> [3] https://static.googleusercontent.com/media/research.google.com/en/u=
s/pubs/archive/36737.pdf
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--s6FGhmjuD2T2oJFMLu8MtstXuMssHFN9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLR8GEACgkQ8dLMyEl6F23KhgCfT7IbGAMQbw9DVxv9xmaNdC+Q
oyIAoIjG0vQaWn7KaYgO5dwp9tLsrYnY
=IDOc
-----END PGP SIGNATURE-----

--s6FGhmjuD2T2oJFMLu8MtstXuMssHFN9m--
