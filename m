From: Loic Dachary <loic@dachary.org>
Subject: Giant contributors credits
Date: Wed, 29 Oct 2014 23:26:36 +0100
Message-ID: <5451699C.4060007@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2DKCFKJdvHwGHGUOJ6dpdR0asJVQsnhw5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:55879 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757745AbaJ2W0o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Oct 2014 18:26:44 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id F3E5B420A8
	for <ceph-devel@vger.kernel.org>; Wed, 29 Oct 2014 23:26:36 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2DKCFKJdvHwGHGUOJ6dpdR0asJVQsnhw5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors (98) and organizations (40) who contribu=
ted to Giant (v0.87), by number of commits or reviews back to Firefly (v0=
=2E80). The affiliation of authors to organizations can be updated by sub=
mitting a patch to https://github.com/ceph/ceph/blob/master/.organization=
map

All commits are reviewed but the number of reviews is a fraction of the n=
umber of commits. More often than not, the reviewer(s) is only mentioned =
in the message of the merge although it means that all associated commits=
 have been reviewed. If you are curious about how it is done, the details=
 are at https://wiki.ceph.com/Community/Ceph_contributors_list_maintenanc=
e_guide .=20

Commits by authors
     1	    561 Sage Weil <sweil@redhat.com>
     2	    227 John Spray <jspray@redhat.com>
     3	    208 Loic Dachary <loic@dachary.org>
     4	    154 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     5	    143 Adam Crume <adamcrume@gmail.com>
     6	    108 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
     7	     98 Yehuda Sadeh <ysadehwe@redhat.com>
     8	     92 Greg Farnum <greg@inktank.com>
     9	     86 John Wilkins <jwilkins@redhat.com>
    10	     84 Samuel Just <sam.just@inktank.com>
    11	     68 Yan, Zheng <zyan@redhat.com>
    12	     46 Ilya Dryomov <idryomov@redhat.com>
    13	     45 David Zafman <dzafman@redhat.com>
    14	     36 Haomai Wang <haomaiwang@gmail.com>
    15	     34 Somnath Roy <somnath.roy@sandisk.com>
    16	     23 Josh Durgin <josh.durgin@inktank.com>
    17	     22 Ma Jianpeng <jianpeng.ma@intel.com>
    18	     22 Dan Mick <dan.mick@inktank.com>
    19	     20 Alfredo Deza <alfredo.deza@inktank.com>
    20	     20 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    21	     15 Kevin Dalley <kevin@kelphead.org>
    22	     13 Wido den Hollander <wido@42on.com>
    23	     12 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
    24	     12 Noah Watkins <noah.watkins@inktank.com>
    25	     11 Sebastien Ponce <sebastien.ponce@cern.ch>
    26	     11 Guang Yang <yguang@yahoo-inc.com>
    27	     10 Dmitry Smirnov <onlyjob@member.fsf.org>
    28	      9 Zhiqiang Wang <wonzhq@hotmail.com>
    29	      9 Shu, Xinxin <xinxin.shu@intel.com>
    30	      8 Jenkins <jenkins@inktank.com>
    31	      7 Swami Reddy <swami.reddy@ril.com>
    32	      7 Luis Pab=F3n <lpabon@redhat.com>
    33	      6 Xiaoxi Chen <xiaoxi.chen@intel.com>
    34	      5 Sandon Van Ness <sandon@inktank.com>
    35	      5 Matt Benjamin <matt@linuxbox.com>
    36	      5 Kevin Cox <kevincox@kevincox.ca>
    37	      5 Andreas Peters <andreas.joachim.peters@cern.ch>
    38	      4 Thorsten Behrens <tbehrens@suse.com>
    39	      4 Stephen Jahl <stephenjahl@gmail.com>
    40	      4 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    41	      4 Jason Dillaman <dillaman@redhat.com>
    42	      4 Huamin Chen <hchen@redhat.com>
    43	      4 Erik Logtenberg <erik@logtenberg.eu>
    44	      3 Stephen F Taylor <steveftaylor@gmail.com>
    45	      3 Michael Riederer <michael@riederer.org>
    46	      3 Janne Grunau <j@jannau.net>
    47	      3 Dan van der Ster <daniel.vanderster@cern.ch>
    48	      3 Daniel J. Hofmann <daniel@trvx.org>
    49	      3 Andrey Kuznetsov <Andrey_Kuznetsov@epam.com>
    50	      2 Wei Luo <luowei@yahoo-inc.com>
    51	      2 Sylvain Munaut <s.munaut@whatever-company.com>
    52	      2 Stefan Eilemann <Stefan.Eilemann@epfl.ch>
    53	      2 Sebastien Han <sebastien.han@enovance.com>
    54	      2 Ross Turk <rturk@redhat.com>
    55	      2 Mohammad Salehe <salehe+dev@gmail.com>
    56	      2 Johnu George <johnugeo@cisco.com>
    57	      2 Fran=E7ois Lafont <flafdivers@free.fr>
    58	      2 Adam Twardowski <adam.twardowski@gmail.com>
    59	      1 Yongyue Sun <abioy.sun@gmail.com>
    60	      1 Xing Lin <xinglin@cs.utah.edu>
    61	      1 Warren Usui <warren.usui@inktank.com>
    62	      1 Walter Huf <hufman@gmail.com>
    63	      1 Venky Shankar <vshankar@redhat.com>
    64	      1 Tyler Brekke <tyler.brekke@inktank.com>
    65	      1 Thorsten Glaser <tg@mirbsd.de>
    66	      1 Sushma Gurram <sushma.gurram@sandisk.com>
    67	      1 Stuart Longland <stuartl@vrt.com.au>
    68	      1 Shawn Edwards <lesser.evil@gmail.com>
    69	      1 Roman Haritonov <reclosedev@gmail.com>
    70	      1 Ray Lv <xiangyulv@gmail.com>
    71	      1 Owen Synge <osynge@suse.com>
    72	      1 Marco Garc=EAs <marco.garces@bci.co.mz>
    73	      1 Lluis Pamies-Juarez <lluis.pamies-juarez@hgst.com>
    74	      1 Kai Zhang <zakir.exe@gmail.com>
    75	      1 JuanJose 'JJ' Galvez <jgalvez@redhat.com>
    76	      1 Jiang Heng <jiangheng0511@gmail.com>
    77	      1 Huang Jun <hjwsm1989@gmail.com>
    78	      1 Henry C Chang <henry_c_chang@tcloudcomputing.com>
    79	      1 Harpreet Dhillon <harpreet@ironsystems.com>
    80	      1 Gerben Meijer <gerben@daybyday.nl>
    81	      1 George Ryall <george.ryall@stfc.ac.uk>
    82	      1 Florent Flament <florent.flament@cloudwatt.com>
    83	      1 Federico Simoncelli <fsimonce@redhat.com>
    84	      1 Federico Gimenez <fgimenez@coit.es>
    85	      1 Dominik Hannen <cantares1+github@gmail.com>
    86	      1 David Moreau Simard <dmsimard@iweb.com>
    87	      1 Colin Mattson <colinmattson@gmail.com>
    88	      1 Christian Theune <ct@gocept.com>
    89	      1 Chris Glass <tribaal@gmail.com>
    90	      1 Brian Rak <dn@devicenull.org>
    91	      1 Boris Ranto <branto@redhat.com>
    92	      1 Ashish Chandra <ashish.a.chandra@ril.com>
    93	      1 Aristoteles Neto <aristoteles.neto@webdrive.co.nz>
    94	      1 Anand Bhat <anand.bhat@sandisk.com>
    95	      1 Alexandre Oliva <oliva@gnu.org>
    96	      1 Alexandre Marangone <alexandre.marangone@inktank.com>
    97	      1 Ailing Zhang <zhangal1992@gmail.com>
    98	      1 Accela Zhao <accelazh@gmail.com>
Commits by organizations
     1	    857 Inktank <contact@inktank.com>
     2	    700 Red Hat <contact@redhat.com>
     3	    154 Deutsche Telekom <contact@telekom.de>
     4	    143 University of California, Santa Cruz <contact@cs.ucsc.edu>=

     5	    128 Cloudwatt <libre.licensing@cloudwatt.com>
     6	    111 Intel <contact@intel.com>
     7	     40 SanDisk <contact@sandisk.com>
     8	     36 UnitedStack <contact@unitedstack.com>
     9	     30 Unaffiliated <no@organization.net>
    10	     28 Reliance Jio Infocomm Ltd. <contact@ril.com>
    11	     19 CERN <contact@cern.ch>
    12	     16 HGST <contact@hgst.com>
    13	     14 Yahoo! <contact@yahoo-inc.com>
    14	     13 Wido 42on <contact@42on.com>
    15	     11 Debian GNU/Linux <contact@debian.org>
    16	      5 The Linux Box <contact@linuxbox.com>
    17	      5 SUSE <contact@suse.com>
    18	      4 MIT Computer Science and Artificial Intelligence Laborator=
y <webmaster@csail.mit.edu>
    19	      3 Karlsruhe Institute of Technology <ceph@lists.kit.edu>
    20	      3 EPAM <contact@epam.com>
    21	      3 CISCO <contact@cisco.com>
    22	      2 Whatever <contact@whatever-company.com>
    23	      2 eNovance <contact@enovance.com>
    24	      2 =C9cole polytechnique f=E9d=E9rale de Lausanne <contact@ep=
fl.ch>
    25	      2 Choopa, LLC <contact@choopa.com>
    26	      2 Bayan <contact@bayan.co.ir>
    27	      1 Web Drive <contact@webdrive.co.nz>
    28	      1 VRT <contact@vrt.com.au>
    29	      1 University of Utah <contact@utah.edu>
    30	      1 TCloud Computing <contact@tcloudcomputing.com>
    31	      1 Science & Technology Facilities Council <contact@stfc.ac.u=
k>
    32	      1 IWeb <contact@iweb.com>
    33	      1 Iron Systems Inc. <info@ironsystems.com>
    34	      1 gocept gmbh & co. kg <mail@gocept.com>
    35	      1 GNU <contact@gnu.org>
    36	      1 GameServers.com <contact@gameservers.com>
    37	      1 Day By Day <contact@daybyday.nl>
    38	      1 Corvisa LLC <contact@corvisa.com>
    39	      1 Canonical <contact@canonical.com>
    40	      1 BCI <contact@bci.co.mz>
Reviews by authors (one review spans multiple commits)
     1	    247 Sage Weil <sweil@redhat.com>
     2	     97 Samuel Just <sam.just@inktank.com>
     3	     73 Greg Farnum <greg@inktank.com>
     4	     72 Loic Dachary <loic@dachary.org>
     5	     50 Josh Durgin <josh.durgin@inktank.com>
     6	     24 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
     7	     18 John Spray <jspray@redhat.com>
     8	     16 Yehuda Sadeh <ysadehwe@redhat.com>
     9	     11 Dan Mick <dan.mick@inktank.com>
    10	      7 John Wilkins <jwilkins@redhat.com>
    11	      7 Christophe Courtaut <christophe.courtaut@gmail.com>
    12	      6 Haomai Wang <haomaiwang@gmail.com>
    13	      5 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
    14	      5 Florent Flament <florent.flament@cloudwatt.com>
    15	      5 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    16	      5 Alfredo Deza <alfredo.deza@inktank.com>
    17	      4 Yan, Zheng <zyan@redhat.com>
    18	      4 David Zafman <dzafman@redhat.com>
    19	      3 Alfredo Deza <adeza@redhat.com>
    20	      2 Xiaoxi Chen <xiaoxi.chen@intel.com>
    21	      2 Wei Luo <luowei@yahoo-inc.com>
    22	      2 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    23	      2 Ma Jianpeng <jianpeng.ma@intel.com>
    24	      2 Lluis Pamies-Juarez <lluis.pamies-juarez@hgst.com>
    25	      2 Janne Grunau <j@jannau.net>
    26	      2 Andreas Peters <andreas.joachim.peters@cern.ch>
    27	      1 Walter Huf <hufman@gmail.com>
    28	      1 Volker Voigt <volker.voigt@1und1.de>
    29	      1 Swami Reddy <swami.reddy@ril.com>
    30	      1 Stephen Jahl <stephenjahl@gmail.com>
    31	      1 Sebastien Ponce <sebastien.ponce@cern.ch>
    32	      1 Noah Watkins <noah.watkins@inktank.com>
    33	      1 Marco Garc=EAs <marco.garces@bci.co.mz>
    34	      1 koleosfuscus <koleosfuscus@yahoo.com>
    35	      1 Kevin Dalley <kevin@kelphead.org>
    36	      1 Kevin Cox <kevincox@kevincox.ca>
    37	      1 Johnu George <johnugeo@cisco.com>
    38	      1 Huang Jun <hjwsm1989@gmail.com>
    39	      1 Huamin Chen <hchen@redhat.com>
    40	      1 Guang Yang <yguang@yahoo-inc.com>
    41	      1 Federico Simoncelli <fsimonce@redhat.com>
    42	      1 Erik Logtenberg <erik@logtenberg.eu>
    43	      1 Dmitry Smirnov <onlyjob@member.fsf.org>
    44	      1 Daniel Schepler <dschepler@gmail.com>
    45	      1 Daniel J. Hofmann <daniel@trvx.org>
    46	      1 Christian Theune <ct@gocept.com>
    47	      1 Chris Glass <tribaal@gmail.com>
    48	      1 Cheng Cheng <ccheng.leo@gmail.com>
    49	      1 Brian Rak <dn@devicenull.org>
    50	      1 Boris Ranto <branto@redhat.com>
    51	      1 Babu Shanmugam <anbu@enovance.com>
    52	      1 Aristoteles Neto <aristoteles.neto@webdrive.co.nz>
    53	      1 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
Reviews by organizations (one review spans multiple commits)
     1	    336 Inktank <contact@inktank.com>
     2	    244 Red Hat <contact@redhat.com>
     3	     69 Cloudwatt <libre.licensing@cloudwatt.com>
     4	      9 Unaffiliated <no@organization.net>
     5	      7 Intel <contact@intel.com>
     6	      6 UnitedStack <contact@unitedstack.com>
     7	      5 Deutsche Telekom <contact@telekom.de>
     8	      3 Yahoo! <contact@yahoo-inc.com>
     9	      3 HGST <contact@hgst.com>
    10	      3 CERN <contact@cern.ch>
    11	      2 SanDisk <contact@sandisk.com>
    12	      2 Reliance Jio Infocomm Ltd. <contact@ril.com>
    13	      1 Web Drive <contact@webdrive.co.nz>
    14	      1 MIT Computer Science and Artificial Intelligence Laborator=
y <webmaster@csail.mit.edu>
    15	      1 Karlsruhe Institute of Technology <ceph@lists.kit.edu>
    16	      1 gocept gmbh & co. kg <mail@gocept.com>
    17	      1 GameServers.com <contact@gameservers.com>
    18	      1 eNovance <contact@enovance.com>
    19	      1 Debian GNU/Linux <contact@debian.org>
    20	      1 Corvisa LLC <contact@corvisa.com>
    21	      1 CISCO <contact@cisco.com>
    22	      1 Canonical <contact@canonical.com>
    23	      1 BCI <contact@bci.co.mz>

Cheers

--=20
Lo=EFc Dachary, Artisan Logiciel Libre




--2DKCFKJdvHwGHGUOJ6dpdR0asJVQsnhw5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlRRaZwACgkQ8dLMyEl6F22ZawCfRGZe+M+AyNjtjYpR5+aIiVp7
7wgAnAixafg4m2U4C57YAa+wWv/iWVqu
=B0jp
-----END PGP SIGNATURE-----

--2DKCFKJdvHwGHGUOJ6dpdR0asJVQsnhw5--
