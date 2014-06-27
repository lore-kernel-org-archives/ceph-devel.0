From: Loic Dachary <loic@dachary.org>
Subject: v0.82 contributors credits
Date: Fri, 27 Jun 2014 23:27:39 +0200
Message-ID: <53ADE1CB.3000006@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Sixor1hmMmK3wNPB9i5eucifswXhNSCug"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59038 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751496AbaF0V1q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 27 Jun 2014 17:27:46 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 6C2E5420A6
	for <ceph-devel@vger.kernel.org>; Fri, 27 Jun 2014 23:27:39 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Sixor1hmMmK3wNPB9i5eucifswXhNSCug
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
82, by number of commits or reviews back to v0.81. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed.=20
If you are curious about how it is done, the details are at the end of th=
is mail.=20

Commits by authors
     1	     61 Sage Weil <sage@inktank.com>
     2	     55 John Spray <john.spray@inktank.com>
     3	     44 Loic Dachary <loic@dachary.org>
     4	     25 Greg Farnum <greg@inktank.com>
     5	     22 John Wilkins <john.wilkins@inktank.com>
     6	     15 Samuel Just <sam.just@inktank.com>
     7	     11 Yan, Zheng <zheng.z.yan@intel.com>
     8	      8 Kevin Dalley <kevin@kelphead.org>
     9	      5 Josh Durgin <josh.durgin@inktank.com>
    10	      4 Alfredo Deza <alfredo.deza@inktank.com>
    11	      3 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    12	      3 Ilya Dryomov <ilya.dryomov@inktank.com>
    13	      2 Yehuda Sadeh <yehuda@inktank.com>
    14	      2 Ross Turk <rturk@redhat.com>
    15	      2 Haomai Wang <haomaiwang@gmail.com>
    16	      2 Dmitry Smirnov <onlyjob@member.fsf.org>
    17	      2 Adam Twardowski <adam.twardowski@gmail.com>
    18	      1 Sushma Gurram <sushma.gurram@sandisk.com>
    19	      1 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@cloudwatt.com>
    20	      1 Mohammad Salehe <salehe+dev@gmail.com>
    21	      1 Kai Zhang <zakir.exe@gmail.com>
    22	      1 Jenkins <jenkins@inktank.com>
    23	      1 Harpreet Dhillon <harpreet@ironsystems.com>
    24	      1 Florent Flament <florent.flament@cloudwatt.com>
    25	      1 Dominik Hannen <cantares1+github@gmail.com>
    26	      1 Dan Mick <dan.mick@inktank.com>
    27	      1 Colin Mattson <colinmattson@gmail.com>
    28	      1 Christian Theune <ct@gocept.com>
    29	      1 Aristoteles Neto <aristoteles.neto@webdrive.co.nz>
    30	      1 Ailing Zhang <zhangal1992@gmail.com>
Commits by organizations
     1	    197 Inktank <contact@inktank.com>
     2	     46 Cloudwatt <libre.licensing@cloudwatt.com>
     3	     11 Intel <contact@intel.com>
     4	      8 HGST <contact@hgst.com>
     5	      3 Unaffiliated <no@organization.net>
     6	      2 UnitedStack <contact@unitedstack.com>
     7	      2 Red Hat <contact@redhat.com>
     8	      2 Debian GNU/Linux <contact@debian.org>
     9	      2 Choopa, LLC <contact@choopa.com>
    10	      1 Web Drive <contact@webdrive.co.nz>
    11	      1 SanDisk <contact@sandisk.com>
    12	      1 Iron Systems Inc. <info@ironsystems.com>
    13	      1 gocept gmbh & co. kg <mail@gocept.com>
    14	      1 CISCO <contact@cisco.com>
    15	      1 Bayan <contact@bayan.co.ir>
Reviews by authors (one review spans multiple commits)
     1	     17 Loic Dachary <loic@dachary.org>
     2	     11 Sage Weil <sage@inktank.com>
     3	      9 Samuel Just <sam.just@inktank.com>
     4	      6 Greg Farnum <greg@inktank.com>
     5	      6 Christophe Courtaut <christophe.courtaut@gmail.com>
     6	      2 Josh Durgin <josh.durgin@inktank.com>
     7	      2 Florent Flament <florent.flament@cloudwatt.com>
     8	      1 Walter Huf <hufman@gmail.com>
     9	      1 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@cloudwatt.com>
    10	      1 koleosfuscus <koleosfuscus@yahoo.com>
    11	      1 Kevin Dalley <kevin@kelphead.org>
    12	      1 John Spray <jspray@redhat.com>
    13	      1 Dmitry Smirnov <onlyjob@member.fsf.org>
    14	      1 Dan Mick <dan.mick@inktank.com>
    15	      1 Daniel J. Hofmann <daniel@trvx.org>
    16	      1 Christian Theune <ct@gocept.com>
    17	      1 Chris Glass <tribaal@gmail.com>
    18	      1 Aristoteles Neto <aristoteles.neto@webdrive.co.nz>
Reviews by organizations (one review spans multiple commits)
     1	     29 Inktank <contact@inktank.com>
     2	     26 Cloudwatt <libre.licensing@cloudwatt.com>
     3	      1 Web Drive <contact@webdrive.co.nz>
     4	      1 Unaffiliated <no@organization.net>
     5	      1 Red Hat <contact@redhat.com>
     6	      1 Karlsruhe Institute of Technology <ceph@lists.kit.edu>
     7	      1 HGST <contact@hgst.com>
     8	      1 gocept gmbh & co. kg <mail@gocept.com>
     9	      1 Debian GNU/Linux <contact@debian.org>
    10	      1 Corvisa LLC <contact@corvisa.com>
    11	      1 Canonical <contact@canonical.com>


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
bash credits.sh tags/v0.81...tags/v0.82

Authors names are normalized with .mailmap and authors affiliations to a =
given organization comes from .organizationmap, both of which can be foun=
d and patched at the root of the ceph source tree.

More sophisticated reports can be generated and visualized by tools such =
as http://bitergia.com/ or http://stackalytics.com/. Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre






--Sixor1hmMmK3wNPB9i5eucifswXhNSCug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOt4csACgkQ8dLMyEl6F22U7gCeMkWZa0C0RV3kaSP/WcTj5aoz
gYsAoJG6tVqK35b1JSNOBt+wgl4QE/vM
=qWii
-----END PGP SIGNATURE-----

--Sixor1hmMmK3wNPB9i5eucifswXhNSCug--
