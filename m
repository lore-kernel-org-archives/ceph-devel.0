From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: v0.93 Contributor Credits
Date: Mon, 02 Mar 2015 11:00:56 +0530
Message-ID: <87egp86k4v.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:42067 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbbCBFb2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Mar 2015 00:31:28 -0500
Received: by pdbfl12 with SMTP id fl12so5649200pdb.9
        for <ceph-devel@vger.kernel.org>; Sun, 01 Mar 2015 21:31:27 -0800 (PST)
Received: from trusty ([106.51.241.2])
        by mx.google.com with ESMTPSA id d9sm10687059pdk.3.2015.03.01.21.31.25
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 01 Mar 2015 21:31:26 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v0.93, by number of commits or reviews back to v0.92. The affiliation o=
f
authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the
number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at https://wiki.ceph.com/Community/=
Ceph_contributors_list_maintenance_guide


Number of lines added and removed, by authors
     1	442699 Jason Dillaman <dillaman@redhat.com>
     2	 17645 Yehuda Sadeh <ysadehwe@redhat.com>
     3	 12675 Sage Weil <sweil@redhat.com>
     4	  9618 Min Chen <minchen@ubuntukylin.com>
     5	  7564 Matt Benjamin <matt@cohortfs.com>
     6	  6838 Xiaoxi Chen <xiaoxi.chen@intel.com>
     7	  5900 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
     8	  5269 Ali Maredia <ali@linuxbox.com>
     9	  2187 Haomai Wang <haomaiwang@gmail.com>
    10	  2091 John Spray <jspray@redhat.com>
    11	  1517 Mykola Golub <mgolub@mirantis.com>
    12	  1441 Samuel Just <sjust@redhat.com>
    13	  1116 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
    14	   980 Cheng Cheng <ccheng.leo@gmail.com>
    15	   956 Loic Dachary <ldachary@redhat.com>
    16	   926 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
    17	   774 Yan, Zheng <zyan@redhat.com>
    18	   635 Josh Durgin <jdurgin@redhat.com>
    19	   589 Vu Pham <vu@mellanox.com>
    20	   517 David Zafman <dzafman@redhat.com>
    21	   492 Ma Jianpeng <jianpeng.ma@intel.com>
    22	   454 Andrew Bartlett <abartlet@catalyst.net.nz>
    23	   293 Shu, Xinxin <xinxin.shu@intel.com>
    24	   286 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    25	   277 Xinze Chi <xmdxcxz@gmail.com>
    26	   276 Dong Yuan <yuandong1222@gmail.com>
    27	   276 Boris Ranto <branto@redhat.com>
    28	   214 Greg Farnum <gfarnum@redhat.com>
    29	   209 Casey Bodley <casey@linuxbox.com>
    30	   149 Matt Benjamin <matt@linuxbox.com>
    31	   148 Kim Vandry <vandry@TZoNE.ORG>
    32	   139 Dmytro Iurchenko <diurchenko@mirantis.com>
    33	   125 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    34	   124 Baptiste Veuillez <baptiste.veuillez--mainard@telecom-bre=
tagne.eu>
    35	   106 Kefu Chai <kchai@redhat.com>
    36	    86 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    37	    74 Jian Wen <wenjian@letv.com>
    38	    64 Zhiqiang Wang <zhiqiang.wang@intel.com>
    39	    63 MingXin Liu <mingxinliu@ubuntukylin.com>
    40	    59 Noah Watkins <nwatkins@redhat.com>
    41	    58 Ken Dreyer <kdreyer@redhat.com>
    42	    47 Tim Freund <tim@freunds.net>
    43	    39 Thorsten Behrens <tbehrens@suse.com>
    44	    22 Shanggao Qiu <qiushanggao@qq.com>
    45	    22 Kiseleva Alyona <akiselyova@mirantis.com>
    46	    19 Yuan Zhou <yuan.zhou@intel.com>
    47	    19 John Wilkins <jwilkins@redhat.com>
    48	    18 Petr Machata <pmachata@redhat.com>
    49	    16 Sebastien Ponce <sebastien.ponce@cern.ch>
    50	    15 Frank Yu <flyxiaoyu@gmail.com>
    51	    14 Robert Jansen <r.jansen@fairbanks.nl>
    52	     9 Billy Olsen <billy.olsen@canonical.com>
    53	     8 Tyler Brekke <tbrekke@redhat.com>
    54	     8 Travis Rhoden <trhoden@redhat.com>
    55	     8 Jenkins <jenkins@inktank.com>
    56	     8 Armando Segnini <armaseg@gmail.com>
    57	     6 Sebastien Han <sebastien.han@enovance.com>
    58	     6 Huang Jun <hjwsm1989@gmail.com>
    59	     6 Dongmao Zhang <deanraccoon@gmail.com>
    60	     5 Thomas Cantin <thomas.cantin@telecom-bretagne.eu>
    61	     4 Ning Yao <zay11022@gmail.com>
    62	     4 Guang Yang <yguang@yahoo-inc.com>
    63	     4 Florian Coste <fcoste21@gmail.com>
    64	     4 Feng He <fenglife@hotmail.com>
    65	     3 Anis Ayari <ayari_anis@live.fr>
    66	     3 Ahoussi Armand <ahoussi.say@telecom-bretagne.eu>
    67	     2 Yongyue Sun <abioy.sun@gmail.com>
    68	     2 Wido den Hollander <wido@42on.com>
    69	     2 Viktor Suprun <popsul1993@gmail.com>
    70	     2 Neil Levine <nlevine@redhat.com>
    71	     2 Karel Striegel <karel.striegel@ipc.be>
    72	     2 Hazem Amara <hazem.amara@telecom-bretagne.eu>
    73	     2 Andy Allan <github@gravitystorm.co.uk>

Number of lines added and removed, by organization
     1	480727 Red Hat <contact@redhat.com>
     2	 10607 Ubuntu Kylin <contact@ubuntukylin.com>
     3	  7706 Intel <contact@intel.com>
     4	  7564 CohortFS, LLC <contact@cohortfs.com>
     5	  5900 Fujitsu <contact@fujitsu.com>
     6	  5627 The Linux Box <contact@linuxbox.com>
     7	  2463 UnitedStack <contact@unitedstack.com>
     8	  1964 Mirantis <contact@mirantis.com>
     9	  1606 Unaffiliated <no@organization.net>
    10	   598 Inktank <contact@inktank.com>
    11	   589 Mellanox <contact@mellanox.com>
    12	   454 Catalyst <enquiries@catalyst.net.nz>
    13	   134 Telecom Bretagne <contact@telecom-bretagne.eu>
    14	   125 Deutsche Telekom <contact@telekom.de>
    15	    86 Reliance Jio Infocomm Ltd. <contact@ril.com>
    16	    39 SUSE <contact@suse.com>
    17	    16 CERN <contact@cern.ch>
    18	    14 Fairbanks <contact@fairbanks.nl>
    19	     9 Canonical <contact@canonical.com>
    20	     6 eNovance <contact@enovance.com>
    21	     4 Yahoo! <contact@yahoo-inc.com>
    22	     2 Wido 42on <contact@42on.com>

Commits, by authors
     1	    219 Yehuda Sadeh <ysadehwe@redhat.com>
     2	     87 Jason Dillaman <dillaman@redhat.com>
     3	     84 Sage Weil <sweil@redhat.com>
     4	     60 Samuel Just <sjust@redhat.com>
     5	     43 Yan, Zheng <zyan@redhat.com>
     6	     38 Loic Dachary <ldachary@redhat.com>
     7	     38 Haomai Wang <haomaiwang@gmail.com>
     8	     33 Josh Durgin <jdurgin@redhat.com>
     9	     30 Ma Jianpeng <jianpeng.ma@intel.com>
    10	     30 John Spray <jspray@redhat.com>
    11	     30 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    12	     26 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
    13	     26 David Zafman <dzafman@redhat.com>
    14	     18 Matt Benjamin <matt@cohortfs.com>
    15	     16 Shu, Xinxin <xinxin.shu@intel.com>
    16	     16 Mykola Golub <mgolub@mirantis.com>
    17	     15 Vu Pham <vu@mellanox.com>
    18	     11 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    19	     11 Greg Farnum <gfarnum@redhat.com>
    20	     10 Zhiqiang Wang <zhiqiang.wang@intel.com>
    21	     10 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
    22	     10 Kefu Chai <kchai@redhat.com>
    23	      8 Min Chen <minchen@ubuntukylin.com>
    24	      7 Xinze Chi <xmdxcxz@gmail.com>
    25	      7 Dong Yuan <yuandong1222@gmail.com>
    26	      5 Ken Dreyer <kdreyer@redhat.com>
    27	      5 Dmytro Iurchenko <diurchenko@mirantis.com>
    28	      5 Casey Bodley <casey@linuxbox.com>
    29	      5 Boris Ranto <branto@redhat.com>
    30	      5 Andrew Bartlett <abartlet@catalyst.net.nz>
    31	      4 Matt Benjamin <matt@linuxbox.com>
    32	      4 Frank Yu <flyxiaoyu@gmail.com>
    33	      3 Yuan Zhou <yuan.zhou@intel.com>
    34	      3 Xiaoxi Chen <xiaoxi.chen@intel.com>
    35	      3 MingXin Liu <mingxinliu@ubuntukylin.com>
    36	      3 John Wilkins <jwilkins@redhat.com>
    37	      3 Jian Wen <wenjian@letv.com>
    38	      3 Cheng Cheng <ccheng.leo@gmail.com>
    39	      2 Thorsten Behrens <tbehrens@suse.com>
    40	      2 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
    41	      2 Robert Jansen <r.jansen@fairbanks.nl>
    42	      2 Noah Watkins <nwatkins@redhat.com>
    43	      2 Kim Vandry <vandry@TZoNE.ORG>
    44	      2 Feng He <fenglife@hotmail.com>
    45	      2 Baptiste Veuillez <baptiste.veuillez--mainard@telecom-br=
etagne.eu>
    46	      1 Yongyue Sun <abioy.sun@gmail.com>
    47	      1 Wido den Hollander <wido@42on.com>
    48	      1 Viktor Suprun <popsul1993@gmail.com>
    49	      1 Tyler Brekke <tbrekke@redhat.com>
    50	      1 Travis Rhoden <trhoden@redhat.com>
    51	      1 Tim Freund <tim@freunds.net>
    52	      1 Thomas Cantin <thomas.cantin@telecom-bretagne.eu>
    53	      1 Shanggao Qiu <qiushanggao@qq.com>
    54	      1 Sebastien Ponce <sebastien.ponce@cern.ch>
    55	      1 Sebastien Han <sebastien.han@enovance.com>
    56	      1 Petr Machata <pmachata@redhat.com>
    57	      1 Ning Yao <zay11022@gmail.com>
    58	      1 Neil Levine <nlevine@redhat.com>
    59	      1 Kiseleva Alyona <akiselyova@mirantis.com>
    60	      1 Karel Striegel <karel.striegel@ipc.be>
    61	      1 Jenkins <jenkins@inktank.com>
    62	      1 Huang Jun <hjwsm1989@gmail.com>
    63	      1 Hazem Amara <hazem.amara@telecom-bretagne.eu>
    64	      1 Guang Yang <yguang@yahoo-inc.com>
    65	      1 Florian Coste <fcoste21@gmail.com>
    66	      1 Dongmao Zhang <deanraccoon@gmail.com>
    67	      1 Billy Olsen <billy.olsen@canonical.com>
    68	      1 Armando Segnini <armaseg@gmail.com>
    69	      1 Anis Ayari <ayari_anis@live.fr>
    70	      1 Andy Allan <github@gravitystorm.co.uk>
    71	      1 Ali Maredia <ali@linuxbox.com>
    72	      1 Ahoussi Armand <ahoussi.say@telecom-bretagne.eu>
    73	      1 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>

Commits, by organizations
     1	    672 Red Hat <contact@redhat.com>
     2	     62 Intel <contact@intel.com>
     3	     45 UnitedStack <contact@unitedstack.com>
     4	     33 Unaffiliated <no@organization.net>
     5	     33 Mirantis <contact@mirantis.com>
     6	     30 Deutsche Telekom <contact@telekom.de>
     7	     21 Ubuntu Kylin <contact@ubuntukylin.com>
     8	     18 CohortFS, LLC <contact@cohortfs.com>
     9	     15 Mellanox <contact@mellanox.com>
    10	     15 Inktank <contact@inktank.com>
    11	     10 The Linux Box <contact@linuxbox.com>
    12	      5 Telecom Bretagne <contact@telecom-bretagne.eu>
    13	      5 Catalyst <enquiries@catalyst.net.nz>
    14	      2 SUSE <contact@suse.com>
    15	      2 Fujitsu <contact@fujitsu.com>
    16	      2 Fairbanks <contact@fairbanks.nl>
    17	      1 Yahoo! <contact@yahoo-inc.com>
    18	      1 Wido 42on <contact@42on.com>
    19	      1 Reliance Jio Infocomm Ltd. <contact@ril.com>
    20	      1 eNovance <contact@enovance.com>
    21	      1 CERN <contact@cern.ch>
    22	      1 Canonical <contact@canonical.com>

Reviews, by authors (one review spans multiple commits)
     1	     98 Sage Weil <sweil@redhat.com>
     2	     62 Josh Durgin <jdurgin@redhat.com>
     3	     38 Loic Dachary <ldachary@redhat.com>
     4	     18 Greg Farnum <gfarnum@redhat.com>
     5	     17 Samuel Just <sjust@redhat.com>
     6	      9 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
     7	      8 Kefu Chai <kchai@redhat.com>
     8	      7 Li Wang <liwang@ubuntukylin.com>
     9	      6 Yehuda Sadeh <ysadehwe@redhat.com>
    10	      6 Dan Mick <dmick@redhat.com>
    11	      4 Matt Benjamin <matt@cohortfs.com>
    12	      4 Ken Dreyer <kdreyer@redhat.com>
    13	      4 John Spray <jspray@redhat.com>
    14	      4 Haomai Wang <haomaiwang@gmail.com>
    15	      2 Zhiqiang Wang <zhiqiang.wang@intel.com>
    16	      2 Yan, Zheng <zyan@redhat.com>
    17	      2 Jason Dillaman <dillaman@redhat.com>
    18	      2 Boris Ranto <branto@redhat.com>
    19	      1 Yann Dupont <yann@objoo.org>
    20	      1 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
    21	      1 Sebastien Ponce <sebastien.ponce@cern.ch>
    22	      1 Sandon Van Ness <svanness@redhat.com>
    23	      1 Ma Jianpeng <jianpeng.ma@intel.com>
    24	      1 John Wilkins <jwilkins@redhat.com>
    25	      1 Huang Jun <hjwsm1989@gmail.com>
    26	      1 Ha=C3=AFkel Gu=C3=A9mar <hguemar@redhat.com>
    27	      1 Dmytro Iurchenko <diurchenko@mirantis.com>
    28	      1 David Zafman <dzafman@redhat.com>
    29	      1 Alfredo Deza <adeza@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1	    281 Red Hat <contact@redhat.com>
     2	      7 Ubuntu Kylin <contact@ubuntukylin.com>
     3	      4 UnitedStack <contact@unitedstack.com>
     4	      4 CohortFS, LLC <contact@cohortfs.com>
     5	      3 Intel <contact@intel.com>
     6	      2 Unaffiliated <no@organization.net>
     7	      1 Mirantis <contact@mirantis.com>
     8	      1 Fujitsu <contact@fujitsu.com>
     9	      1 CERN <contact@cern.ch>

Thank you everyone for contributing to Ceph.

Cheers
Abhishek
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJU8/WQAAoJEPnwZB8bZe1fta0H/isF2zgItfCvVxMuO1iCUvST
AyAmqH8zKQ5kqIH3AFAuqSWxTYyA9BM6nEuF6pne5dh2StuFJF8qxBvCpGqnGqLY
jwEbHd0CtWFOiQUPyUPloZFLNCbWGKqoAs0ua7KRJp19hr5Q3+zsl/YEO6zN9fIh
7HuNE0iYVVQ43aR80sZSrxnyL9YttIS8jT32Ai9yJjpRJnGHCuzFEB+1+clK+y4h
4DpSJ+mGiMJ3LU6bdtb65JFkN1UiGuTWhg7HeB90TCNm+y5Lqw1IM2LJcA62UGoe
CMdg8rnSrzkzLyU3sxXIb7cSzK6FValQ8pxpAn5hpWNiZO3okHwOf5heqRo0bM4=3D
=3DZBsS
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
