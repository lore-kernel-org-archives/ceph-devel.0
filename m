From: Loic Dachary <loic@dachary.org>
Subject: v0.78 contributors credits
Date: Sun, 23 Mar 2014 15:14:32 +0100
Message-ID: <532EEC48.6080802@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="SST97J1f0ETSuxVoTo7ab0CWwPSnj2WFP"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:51932 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbaCWOOf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Mar 2014 10:14:35 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, Ceph Community <ceph-community@lists.ceph.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SST97J1f0ETSuxVoTo7ab0CWwPSnj2WFP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to v0.=
78, by number of commits or reviews back to v0.77. The affiliation of aut=
hors to organizations can be updated by submitting a patch to https://git=
hub.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed.=20

If you are curious about how it is done, the details are at the end of th=
is mail.=20

Commits by authors
     1	    255 Sage Weil <sage@inktank.com>
     2	    187 Samuel Just <sam.just@inktank.com>
     3	    104 Loic Dachary <loic@dachary.org>
     4	     69 Josh Durgin <josh.durgin@inktank.com>
     5	     57 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     6	     47 Yan, Zheng <zheng.z.yan@intel.com>
     7	     27 Babu Shanmugam <anbu@enovance.com>
     8	     23 Haomai Wang <haomaiwang@gmail.com>
     9	     22 Greg Farnum <greg@inktank.com>
    10	     19 Yehuda Sadeh <yehuda@inktank.com>
    11	     18 Ilya Dryomov <ilya.dryomov@inktank.com>
    12	     15 David Zafman <david.zafman@inktank.com>
    13	     13 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    14	     10 John Wilkins <john.wilkins@inktank.com>
    15	      6 Matt Benjamin <matt@linuxbox.com>
    16	      6 John Spray <john.spray@inktank.com>
    17	      6 Adam C. Emerson <aemerson@linuxbox.com>
    18	      5 Noah Watkins <noah.watkins@inktank.com>
    19	      4 Andrey Kuznetsov <Andrey_Kuznetsov@epam.com>
    20	      3 Warren Usui <warren.usui@inktank.com>
    21	      3 Somnath Roy <somnath.roy@sandisk.com>
    22	      2 Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
    23	      2 Sebastien Han <sebastien.han@enovance.com>
    24	      2 Dan Mick <dan.mick@inktank.com>
    25	      2 Christopher O'Connell <jwriteclub@gmail.com>
    26	      2 Casey Bodley <casey@linuxbox.com>
    27	      2 Alfredo Deza <alfredo.deza@inktank.com>
    28	      1 Wang, Yaguang <yaguang.wang@intel.com>
    29	      1 Stephan Renatus <s.renatus@x-ion.de>
    30	      1 Ray Lv <xiangyulv@gmail.com>
    31	      1 Mouad Benchchaoui <m.benchchaoui@x-ion.de>
    32	      1 Mike Lundy <mike@fluffypenguin.org>
    33	      1 Ken Dreyer <ken.dreyer@inktank.com>
    34	      1 Jenkins <jenkins@inktank.com>
    35	      1 Florian Haas <florian@hastexo.com>
    36	      1 David Moreau Simard <dmsimard@iweb.com>
    37	      1 Christophe Courtaut <christophe.courtaut@gmail.com>
    38	      1 Alexandre Oliva <oliva@gnu.org>
Commits by organizations
     1	    630 Inktank <contact@inktank.com>
     2	    105 Cloudwatt <libre.licensing@cloudwatt.com>
     3	     57 Deutsche Telekom <contact@telekom.de>
     4	     48 Intel <contact@intel.com>
     5	     29 eNovance <contact@enovance.com>
     6	     23 UnitedStack <contact@unitedstack.com>
     7	     14 The Linux Box <contact@linuxbox.com>
     8	      4 EPAM <contact@epam.com>
     9	      3 SanDisk <contact@sandisk.com>
    10	      2 X-ION <contact@x-ion.de>
    11	      2 SendFaster <contact@sendfaster.com>
    12	      1 Yahoo! <contact@yahoo-inc.com>
    13	      1 Piston Cloud Computing <info@pistoncloud.com>
    14	      1 IWeb <contact@iweb.com>
    15	      1 Hastexo <contact@hastexo.com>
    16	      1 GNU <contact@gnu.org>
Reviews by authors (one review spans multiple commits)
     1	     87 Sage Weil <sage@inktank.com>
     2	     32 Christophe Courtaut <christophe.courtaut@gmail.com>
     3	     26 Greg Farnum <greg@inktank.com>
     4	     22 Samuel Just <sam.just@inktank.com>
     5	     22 Josh Durgin <josh.durgin@inktank.com>
     6	     18 Loic Dachary <loic@dachary.org>
     7	      6 Yehuda Sadeh <yehuda@inktank.com>
     8	      5 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
     9	      5 David Zafman <david.zafman@inktank.com>
    10	      2 Haomai Wang <haomaiwang@gmail.com>
    11	      2 Dan Mick <dan.mick@inktank.com>
    12	      1 Yan, Zheng <zheng.z.yan@intel.com>
    13	      1 Ray Lv <xiangyulv@gmail.com>
    14	      1 Moritz M=F6ller <mm@mxs.de>
    15	      1 Eric Mourgaya <eric.mourgaya@arkea.com>
    16	      1 Dmitry Smirnov <onlyjob@member.fsf.org>
Reviews by organizations (one review spans multiple commits)
     1	    175 Inktank <contact@inktank.com>
     2	     50 Cloudwatt <libre.licensing@cloudwatt.com>
     3	      2 UnitedStack <contact@unitedstack.com>
     4	      1 Yahoo! <contact@yahoo-inc.com>
     5	      1 Intel <contact@intel.com>
     6	      1 Debian GNU/Linux <contact@debian.org>
     7	      1 Credit Mutuel Arkea <contact@arkea.com>
     8	      1 Bigpoint.com <contact@bigpoint.net>

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
bash credits.sh tags/v0.77...tags/v0.78

Authors names are normalized with .mailmap and authors affiliations to a =
given organization comes from .organizationmap, both of which can be foun=
d and patched at the root of the ceph source tree.

More sophisticated reports can be generated and visualized by tools such =
as http://bitergia.com/ or http://stackalytics.com/. Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre




--SST97J1f0ETSuxVoTo7ab0CWwPSnj2WFP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMu7EgACgkQ8dLMyEl6F22KLACeM+NL/0QG9X2v1yA/+Ct8vmzB
N5EAn1D6I5HgZaRGfEJrE/3thJXWwlL5
=pZbw
-----END PGP SIGNATURE-----

--SST97J1f0ETSuxVoTo7ab0CWwPSnj2WFP--
