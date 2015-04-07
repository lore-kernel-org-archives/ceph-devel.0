From: Yann Dupont <yann@objoo.org>
Subject: v0.94 "Hammer" contributors credits (since Firefly)
Date: Tue, 07 Apr 2015 23:44:26 +0200
Message-ID: <55244FBA.4090306@objoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 1.mo2.mail-out.ovh.net ([46.105.63.121]:59233 "EHLO
	1.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753847AbbDGXB1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Apr 2015 19:01:27 -0400
Received: from mail135.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo2.mail-out.ovh.net (Postfix) with SMTP id 6936EFF9815
	for <ceph-devel@vger.kernel.org>; Tue,  7 Apr 2015 23:44:30 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

As promised, here is a complement of my previous mail - this time, with
the sorted list of authors and organizations who contributed
to v0.94 "Hammer", by number of commits or reviews back to previous
stable version v0.87 "Firefly".

And BTW, congrats to all devs :)


The affiliation of authors to organizations can be updated by
submitting a patch to :
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, the details are at
https://wiki.ceph.com/Community/Ceph_contributors_list_maintenance_guid=
e

Number of lines added and removed, by authors
      1	450375 Jason Dillaman <dillaman@redhat.com>
      2	 41192 Sage Weil <sweil@redhat.com>
      3	 22283 Yehuda Sadeh <ysadehwe@redhat.com>
      4	 20340 Haomai Wang <haomaiwang@gmail.com>
      5	  9618 Min Chen <minchen@ubuntukylin.com>
      6	  8646 John Spray <jspray@redhat.com>
      7	  8343 Loic Dachary <ldachary@redhat.com>
      8	  8136 Nilamdyuti Goswami <ngoswami@redhat.com>
      9	  7896 Matt Benjamin <matt@cohortfs.com>
     10	  7703 Xiaoxi Chen <xiaoxi.chen@intel.com>
     11	  6049 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
     12	  5360 David Zafman <dzafman@redhat.com>
     13	  5320 Samuel Just <sjust@redhat.com>
     14	  5269 Ali Maredia <ali@linuxbox.com>
     15	  3960 Boris Ranto <branto@redhat.com>
     16	  3532 Dong Yuan <yuandong1222@gmail.com>
     17	  3414 Adam Crume <adamcrume@gmail.com>
     18	  2950 Yan, Zheng <zyan@redhat.com>
     19	  2444 Greg Farnum <gfarnum@redhat.com>
     20	  2248 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
     21	  2159 Ma Jianpeng <jianpeng.ma@intel.com>
     22	  1907 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
     23	  1750 Guang Yang <yguang@yahoo-inc.com>
     24	  1624 Mykola Golub <mgolub@mirantis.com>
     25	  1408 Andreas Peters <andreas.joachim.peters@cern.ch>
     26	  1386 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     27	  1239 Cheng Cheng <ccheng.leo@gmail.com>
     28	   868 John Wilkins <jwilkins@redhat.com>
     29	   846 Josh Durgin <jdurgin@redhat.com>
     30	   649 Ken Dreyer <kdreyer@redhat.com>
     31	   589 Vu Pham <vu@mellanox.com>
     32	   537 Zhiqiang Wang <zhiqiang.wang@intel.com>
     33	   492 Rongze Zhu <zrzhit@gmail.com>
     34	   473 Johnu George <johnugeo@cisco.com>
     35	   464 Ilya Dryomov <idryomov@redhat.com>
     36	   454 Andrew Bartlett <abartlet@catalyst.net.nz>
     37	   361 Shu, Xinxin <xinxin.shu@intel.com>
     38	   321 Xinze Chi <xmdxcxz@gmail.com>
     39	   319 Kefu Chai <kchai@redhat.com>
     40	   286 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     41	   255 Dan Mick <dmick@redhat.com>
     42	   240 Sebastien Han <sebastien.han@enovance.com>
     43	   220 Noah Watkins <nwatkins@redhat.com>
     44	   211 Wido den Hollander <wido@42on.com>
     45	   209 Casey Bodley <casey@linuxbox.com>
     46	   203 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
     47	   201 Ray Lv <xiangyulv@gmail.com>
     48	   168 Sebastien Ponce <sebastien.ponce@cern.ch>
     49	   167 Dan van der Ster <daniel.vanderster@cern.ch>
     50	   154 Mehdi Abaakouk <sileht@sileht.net>
     51	   149 Alfredo Deza <adeza@redhat.com>
     52	   148 Kim Vandry <vandry@TZoNE.ORG>
     53	   139 Dmytro Iurchenko <diurchenko@mirantis.com>
     54	   124 Baptiste Veuillez=20
<baptiste.veuillez--mainard@telecom-bretagne.eu>
     55	   117 Chris Holcombe <chris.holcombe@nebula.com>
     56	   114 Janne Grunau <j@jannau.net>
     57	   106 Owen Synge <osynge@suse.com>
     58	    98 Yuan Zhou <yuan.zhou@intel.com>
     59	    74 Jian Wen <wenjian@letv.com>
     60	    70 Federico Gimenez <fgimenez@coit.es>
     61	    66 Michal Jarzabek <stiopa@gmail.com>
     62	    63 MingXin Liu <mingxinliu@ubuntukylin.com>
     63	    57 Chendi Xue <chendi.xue@intel.com>
     64	    56 Jenkins <jenkins@inktank.com>
     65	    47 Tim Freund <tim@freunds.net>
     66	    44 shishir gowda <shishir.gowda@sandisk.com>
     67	    44 Ning Yao <zay11022@gmail.com>
     68	    43 Dongmao Zhang <deanraccoon@gmail.com>
     69	    40 Sandon Van Ness <svanness@redhat.com>
     70	    39 Thorsten Behrens <tbehrens@suse.com>
     71	    31 Patrick McGarry <pmcgarry@redhat.com>
     72	    31 Blaine Gardner <blaine.gardner@hp.com>
     73	    30 VRan Liu <gliuwr@gmail.com>
     74	    29 Yann Dupont <yann@objoo.org>
     75	    27 Kevin Dalley <kevin@kelphead.org>
     76	    22 Warren Usui <wusui@redhat.com>
     77	    22 Shanggao Qiu <qiushanggao@qq.com>
     78	    22 Luis Pab=F3n <lpabon@redhat.com>
     79	    22 Kiseleva Alyona <akiselyova@mirantis.com>
     80	    18 Rohan Mars <code@rohanmars.com>
     81	    18 Petr Machata <pmachata@redhat.com>
     82	    15 Frank Yu <flyxiaoyu@gmail.com>
     83	    14 Robert Jansen <r.jansen@fairbanks.nl>
     84	    12 Swami Reddy <swami.reddy@ril.com>
     85	    11 Raju Kurunkad <raju.kurunkad@sandisk.com>
     86	    11 Matt Richards <mattjrichards@gmail.com>
     87	    11 David Anderson <dave@natulte.net>
     88	    11 BJ Lougee <almightybeeij@gmail.com>
     89	    10 Huang Jun <hjwsm1989@gmail.com>
     90	     9 Lei Dong <leidong@yahoo-inc.com>
     91	     9 Billy Olsen <billy.olsen@canonical.com>
     92	     8 Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
     93	     8 Tyler Brekke <tbrekke@redhat.com>
     94	     8 Travis Rhoden <trhoden@redhat.com>
     95	     8 Karl Eichwalder <ke@suse.de>
     96	     8 Armando Segnini <armaseg@gmail.com>
     97	     7 Xiong Yiliang <xiongyiliang@xunlei.com>
     98	     7 William A. Kennington III <william@wkennington.com>
     99	     7 Henry C Chang <henry_c_chang@tcloudcomputing.com>
    100	     6 Adam Spiers <aspiers@suse.com>
    101	     5 Thomas Cantin <thomas.cantin@telecom-bretagne.eu>
    102	     4 Vicente Cheng <freeze.bilsted@gmail.com>
    103	     4 Florian Coste <fcoste21@gmail.com>
    104	     4 Feng He <fenglife@hotmail.com>
    105	     4 Federico Simoncelli <fsimonce@redhat.com>
    106	     4 Ding Dinghua <dingdinghua85@gmail.com>
    107	     3 Xan Peng <xanpeng@gmail.com>
    108	     3 Jiantao He <hejiantao5@gmail.com>
    109	     3 Anis Ayari <ayari_anis@live.fr>
    110	     3 Ahoussi Armand <ahoussi.say@telecom-bretagne.eu>
    111	     2 Yongyue Sun <abioy.sun@gmail.com>
    112	     2 Xie Rui <875016668@qq.com>
    113	     2 Viktor Suprun <popsul1993@gmail.com>
    114	     2 Neil Levine <nlevine@redhat.com>
    115	     2 Karel Striegel <karel.striegel@ipc.be>
    116	     2 Hazem Amara <hazem.amara@telecom-bretagne.eu>
    117	     2 Derrick Schneider <derrick.schneider@opower.com>
    118	     2 Christos Stavrakakis <stavr.chris@gmail.com>
    119	     2 Andy Allan <andy@gravitystorm.co.uk>

Number of lines added and removed, by organization
      1	561592 Red Hat <contact@redhat.com>
      2	 24364 UnitedStack <contact@unitedstack.com>
      3	 11588 Ubuntu Kylin <contact@ubuntukylin.com>
      4	 11156 Intel <contact@intel.com>
      5	  7896 CohortFS, LLC <contact@cohortfs.com>
      6	  6049 Fujitsu <contact@fujitsu.com>
      7	  5478 The Linux Box <contact@linuxbox.com>
      8	  3414 University of California, Santa Cruz <contact@cs.ucsc.ed=
u>
      9	  3405 Inktank <contact@inktank.com>
     10	  2536 Unaffiliated <no@organization.net>
     11	  2071 Mirantis <contact@mirantis.com>
     12	  1960 Yahoo! <contact@yahoo-inc.com>
     13	  1743 CERN <contact@cern.ch>
     14	  1386 Deutsche Telekom <contact@telekom.de>
     15	   589 Mellanox <contact@mellanox.com>
     16	   473 CISCO <contact@cisco.com>
     17	   454 Catalyst <enquiries@catalyst.net.nz>
     18	   240 eNovance <contact@enovance.com>
     19	   215 Reliance Jio Infocomm Ltd. <contact@ril.com>
     20	   211 Wido 42on <contact@42on.com>
     21	   159 SUSE <contact@suse.com>
     22	   134 Telecom Bretagne <contact@telecom-bretagne.eu>
     23	   117 Nebula <info@nebula.com>
     24	    55 SanDisk <contact@sandisk.com>
     25	    31 HP <contact@hp.com>
     26	    27 HGST <contact@hgst.com>
     27	    14 Fairbanks <contact@fairbanks.nl>
     28	     9 Canonical <contact@canonical.com>
     29	     8 Keeper Technology <contact@keepertech.com>
     30	     7 TCloud Computing <contact@tcloudcomputing.com>
     31	     2 Opower <contact@opower.com>

Commits, by authors
      1	    485 Sage Weil <sweil@redhat.com>
      2	    293 Yehuda Sadeh <ysadehwe@redhat.com>
      3	    242 Loic Dachary <ldachary@redhat.com>
      4	    168 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
      5	    150 Jason Dillaman <dillaman@redhat.com>
      6	    148 Haomai Wang <haomaiwang@gmail.com>
      7	    102 Samuel Just <sjust@redhat.com>
      8	    100 John Spray <jspray@redhat.com>
      9	     99 Yan, Zheng <zyan@redhat.com>
     10	     90 Ma Jianpeng <jianpeng.ma@intel.com>
     11	     90 David Zafman <dzafman@redhat.com>
     12	     75 Greg Farnum <gfarnum@redhat.com>
     13	     55 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
     14	     46 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
     15	     43 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
     16	     43 Josh Durgin <jdurgin@redhat.com>
     17	     29 Matt Benjamin <matt@cohortfs.com>
     18	     25 Nilamdyuti Goswami <ngoswami@redhat.com>
     19	     23 Zhiqiang Wang <zhiqiang.wang@intel.com>
     20	     23 Kefu Chai <kchai@redhat.com>
     21	     22 Shu, Xinxin <xinxin.shu@intel.com>
     22	     22 Mykola Golub <mgolub@mirantis.com>
     23	     22 Ken Dreyer <kdreyer@redhat.com>
     24	     22 Adam Crume <adamcrume@gmail.com>
     25	     20 John Wilkins <jwilkins@redhat.com>
     26	     20 Boris Ranto <branto@redhat.com>
     27	     19 Dong Yuan <yuandong1222@gmail.com>
     28	     15 Vu Pham <vu@mellanox.com>
     29	     14 Xinze Chi <xmdxcxz@gmail.com>
     30	     11 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     31	     10 Guang Yang <yguang@yahoo-inc.com>
     32	     10 Dan Mick <dmick@redhat.com>
     33	      9 Yann Dupont <yann@objoo.org>
     34	      9 Wido den Hollander <wido@42on.com>
     35	      8 Xiaoxi Chen <xiaoxi.chen@intel.com>
     36	      8 Sebastien Han <sebastien.han@enovance.com>
     37	      8 Min Chen <minchen@ubuntukylin.com>
     38	      7 Yuan Zhou <yuan.zhou@intel.com>
     39	      7 Sebastien Ponce <sebastien.ponce@cern.ch>
     40	      7 Noah Watkins <nwatkins@redhat.com>
     41	      7 Jenkins <jenkins@inktank.com>
     42	      6 Dan van der Ster <daniel.vanderster@cern.ch>
     43	      5 VRan Liu <gliuwr@gmail.com>
     44	      5 Swami Reddy <swami.reddy@ril.com>
     45	      5 Ning Yao <zay11022@gmail.com>
     46	      5 Janne Grunau <j@jannau.net>
     47	      5 Dongmao Zhang <deanraccoon@gmail.com>
     48	      5 Dmytro Iurchenko <diurchenko@mirantis.com>
     49	      5 Cheng Cheng <ccheng.leo@gmail.com>
     50	      5 Casey Bodley <casey@linuxbox.com>
     51	      5 Andrew Bartlett <abartlet@catalyst.net.nz>
     52	      4 Ilya Dryomov <idryomov@redhat.com>
     53	      4 Frank Yu <flyxiaoyu@gmail.com>
     54	      4 Federico Gimenez <fgimenez@coit.es>
     55	      4 David Anderson <dave@natulte.net>
     56	      3 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
     57	      3 MingXin Liu <mingxinliu@ubuntukylin.com>
     58	      3 Michal Jarzabek <stiopa@gmail.com>
     59	      3 Jian Wen <wenjian@letv.com>
     60	      3 Alfredo Deza <adeza@redhat.com>
     61	      3 Adam Spiers <aspiers@suse.com>
     62	      2 Warren Usui <wusui@redhat.com>
     63	      2 Thorsten Behrens <tbehrens@suse.com>
     64	      2 Sandon Van Ness <svanness@redhat.com>
     65	      2 Rongze Zhu <zrzhit@gmail.com>
     66	      2 Robert Jansen <r.jansen@fairbanks.nl>
     67	      2 Ray Lv <xiangyulv@gmail.com>
     68	      2 Owen Synge <osynge@suse.com>
     69	      2 Matt Richards <mattjrichards@gmail.com>
     70	      2 Lei Dong <leidong@yahoo-inc.com>
     71	      2 Kim Vandry <vandry@TZoNE.ORG>
     72	      2 Karl Eichwalder <ke@suse.de>
     73	      2 Johnu George <johnugeo@cisco.com>
     74	      2 Huang Jun <hjwsm1989@gmail.com>
     75	      2 Feng He <fenglife@hotmail.com>
     76	      2 Ding Dinghua <dingdinghua85@gmail.com>
     77	      2 Chendi Xue <chendi.xue@intel.com>
     78	      2 Baptiste Veuillez=20
<baptiste.veuillez--mainard@telecom-bretagne.eu>
     79	      2 Andreas Peters <andreas.joachim.peters@cern.ch>
     80	      1 shishir gowda <shishir.gowda@sandisk.com>
     81	      1 Yongyue Sun <abioy.sun@gmail.com>
     82	      1 Xiong Yiliang <xiongyiliang@xunlei.com>
     83	      1 Xie Rui <875016668@qq.com>
     84	      1 Xan Peng <xanpeng@gmail.com>
     85	      1 Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
     86	      1 William A. Kennington III <william@wkennington.com>
     87	      1 Viktor Suprun <popsul1993@gmail.com>
     88	      1 Vicente Cheng <freeze.bilsted@gmail.com>
     89	      1 Tyler Brekke <tbrekke@redhat.com>
     90	      1 Travis Rhoden <trhoden@redhat.com>
     91	      1 Tim Freund <tim@freunds.net>
     92	      1 Thomas Cantin <thomas.cantin@telecom-bretagne.eu>
     93	      1 Shanggao Qiu <qiushanggao@qq.com>
     94	      1 Rohan Mars <code@rohanmars.com>
     95	      1 Raju Kurunkad <raju.kurunkad@sandisk.com>
     96	      1 Petr Machata <pmachata@redhat.com>
     97	      1 Patrick McGarry <pmcgarry@redhat.com>
     98	      1 Neil Levine <nlevine@redhat.com>
     99	      1 Mehdi Abaakouk <sileht@sileht.net>
    100	      1 Luis Pab=F3n <lpabon@redhat.com>
    101	      1 Kiseleva Alyona <akiselyova@mirantis.com>
    102	      1 Kevin Dalley <kevin@kelphead.org>
    103	      1 Karel Striegel <karel.striegel@ipc.be>
    104	      1 Jiantao He <hejiantao5@gmail.com>
    105	      1 Henry C Chang <henry_c_chang@tcloudcomputing.com>
    106	      1 Hazem Amara <hazem.amara@telecom-bretagne.eu>
    107	      1 Florian Coste <fcoste21@gmail.com>
    108	      1 Federico Simoncelli <fsimonce@redhat.com>
    109	      1 Derrick Schneider <derrick.schneider@opower.com>
    110	      1 Christos Stavrakakis <stavr.chris@gmail.com>
    111	      1 Chris Holcombe <chris.holcombe@nebula.com>
    112	      1 Blaine Gardner <blaine.gardner@hp.com>
    113	      1 Billy Olsen <billy.olsen@canonical.com>
    114	      1 BJ Lougee <almightybeeij@gmail.com>
    115	      1 Armando Segnini <armaseg@gmail.com>
    116	      1 Anis Ayari <ayari_anis@live.fr>
    117	      1 Andy Allan <andy@gravitystorm.co.uk>
    118	      1 Ali Maredia <ali@linuxbox.com>
    119	      1 Ahoussi Armand <ahoussi.say@telecom-bretagne.eu>

Commits, by organizations
      1	   1811 Red Hat <contact@redhat.com>
      2	    169 UnitedStack <contact@unitedstack.com>
      3	    168 Deutsche Telekom <contact@telekom.de>
      4	    155 Intel <contact@intel.com>
      5	     95 Unaffiliated <no@organization.net>
      6	     72 Inktank <contact@inktank.com>
      7	     54 Ubuntu Kylin <contact@ubuntukylin.com>
      8	     51 Reliance Jio Infocomm Ltd. <contact@ril.com>
      9	     39 Mirantis <contact@mirantis.com>
     10	     29 CohortFS, LLC <contact@cohortfs.com>
     11	     22 University of California, Santa Cruz <contact@cs.ucsc.e=
du>
     12	     15 Mellanox <contact@mellanox.com>
     13	     15 CERN <contact@cern.ch>
     14	     14 Yahoo! <contact@yahoo-inc.com>
     15	      9 Wido 42on <contact@42on.com>
     16	      9 SUSE <contact@suse.com>
     17	      8 eNovance <contact@enovance.com>
     18	      6 The Linux Box <contact@linuxbox.com>
     19	      5 Telecom Bretagne <contact@telecom-bretagne.eu>
     20	      5 Catalyst <enquiries@catalyst.net.nz>
     21	      3 Fujitsu <contact@fujitsu.com>
     22	      2 SanDisk <contact@sandisk.com>
     23	      2 Fairbanks <contact@fairbanks.nl>
     24	      2 CISCO <contact@cisco.com>
     25	      1 TCloud Computing <contact@tcloudcomputing.com>
     26	      1 Opower <contact@opower.com>
     27	      1 Nebula <info@nebula.com>
     28	      1 Keeper Technology <contact@keepertech.com>
     29	      1 HP <contact@hp.com>
     30	      1 HGST <contact@hgst.com>
     31	      1 Canonical <contact@canonical.com>

Reviews, by authors (one review spans multiple commits)
      1	    288 Sage Weil <sweil@redhat.com>
      2	    154 Loic Dachary <ldachary@redhat.com>
      3	    129 Josh Durgin <jdurgin@redhat.com>
      4	     78 Samuel Just <sjust@redhat.com>
      5	     64 Greg Farnum <gfarnum@redhat.com>
      6	     24 Jo=E3o Eduardo Lu=EDs <joao@redhat.com>
      7	     17 John Spray <jspray@redhat.com>
      8	     16 Yehuda Sadeh <ysadehwe@redhat.com>
      9	     13 Kefu Chai <kchai@redhat.com>
     10	     13 John Wilkins <jwilkins@redhat.com>
     11	     12 Haomai Wang <haomaiwang@gmail.com>
     12	      9 Yan, Zheng <zyan@redhat.com>
     13	      9 Dan Mick <dmick@redhat.com>
     14	      7 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
     15	      7 Li Wang <liwang@ubuntukylin.com>
     16	      7 Jason Dillaman <dillaman@redhat.com>
     17	      6 Ken Dreyer <kdreyer@redhat.com>
     18	      6 David Zafman <dzafman@redhat.com>
     19	      4 Matt Benjamin <matt@cohortfs.com>
     20	      3 Yann Dupont <yann@objoo.org>
     21	      3 Ma Jianpeng <jianpeng.ma@intel.com>
     22	      3 Laurent Guerby <laurent@guerby.net>
     23	      2 Zhiqiang Wang <zhiqiang.wang@intel.com>
     24	      2 Sandon Van Ness <svanness@redhat.com>
     25	      2 Gerben Meijer <gerben@daybyday.nl>
     26	      2 Christophe Courtaut <christophe.courtaut@gmail.com>
     27	      2 Boris Ranto <branto@redhat.com>
     28	      1 Zhi (David) Zhang <zhangz@yahoo-inc.com>
     29	      1 Thorsten Glaser <tg@mirbsd.de>
     30	      1 Thorsten Behrens <tbehrens@suse.com>
     31	      1 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
     32	      1 Swami Reddy <swami.reddy@ril.com>
     33	      1 Sebastien Ponce <sebastien.ponce@cern.ch>
     34	      1 Ray Lv <xiangyulv@gmail.com>
     35	      1 Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
     36	      1 Nilamdyuti Goswami <ngoswami@redhat.com>
     37	      1 Mehdi Abaakouk <sileht@sileht.net>
     38	      1 Johnu George <johnugeo@cisco.com>
     39	      1 Huang Jun <hjwsm1989@gmail.com>
     40	      1 Ha=EFkel Gu=E9mar <hguemar@redhat.com>
     41	      1 Dmytro Iurchenko <diurchenko@mirantis.com>
     42	      1 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     43	      1 Cheng Cheng <ccheng.leo@gmail.com>
     44	      1 Andreas Peters <andreas.joachim.peters@cern.ch>
     45	      1 Alfredo Deza <adeza@redhat.com>
     46	      1 Adam Crume <adamcrume@gmail.com>

Reviews, by organizations (one review spans multiple commits)
      1	    789 Red Hat <contact@redhat.com>
      2	     52 Inktank <contact@inktank.com>
      3	     12 UnitedStack <contact@unitedstack.com>
      4	      9 Unaffiliated <no@organization.net>
      5	      8 Intel <contact@intel.com>
      6	      7 Ubuntu Kylin <contact@ubuntukylin.com>
      7	      5 Cloudwatt <libre.licensing@cloudwatt.com>
      8	      4 CohortFS, LLC <contact@cohortfs.com>
      9	      2 Yahoo! <contact@yahoo-inc.com>
     10	      2 Day By Day <contact@daybyday.nl>
     11	      2 CERN <contact@cern.ch>
     12	      1 University of California, Santa Cruz <contact@cs.ucsc.e=
du>
     13	      1 SanDisk <contact@sandisk.com>
     14	      1 SUSE <contact@suse.com>
     15	      1 Reliance Jio Infocomm Ltd. <contact@ril.com>
     16	      1 Mirantis <contact@mirantis.com>
     17	      1 Fujitsu <contact@fujitsu.com>
     18	      1 Deutsche Telekom <contact@telekom.de>
     19	      1 Debian GNU/Linux <contact@debian.org>
     20	      1 CISCO <contact@cisco.com>


Cheers,
Yann
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
