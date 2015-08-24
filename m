From: Loic Dachary <loic@dachary.org>
Subject: v9.0.3 Contributor credits
Date: Mon, 24 Aug 2015 23:08:48 +0200
Message-ID: <55DB87E0.404@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dmsuOnaxnWCFBDqVaKcfx8lTWPdTiDSh8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:43152 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753810AbbHXVIx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Aug 2015 17:08:53 -0400
Received: from [10.9.0.6] (unknown [10.0.2.28])
	by smtp.dmail.dachary.org (Postfix) with ESMTP id ABED542B44
	for <ceph-devel@vger.kernel.org>; Mon, 24 Aug 2015 23:08:48 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dmsuOnaxnWCFBDqVaKcfx8lTWPdTiDSh8
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v9.0.3, by number of commits or reviews back to v9.0.2. The affiliation o=
f
authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the
number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at http://tracker.ceph.com/projects/c=
eph/wiki/Ceph_contributors_list_maintenance_guide

Number of lines added and removed, by authors
     1	  8419 John Spray <jspray@redhat.com>
     2	  5277 Sage Weil <sweil@redhat.com>
     3	  1738 Yehuda Sadeh <ysadehwe@redhat.com>
     4	  1266 Shotaro Kawaguchi <kawaguchi.s@jp.fujitsu.com>
     5	  1098 Takanori Nakao <nakao.takanori@jp.fujitsu.com>
     6	  1008 Ilya Dryomov <idryomov@redhat.com>
     7	  1001 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     8	   821 David Zafman <dzafman@redhat.com>
     9	   769 Haomai Wang <haomaiwang@gmail.com>
    10	   604 Jason Dillaman <dillaman@redhat.com>
    11	   546 Joao Eduardo Luis <joao@suse.de>
    12	   493 Ma Jianpeng <jianpeng.ma@intel.com>
    13	   424 Kefu Chai <kchai@redhat.com>
    14	   384 Vikhyat Umrao <vumrao@redhat.com>
    15	   240 Sebastien Ponce <sebastien.ponce@cern.ch>
    16	   236 Shu, Xinxin <xinxin.shu@intel.com>
    17	   236 Jevon Qiao <qiaojianfeng@unitedstack.com>
    18	   229 Zhiqiang Wang <zhiqiang.wang@intel.com>
    19	   178 Pete Zaitcev <zaitcev@redhat.com>
    20	   149 Mingxin Liu <mingxinliu@ubuntukylin.com>
    21	   142 Vu Pham <vu@mellanox.com>
    22	   136 Loic Dachary <ldachary@redhat.com>
    23	   125 Nathan Cutler <ncutler@suse.com>
    24	   115 Joe Handzik <joseph.t.handzik@hp.com>
    25	   104 S=C3=A9bastien Han <shan@redhat.com>
    26	    89 Owen Synge <osynge@suse.com>
    27	    88 Mykola Golub <mgolub@mirantis.com>
    28	    82 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    29	    73 Alfredo Deza <adeza@redhat.com>
    30	    65 Maxime Robert <maxime.robert1992@gmail.com>
    31	    63 Samuel Just <sjust@redhat.com>
    32	    60 Yan, Zheng <zyan@redhat.com>
    33	    53 Michal Jarzabek <stiopa@gmail.com>
    34	    46 Xinze Chi <xmdxcxz@gmail.com>
    35	    43 Yuan Zhou <yuan.zhou@intel.com>
    36	    39 Xiaoxi Chen <xiaoxi.chen@intel.com>
    37	    36 Abhishek Dixit <dixitabhi@gmail.com>
    38	    32 Krzysztof Kosi=C5=84ski <krzysztof.kosinski@intel.com>
    39	    30 Wu Xingyi <wuxingyi@letv.com>
    40	    20 Valentin Arshanes Thomas <valentin.arshanes.thomas@gmail.co=
m>
    41	    20 Shawn Chen <cxwshawn@gmail.com>
    42	    19 Orit Wasserman <owasserm@redhat.com>
    43	    18 Huang Jun <hjwsm1989@gmail.com>
    44	    17 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    45	    15 Zhi (David) Zhang <zhangz@yahoo-inc.com>
    46	    15 Boris Ranto <branto@redhat.com>
    47	    11 Dan van der Ster <daniel.vanderster@cern.ch>
    48	    10 Pierre Chaumont <pierre.chaumont31@gmail.com>
    49	     8 Ken Dreyer <kdreyer@redhat.com>
    50	     8 Jenkins <jenkins@inktank.com>
    51	     8 guce <guce@h3c.com>
    52	     6 Wido den Hollander <wido@42on.com>
    53	     5 Yazen Ghannam <yazen.ghannam@linaro.org>
    54	     5 Greg Farnum <gfarnum@redhat.com>
    55	     4 Thomas Laumondais <thomas.laumondais@gmail.com>
    56	     4 Ira Cooper <ira@samba.org>
    57	     4 Germain Chipaux <germain.chipaux@gmail.com>
    58	     4 Arthur Gorjux <arthurgorjux@gmail.com>
    59	     3 Nicolas Yong <nicolas.yong93@gmail.com>
    60	     2 Yannick Atchy Dalama <yannick.atchy.dalama@gmail.com>
    61	     2 Swami Reddy <swami.reddy@ril.com>
    62	     2 Robin Tang <robintang974@gmail.com>
    63	     2 Raju Kurunkad <raju.kurunkad@sandisk.com>
    64	     2 Lucas Fantinel <lucas.fantinel@gmail.com>
    65	     2 K=C3=A9vin Caradant <kevin.caradant@gmail.com>
    66	     2 Jordan Dorne <jordan.dorne@gmail.com>
    67	     2 Jiaying Ren <mikulely@gmail.com>
    68	     2 Jean-R=C3=A9mi Deveaux <jeanremi.deveaux@gmail.com>
    69	     2 Guang Yang <yguang@yahoo-inc.com>
    70	     2 Ga=C3=ABl Fenet-Garde <gael.fenet.garde@gmail.com>
    71	     2 Gabriel Sentucq <perso@kazhord.fr>
    72	     2 Clement Lebrun <clement.lebrun.31@gmail.com>
    73	     1 Claire Massot <claire.massot93@gmail.com>

Number of lines added and removed, by organization
     1	 19340 Red Hat <contact@redhat.com>
     2	  2446 Fujitsu <contact@fujitsu.com>
     3	  1089 Mirantis <contact@mirantis.com>
     4	  1073 Unaffiliated <no@organization.net>
     5	  1072 Intel <contact@intel.com>
     6	   760 SUSE <contact@suse.com>
     7	   251 CERN <contact@cern.ch>
     8	   236 UnitedStack <contact@unitedstack.com>
     9	   149 Ubuntu Kylin <contact@ubuntukylin.com>
    10	   142 Mellanox <contact@mellanox.com>
    11	   115 HP <contact@hp.com>
    12	    30 LETV <contact@letv.com>
    13	    19 Reliance Jio Infocomm Ltd. <contact@ril.com>
    14	    17 Yahoo! <contact@yahoo-inc.com>
    15	     8 Inktank <contact@inktank.com>
    16	     8 guce <guce@h3c.com>
    17	     6 Wido 42on <contact@42on.com>
    18	     5 Linaro <contact@linaro.org>
    19	     2 SanDisk <contact@sandisk.com>

Commits, by authors
     1	     99 Sage Weil <sweil@redhat.com>
     2	     56 John Spray <jspray@redhat.com>
     3	     28 Ma Jianpeng <jianpeng.ma@intel.com>
     4	     28 Joao Eduardo Luis <joao@suse.de>
     5	     25 Kefu Chai <kchai@redhat.com>
     6	     25 David Zafman <dzafman@redhat.com>
     7	     21 Yehuda Sadeh <ysadehwe@redhat.com>
     8	     20 Nathan Cutler <ncutler@suse.com>
     9	     18 Haomai Wang <haomaiwang@gmail.com>
    10	     13 Jason Dillaman <dillaman@redhat.com>
    11	     12 Ilya Dryomov <idryomov@redhat.com>
    12	     11 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    13	      9 Zhiqiang Wang <zhiqiang.wang@intel.com>
    14	      9 Loic Dachary <ldachary@redhat.com>
    15	      8 Shu, Xinxin <xinxin.shu@intel.com>
    16	      7 Owen Synge <osynge@suse.com>
    17	      6 Yuan Zhou <yuan.zhou@intel.com>
    18	      5 Sebastien Ponce <sebastien.ponce@cern.ch>
    19	      5 Orit Wasserman <owasserm@redhat.com>
    20	      5 Mingxin Liu <mingxinliu@ubuntukylin.com>
    21	      4 Yan, Zheng <zyan@redhat.com>
    22	      4 Xinze Chi <xmdxcxz@gmail.com>
    23	      4 Mykola Golub <mgolub@mirantis.com>
    24	      4 Jevon Qiao <qiaojianfeng@unitedstack.com>
    25	      4 Boris Ranto <branto@redhat.com>
    26	      4 Alfredo Deza <adeza@redhat.com>
    27	      3 Vu Pham <vu@mellanox.com>
    28	      3 Vikhyat Umrao <vumrao@redhat.com>
    29	      3 Samuel Just <sjust@redhat.com>
    30	      3 Ken Dreyer <kdreyer@redhat.com>
    31	      3 Huang Jun <hjwsm1989@gmail.com>
    32	      2 Zhi (David) Zhang <zhangz@yahoo-inc.com>
    33	      2 Yazen Ghannam <yazen.ghannam@linaro.org>
    34	      2 Xiaoxi Chen <xiaoxi.chen@intel.com>
    35	      2 Wu Xingyi <wuxingyi@letv.com>
    36	      2 Thomas Laumondais <thomas.laumondais@gmail.com>
    37	      2 Takanori Nakao <nakao.takanori@jp.fujitsu.com>
    38	      2 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    39	      2 Michal Jarzabek <stiopa@gmail.com>
    40	      2 Maxime Robert <maxime.robert1992@gmail.com>
    41	      2 Krzysztof Kosi=C5=84ski <krzysztof.kosinski@intel.com>
    42	      2 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    43	      2 Abhishek Dixit <dixitabhi@gmail.com>
    44	      1 Yannick Atchy Dalama <yannick.atchy.dalama@gmail.com>
    45	      1 Wido den Hollander <wido@42on.com>
    46	      1 Valentin Arshanes Thomas <valentin.arshanes.thomas@gmail.c=
om>
    47	      1 Swami Reddy <swami.reddy@ril.com>
    48	      1 Shotaro Kawaguchi <kawaguchi.s@jp.fujitsu.com>
    49	      1 Shawn Chen <cxwshawn@gmail.com>
    50	      1 S=C3=A9bastien Han <shan@redhat.com>
    51	      1 Robin Tang <robintang974@gmail.com>
    52	      1 Raju Kurunkad <raju.kurunkad@sandisk.com>
    53	      1 Pierre Chaumont <pierre.chaumont31@gmail.com>
    54	      1 Pete Zaitcev <zaitcev@redhat.com>
    55	      1 Nicolas Yong <nicolas.yong93@gmail.com>
    56	      1 Lucas Fantinel <lucas.fantinel@gmail.com>
    57	      1 liumingxin <mingxinliu@ubuntukylin.com>
    58	      1 K=C3=A9vin Caradant <kevin.caradant@gmail.com>
    59	      1 Jordan Dorne <jordan.dorne@gmail.com>
    60	      1 Joe Handzik <joseph.t.handzik@hp.com>
    61	      1 Jiaying Ren <mikulely@gmail.com>
    62	      1 Jenkins <jenkins@inktank.com>
    63	      1 Jean-R=C3=A9mi Deveaux <jeanremi.deveaux@gmail.com>
    64	      1 Ira Cooper <ira@samba.org>
    65	      1 guce <guce@h3c.com>
    66	      1 Guang Yang <yguang@yahoo-inc.com>
    67	      1 Greg Farnum <gfarnum@redhat.com>
    68	      1 Germain Chipaux <germain.chipaux@gmail.com>
    69	      1 Ga=C3=ABl Fenet-Garde <gael.fenet.garde@gmail.com>
    70	      1 Gabriel Sentucq <perso@kazhord.fr>
    71	      1 Dan van der Ster <daniel.vanderster@cern.ch>
    72	      1 Clement Lebrun <clement.lebrun.31@gmail.com>
    73	      1 Claire Massot <claire.massot93@gmail.com>
    74	      1 Arthur Gorjux <arthurgorjux@gmail.com>

Commits, by organizations
     1	    290 Red Hat <contact@redhat.com>
     2	     55 SUSE <contact@suse.com>
     3	     55 Intel <contact@intel.com>
     4	     50 Unaffiliated <no@organization.net>
     5	     15 Mirantis <contact@mirantis.com>
     6	      6 CERN <contact@cern.ch>
     7	      5 Ubuntu Kylin <contact@ubuntukylin.com>
     8	      5 Fujitsu <contact@fujitsu.com>
     9	      4 UnitedStack <contact@unitedstack.com>
    10	      3 Yahoo! <contact@yahoo-inc.com>
    11	      3 Reliance Jio Infocomm Ltd. <contact@ril.com>
    12	      3 Mellanox <contact@mellanox.com>
    13	      2 Linaro <contact@linaro.org>
    14	      2 LETV <contact@letv.com>
    15	      1 Wido 42on <contact@42on.com>
    16	      1 SanDisk <contact@sandisk.com>
    17	      1 liumingxin <mingxinliu@ubuntukylin.com>
    18	      1 Inktank <contact@inktank.com>
    19	      1 HP <contact@hp.com>
    20	      1 guce <guce@h3c.com>

Reviews, by authors (one review spans multiple commits)
     1	     41 Loic Dachary <ldachary@redhat.com>
     2	     39 Kefu Chai <kchai@redhat.com>
     3	     23 Sage Weil <sweil@redhat.com>
     4	     17 Josh Durgin <jdurgin@redhat.com>
     5	     15 Yehuda Sadeh <ysadehwe@redhat.com>
     6	     15 Ken Dreyer <kdreyer@redhat.com>
     7	     14 Greg Farnum <gfarnum@redhat.com>
     8	      8 Samuel Just <sjust@redhat.com>
     9	      8 Li Wang <liwang@ubuntukylin.com>
    10	      8 John Spray <jspray@redhat.com>
    11	      5 Joao Eduardo Luis <joao@suse.de>
    12	      5 Haomai Wang <haomaiwang@gmail.com>
    13	      5 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    14	      3 Nathan Cutler <ncutler@suse.com>
    15	      3 Boris Ranto <branto@redhat.com>
    16	      2 David Zafman <dzafman@redhat.com>
    17	      2 Alfredo Deza <adeza@redhat.com>
    18	      1 Varada Kari <varada.kari@sandisk.com>
    19	      1 Travis Rhoden <trhoden@redhat.com>
    20	      1 Min Chen <minchen@ubuntukylin.com>
    21	      1 Jason Dillaman <dillaman@redhat.com>
    22	      1 Dan Mick <dmick@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1	    190 Red Hat <contact@redhat.com>
     2	      9 Ubuntu Kylin <contact@ubuntukylin.com>
     3	      8 SUSE <contact@suse.com>
     4	      5 Unaffiliated <no@organization.net>
     5	      5 Reliance Jio Infocomm Ltd. <contact@ril.com>
     6	      1 SanDisk <contact@sandisk.com>

P.S. If anyone knows which names goes with guce <guce@h3c.com> is, please=
 let me know ;-)

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--dmsuOnaxnWCFBDqVaKcfx8lTWPdTiDSh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXbh+AACgkQ8dLMyEl6F20xMgCbBjJBHfqwrscNOpETUKYPR78C
sfQAoLzhg3p7x3k7fbrj2nHGY2g/bB9O
=OaIy
-----END PGP SIGNATURE-----

--dmsuOnaxnWCFBDqVaKcfx8lTWPdTiDSh8--
