From: Loic Dachary <loic@dachary.org>
Subject: v0.75 contributors credits ( experimental)
Date: Wed, 15 Jan 2014 09:21:34 +0100
Message-ID: <52D6450E.1090605@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WNqdSuU3e3x8ccJbLlQRsupht91ucSQm4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:43837 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaAOIVh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jan 2014 03:21:37 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Ceph Community <ceph-community@lists.ceph.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WNqdSuU3e3x8ccJbLlQRsupht91ucSQm4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
75, by number of commits or reviews back to v0.74. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

If you are curious about how it is done, the details are at the end of th=
is mail.=20

Commits by authors
     1	    104 Sage Weil <sage@inktank.com>
     2	     86 Loic Dachary <loic@dachary.org>
     3	     18 Noah Watkins <noah.watkins@inktank.com>
     4	     12 David Zafman <david.zafman@inktank.com>
     5	      8 Josh Durgin <josh.durgin@inktank.com>
     6	      7 John Wilkins <john.wilkins@inktank.com>
     7	      6 Samuel Just <sam.just@inktank.com>
     8	      4 Yan, Zheng <zheng.z.yan@intel.com>
     9	      3 Ken Dreyer <ken.dreyer@inktank.com>
    10	      2 Yehuda Sadeh <yehuda@inktank.com>
    11	      2 Greg Farnum <greg@inktank.com>
    12	      2 Gary Lowell <gary.lowell@inktank.com>
    13	      2 David Moreau Simard <dmsimard@iweb.com>
    14	      2 Christophe Courtaut <christophe.courtaut@gmail.com>
    15	      1 Yan, Zheng <ukernel@gmail.com>
    16	      1 Xihui He <xihuihe@gmail.com>
    17	      1 Rutger ter Borg <rutger@terborg.net>
    18	      1 Kun Huang <academicgareth@gmail.com>
    19	      1 Jonathan Dieter <jdieter@lesbg.com>
    20	      1 Dan Mick <dan.mick@inktank.com>
    21	      1 Bj=F8rnar Ness <bjornar.ness@gmail.com>
    22	      1 Andreas Peters <andreas.joachim.peters@cern.ch>
Commits by organizations
     1	    165 Inktank <contact@inktank.com>
     2	     88 Cloudwatt <libre.licensing@cloudwatt.com>
     3	      4 Intel <contact@intel.com>
     4	      2 IWeb <contact@iweb.com>
     5	      1 Yan, Zheng <ukernel@gmail.com>
     6	      1 Xihui He <xihuihe@gmail.com>
     7	      1 Rutger ter Borg <rutger@terborg.net>
     8	      1 Kun Huang <academicgareth@gmail.com>
     9	      1 Jonathan Dieter <jdieter@lesbg.com>
    10	      1 CERN <contact@cern.ch>
    11	      1 Bj=F8rnar Ness <bjornar.ness@gmail.com>
Reviews by authors
     1	     28 Sage Weil <sage@inktank.com>
     2	      6 Loic Dachary <loic@dachary.org>
     3	      6 Josh Durgin <josh.durgin@inktank.com>
     4	      3 Samuel Just <sam.just@inktank.com>
     5	      2 Yan, Zheng <zheng.z.yan@intel.com>
     6	      2 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
     7	      2 Greg Farnum <greg@inktank.com>
     8	      2 Dan Mick <dan.mick@inktank.com>
     9	      1 Yehuda Sadeh <yehuda@inktank.com>
    10	      1 Roald J. van Loon <roald@roaldvanloon.nl>
    11	      1 Noah Watkins <noah.watkins@inktank.com>
    12	      1 David Moreau Simard <dmsimard@iweb.com>
    13	      1 Andreas Peters <andreas.joachim.peters@cern.ch>
Reviews by organizations
     1	     45 Inktank <contact@inktank.com>
     2	      6 Cloudwatt <libre.licensing@cloudwatt.com>
     3	      2 Intel <contact@intel.com>
     4	      1 Roald van Loon Consultancy <roald@roaldvanloon.nl>
     5	      1 IWeb <contact@iweb.com>
     6	      1 CERN <contact@cern.ch>

The script used to generate this output is (copy paste at the root of a g=
it clone https://github.com/ceph/ceph.git):

cat > credits.sh <<'EOF'
previous_version=3D$1
next_version=3D$2

echo "Commits by authors"
git log --after $previous_version --before $next_version --pretty=3D'%aN =
<%aE>' | sort | uniq -c | sort -rn | nl
echo "Commits by organizations"
git log --after $previous_version --before $next_version --pretty=3D'%aN =
<%aE>' | git -c mailmap.file=3D.organizationmap check-mailmap --stdin | s=
ort | uniq -c | sort -rn | nl
echo "Reviews by authors"
git log --after $previous_version --before $next_version --pretty=3D%b | =
perl -n -e 'print "$_\n" if(s/^\s*Reviewed-by:\s*(.*<.*>)\s*$/\1/)' | git=
 check-mailmap --stdin | sort | uniq -c | sort -rn | nl
echo "Reviews by organizations"
git log --after $previous_version --before $next_version --pretty=3D%b | =
perl -n -e 'print "$_\n" if(s/^\s*Reviewed-by:\s*(.*<.*>)\s*$/\1/)' | git=
 check-mailmap --stdin | git -c mailmap.file=3D.organizationmap check-mai=
lmap --stdin | sort | uniq -c | sort -rn | nl
EOF
v0_74=3D2013-12-30 ; v0_75=3D2014-01-14 ; bash credits.sh $v0_74 $v0_75

Authors names are normalized with .mailmap and authors affiliations to a =
given organization comes from .organizationmap, both of which can be foun=
d and patched at the root of the ceph source tree.

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--WNqdSuU3e3x8ccJbLlQRsupht91ucSQm4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLWRQ4ACgkQ8dLMyEl6F22G0QCdHpJdTeYd5WHktuQoa5m6W2ar
rZ4AmQF0/NU5HXZti1DqsolIQZ0aLShr
=Gp0P
-----END PGP SIGNATURE-----

--WNqdSuU3e3x8ccJbLlQRsupht91ucSQm4--
