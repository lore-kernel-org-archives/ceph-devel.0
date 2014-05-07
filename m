From: Loic Dachary <loic@dachary.org>
Subject: Firefly contributors credits
Date: Wed, 07 May 2014 10:47:04 +0200
Message-ID: <5369F308.9000601@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EkX7EVuHA6FEUqHas55jNHtl3PLV82c7F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:57286 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755495AbaEGIrI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 May 2014 04:47:08 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id 4C8784210B
	for <ceph-devel@vger.kernel.org>; Wed,  7 May 2014 10:47:05 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EkX7EVuHA6FEUqHas55jNHtl3PLV82c7F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors (82) and organizations (41) who contribu=
ted to Firefly (v0.80), by number of commits or reviews back to Emperor (=
v0.72). The affiliation of authors to organizations can be updated by sub=
mitting a patch to https://github.com/ceph/ceph/blob/master/.organization=
map

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed.=20

If you are curious about how it is done, the details are at the end of th=
is mail.=20

Commits by authors
     1	   1144 Sage Weil <sage@inktank.com>
     2	    449 Loic Dachary <loic@dachary.org>
     3	    379 Samuel Just <sam.just@inktank.com>
     4	    200 Yan, Zheng <zheng.z.yan@intel.com>
     5	    161 Josh Durgin <josh.durgin@inktank.com>
     6	    157 Greg Farnum <greg@inktank.com>
     7	    152 Yehuda Sadeh <yehuda@inktank.com>
     8	    150 John Wilkins <john.wilkins@inktank.com>
     9	    116 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    10	     95 David Zafman <david.zafman@inktank.com>
    11	     93 Noah Watkins <noah.watkins@inktank.com>
    12	     63 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
    13	     51 Ilya Dryomov <ilya.dryomov@inktank.com>
    14	     35 Haomai Wang <haomaiwang@gmail.com>
    15	     33 John Spray <john.spray@inktank.com>
    16	     32 Babu Shanmugam <anbu@enovance.com>
    17	     25 Li Wang <liwang@ubuntukylin.com>
    18	     20 Dan Mick <dan.mick@inktank.com>
    19	     16 Tamil Muthamizhan <tamil.muthamizhan@inktank.com>
    20	     15 Ken Dreyer <ken.dreyer@inktank.com>
    21	     13 Xing Lin <xinglin@cs.utah.edu>
    22	     12 Wido den Hollander <wido@42on.com>
    23	     12 Warren Usui <warren.usui@inktank.com>
    24	     11 Christophe Courtaut <christophe.courtaut@gmail.com>
    25	     11 Alfredo Deza <alfredo.deza@inktank.com>
    26	      9 Gary Lowell <gary.lowell@inktank.com>
    27	      9 Dmitry Smirnov <onlyjob@member.fsf.org>
    28	      7 Huang Jun <hjwsm1989@gmail.com>
    29	      7 David Moreau Simard <dmsimard@iweb.com>
    30	      6 Robin H. Johnson <robbat2@gentoo.org>
    31	      6 Matt Benjamin <matt@linuxbox.com>
    32	      6 Adam C. Emerson <aemerson@linuxbox.com>
    33	      4 Sharif Olorin <sio@tesser.org>
    34	      4 Sebastien Han <sebastien.han@enovance.com>
    35	      4 Jenkins <jenkins@inktank.com>
    36	      4 Guang Yang <yguang@yahoo-inc.com>
    37	      4 Andrey Kuznetsov <Andrey_Kuznetsov@epam.com>
    38	      4 Alexandre Oliva <oliva@gnu.org>
    39	      4 Alan Somers <asomers@gmail.com>
    40	      3 Somnath Roy <somnath.roy@sandisk.com>
    41	      3 Sandon Van Ness <sandon@inktank.com>
    42	      3 Ray Lv <xiangyulv@gmail.com>
    43	      3 Kai Zhang <zakir.exe@gmail.com>
    44	      3 Florian Haas <florian@hastexo.com>
    45	      3 Andreas Peters <andreas.joachim.peters@cern.ch>
    46	      2 Mohammad Salehe <salehe+dev@gmail.com>
    47	      2 Derek Yarnell <derek@umiacs.umd.edu>
    48	      2 Dan van der Ster <daniel.vanderster@cern.ch>
    49	      2 Christopher O'Connell <jwriteclub@gmail.com>
    50	      2 Christian Marie <pingu@anchor.net.au>
    51	      2 Casey Bodley <casey@linuxbox.com>
    52	      2 Bastian Blank <waldi@debian.org>
    53	      2 Adam Twardowski <adam.twardowski@gmail.com>
    54	      1 Xihui He <xihuihe@gmail.com>
    55	      1 Wang, Yaguang <yaguang.wang@intel.com>
    56	      1 Tyler Brekke <tyler.brekke@inktank.com>
    57	      1 Thomas Bechtold <t.bechtold@telekom.de>
    58	      1 Steve Stock <steve@technolope.org>
    59	      1 Stephan Renatus <s.renatus@x-ion.de>
    60	      1 Rutger ter Borg <rutger@terborg.net>
    61	      1 Ron Allred <rallred@itrefined.com>
    62	      1 Paul Meserve <paul@pogodan.com>
    63	      1 Patrick McGarry <patrick@inktank.com>
    64	      1 Nikola Kotur <kotnick@gmail.com>
    65	      1 Mouad Benchchaoui <m.benchchaoui@x-ion.de>
    66	      1 Moritz M=F6ller <mm@mxs.de>
    67	      1 Mike Lundy <mike@fluffypenguin.org>
    68	      1 Michael Nelson <mikenel@tnld.net>
    69	      1 Liam Monahan <liam@umiacs.umd.edu>
    70	      1 Laurent Barbe <laurent@ksperis.com>
    71	      1 Kun Huang <academicgareth@gmail.com>
    72	      1 Jonathan Dieter <jdieter@lesbg.com>
    73	      1 Jonathan Davies <jonathan.davies@canonical.com>
    74	      1 Jens-Christian Fischer <jens-christian.fischer@switch.ch>
    75	      1 James Ryan Cresawn <jrcresawn@gmail.com>
    76	      1 James Page <james.page@ubuntu.com>
    77	      1 Florent Bautista <florent@coppint.com>
    78	      1 Eric Mourgaya <eric.mourgaya@arkea.com>
    79	      1 Dan Chai <tengweicai@gmail.com>
    80	      1 Bj=F8rnar Ness <bjornar.ness@gmail.com>
    81	      1 Allen Samuels <allen.samuels@sandisk.com>
    82	      1 Alexandre Marangone <alexandre.marangone@inktank.com>
Commits by organizations
     1	   2571 Inktank <contact@inktank.com>
     2	    460 Cloudwatt <libre.licensing@cloudwatt.com>
     3	    201 Intel <contact@intel.com>
     4	    117 Deutsche Telekom <contact@telekom.de>
     5	     36 UnitedStack <contact@unitedstack.com>
     6	     36 eNovance <contact@enovance.com>
     7	     25 Ubuntu Kylin <contact@ubuntukylin.com>
     8	     14 The Linux Box <contact@linuxbox.com>
     9	     13 University of Utah <contact@utah.edu>
    10	     12 Wido 42on <contact@42on.com>
    11	     11 Unaffiliated <no@organization.net>
    12	     11 Debian GNU/Linux <contact@debian.org>
    13	      8 Yahoo! <contact@yahoo-inc.com>
    14	      7 IWeb <contact@iweb.com>
    15	      6 Gentoo <contact@gentoo.org>
    16	      6 Anchor Hosting <contact@anchor.com.au>
    17	      5 CERN <contact@cern.ch>
    18	      4 Spectra Logic <contact@spectralogic.com>
    19	      4 SanDisk <contact@sandisk.com>
    20	      4 GNU <contact@gnu.org>
    21	      4 EPAM <contact@epam.com>
    22	      3 University of Mississippi <contact@umd.edu>
    23	      3 Hastexo <contact@hastexo.com>
    24	      3 CISCO <contact@cisco.com>
    25	      2 X-ION <contact@x-ion.de>
    26	      2 SendFaster <contact@sendfaster.com>
    27	      2 Choopa, LLC <contact@choopa.com>
    28	      2 Canonical <contact@canonical.com>
    29	      2 Bayan <contact@bayan.co.ir>
    30	      1 The University of Arizona <contact@arizona.edu>
    31	      1 SWITCH <contact@switch.ch>
    32	      1 Pogoapp <contact@pogoapp.com>
    33	      1 Piston Cloud Computing <info@pistoncloud.com>
    34	      1 Lebanon Evangelical School <contact@lesbg.com>
    35	      1 IT Refined <contact@itrefined.com>
    36	      1 iNic <contact@inic.no>
    37	      1 Credit Mutuel Arkea <contact@arkea.com>
    38	      1 Commerce Guys <contact@commerceguys.com>
    39	      1 CCM Benchmark <contact@ccmbenchmark.com>
    40	      1 Bigpoint.com <contact@bigpoint.net>
    41	      1 ArtiBit <contact@artibit.com>
Reviews by authors (one review spans multiple commits)
     1	    367 Sage Weil <sage@inktank.com>
     2	     92 Josh Durgin <josh.durgin@inktank.com>
     3	     84 Samuel Just <sam.just@inktank.com>
     4	     83 Greg Farnum <greg@inktank.com>
     5	     51 Loic Dachary <loic@dachary.org>
     6	     44 Christophe Courtaut <christophe.courtaut@gmail.com>
     7	     23 Yehuda Sadeh <yehuda@inktank.com>
     8	     22 Jo=E3o Eduardo Lu=EDs <joao.luis@inktank.com>
     9	     12 David Zafman <david.zafman@inktank.com>
    10	      8 Dan Mick <dan.mick@inktank.com>
    11	      6 Yan, Zheng <zheng.z.yan@intel.com>
    12	      5 Noah Watkins <noah.watkins@inktank.com>
    13	      4 Ken Dreyer <ken.dreyer@inktank.com>
    14	      3 Haomai Wang <haomaiwang@gmail.com>
    15	      3 Andreas Peters <andreas.joachim.peters@cern.ch>
    16	      2 Mark Nelson <mark.nelson@inktank.com>
    17	      2 Ilya Dryomov <ilya.dryomov@inktank.com>
    18	      2 Alfredo Deza <alfredo.deza@inktank.com>
    19	      1 Warren Usui <warren.usui@inktank.com>
    20	      1 Wang, Yaguang <yaguang.wang@intel.com>
    21	      1 Tyler Brekke <tyler.brekke@inktank.com>
    22	      1 Thomas Bechtold <t.bechtold@telekom.de>
    23	      1 Stephan Renatus <s.renatus@x-ion.de>
    24	      1 Sharif Olorin <sio@tesser.org>
    25	      1 Rutger ter Borg <rutger@terborg.net>
    26	      1 Roald J. van Loon <roald@roaldvanloon.nl>
    27	      1 Ray Lv <xiangyulv@gmail.com>
    28	      1 Nikola Kotur <kotnick@gmail.com>
    29	      1 Neil Levine <neil.levine@inktank.com>
    30	      1 Moritz M=F6ller <mm@mxs.de>
    31	      1 Mohammad Salehe <salehe+dev@gmail.com>
    32	      1 Laurent Barbe <laurent@ksperis.com>
    33	      1 Kai Zhang <zakir.exe@gmail.com>
    34	      1 Jonathan Dieter <jdieter@lesbg.com>
    35	      1 John Spray <john.spray@inktank.com>
    36	      1 Huang Jun <hjwsm1989@gmail.com>
    37	      1 Guang Yang <yguang@yahoo-inc.com>
    38	      1 Eric Mourgaya <eric.mourgaya@arkea.com>
    39	      1 Dmitry Smirnov <onlyjob@member.fsf.org>
    40	      1 Derek Yarnell <derek@umiacs.umd.edu>
    41	      1 David Moreau Simard <dmsimard@iweb.com>
    42	      1 Dan Chai <tengweicai@gmail.com>
    43	      1 Christopher O'Connell <jwriteclub@gmail.com>
    44	      1 Christian Marie <pingu@anchor.net.au>
    45	      1 Andrey Kuznetsov <Andrey_Kuznetsov@epam.com>
    46	      1 Alan Somers <asomers@gmail.com>
Reviews by organizations (one review spans multiple commits)
     1	    710 Inktank <contact@inktank.com>
     2	     95 Cloudwatt <libre.licensing@cloudwatt.com>
     3	      7 Intel <contact@intel.com>
     4	      3 UnitedStack <contact@unitedstack.com>
     5	      3 CERN <contact@cern.ch>
     6	      2 Yahoo! <contact@yahoo-inc.com>
     7	      2 Unaffiliated <no@organization.net>
     8	      2 Anchor Hosting <contact@anchor.com.au>
     9	      1 X-ION <contact@x-ion.de>
    10	      1 University of Mississippi <contact@umd.edu>
    11	      1 Spectra Logic <contact@spectralogic.com>
    12	      1 SendFaster <contact@sendfaster.com>
    13	      1 Roald van Loon Consultancy <roald@roaldvanloon.nl>
    14	      1 Lebanon Evangelical School <contact@lesbg.com>
    15	      1 IWeb <contact@iweb.com>
    16	      1 EPAM <contact@epam.com>
    17	      1 Deutsche Telekom <contact@telekom.de>
    18	      1 Debian GNU/Linux <contact@debian.org>
    19	      1 Credit Mutuel Arkea <contact@arkea.com>
    20	      1 Commerce Guys <contact@commerceguys.com>
    21	      1 CISCO <contact@cisco.com>
    22	      1 CCM Benchmark <contact@ccmbenchmark.com>
    23	      1 Bigpoint.com <contact@bigpoint.net>
    24	      1 Bayan <contact@bayan.co.ir>
    25	      1 ArtiBit <contact@artibit.com>

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
bash credits.sh tags/v0.72...tags/v0.80

Authors names are normalized with .mailmap and authors affiliations to a =
given organization comes from .organizationmap, both of which can be foun=
d and patched at the root of the ceph source tree.

More sophisticated reports can be generated and visualized by tools such =
as http://bitergia.com/ or http://stackalytics.com/. Cheers


--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--EkX7EVuHA6FEUqHas55jNHtl3PLV82c7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNp8wgACgkQ8dLMyEl6F20ClACghMNI7mtglBIo7ZF1O0dfHF+v
t5YAoJ017BbNzTRFapMtaNofP+1oYB5T
=mfHA
-----END PGP SIGNATURE-----

--EkX7EVuHA6FEUqHas55jNHtl3PLV82c7F--
