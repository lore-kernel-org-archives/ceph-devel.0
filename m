From: Loic Dachary <loic@dachary.org>
Subject: v0.81 contributors credits
Date: Tue, 03 Jun 2014 09:33:08 +0200
Message-ID: <538D7A34.1050108@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Q2es9wtMAOdIEHkWsjJPrR1JRJn2Kufoc"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:59432 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbaFCHdK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jun 2014 03:33:10 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 8A76F42B59
	for <ceph-devel@vger.kernel.org>; Tue,  3 Jun 2014 09:33:08 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q2es9wtMAOdIEHkWsjJPrR1JRJn2Kufoc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
81, by number of commits or reviews back to v0.80. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed.=20

If you are curious about how it is done, the details are at the end of th=
is mail.=20

Commits by authors
     1	    104 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     2	     84 Sage Weil <sage@inktank.com>
     3	     44 Greg Farnum <greg@inktank.com>
     4	     42 Yan, Zheng <zheng.z.yan@intel.com>
     5	     38 John Wilkins <john.wilkins@inktank.com>
     6	     33 Samuel Just <sam.just@inktank.com>
     7	     24 Ilya Dryomov <ilya.dryomov@inktank.com>
     8	     15 Yehuda Sadeh <yehuda@inktank.com>
     9	     14 Josh Durgin <josh.durgin@inktank.com>
    10	      8 John Spray <john.spray@inktank.com>
    11	      6 Loic Dachary <loic@dachary.org>
    12	      6 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    13	      4 Kevin Dalley <kevin@kelphead.org>
    14	      4 Dmitry Smirnov <onlyjob@member.fsf.org>
    15	      4 David Zafman <david.zafman@inktank.com>
    16	      3 Michael Riederer <michael@riederer.org>
    17	      3 Haomai Wang <haomaiwang@gmail.com>
    18	      3 Daniel J. Hofmann <daniel@trvx.org>
    19	      3 Alfredo Deza <alfredo.deza@inktank.com>
    20	      2 Stephen F Taylor <steveftaylor@gmail.com>
    21	      2 Stefan Eilemann <Stefan.Eilemann@epfl.ch>
    22	      2 Guang Yang <yguang@yahoo-inc.com>
    23	      1 Xing Lin <xinglin@cs.utah.edu>
    24	      1 Wido den Hollander <wido@42on.com>
    25	      1 Warren Usui <warren.usui@inktank.com>
    26	      1 Walter Huf <hufman@gmail.com>
    27	      1 Stuart Longland <stuartl@vrt.com.au>
    28	      1 Shawn Edwards <lesser.evil@gmail.com>
    29	      1 Jenkins <jenkins@inktank.com>
    30	      1 Chris Glass <tribaal@gmail.com>
Commits by organizations
     1	    275 Inktank <contact@inktank.com>
     2	    104 Deutsche Telekom <contact@telekom.de>
     3	     42 Intel <contact@intel.com>
     4	      6 Unaffiliated <no@organization.net>
     5	      6 Cloudwatt <libre.licensing@cloudwatt.com>
     6	      4 HGST <contact@hgst.com>
     7	      4 Debian GNU/Linux <contact@debian.org>
     8	      3 UnitedStack <contact@unitedstack.com>
     9	      3 Karlsruhe Institute of Technology <ceph@lists.kit.edu>
    10	      2 Yahoo! <contact@yahoo-inc.com>
    11	      2 =C9cole polytechnique f=E9d=E9rale de Lausanne <contact@ep=
fl.ch>
    12	      1 Wido 42on <contact@42on.com>
    13	      1 VRT <contact@vrt.com.au>
    14	      1 University of Utah <contact@utah.edu>
    15	      1 Corvisa LLC <contact@corvisa.com>
    16	      1 Canonical <contact@canonical.com>
Reviews by authors (one review spans multiple commits)
     1	     35 Sage Weil <sage@inktank.com>
     2	     19 Samuel Just <sam.just@inktank.com>
     3	     11 Josh Durgin <josh.durgin@inktank.com>
     4	     11 Greg Farnum <greg@inktank.com>
     5	      4 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     6	      3 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
     7	      3 Alfredo Deza <alfredo.deza@inktank.com>
     8	      1 Yehuda Sadeh <yehuda@inktank.com>
     9	      1 Loic Dachary <loic@dachary.org>
    10	      1 David Zafman <david.zafman@inktank.com>
    11	      1 Babu Shanmugam <anbu@enovance.com>
Reviews by organizations (one review spans multiple commits)
     1	     84 Inktank <contact@inktank.com>
     2	      4 Deutsche Telekom <contact@telekom.de>
     3	      1 eNovance <contact@enovance.com>
     4	      1 Cloudwatt <libre.licensing@cloudwatt.com>

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
bash credits.sh tags/v0.80...tags/v0.81

Authors names are normalized with .mailmap and authors affiliations to a =
given organization comes from .organizationmap, both of which can be foun=
d and patched at the root of the ceph source tree.

More sophisticated reports can be generated and visualized by tools such =
as http://bitergia.com/ or http://stackalytics.com/.=20
Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre




--Q2es9wtMAOdIEHkWsjJPrR1JRJn2Kufoc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlONejQACgkQ8dLMyEl6F22bXwCgkireK8vWbkDTCNyNOIuI6j6G
KwcAn0Stqo0UvrVv2Vz7cGCbrx37H+jO
=UjRr
-----END PGP SIGNATURE-----

--Q2es9wtMAOdIEHkWsjJPrR1JRJn2Kufoc--
