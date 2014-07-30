From: Loic Dachary <loic@dachary.org>
Subject: v0.83 contributors credits
Date: Wed, 30 Jul 2014 09:47:00 +0600
Message-ID: <53D86AB4.2020908@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7OuoNJ8VmWDhAt48RncEx9LONkTMVgVNu"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50607 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754723AbaG3DrX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 23:47:23 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 05B51420A3
	for <ceph-devel@vger.kernel.org>; Wed, 30 Jul 2014 05:47:08 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7OuoNJ8VmWDhAt48RncEx9LONkTMVgVNu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
83, by number of commits or reviews back to v0.82. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed. If you are curious about how it is done, the details=
 are at the end of this mail.=20

Commits by authors
     1	    100 Sage Weil <sage@inktank.com>
     2	     66 Loic Dachary <loic@dachary.org>
     3	     29 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
     4	     25 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     5	     20 Greg Farnum <greg@inktank.com>
     6	     15 Samuel Just <sam.just@inktank.com>
     7	     14 Yehuda Sadeh <yehuda@inktank.com>
     8	     14 Sage Weil <sweil@redhat.com>
     9	     13 Josh Durgin <josh.durgin@inktank.com>
    10	     12 John Wilkins <john.wilkins@inktank.com>
    11	     12 Haomai Wang <haomaiwang@gmail.com>
    12	     11 Somnath Roy <somnath.roy@sandisk.com>
    13	     11 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@cloudwatt.com>
    14	     11 Ilya Dryomov <ilya.dryomov@inktank.com>
    15	     10 Sebastien Ponce <sebastien.ponce@cern.ch>
    16	      8 Dan Mick <dan.mick@inktank.com>
    17	      5 John Spray <jspray@redhat.com>
    18	      5 John Spray <john.spray@inktank.com>
    19	      5 Alfredo Deza <alfredo.deza@inktank.com>
    20	      3 Adam Crume <adamcrume@gmail.com>
    21	      2 Kevin Dalley <kevin@kelphead.org>
    22	      1 Yan, Zheng <zheng.z.yan@intel.com>
    23	      1 Wei Luo <luowei@yahoo-inc.com>
    24	      1 Venky Shankar <vshankar@redhat.com>
    25	      1 Tyler Brekke <tyler.brekke@inktank.com>
    26	      1 Sylvain Munaut <s.munaut@whatever-company.com>
    27	      1 Stephen Jahl <stephenjahl@gmail.com>
    28	      1 Stephen F Taylor <steveftaylor@gmail.com>
    29	      1 Sebastien Ponce <Sebastien.Ponce@cern.ch>
    30	      1 Sandon Van Ness <sandon@inktank.com>
    31	      1 Ma Jianpeng <majianpeng@gmail.com>
    32	      1 Lluis Pamies-Juarez <lluis.pamies-juarez@hgst.com>
    33	      1 Kevin Cox <kevincox@kevincox.ca>
    34	      1 Jenkins <jenkins@inktank.com>
    35	      1 Huang Jun <hjwsm1989@gmail.com>
    36	      1 George Ryall <george.ryall@stfc.ac.uk>
    37	      1 devicenull <dn@devicenull.org>
    38	      1 Accela Zhao <accelazh@gmail.com>
Commits by organizations
     1	    235 Inktank <contact@inktank.com>
     2	     77 Cloudwatt <libre.licensing@cloudwatt.com>
     3	     25 Deutsche Telekom <contact@telekom.de>
     4	     20 Red Hat <contact@redhat.com>
     5	     12 UnitedStack <contact@unitedstack.com>
     6	     11 SanDisk <contact@sandisk.com>
     7	     11 CERN <contact@cern.ch>
     8	      4 Unaffiliated <no@organization.net>
     9	      3 University of California, Santa Cruz <contact@cs.ucsc.edu>=

    10	      3 HGST <contact@hgst.com>
    11	      1 Yahoo! <contact@yahoo-inc.com>
    12	      1 Whatever <contact@whatever-company.com>
    13	      1 Science & Technology Facilities Council <contact@stfc.ac.u=
k>
    14	      1 MIT Computer Science and Artificial Intelligence Laborator=
y <webmaster@csail.mit.edu>
    15	      1 Kedacom <contact@kedacom.com>
    16	      1 Intel <contact@intel.com>
    17	      1 GAMESERVERS <contact@gameservers.com>
Reviews by authors (one review spans multiple commits)
     1	     21 Sage Weil <sage@inktank.com>
     2	     19 Loic Dachary <loic@dachary.org>
     3	     16 Sage Weil <sweil@redhat.com>
     4	     14 Greg Farnum <greg@inktank.com>
     5	     12 Josh Durgin <josh.durgin@inktank.com>
     6	     11 Samuel Just <sam.just@inktank.com>
     7	      7 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
     8	      5 Dan Mick <dan.mick@inktank.com>
     9	      2 Wei Luo <luowei@yahoo-inc.com>
    10	      2 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@cloudwatt.com>
    11	      2 Lluis Pamies-Juarez <lluis.pamies-juarez@hgst.com>
    12	      1 Yehuda Sadeh <ysadey@redhat.com>
    13	      1 Yehuda Sadeh <yehuda@inktank.com>
    14	      1 Sebastien Ponce <sebastien.ponce@cern.ch>
    15	      1 Huang Jun <hjwsm1989@gmail.com>
    16	      1 Florent Flament <florent.flament@cloudwatt.com>
    17	      1 Christophe Courtaut <christophe.courtaut@gmail.com>
    18	      1 Alfredo Deza <alfredo.deza@inktank.com>
Reviews by organizations (one review spans multiple commits)
     1	     72 Inktank <contact@inktank.com>
     2	     23 Cloudwatt <libre.licensing@cloudwatt.com>
     3	     17 Red Hat <contact@redhat.com>
     4	      2 Yahoo! <contact@yahoo-inc.com>
     5	      2 HGST <contact@hgst.com>
     6	      1 Unaffiliated <no@organization.net>
     7	      1 CERN <contact@cern.ch>

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

bash credits.sh tags/v0.82...tags/v0.83

Authors names are normalized with .mailmap and authors affiliations to a =
given organization comes from .organizationmap, both of which can be foun=
d and patched at the root of the ceph source tree.

More sophisticated reports can be generated and visualized by tools such =
as http://bitergia.com/ or http://stackalytics.com/.=20

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre









--7OuoNJ8VmWDhAt48RncEx9LONkTMVgVNu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPYarQACgkQ8dLMyEl6F2171QCeOF8PEa5JUnfpyfSuKpNE3QPB
vJkAoL9rgjRg4RjQhdSjn9e+tx/UWkyl
=Q0io
-----END PGP SIGNATURE-----

--7OuoNJ8VmWDhAt48RncEx9LONkTMVgVNu--
