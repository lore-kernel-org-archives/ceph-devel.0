From: Yann Dupont <yd@objoo.org>
Subject: v9.2.0 (Infernalis) Contributor credits
Date: Sun, 8 Nov 2015 23:22:52 +0100
Message-ID: <563FCB3C.5090207@objoo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030006070300060902090500"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 7.mo6.mail-out.ovh.net ([46.105.59.196]:44396 "EHLO
	7.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbKHXjK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 8 Nov 2015 18:39:10 -0500
Received: from mail188.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo6.mail-out.ovh.net (Postfix) with SMTP id 1E3C0FFBF68
	for <ceph-devel@vger.kernel.org>; Sun,  8 Nov 2015 23:22:54 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Community <ceph-community@lists.ceph.com>, ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030006070300060902090500
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Everybody,

The all fresh, shiny new version is now out. First,congratulations to
everyone involved, and now, here is the contributor credits.

This is a sorted list of authors and organizations who contributed to
v9.2.0, by number of commits or reviews back to old stable version
v0.94.

The affiliation of authors to organizations can be updated by
submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the
number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenance_guide

Number of lines added and removed, by authors
         1	185533 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
         2	 47700 Sage Weil <sweil@redhat.com>
         3	 40536 Kefu Chai <kchai@redhat.com>
         4	 27226 John Spray <jspray@redhat.com>
         5	 21737 Jason Dillaman <dillaman@redhat.com>
         6	 14199 Loic Dachary <ldachary@redhat.com>
         7	  9759 Haomai Wang <haomai@xsky.com>
         8	  9318 Yuan Zhou <yuan.zhou@intel.com>
         9	  6009 Yan, Zheng <zyan@redhat.com>
        10	  4876 David Zafman <dzafman@redhat.com>
        11	  3879 Nilamdyuti Goswami <ngoswami@redhat.com>
        12	  3696 Joao Eduardo Luis <joao@suse.de>
        13	  3523 Yehuda Sadeh <ysadehwe@redhat.com>
        14	  3280 Radoslaw Zarzynski <rzarzynski@mirantis.com>
        15	  2463 Zhiqiang Wang <zhiqiang.wang@intel.com>
        16	  2428 Xiaoxi Chen <xiaoxi.chen@intel.com>
        17	  2301 Boris Ranto <branto@redhat.com>
        18	  2247 Samuel Just <sjust@redhat.com>
        19	  2101 Ilya Dryomov <idryomov@redhat.com>
        20	  2076 Mykola Golub <mgolub@mirantis.com>
        21	  2017 Ma Jianpeng <jianpeng.ma@intel.com>
        22	  1947 Shotaro Kawaguchi <kawaguchi.s@jp.fujitsu.com>
        23	  1938 Casey Bodley <cbodley@redhat.com>
        24	  1797 Ali Maredia <amaredia@redhat.com>
        25	  1431 Takanori Nakao <nakao.takanori@jp.fujitsu.com>
        26	   982 Kiseleva Alyona <akiselyova@mirantis.com>
        27	   910 Shu, Xinxin <xinxin.shu@intel.com>
        28	   794 Xavier Roche <roche+git@exalead.com>
        29	   792 Owen Synge <osynge@suse.com>
        30	   763 Guang Yang <yguang@yahoo-inc.com>
        31	   740 Joaquim Rocha <joaquim.rocha@cern.ch>
        32	   733 Michal Jarzabek <stiopa@gmail.com>
        33	   615 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
        34	   559 Nathan Cutler <ncutler@suse.com>
        35	   549 Vikhyat Umrao <vumrao@redhat.com>
        36	   456 Alfredo Deza <adeza@redhat.com>
        37	   439 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
        38	   432 Daniel Gryniewicz <dang@redhat.com>
        39	   419 Xinze Chi <xinze@xsky.com>
        40	   395 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
        41	   382 Xiaowei Chen <chen.xiaowei@h3c.com>
        42	   367 Orit Wasserman <owasserm@redhat.com>
        43	   295 Ji Chen <insomnia@139.com>
        44	   294 Noah Watkins <nwatkins@redhat.com>
        45	   269 Josh Durgin <jdurgin@redhat.com>
        46	   244 Zhi Zhang <zhangz.david@outlook.com>
        47	   240 Sebastien Ponce <sebastien.ponce@cern.ch>
        48	   236 Jevon Qiao <qiaojianfeng@unitedstack.com>
        49	   219 David Disseldorp <ddiss@suse.de>
        50	   210 Vu Pham <vu@mellanox.com>
        51	   209 Pete Zaitcev <zaitcev@redhat.com>
        52	   206 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
        53	   192 Rohan Mars <code@rohanmars.com>
        54	   191 Kadu Ribeiro <mail+github@carlosribeiro.me>
        55	   183 Ken Dreyer <kdreyer@redhat.com>
        56	   179 Yann Dupont <yann@objoo.org>
        57	   169 Douglas Fuller <dfuller@redhat.com>
        58	   162 Tianshan Qu <tianshan@xsky.com>
        59	   161 Dennis Schafroth <dennis@schafroth.com>
        60	   152 Mingxin Liu <mingxinliu@ubuntukylin.com>
        61	   151 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
        62	   142 Raju Kurunkad <raju.kurunkad@sandisk.com>
        63	   142 Krzysztof Kosiński <krzysztof.kosinski@intel.com>
        64	   141 Yazen Ghannam <yazen.ghannam@linaro.org>
        65	   135 Milan Broz <mbroz@redhat.com>
        66	   135 Ce Gu <guce@h3c.com>
        67	   127 Joe Handzik <joseph.t.handzik@hp.com>
        68	   120 Robin H. Johnson <robbat2@gentoo.org>
        69	   111 Rajesh Nambiar <rajesh.n@msystechnologies.com>
        70	   109 Ruifeng Yang <yangruifeng.09209@h3c.com>
        71	   108 Alexandre Marangone <amarango@redhat.com>
        72	   107 Casey Bodley <casey@cohortfs.com>
        73	   106 Tim Serong <tserong@suse.com>
        74	   104 Sébastien Han <shan@redhat.com>
        75	   104 Ning Yao <yaoning@ruijie.com.cn>
        76	   102 Robin Dehu <robindehu@gmail.com>
        77	   102 Dmytro Iurchenko <diurchenko@mirantis.com>
        78	    98 Travis Rhoden <trhoden@redhat.com>
        79	    88 Thorsten Behrens <tbehrens@suse.com>
        80	    74 Huang Jun <hjwsm1989@gmail.com>
        81	    65 Maxime Robert <maxime.robert1992@gmail.com>
        82	    63 Matt Benjamin <matt@cohortfs.com>
        83	    59 Greg Farnum <gfarnum@redhat.com>
        84	    55 Robin H. Johnson <robin.johnson@dreamhost.com>
        85	    52 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
        86	    51 Jon Bernard <jbernard@tuxion.com>
        87	    50 Burkhard Linke 
<Burkhard.Linke@computational.bio.uni-giessen.de>
        88	    48 Jenkins <jenkins@ceph.com>
        89	    45 Steve Capper <steve.capper@linaro.org>
        90	    42 Wido den Hollander <wido@42on.com>
        91	    42 Henry Chang <henry@bigtera.com>
        92	    41 Siddharth Sharma <siddharth@redhat.com>
        93	    39 Lu Shi <shi.lu@h3c.com>
        94	    36 Mingyue Zhao <zhao.mingyue@h3c.com>
        95	    36 Abhishek Dixit <dixitabhi@gmail.com>
        96	    35 Varada Kari <varada.kari@sandisk.com>
        97	    35 Casey Bodley <casey@linuxbox.com>
        98	    32 Min Chen <minchen@ubuntukylin.com>
        99	    30 Wu Xingyi <wuxingyi@letv.com>
       100	    29 Dan van der Ster <daniel.vanderster@cern.ch>
       101	    28 Vartika Rai <vartikarai17@gmail.com>
       102	    26 Yuri Weinstein <yuri.weinstein@redhat.com>
       103	    26 Jeff Weber <jweber@cofront.net>
       104	    25 Li Wang <liwang@ubuntukylin.com>
       105	    24 ritz303 <ritz_303@yahoo.com>
       106	    21 Vasu Kulkarni <vasu@redhat.com>
       107	    21 François Lafont <flafdivers@free.fr>
       108	    20 Valentin Arshanes Thomas 
<valentin.arshanes.thomas@gmail.com>
       109	    20 Joseph McDonald <joseph.mcdonald@alcatel-lucent.com>
       110	    19 Sangdi Xu <xu.sangdi@h3c.com>
       111	    19 Brad Hubbard <bhubbard@redhat.com>
       112	    18 Ian Kelling <ian@iankelling.org>
       113	    18 Bo Cai <cai.bo@h3c.com>
       114	    17 Li Peng <lip@dtdream.com>
       115	    16 Sylvain Baubeau <sbaubeau@redhat.com>
       116	    16 Sergey Arkhipov <nineseconds@yandex.ru>
       117	    16 Andreas Peters <andreas.joachim.peters@cern.ch>
       118	    14 Javier M. Mellid <jmunhoz@igalia.com>
       119	    14 Ilja Slepnev <islepnev@gmail.com>
       120	    13 Lee Revell <rlrevell@gmail.com>
       121	    12 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
       122	    12 Brian Andrus <bandrus@redhat.com>
       123	    11 Weijun Duan <duanweijun@h3c.com>
       124	    10 Thomas Johnson <NTmatter@gmail.com>
       125	    10 Pierre Chaumont <pierre.chaumont31@gmail.com>
       126	     9 James Page <james.page@ubuntu.com>
       127	     8 Wei Qian <weiq@dtdream.com>
       128	     8 John Wilkins <jwilkins@redhat.com>
       129	     8 Florian Haas <florian@hastexo.com>
       130	     7 Xiong Yiliang <xiongyiliang@xunlei.com>
       131	     7 Swami Reddy <swami.reddy@ril.com>
       132	     7 Na Xie <xie.na@h3c.com>
       133	     6 William A. Kennington III <william@wkennington.com>
       134	     6 Neha Ummareddy <nehaummareddy@gmail.com>
       135	     6 Bosse Klykken <larkly@gmail.com>
       136	     6 BJ Lougee <almightybeeij@gmail.com>
       137	     5 Javier Guerra <javier@guerrag.com>
       138	     5 Anton Aksola <anton.aksola@nebula.fi>
       139	     4 Xie Rui <875016668@qq.com>
       140	     4 Thomas Laumondais <thomas.laumondais@gmail.com>
       141	     4 Shylesh Kumar <shmohan@redhat.com>
       142	     4 Ruben Kerkhof <ruben@rubenkerkhof.com>
       143	     4 Qiankun Zheng <zheng.qiankun@h3c.com>
       144	     4 Jeff Epstein <jepst79@gmail.com>
       145	     4 Ira Cooper <ira@samba.org>
       146	     4 Gregory Meno <gmeno@redhat.com>
       147	     4 Germain Chipaux <germain.chipaux@gmail.com>
       148	     4 Arthur Gorjux <arthurgorjux@gmail.com>
       149	     4 Alistair Strachan <alistair.strachan@imgtec.com>
       150	     3 Nicolas Yong <nicolas.yong93@gmail.com>
       151	     3 Juan A. Suarez Romero <jasuarez@igalia.com>
       152	     2 Zhicheng Wei <zhicheng@opensourceforge.net>
       153	     2 Zhe Zhang <zzxuanyuan@gmail.com>
       154	     2 Yehua Chen <chen.yehua@h3c.com>
       155	     2 Yannick Atchy Dalama <yannick.atchy.dalama@gmail.com>
       156	     2 Xuan Liu <liu.xuan@h3c.com>
       157	     2 Xingyi Wu <wuxingyi2015@outlook.com>
       158	     2 Vicente Cheng <freeze.bilsted@gmail.com>
       159	     2 Robin Tang <robintang974@gmail.com>
       160	     2 Ren Huanwen <ren.huanwen@zte.com.cn>
       161	     2 Lucas Fantinel <lucas.fantinel@gmail.com>
       162	     2 Kévin Caradant <kevin.caradant@gmail.com>
       163	     2 Jordan Dorne <jordan.dorne@gmail.com>
       164	     2 Jiaying Ren <mikulely@gmail.com>
       165	     2 Jean-Rémi Deveaux <jeanremi.deveaux@gmail.com>
       166	     2 Ismael Serrano <ismael.serrano@gmail.com>
       167	     2 Hervé Rousseau <hroussea@cern.ch>
       168	     2 Gerhard Muntingh <gerhard@warpnet.nl>
       169	     2 Gaël Fenet-Garde <gael.fenet.garde@gmail.com>
       170	     2 Gabriel Sentucq <perso@kazhord.fr>
       171	     2 Florian Marsylle <florian.marsylle@hotmail.fr>
       172	     2 Fabio Alessandro Locati <fabiolocati@gmail.com>
       173	     2 Donghai Xu <xu.donghai@h3c.com>
       174	     2 Clement Lebrun <clement.lebrun.31@gmail.com>
       175	     2 Andy Allan <andy@gravitystorm.co.uk>
       176	     2 Alexis Normand <n.al3xis@gmail.com>
       177	     2 Alexander Chuzhoy <achuzhoy@redhat.com>
       178	     1 Xie Xingguo <xie.xingguo@zte.com.cn>
       179	     1 Matt Benjamin <mbenjamin@redhat.com>
       180	     1 Ketor Meng <d.ketor@gmail.com>
       181	     1 Claire Massot <claire.massot93@gmail.com>
       182	     0 Patrick McGarry <pmcgarry@redhat.com>
       183	     0 Chen Dihao <tobeg3oogle@gmail.com>

Number of lines added and removed, by organization
         1	185533 Deutsche Telekom <contact@telekom.de>
         2	185391 Red Hat <contact@redhat.com>
         3	 17278 Intel <contact@intel.com>
         4	 10340 XSky <contact@xsky.com>
         5	  6879 Mirantis <contact@mirantis.com>
         6	  4144 Fujitsu <contact@fujitsu.com>
         7	  3728 SUSE <contact@suse.com>
         8	  2486 Unaffiliated <no@organization.net>
         9	  1027 CERN <contact@cern.ch>
        10	   992 Yahoo! <contact@yahoo-inc.com>
        11	   794 Exalead <contact@exalead.com>
        12	   766 H3C <wentao@h3c.com>
        13	   402 Reliance Jio Infocomm Ltd. <contact@ril.com>
        14	   383 SanDisk <contact@sandisk.com>
        15	   261 Ubuntu Kylin <contact@ubuntukylin.com>
        16	   236 UnitedStack <contact@unitedstack.com>
        17	   210 Mellanox <contact@mellanox.com>
        18	   186 Linaro <contact@linaro.org>
        19	   170 CohortFS, LLC <contact@cohortfs.com>
        20	   127 HP <contact@hp.com>
        21	   120 Gentoo <contact@gentoo.org>
        22	   111 MSys Technologies <contact@msystechnologies.com>
        23	   104 Ruijie Networks <contact@ruijie.com.cn>
        24	    55 DreamHost <contact@dreamhost.com>
        25	    42 Wido 42on <contact@42on.com>
        26	    35 The Linux Box <contact@linuxbox.com>
        27	    34 Inktank <contact@inktank.com>
        28	    30 LETV <contact@letv.com>
        29	    25 Dtdream <contact@dtdream.com>
        30	    20 Alcatel Lucent <contact@alcatel-lucent.com>
        31	    17 Igalia <contact@igalia.com>
        32	    15 Tencent <contact@tencent.com>
        33	    14 Cloudwatt <libre.licensing@cloudwatt.com>
        34	     9 Canonical <contact@canonical.com>
        35	     8 Hastexo <contact@hastexo.com>
        36	     5 Nebula <info@nebula.com>
        37	     4 Imagination Technologies Ltd. <contact@imgtec.com>
        38	     3 ZTE <contact@zte.com.cn>
        39	     2 Warpnet B.V. <contact@warpnet.nl>

Commits, by authors
         1	    658 Sage Weil <sweil@redhat.com>
         2	    303 Loic Dachary <ldachary@redhat.com>
         3	    272 Jason Dillaman <dillaman@redhat.com>
         4	    253 John Spray <jspray@redhat.com>
         5	    194 Kefu Chai <kchai@redhat.com>
         6	    175 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
         7	    165 Yan, Zheng <zyan@redhat.com>
         8	    164 Haomai Wang <haomai@xsky.com>
         9	    122 Ma Jianpeng <jianpeng.ma@intel.com>
        10	    114 David Zafman <dzafman@redhat.com>
        11	     99 Zhiqiang Wang <zhiqiang.wang@intel.com>
        12	     84 Joao Eduardo Luis <joao@suse.de>
        13	     78 Yehuda Sadeh <ysadehwe@redhat.com>
        14	     76 Samuel Just <sjust@redhat.com>
        15	     72 Nathan Cutler <ncutler@suse.com>
        16	     62 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
        17	     59 Radoslaw Zarzynski <rzarzynski@mirantis.com>
        18	     45 Xiaoxi Chen <xiaoxi.chen@intel.com>
        19	     37 Yann Dupont <yann@objoo.org>
        20	     34 Boris Ranto <branto@redhat.com>
        21	     33 Ilya Dryomov <idryomov@redhat.com>
        22	     30 Shu, Xinxin <xinxin.shu@intel.com>
        23	     30 Owen Synge <osynge@suse.com>
        24	     28 Mykola Golub <mgolub@mirantis.com>
        25	     26 Xinze Chi <xinze@xsky.com>
        26	     26 Casey Bodley <cbodley@redhat.com>
        27	     25 Ken Dreyer <kdreyer@redhat.com>
        28	     23 Nilamdyuti Goswami <ngoswami@redhat.com>
        29	     22 Guang Yang <yguang@yahoo-inc.com>
        30	     20 Yuan Zhou <yuan.zhou@intel.com>
        31	     20 Orit Wasserman <owasserm@redhat.com>
        32	     18 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
        33	     18 Josh Durgin <jdurgin@redhat.com>
        34	     15 Kiseleva Alyona <akiselyova@mirantis.com>
        35	     15 Daniel Gryniewicz <dang@redhat.com>
        36	     14 Dennis Schafroth <dennis@schafroth.com>
        37	     13 Vu Pham <vu@mellanox.com>
        38	     13 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
        39	     12 Michal Jarzabek <stiopa@gmail.com>
        40	     11 Ali Maredia <amaredia@redhat.com>
        41	     10 Huang Jun <hjwsm1989@gmail.com>
        42	     10 Alfredo Deza <adeza@redhat.com>
        43	      9 Noah Watkins <nwatkins@redhat.com>
        44	      9 Milan Broz <mbroz@redhat.com>
        45	      8 Vikhyat Umrao <vumrao@redhat.com>
        46	      8 David Disseldorp <ddiss@suse.de>
        47	      8 Casey Bodley <casey@cohortfs.com>
        48	      7 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
        49	      7 Xiaowei Chen <chen.xiaowei@h3c.com>
        50	      7 Xavier Roche <roche+git@exalead.com>
        51	      7 Greg Farnum <gfarnum@redhat.com>
        52	      6 Varada Kari <varada.kari@sandisk.com>
        53	      6 Travis Rhoden <trhoden@redhat.com>
        54	      6 Ruifeng Yang <yangruifeng.09209@h3c.com>
        55	      6 Robin H. Johnson <robbat2@gentoo.org>
        56	      6 Mingxin Liu <mingxinliu@ubuntukylin.com>
        57	      6 Jenkins <jenkins@ceph.com>
        58	      6 Dan van der Ster <daniel.vanderster@cern.ch>
        59	      6 Brad Hubbard <bhubbard@redhat.com>
        60	      5 Wido den Hollander <wido@42on.com>
        61	      5 Tim Serong <tserong@suse.com>
        62	      5 Sebastien Ponce <sebastien.ponce@cern.ch>
        63	      5 Robin H. Johnson <robin.johnson@dreamhost.com>
        64	      5 Krzysztof Kosiński <krzysztof.kosinski@intel.com>
        65	      5 Joaquim Rocha <joaquim.rocha@cern.ch>
        66	      5 Henry Chang <henry@bigtera.com>
        67	      5 Douglas Fuller <dfuller@redhat.com>
        68	      5 Ce Gu <guce@h3c.com>
        69	      4 Swami Reddy <swami.reddy@ril.com>
        70	      4 Raju Kurunkad <raju.kurunkad@sandisk.com>
        71	      4 Rajesh Nambiar <rajesh.n@msystechnologies.com>
        72	      4 Pete Zaitcev <zaitcev@redhat.com>
        73	      4 Lu Shi <shi.lu@h3c.com>
        74	      4 Jevon Qiao <qiaojianfeng@unitedstack.com>
        75	      4 Javier M. Mellid <jmunhoz@igalia.com>
        76	      3 ritz303 <ritz_303@yahoo.com>
        77	      3 Zhi Zhang <zhangz.david@outlook.com>
        78	      3 Yazen Ghannam <yazen.ghannam@linaro.org>
        79	      3 Takanori Nakao <nakao.takanori@jp.fujitsu.com>
        80	      3 Siddharth Sharma <siddharth@redhat.com>
        81	      3 Ning Yao <yaoning@ruijie.com.cn>
        82	      3 Min Chen <minchen@ubuntukylin.com>
        83	      3 Matt Benjamin <matt@cohortfs.com>
        84	      3 Li Peng <lip@dtdream.com>
        85	      2 Yuri Weinstein <yuri.weinstein@redhat.com>
        86	      2 Wu Xingyi <wuxingyi@letv.com>
        87	      2 Thorsten Behrens <tbehrens@suse.com>
        88	      2 Thomas Laumondais <thomas.laumondais@gmail.com>
        89	      2 Thomas Johnson <NTmatter@gmail.com>
        90	      2 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
        91	      2 Sylvain Baubeau <sbaubeau@redhat.com>
        92	      2 Steve Capper <steve.capper@linaro.org>
        93	      2 Shotaro Kawaguchi <kawaguchi.s@jp.fujitsu.com>
        94	      2 Sangdi Xu <xu.sangdi@h3c.com>
        95	      2 Rohan Mars <code@rohanmars.com>
        96	      2 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
        97	      2 Maxime Robert <maxime.robert1992@gmail.com>
        98	      2 Lee Revell <rlrevell@gmail.com>
        99	      2 Joseph McDonald <joseph.mcdonald@alcatel-lucent.com>
       100	      2 Joe Handzik <joseph.t.handzik@hp.com>
       101	      2 Javier Guerra <javier@guerrag.com>
       102	      2 Florian Haas <florian@hastexo.com>
       103	      2 Dmytro Iurchenko <diurchenko@mirantis.com>
       104	      2 Burkhard Linke 
<Burkhard.Linke@computational.bio.uni-giessen.de>
       105	      2 Brian Andrus <bandrus@redhat.com>
       106	      2 Bosse Klykken <larkly@gmail.com>
       107	      2 Bo Cai <cai.bo@h3c.com>
       108	      2 Abhishek Dixit <dixitabhi@gmail.com>
       109	      1 Zhicheng Wei <zhicheng@opensourceforge.net>
       110	      1 Zhe Zhang <zzxuanyuan@gmail.com>
       111	      1 Yehua Chen <chen.yehua@h3c.com>
       112	      1 Yannick Atchy Dalama <yannick.atchy.dalama@gmail.com>
       113	      1 Xuan Liu <liu.xuan@h3c.com>
       114	      1 Xiong Yiliang <xiongyiliang@xunlei.com>
       115	      1 Xingyi Wu <wuxingyi2015@outlook.com>
       116	      1 Xie Xingguo <xie.xingguo@zte.com.cn>
       117	      1 Xie Rui <875016668@qq.com>
       118	      1 William A. Kennington III <william@wkennington.com>
       119	      1 Weijun Duan <duanweijun@h3c.com>
       120	      1 Wei Qian <weiq@dtdream.com>
       121	      1 Vicente Cheng <freeze.bilsted@gmail.com>
       122	      1 Vasu Kulkarni <vasu@redhat.com>
       123	      1 Vartika Rai <vartikarai17@gmail.com>
       124	      1 Valentin Arshanes Thomas 
<valentin.arshanes.thomas@gmail.com>
       125	      1 Tianshan Qu <tianshan@xsky.com>
       126	      1 Sébastien Han <shan@redhat.com>
       127	      1 Shylesh Kumar <shmohan@redhat.com>
       128	      1 Sergey Arkhipov <nineseconds@yandex.ru>
       129	      1 Ruben Kerkhof <ruben@rubenkerkhof.com>
       130	      1 Robin Tang <robintang974@gmail.com>
       131	      1 Robin Dehu <robindehu@gmail.com>
       132	      1 Ren Huanwen <ren.huanwen@zte.com.cn>
       133	      1 Qiankun Zheng <zheng.qiankun@h3c.com>
       134	      1 Pierre Chaumont <pierre.chaumont31@gmail.com>
       135	      1 Patrick McGarry <pmcgarry@redhat.com>
       136	      1 Nicolas Yong <nicolas.yong93@gmail.com>
       137	      1 Neha Ummareddy <nehaummareddy@gmail.com>
       138	      1 Na Xie <xie.na@h3c.com>
       139	      1 Mingyue Zhao <zhao.mingyue@h3c.com>
       140	      1 MingXin Liu <mingxinliu@ubuntukylin.com>
       141	      1 Matt Benjamin <mbenjamin@redhat.com>
       142	      1 Lucas Fantinel <lucas.fantinel@gmail.com>
       143	      1 Li Wang <liwang@ubuntukylin.com>
       144	      1 Kévin Caradant <kevin.caradant@gmail.com>
       145	      1 Ketor Meng <d.ketor@gmail.com>
       146	      1 Kadu Ribeiro <mail+github@carlosribeiro.me>
       147	      1 Juan A. Suarez Romero <jasuarez@igalia.com>
       148	      1 Jordan Dorne <jordan.dorne@gmail.com>
       149	      1 Jon Bernard <jbernard@tuxion.com>
       150	      1 John Wilkins <jwilkins@redhat.com>
       151	      1 Jiaying Ren <mikulely@gmail.com>
       152	      1 Ji Chen <insomnia@139.com>
       153	      1 Jeff Weber <jweber@cofront.net>
       154	      1 Jeff Epstein <jepst79@gmail.com>
       155	      1 Jean-Rémi Deveaux <jeanremi.deveaux@gmail.com>
       156	      1 James Page <james.page@ubuntu.com>
       157	      1 Ismael Serrano <ismael.serrano@gmail.com>
       158	      1 Ira Cooper <ira@samba.org>
       159	      1 Ilja Slepnev <islepnev@gmail.com>
       160	      1 Ian Kelling <ian@iankelling.org>
       161	      1 Hervé Rousseau <hroussea@cern.ch>
       162	      1 Gregory Meno <gmeno@redhat.com>
       163	      1 Germain Chipaux <germain.chipaux@gmail.com>
       164	      1 Gerhard Muntingh <gerhard@warpnet.nl>
       165	      1 Gaël Fenet-Garde <gael.fenet.garde@gmail.com>
       166	      1 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
       167	      1 Gabriel Sentucq <perso@kazhord.fr>
       168	      1 François Lafont <flafdivers@free.fr>
       169	      1 Florian Marsylle <florian.marsylle@hotmail.fr>
       170	      1 Fabio Alessandro Locati <fabiolocati@gmail.com>
       171	      1 Donghai Xu <xu.donghai@h3c.com>
       172	      1 Clement Lebrun <clement.lebrun.31@gmail.com>
       173	      1 Claire Massot <claire.massot93@gmail.com>
       174	      1 Chen Dihao <tobeg3oogle@gmail.com>
       175	      1 Casey Bodley <casey@linuxbox.com>
       176	      1 BJ Lougee <almightybeeij@gmail.com>
       177	      1 Arthur Gorjux <arthurgorjux@gmail.com>
       178	      1 Anton Aksola <anton.aksola@nebula.fi>
       179	      1 Andy Allan <andy@gravitystorm.co.uk>
       180	      1 Andreas Peters <andreas.joachim.peters@cern.ch>
       181	      1 Alistair Strachan <alistair.strachan@imgtec.com>
       182	      1 Alexis Normand <n.al3xis@gmail.com>
       183	      1 Alexandre Marangone <amarango@redhat.com>
       184	      1 Alexander Chuzhoy <achuzhoy@redhat.com>

Commits, by organizations
         1	   2409 Red Hat <contact@redhat.com>
         2	    321 Intel <contact@intel.com>
         3	    194 SUSE <contact@suse.com>
         4	    191 XSky <contact@xsky.com>
         5	    175 Deutsche Telekom <contact@telekom.de>
         6	    143 Unaffiliated <no@organization.net>
         7	    117 Mirantis <contact@mirantis.com>
         8	     66 Reliance Jio Infocomm Ltd. <contact@ril.com>
         9	     33 H3C <wentao@h3c.com>
        10	     25 Fujitsu <contact@fujitsu.com>
        11	     23 Yahoo! <contact@yahoo-inc.com>
        12	     18 Ubuntu Kylin <contact@ubuntukylin.com>
        13	     18 CERN <contact@cern.ch>
        14	     13 Mellanox <contact@mellanox.com>
        15	     12 SanDisk <contact@sandisk.com>
        16	     11 CohortFS, LLC <contact@cohortfs.com>
        17	      7 Exalead <contact@exalead.com>
        18	      6 Gentoo <contact@gentoo.org>
        19	      5 Wido 42on <contact@42on.com>
        20	      5 UnitedStack <contact@unitedstack.com>
        21	      5 Linaro <contact@linaro.org>
        22	      5 Igalia <contact@igalia.com>
        23	      5 DreamHost <contact@dreamhost.com>
        24	      4 MSys Technologies <contact@msystechnologies.com>
        25	      4 Dtdream <contact@dtdream.com>
        26	      3 Ruijie Networks <contact@ruijie.com.cn>
        27	      3 Inktank <contact@inktank.com>
        28	      2 ZTE <contact@zte.com.cn>
        29	      2 Tencent <contact@tencent.com>
        30	      2 LETV <contact@letv.com>
        31	      2 Hastexo <contact@hastexo.com>
        32	      2 HP <contact@hp.com>
        33	      2 Cloudwatt <libre.licensing@cloudwatt.com>
        34	      2 Alcatel Lucent <contact@alcatel-lucent.com>
        35	      1 Warpnet B.V. <contact@warpnet.nl>
        36	      1 The Linux Box <contact@linuxbox.com>
        37	      1 Nebula <info@nebula.com>
        38	      1 Imagination Technologies Ltd. <contact@imgtec.com>
        39	      1 Canonical <contact@canonical.com>

Reviews, by authors (one review spans multiple commits)
         1	    246 Loic Dachary <ldachary@redhat.com>
         2	    242 Sage Weil <sweil@redhat.com>
         3	    221 Kefu Chai <kchai@redhat.com>
         4	    142 Josh Durgin <jdurgin@redhat.com>
         5	     99 Greg Farnum <gfarnum@redhat.com>
         6	     80 Yehuda Sadeh <ysadehwe@redhat.com>
         7	     64 Samuel Just <sjust@redhat.com>
         8	     51 Ken Dreyer <kdreyer@redhat.com>
         9	     49 John Spray <jspray@redhat.com>
        10	     32 Haomai Wang <haomai@xsky.com>
        11	     31 Joao Eduardo Luis <joao@suse.de>
        12	     26 David Zafman <dzafman@redhat.com>
        13	     18 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
        14	     15 Li Wang <liwang@ubuntukylin.com>
        15	     14 Jason Dillaman <dillaman@redhat.com>
        16	     14 Boris Ranto <branto@redhat.com>
        17	      9 Nathan Cutler <ncutler@suse.com>
        18	      7 Travis Rhoden <trhoden@redhat.com>
        19	      7 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
        20	      5 Dan Mick <dmick@redhat.com>
        21	      5 Andreas Peters <andreas.joachim.peters@cern.ch>
        22	      5 Alfredo Deza <adeza@redhat.com>
        23	      4 Milan Broz <mbroz@redhat.com>
        24	      4 Casey Bodley <cbodley@redhat.com>
        25	      3 Zhi Zhang <zhangz.david@outlook.com>
        26	      3 Yann Dupont <yann@objoo.org>
        27	      3 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
        28	      3 Owen Synge <osynge@suse.com>
        29	      2 Yan, Zheng <zyan@redhat.com>
        30	      2 Varada Kari <varada.kari@sandisk.com>
        31	      2 Steve Capper <steve.capper@linaro.org>
        32	      2 Simon Guinot <simon.guinot@sequanux.org>
        33	      2 Radoslaw Zarzynski <rzarzynski@mirantis.com>
        34	      2 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
        35	      2 Mingxin Liu <mingxinliu@ubuntukylin.com>
        36	      2 Ma Jianpeng <jianpeng.ma@intel.com>
        37	      2 John Wilkins <jwilkins@redhat.com>
        38	      2 James Page <james.page@ubuntu.com>
        39	      2 Ilya Dryomov <idryomov@redhat.com>
        40	      1 Yuri Weinstein <yuriw@redhat.com>
        41	      1 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
        42	      1 Yuan Zhou <yuan.zhou@intel.com>
        43	      1 Xinze Chi <xinze@xsky.com>
        44	      1 Vikhyat Umrao <vumrao@redhat.com>
        45	      1 Shylesh Kumar <shmohan@redhat.com>
        46	      1 Shotaro Kawaguchi <kawaguchi.s@jp.fujitsu.com>
        47	      1 Sebastien Ponce <sebastien.ponce@cern.ch>
        48	      1 Raju Kurunkad <Raju.Kurunkad@sandisk.com>
        49	      1 Rajesh Nambiar <rajesh.n@msystechnologies.com>
        50	      1 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
        51	      1 Noah Watkins <nwatkins@redhat.com>
        52	      1 Ning Yao <yaoning@ruijie.com.cn>
        53	      1 Mykola Golub <mgolub@mirantis.com>
        54	      1 Min Chen <minchen@ubuntukylin.com>
        55	      1 Michal Jarzabek <stiopa@gmail.com>
        56	      1 Kernel Neophyte <neophyte.hacker001@gmail.com>
        57	      1 Jian Wen <wenjian@letv.com>
        58	      1 Huang Jun <hjwsm1989@gmail.com>
        59	      1 Guang Yang <yguang@yahoo-inc.com>
        60	      1 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
        61	      1 Billy Olsen <billy.olsen@canonical.com>
        62	      1 Andrew Bartlett <abartlet@catalyst.net.nz>
        63	      1 Alistair Israel <aisrael@gmail.com>

Reviews, by organizations (one review spans multiple commits)
         1	   1281 Red Hat <contact@redhat.com>
         2	     42 SUSE <contact@suse.com>
         3	     33 XSky <contact@xsky.com>
         4	     19 Ubuntu Kylin <contact@ubuntukylin.com>
         5	     18 Reliance Jio Infocomm Ltd. <contact@ril.com>
         6	      9 Unaffiliated <no@organization.net>
         7	      7 Deutsche Telekom <contact@telekom.de>
         8	      6 Fujitsu <contact@fujitsu.com>
         9	      6 CERN <contact@cern.ch>
        10	      4 SanDisk <contact@sandisk.com>
        11	      4 Mirantis <contact@mirantis.com>
        12	      3 Yahoo! <contact@yahoo-inc.com>
        13	      3 Intel <contact@intel.com>
        14	      3 Cloudwatt <libre.licensing@cloudwatt.com>
        15	      3 Canonical <contact@canonical.com>
        16	      2 Linaro <contact@linaro.org>
        17	      1 Tencent <contact@tencent.com>
        18	      1 Ruijie Networks <contact@ruijie.com.cn>
        19	      1 MSys Technologies <contact@msystechnologies.com>
        20	      1 Catalyst <enquiries@catalyst.net.nz>
        21	      1 Acaleph <contact@acale.ph>


Cheers, Yann

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html






--------------030006070300060902090500
Content-Type: application/pgp-signature;
 name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjIuMC4yMiAo
R05VL0xpbnV4KQoKaUVZRUFSRUNBQVlGQWxYYmgrQUFDZ2tROGRMTXlFbDZGMjB4TWdDYkJq
SkJIZnF3cnNjTk9wRVRVS1lQUjc4QwpzZlFBb0x6aGczcDd4M2s3ZmJyajJuSEdZMmcvYkI5
Two9T2FJeQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0KCg==
--------------030006070300060902090500--
