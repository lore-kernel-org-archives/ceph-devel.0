From: Loic Dachary <loic@dachary.org>
Subject: v0.79 contributors credits
Date: Tue, 08 Apr 2014 08:54:47 +0200
Message-ID: <53439D37.2000809@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dq7gED2wQ5IClrb0mUHKMCfnqN0JqEw6v"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:43533 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbaDHHNm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Apr 2014 03:13:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Ceph Community <ceph-community@lists.ceph.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dq7gED2wQ5IClrb0mUHKMCfnqN0JqEw6v
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
79, by number of commits or reviews back to v0.78. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed.=20

If you are curious about how it is done, the details are at the end of th=
is mail.=20

Commits by authors
     1	    182 Sage Weil <sage@inktank.com>
     2	     94 Loic Dachary <loic@dachary.org>
     3	     70 Yan, Zheng <zheng.z.yan@intel.com>
     4	     44 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     5	     24 David Zafman <david.zafman@inktank.com>
     6	     21 John Spray <john.spray@inktank.com>
     7	     20 Samuel Just <sam.just@inktank.com>
     8	     15 Yehuda Sadeh <yehuda@inktank.com>
     9	     13 Josh Durgin <josh.durgin@inktank.com>
    10	     12 John Wilkins <john.wilkins@inktank.com>
    11	     11 Greg Farnum <greg@inktank.com>
    12	     11 Dan Mick <dan.mick@inktank.com>
    13	      9 Ilya Dryomov <ilya.dryomov@inktank.com>
    14	      7 Dmitry Smirnov <onlyjob@member.fsf.org>
    15	      6 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    16	      5 Warren Usui <warren.usui@inktank.com>
    17	      4 Sharif Olorin <sio@tesser.org>
    18	      4 Ken Dreyer <ken.dreyer@inktank.com>
    19	      3 Sandon Van Ness <sandon@inktank.com>
    20	      3 Alfredo Deza <alfredo.deza@inktank.com>
    21	      2 Mohammad Salehe <salehe+dev@gmail.com>
    22	      2 Huang Jun <hjwsm1989@gmail.com>
    23	      2 Guang Yang <yguang@yahoo-inc.com>
    24	      2 Gary Lowell <gary.lowell@inktank.com>
    25	      2 Florian Haas <florian@hastexo.com>
    26	      1 Wido den Hollander <wido@42on.com>
    27	      1 Sebastien Han <sebastien.han@enovance.com>
    28	      1 Paul Meserve <paul@pogodan.com>
    29	      1 Noah Watkins <noah.watkins@inktank.com>
    30	      1 Nikola Kotur <kotnick@gmail.com>
    31	      1 Michael Nelson <mikenel@tnld.net>
    32	      1 Kai Zhang <zakir.exe@gmail.com>
    33	      1 Jenkins <jenkins@inktank.com>
    34	      1 James Ryan Cresawn <jrcresawn@gmail.com>
    35	      1 Dan van der Ster <daniel.vanderster@cern.ch>
    36	      1 Allen Samuels <allen.samuels@sandisk.com>
Commits by organizations
     1	    343 Inktank <contact@inktank.com>
     2	     94 Cloudwatt <libre.licensing@cloudwatt.com>
     3	     70 Intel <contact@intel.com>
     4	     44 Deutsche Telekom <contact@telekom.de>
     5	      7 Debian GNU/Linux <contact@debian.org>
     6	      4 Anchor Hosting <contact@anchor.com.au>
     7	      3 Unaffiliated <no@organization.net>
     8	      2 Yahoo! <contact@yahoo-inc.com>
     9	      2 Hastexo <contact@hastexo.com>
    10	      2 Bayan <contact@bayan.co.ir>
    11	      1 Wido 42on <contact@42on.com>
    12	      1 The University of Arizona <contact@arizona.edu>
    13	      1 SanDisk <contact@sandisk.com>
    14	      1 Pogoapp <contact@pogoapp.com>
    15	      1 eNovance <contact@enovance.com>
    16	      1 Commerce Guys <contact@commerceguys.com>
    17	      1 CISCO <contact@cisco.com>
    18	      1 CERN <contact@cern.ch>
Reviews by authors (one review spans multiple commits)
     1	     76 Sage Weil <sage@inktank.com>
     2	     18 Samuel Just <sam.just@inktank.com>
     3	     14 Josh Durgin <josh.durgin@inktank.com>
     4	     10 Greg Farnum <greg@inktank.com>
     5	      5 Loic Dachary <loic@dachary.org>
     6	      5 Christophe Courtaut <christophe.courtaut@gmail.com>
     7	      4 Ken Dreyer <ken.dreyer@inktank.com>
     8	      3 Yehuda Sadeh <yehuda@inktank.com>
     9	      3 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    10	      2 Ilya Dryomov <ilya.dryomov@inktank.com>
    11	      1 Zheng Yan <zheng.z.yan@intel.com>
    12	      1 Warren Usui <warren.usui@inktank.com>
    13	      1 Wang, Yaguang <yaguang.wang@intel.com>
    14	      1 Tyler Brekke <tyler.brekke@inktank.com>
    15	      1 Stephan Renatus <s.renatus@x-ion.de>
    16	      1 Sharif Olorin <sio@tesser.org>
    17	      1 Mohammad Salehe <salehe+dev@gmail.com>
    18	      1 Haomai Wang <haomaiwang@gmail.com>
    19	      1 Guang Yang <yguang@yahoo-inc.com>
    20	      1 Dan Mick <dan.mick@inktank.com>
    21	      1 Christopher O'Connell <jwriteclub@gmail.com>
    22	      1 Andrey Kuznetsov <Andrey_Kuznetsov@epam.com>
    23	      1 Alfredo Deza <alfredo.deza@inktank.com>
Reviews by organizations (one review spans multiple commits)
     1	    134 Inktank <contact@inktank.com>
     2	     10 Cloudwatt <libre.licensing@cloudwatt.com>
     3	      1 Zheng Yan <zheng.z.yan@intel.com>
     4	      1 Yahoo! <contact@yahoo-inc.com>
     5	      1 X-ION <contact@x-ion.de>
     6	      1 UnitedStack <contact@unitedstack.com>
     7	      1 SendFaster <contact@sendfaster.com>
     8	      1 Intel <contact@intel.com>
     9	      1 EPAM <contact@epam.com>
    10	      1 Bayan <contact@bayan.co.ir>
    11	      1 Anchor Hosting <contact@anchor.com.au>

The script used to generate this output is (copy paste at the root of a g=
it clone https://github.com/ceph/ceph.git):

cat > credits.sh <<'EOF'
range=3D$1
echo "Commits by authors"
git log --pretty=3D'%aN <%aE>' $range | sort | uniq -c | sort -rn | nl
echo "Commits by organizations"
git log --pretty=3D'%aN <%aE>' $range | git -c mailmap.file=3D.organizati=
onmap check-mailmap --stdin | sort | uniq -c | sort -rn | nl
echo "Reviews by authors (one review spans multiple commits)"
git log --pretty=3D%b $range | perl -n -e 'print "$_\n" if(s/^\s*Reviewed=
-by:\s*(.*<.*>)\s*$/\1/)' | git check-mailmap --stdin | sort | uniq -c | =
sort -rn | nl
echo "Reviews by organizations (one review spans multiple commits)"
git log --pretty=3D%b $range | perl -n -e 'print "$_\n" if(s/^\s*Reviewed=
-by:\s*(.*<.*>)\s*$/\1/)' | git check-mailmap --stdin | git -c mailmap.fi=
le=3D.organizationmap check-mailmap --stdin | sort | uniq -c | sort -rn |=
 nl
EOF
bash credits.sh tags/v0.78...tags/v0.79

Authors names are normalized with .mailmap and authors affiliations to a =
given organization comes from .organizationmap, both of which can be foun=
d and patched at the root of the ceph source tree.

More sophisticated reports can be generated and visualized by tools such =
as http://bitergia.com/ or http://stackalytics.com/. Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre




--dq7gED2wQ5IClrb0mUHKMCfnqN0JqEw6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNDnTsACgkQ8dLMyEl6F22gdgCgxQ4LPwRGuUrEvX3uHv6U0zYB
r+AAnRzg6b1DbDabyuwrfedXTYU8P5eW
=PDN6
-----END PGP SIGNATURE-----

--dq7gED2wQ5IClrb0mUHKMCfnqN0JqEw6v--
