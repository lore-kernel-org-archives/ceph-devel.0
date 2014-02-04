From: Loic Dachary <loic@dachary.org>
Subject: v0.76 contributors credits (beta)
Date: Tue, 04 Feb 2014 15:51:09 +0100
Message-ID: <52F0FE5D.1030201@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="c01gJ73JT56EpdsR6nuDc1wsAJUQpSuGb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:32814 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbaBDOvM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Feb 2014 09:51:12 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Ceph Community <ceph-community@lists.ceph.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c01gJ73JT56EpdsR6nuDc1wsAJUQpSuGb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
76, by number of commits or reviews back to v0.75. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed.=20

If you are curious about how it is done, the details are at the end of th=
is mail.=20

Commits by authors
     1	     99 Sage Weil <sage@inktank.com>
     2	     82 Loic Dachary <loic@dachary.org>
     3	     12 David Zafman <david.zafman@inktank.com>
     4	     10 Noah Watkins <noah.watkins@inktank.com>
     5	      7 Josh Durgin <josh.durgin@inktank.com>
     6	      7 John Wilkins <john.wilkins@inktank.com>
     7	      6 Samuel Just <sam.just@inktank.com>
     8	      5 Ken Dreyer <ken.dreyer@inktank.com>
     9	      4 Yan, Zheng <zheng.z.yan@intel.com>
    10	      3 Yehuda Sadeh <yehuda@inktank.com>
    11	      3 Robin H. Johnson <robbat2@gentoo.org>
    12	      2 Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
    13	      2 David Moreau Simard <dmsimard@iweb.com>
    14	      2 Dan Mick <dan.mick@inktank.com>
    15	      2 Christophe Courtaut <christophe.courtaut@gmail.com>
    16	      1 Yan, Zheng <ukernel@gmail.com>
    17	      1 Kun Huang <academicgareth@gmail.com>
    18	      1 Jonathan Dieter <jdieter@lesbg.com>
    19	      1 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    20	      1 Greg Farnum <greg@inktank.com>
    21	      1 Derek Yarnell <derek@umiacs.umd.edu>
    22	      1 Andreas Peters <andreas.joachim.peters@cern.ch>
    23	      1 Alfredo Deza <alfredo.deza@inktank.com>
Commits by organizations
     1	    156 Inktank <contact@inktank.com>
     2	     84 Cloudwatt <libre.licensing@cloudwatt.com>
     3	      4 Intel <contact@intel.com>
     4	      3 Gentoo <contact@gentoo.org>
     5	      2 IWeb <contact@iweb.com>
     6	      1 Yan, Zheng <ukernel@gmail.com>
     7	      1 UnitedStack <contact@unitedstack.com>
     8	      1 Lebanon Evangelical School <contact@lesbg.com>
     9	      1 Derek Yarnell <derek@umiacs.umd.edu>
    10	      1 CERN <contact@cern.ch>
Reviews by authors (one review spans multiple commits)
     1	     21 Sage Weil <sage@inktank.com>
     2	      7 Loic Dachary <loic@dachary.org>
     3	      5 Greg Farnum <greg@inktank.com>
     4	      4 Josh Durgin <josh.durgin@inktank.com>
     5	      3 Dan Mick <dan.mick@inktank.com>
     6	      2 Yehuda Sadeh <yehuda@inktank.com>
     7	      2 Yan, Zheng <zheng.z.yan@intel.com>
     8	      2 Samuel Just <sam.just@inktank.com>
     9	      2 Andreas Peters <andreas.joachim.peters@cern.ch>
    10	      1 Roald J. van Loon <roald@roaldvanloon.nl>
    11	      1 Noah Watkins <noah.watkins@inktank.com>
    12	      1 John Spray <john.spray@inktank.com>
    13	      1 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    14	      1 David Moreau Simard <dmsimard@iweb.com>
Reviews by organizations (one review spans multiple commits)
     1	     40 Inktank <contact@inktank.com>
     2	      7 Cloudwatt <libre.licensing@cloudwatt.com>
     3	      2 Intel <contact@intel.com>
     4	      2 CERN <contact@cern.ch>
     5	      1 Roald van Loon Consultancy <roald@roaldvanloon.nl>
     6	      1 IWeb <contact@iweb.com>

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
bash credits.sh tags/v0.75...tags/v0.76

Authors names are normalized with .mailmap and authors affiliations to a =
given organization comes from .organizationmap, both of which can be foun=
d and patched at the root of the ceph source tree.

More sophisticated reports can be generated and visualized by tools such =
as http://bitergia.com/ or http://stackalytics.com/.=20
Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre






--c01gJ73JT56EpdsR6nuDc1wsAJUQpSuGb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLw/l4ACgkQ8dLMyEl6F22DYQCggx5r1HeP9vIcv6jipdEoDwFd
WR0AnjBPx9kiluhAfSya4bPVN3E9QA6E
=Zt7g
-----END PGP SIGNATURE-----

--c01gJ73JT56EpdsR6nuDc1wsAJUQpSuGb--
