From: Sage Weil <sage@newdream.net>
Subject: Re: v11.2.0 Kraken contributor credits
Date: Fri, 20 Jan 2017 19:58:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1701201954500.3654@piezo.novalocal>
References: <87wpdp25m3.fsf@suse.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1660409522-1484942318=:3654"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58318 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752727AbdATT6j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jan 2017 14:58:39 -0500
In-Reply-To: <87wpdp25m3.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek@suse.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-community@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1660409522-1484942318=:3654
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 20 Jan 2017, Abhishek L wrote:
> Hi cephers,
> 
> As announced previously, a new stable version of Ceph, Kraken is out,
> congratulations to everyone for making this happen!
> 
> Here is a sorted list of authors & organizations who've contributed to
> Kraken(v11.2.0), by number of commits &/ reviews back to the last stable release
> Jewel (v10.2.0).

These results were a bit skewed because we merged the ceph-qa-suite.git 
repo into ceph.git during this cycle and the entire past history of that 
tree was included in the stats.  I reran the credits script, this time 
going from the latest jewel branch (which includes that history up through 
jewel) instead of v10.2.0.  These should be more accurate:


Number of lines added and removed, by authors
     1	 69272 Sage Weil <sweil@redhat.com>
     2	 41745 Jason Dillaman <dillaman@redhat.com>
     3	 22558 Haomai Wang <haomai@xsky.com>
     4	 21394 John Spray <jspray@redhat.com>
     5	 16625 Samuel Just <sjust@redhat.com>
     6	 14734 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     7	 14543 Mykola Golub <mgolub@mirantis.com>
     8	 13289 Abhishek Lekshmanan <abhishek@suse.com>
     9	 12873 Kefu Chai <kchai@redhat.com>
    10	 10198 Warren Usui <wusui@redhat.com>
    11	  8863 Ramesh Chander <Ramesh.Chander@sandisk.com>
    12	  7240 Xie Xingguo <xie.xingguo@zte.com.cn>
    13	  7233 Igor Fedotov <ifedotov@mirantis.com>
    14	  6376 Casey Bodley <cbodley@redhat.com>
    15	  5851 Yan, Zheng <zyan@redhat.com>
    16	  5450 Ricardo Dias <rdias@suse.com>
    17	  5440 David Zafman <dzafman@redhat.com>
    18	  5383 Yehuda Sadeh <ysadehwe@redhat.com>
    19	  4667 Victor Denisov <denisovenator@gmail.com>
    20	  4267 Greg Farnum <gfarnum@redhat.com>
    21	  4254 Michal Jarzabek <stiopa@gmail.com>
    22	  3874 Jeff Layton <jlayton@redhat.com>
    23	  3580 Noah Watkins <nwatkins@redhat.com>
    24	  3429 Bassam Tabbara <bassam.tabbara@quantum.com>
    25	  3212 Venky Shankar <vshankar@redhat.com>
    26	  2808 Josh Durgin <jdurgin@redhat.com>
    27	  2581 Yuri Weinstein <yweinste@redhat.com>
    28	  2264 Oleh Prypin <oleh@pryp.in>
    29	  2166 Sebastien Ponce <sebastien.ponce@cern.ch>
    30	  2125 Matt Benjamin <mbenjamin@redhat.com>
    31	  2124 Nathan Cutler <ncutler@suse.com>
    32	  2086 João Eduardo Luís <joao@suse.de>
    33	  2084 Willem Jan Withagen <wjw@digiware.nl>
    34	  1976 Ji Chen <insomnia@139.com>
    35	  1955 Patrick Donnelly <pdonnell@redhat.com>
    36	  1936 Douglas Fuller <dfuller@redhat.com>
    37	  1874 Kiseleva Alyona <akiselyova@mirantis.com>
    38	  1863 Ma Jianpeng <jianpeng.ma@intel.com>
    39	  1777 Patrick Donnelly <batrick@batbytes.com>
    40	  1568 Anirudha Bose <ani07nov@gmail.com>
    41	  1433 Ali Maredia <amaredia@redhat.com>
    42	  1260 Ramana Raja <rraja@redhat.com>
    43	  1176 zhouruisong <236131368@qq.com>
    44	  1115 Frank Filz <ffilz@redhat.com>
    45	  1078 Dongsheng Yang <dongsheng.yang@easystack.cn>
    46	  1054 Pritha Srivastava <prsrivas@redhat.com>
    47	   978 Daniel Gryniewicz <dang@redhat.com>
    48	   931 Michael Sevilla <mikesevilla3@gmail.com>
    49	   919 Li Tianqing <tianqing@unitedstack.com>
    50	   839 Xiaowei Chen <chen.xiaowei@h3c.com>
    51	   802 David Disseldorp <ddiss@suse.de>
    52	   784 Adam Kupczyk <akupczyk@mirantis.com>
    53	   781 Varada Kari <varada.kari@sandisk.com>
    54	   745 Adam C. Emerson <aemerson@redhat.com>
    55	   736 gcharot <buixor@gmail.com>
    56	   690 Piotr Dałek <git@predictor.org.pl>
    57	   672 Roushan Ali <roushan.ali@sandisk.com>
    58	   649 Alexey Sheplyakov <asheplyakov@mirantis.com>
    59	   639 Loic Dachary <ldachary@redhat.com>
    60	   605 Javier M. Mellid <jmunhoz@igalia.com>
    61	   593 Ren Huanwen <ren.huanwen@zte.com.cn>
    62	   561 Yan Jun <yan.jun8@zte.com.cn>
    63	   534 Ken Dreyer <kdreyer@redhat.com>
    64	   495 Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
    65	   485 Avner BenHanoch <avnerb@mellanox.com>
    66	   475 Robin H. Johnson <robin.johnson@dreamhost.com>
    67	   473 Manali Kulkarni <Manali.Kulkarni@sandisk.com>
    68	   457 Zhao Junwang <zhjwpku@gmail.com>
    69	   423 Zhi Zhang <willzzhang@tencent.com>
    70	   423 Hector Martin <marcan@marcan.st>
    71	   421 Ilya Dryomov <idryomov@redhat.com>
    72	   411 Iain Buclaw <iain.buclaw@sociomantic.com>
    73	   408 Brad Hubbard <bhubbard@redhat.com>
    74	   382 Pan Liu <pan.liu@istuary.com>
    75	   379 Zhiqiang Wang <zhiqiang@xsky.com>
    76	   373 Song Baisen <song.baisen@zte.com.cn>
    77	   370 Daniel Gollub <d.gollub@telekom.de>
    78	   365 Ryne Li <lizhenqiangsnake@gmail.com>
    79	   358 John Coyle <dx9err@gmail.com>
    80	   354 Pete Zaitcev <zaitcev@redhat.com>
    81	   345 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
    82	   324 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
    83	   292 Vishal Kanaujia <Vishal.Kanaujia@sandisk.com>
    84	   288 Mehdi Abaakouk <sileht@redhat.com>
    85	   288 Ivo Jimenez <ivo.jimenez@gmail.com>
    86	   281 Warren Usui <wusui@magna002.ceph.redhat.com>
    87	   280 Boris Ranto <branto@redhat.com>
    88	   253 Orit Wasserman <owasserm@redhat.com>
    89	   243 Vu Pham <vu@mellanox.com>
    90	   240 Vasu Kulkarni <vasu@redhat.com>
    91	   239 Wei Jin <jinwei15@wanda.cn>
    92	   227 Allen Samuels <allen.samuels@sandisk.com>
    93	   224 J. Eric Ivancich <ivancich@redhat.com>
    94	   217 Karol Mroz <kmroz@suse.com>
    95	   217 Jiaying Ren <mikulely@gmail.com>
    96	   215 Vaibhav Bhembre <vaibhav@digitalocean.com>
    97	   212 Vikhyat Umrao <vumrao@redhat.com>
    98	   204 Mingxin Liu <mingxin@xsky.com>
    99	   201 Tim Serong <tserong@suse.com>
   100	   182 Chendi Xue <chendi.xue@intel.com>
   101	   174 Tomy Cheru <tomy.cheru@sandisk.com>
   102	   174 Haodong Tang <haodong.tang@intel.com>
   103	   174 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
   104	   172 Wido den Hollander <wido@42on.com>
   105	   160 Shehbaz Jaffer <shehbaz.jaffer@mail.utoronto.ca>
   106	   155 Alfredo Deza <adeza@redhat.com>
   107	   154 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
   108	   154 Luo Runbing <runsisi@zte.com.cn>
   109	   152 Yann Dupont <yann@objoo.org>
   110	   151 Jianjian Huo <jianjian.huo@ssi.samsung.com>
   111	   151 Dan Mick <dmick@redhat.com>
   112	   144 Xiaoxi Chen <xiaoxchen@ebay.com>
   113	   137 Somnath Roy <somnath.roy@sandisk.com>
   114	   134 Li Peng <lip@dtdream.com>
   115	   133 Bartłomiej Święcki <bartlomiej.swiecki@corp.ovh.com>
   116	   118 shylesh kumar <shylesh.mohan@gmail.com>
   117	   116 Lu Shi <shi.lu@h3c.com>
   118	   114 Ning Yao <yaoning@unitedstack.com>
   119	   105 François Lafont <flafdivers@free.fr>
   120	    89 Wanlong Gao <wanlong.gao@easystack.cn>
   121	    86 Zack Cerza <zack@redhat.com>
   122	    86 Li Wang <li.wang@kylin-cloud.com>
   123	    84 Roi Dayan <roid@mellanox.com>
   124	    83 You Ji <youji@ebay.com>
   125	    80 David Galloway <dgallowa@redhat.com>
   126	    80 Adir Lev <adirl@mellanox.com>
   127	    76 Luo Runbing <runsisi@hust.edu.cn>
   128	    68 Mike Christie <mchristi@redhat.com>
   129	    64 Zengran Zhang <zhangzengran@h3c.com>
   130	    62 Roland Mechler <rmechler@cisco.com>
   131	    59 Ramakrishnan <ramakrishnan@dhcp35-178.lab.eng.blr.redhat.com>
   132	    58 Colin Walters <walters@redhat.com>
   133	    54 Ilsoo Byun <ilsoo.byun@sk.com>
   134	    53 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
   135	    49 Jon Bernard <jbernard@tuxion.com>
   136	    48 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
   137	    48 Jesse Williamson <jesse.williamson@suse.com>
   138	    47 Mark Nelson <mnelson@redhat.com>
   139	    46 Harald Klein <hari@vt100.at>
   140	    44 Owen Synge <osynge@suse.com>
   141	    42 Zhang Zezhu <zhang.zezhu@zte.com.cn>
   142	    41 Xinze Chi <xinze@xsky.com>
   143	    40 Jenkins <jenkins@ceph.com>
   144	    40 Erwan Velu <erwan@redhat.com>
   145	    39 Peter Maloney <peter.maloney@yahoo.ca>
   146	    38 Marcus Watts <mwatts@redhat.com>
   147	    37 Weibing Zhang <zhangweibing@unitedstack.com>
   148	    37 Sébastien Han <seb@redhat.com>
   149	    37 Paweł Sadowski <pawel.sadowski@corp.ovh.com>
   150	    37 Jayashree Candadai <jayaajay@indiana.edu>
   151	    37 Jan Fajerski <jfajerski@suse.com>
   152	    36 whu_liuchang <nfcj000@qq.com>
   153	    34 Leo Zhang <nguzcf@gmail.com>
   154	    33 Yuri Weinstein <yuri.weinstein@gmail.com>
   155	    33 Yang Honggang <joseph.yang@xtaotech.com>
   156	    32 Yongqiang He <he.yongqiang@h3c.com>
   157	    29 Tamil Muthamizhan <tmuthami@redhat.com>
   158	    29 Steven Dieffenbach <sdieffen@redhat.com>
   159	    28 xianxiaxiao <xianxia.xiao@kylin-cloud.com>
   160	    28 Chengwei Yang <yangchengwei@qiyi.com>
   161	    26 Yuan Zhou <yuan.zhou@intel.com>
   162	    26 wangsongbo <wangsongbo@unitedstack.com>
   163	    25 Tao Chang <changtao@hihuron.com>
   164	    24 Vladislav Odintsov <odivlad@gmail.com>
   165	    24 Uday Mullangi <udaymjl@gmail.com>
   166	    24 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
   167	    23 Etienne Menguy <etienne.menguy@corp.ovh.com>
   168	    22 Shu, Xinxin <xinxin.shu@intel.com>
   169	    22 Shinobu Kinjo <shinobu@redhat.com>
   170	    22 Hans van den Bogert <hansbogert@gmail.com>
   171	    22 Dan Horák <dan@danny.cz>
   172	    22 Chang-Yi Lee <cy.l@inwinstack.com>
   173	    21 Weibing Zhang <atheism.zhang@gmail.com>
   174	    20 Luo Kexue <luo.kexue@zte.com.cn>
   175	    19 Min Chen <chenmin@xsky.com>
   176	    19 Michel Normand <normand@linux.vnet.ibm.com>
   177	    19 Alexander Graf <agraf@suse.de>
   178	    17 snakeAngel2015 <li.jieA@h3c.com>
   179	    16 Jim Wright <jim@quadraturecapital.com>
   180	    16 Javeme <javaloveme@gmail.com>
   181	    15 Igor Podoski <igor.podoski@ts.fujitsu.com>
   182	    15 Dong Wu <archer.wudong@gmail.com>
   183	    14 Weijun Duan <duanweijun@h3c.com>
   184	    14 MinSheng Lin <minsheng.l@inwinstack.com>
   185	    14 liuchang0812 <liuchang0812@gmail.com>
   186	    14 Huang Jun <hjwsm1989@gmail.com>
   187	    14 Gong Chuang <gong.chuang@zte.com.cn>
   188	    14 DesmondS <jordanjimmy41177@gmail.com>
   189	    13 Huan Zhang <zhanghuan@chinac.com>
   190	    13 Alexandre Derumier <aderumier@odiso.com>
   191	    12 Wenjun Huang <wenjunhuang@tencent.com>
   192	    12 Lan De <lan.de3@zte.com.cn>
   193	    12 Dan van der Ster <daniel.vanderster@cern.ch>
   194	    12 Bryan Stillwell <bryan.stillwell@twcable.com>
   195	    11 zhangshaowen <zhang_shaowen@139.com>
   196	    11 Jie Wang <jie.wang@kylin-cloud.com>
   197	    10 Vicente Cheng <freeze.bilsted@gmail.com>
   198	    10 Uday Mullangi <umullan@L-IDCAA8G3QC-M.local>
   199	    10 Mingxin Liu <mingxin.liu@kylin-cloud.com>
   200	    10 Brett Niver <bniver@redhat.com>
   201	    10 Abhishek Varshney <abhishek.varshney@flipkart.com>
   202	     9 Xuan Liu <liu.xuan@h3c.com>
   203	     9 Thomas Serlin <tserlin@redhat.com>
   204	     9 Na Xie <xie.na@h3c.com>
   205	     9 Jaemyoun Lee <jaemyoun@gmail.com>
   206	     9 Ira Cooper <ira@redhat.com>
   207	     9 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
   208	     8 Zhuang Xiaochun <zhuangxc89@163.com>
   209	     8 Zhenyu Leng <lengzhenyu@ict.ac.cn>
   210	     8 Yatin Kumbhare <yatinkumbhare@gmail.com>
   211	     8 Mark Korenberg <socketpair@gmail.com>
   212	     8 Feng Guo <diluga@gmail.com>
   213	     7 Proskurin Kirill <kproskurin@mirantis.com>
   214	     7 Ignacio Bravo <ibravo@hotmail.com>
   215	     7 guozhandong <18896723979@139.com>
   216	     6 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
   217	     6 Xinxin Shu <shuxinxin@chinac.com>
   218	     6 Sirisha Guduru <SGuduru@walmartlabs.com>
   219	     6 Shilpa Jagannath <smanjara@redhat.com>
   220	     6 Marov Aleksey <Marov.A@raidix.com>
   221	     6 Ker Liu <ker.liu@alcatel-lucent.com>
   222	     6 Jianjian huo <jianjian.huo@ssi.samsung.com>
   223	     5 Tianshan Qu <tianshan@xsky.com>
   224	     5 Shylesh Kumar <shmohan@redhat.com>
   225	     5 Hong Zhangoole <hong.zhangoole@gmail.com>
   226	     5 Diwakar Goel <diwakargoel@gmail.com>
   227	     5 Albert Tu <albert.t@inwinstack.com>
   228	     4 Zhao Kun <jswps2011@163.com>
   229	     4 Zhao Chao <zhaochao1984@gmail.com>
   230	     4 Wu Xingyi <wuxingyi@letv.com>
   231	     4 Patrick McGarry <pmcgarry@redhat.com>
   232	     4 Ira Cooper <ira@samba.org>
   233	     4 Feng Yu <amoxic@126.com>
   234	     4 chanyoung <park910113@gmail.com>
   235	     3 root <root@osscr03r06s11.local.lan>
   236	     3 root <root@lxbre43a05.cern.ch>
   237	     3 root <root@korea-fg-ceph-57-117.120.120.117>
   238	     3 Nick Fisk <nick@fisk.me.uk>
   239	     3 LiuYang <yippeetry@gmail.com>
   240	     3 Jelle vd Kooij <vdkooij.jelle@gmail.com>
   241	     2 Yibo Cai <yibo.cai@linaro.org>
   242	     2 Xu Biao <xubiao.codeyz@gmail.com>
   243	     2 shiqi <m13913886148@gmail.com>
   244	     2 Ruben Kerkhof <ruben@rubenkerkhof.com>
   245	     2 Qinghua Jin <qhjin_dev@163.com>
   246	     2 Qiankun Zheng <zheng.qiankun@h3c.com>
   247	     2 Nitin A Kamble <Nitin.Kamble@Teradata.com>
   248	     2 Mike Hackett <mhackett@redhat.com>
   249	     2 Marc Koderer <marc@koderer.com>
   250	     2 Malte Fiala <maltefiala@produktion.io>
   251	     2 Linfei Hou <hou.linfei@h3c.com>
   252	     2 John Wilkins <jwilkins@redhat.com>
   253	     2 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
   254	     2 James Page <james.page@ubuntu.com>
   255	     2 James Liu <james.liu@ssi.samsung.com>
   256	     2 chrone <charlesalva@gmail.com>
   257	     2 Billy Olsen <billy.olsen@canonical.com>
   258	     2 Barbora Ančincová <bara@redhat.com>
   259	     1 Gui Hecheng <guihecheng@cmss.chinamobile.com>
   260	     1 Gregory Meno <gmeno@redhat.com>
   261	     1 Daniel Oliveira <doliveira@suse.com>

Number of lines added and removed, by organization
     1	230193 Red Hat <contact@redhat.com>
     2	 44484 Mirantis <contact@mirantis.com>
     3	 24299 SUSE <contact@suse.com>
     4	 23206 XSky <contact@xsky.com>
     5	 14201 Unaffiliated <no@organization.net>
     6	 10996 SanDisk <contact@sandisk.com>
     7	  9333 ZTE <contact@zte.com.cn>
     8	  3429 Quantum Corporation <info@quantum.com>
     9	  2581 Yuri Weinstein <yweinste@redhat.com>
    10	  2267 Intel <contact@intel.com>
    11	  2178 CERN <contact@cern.ch>
    12	  2084 Digiware <contact@digiware.nl>
    13	  1980 LETV <contact@letv.com>
    14	  1241 H3C <contact@h3c.com>
    15	  1167 Easystack <contact@easystack.cn>
    16	  1096 UnitedStack <contact@unitedstack.com>
    17	   931 Michael Sevilla <mikesevilla3@gmail.com>
    18	   892 Mellanox <contact@mellanox.com>
    19	   736 gcharot <buixor@gmail.com>
    20	   605 Igalia <contact@igalia.com>
    21	   544 Deutsche Telekom <contact@telekom.de>
    22	   501 Walmart Labs <contact@walmartlabs.com>
    23	   475 DreamHost <contact@dreamhost.com>
    24	   473 Manali Kulkarni <Manali.Kulkarni@sandisk.com>
    25	   435 Tencent <contact@tencent.com>
    26	   411 Sociomantic Labs <info@sociomantic.com>
    27	   382 Pan Liu <pan.liu@istuary.com>
    28	   360 Fujitsu <contact@fujitsu.com>
    29	   288 Ivo Jimenez <ivo.jimenez@gmail.com>
    30	   281 Warren Usui <wusui@magna002.ceph.redhat.com>
    31	   239 Wanda ffan <contact@wanda.cn>
    32	   227 Ebay <contact@ebay.com>
    33	   215 DigitalOcean <contact@digitalocean.com>
    34	   183 Kylin Cloud <contact@kylin-cloud.com>
    35	   174 Tomy Cheru <tomy.cheru@sandisk.com>
    36	   172 Wido 42on <contact@42on.com>
    37	   160 University of Toronto <contact@mail.utoronto.ca>
    38	   159 Samsung <contact@samsung.com>
    39	   134 Dtdream <contact@dtdream.com>
    40	   133 Bartłomiej Święcki <bartlomiej.swiecki@corp.ovh.com>
    41	   118 shylesh kumar <shylesh.mohan@gmail.com>
    42	    76 Huazhong University of Science and Technology <contact@hust.edu.cn>
    43	    62 CISCO <contact@cisco.com>
    44	    59 Ramakrishnan <ramakrishnan@dhcp35-178.lab.eng.blr.redhat.com>
    45	    56 Inktank <contact@inktank.com>
    46	    54 SK Telecom <rnd@sktelecom.com>
    47	    41 inwinSTACK inc. <leo.l@inwinstack.com>
    48	    37 Sébastien Han <seb@redhat.com>
    49	    37 Paweł Sadowski <pawel.sadowski@corp.ovh.com>
    50	    37 Jayashree Candadai <jayaajay@indiana.edu>
    51	    36 whu_liuchang <nfcj000@qq.com>
    52	    33 Yuri Weinstein <yuri.weinstein@gmail.com>
    53	    28 iQIYI <edison@qiyi.com>
    54	    25 Hihuron <contact@huron.com>
    55	    24 Uday Mullangi <udaymjl@gmail.com>
    56	    23 OVH <contact@corp.ovh.com>
    57	    22 Hans van den Bogert <hansbogert@gmail.com>
    58	    21 Weibing Zhang <atheism.zhang@gmail.com>
    59	    19 IBM <contact@IBM.com>
    60	    19 Chinac <info@chinac.com>
    61	    19 Alexander Graf <agraf@suse.de>
    62	    17 snakeAngel2015 <li.jieA@h3c.com>
    63	    16 Quadrature Capital Limited <info@quadraturecapital.com>
    64	    16 Javeme <javaloveme@gmail.com>
    65	    15 Dong Wu <archer.wudong@gmail.com>
    66	    14 liuchang0812 <liuchang0812@gmail.com>
    67	    14 DesmondS <jordanjimmy41177@gmail.com>
    68	    13 Odiso <contact@odiso.com>
    69	    12 Time Warner Cable Inc. <contact@twcable.com>
    70	    11 zhangshaowen <zhang_shaowen@139.com>
    71	    10 Uday Mullangi <umullan@L-IDCAA8G3QC-M.local>
    72	    10 Flipkart <contact@flipkart.com>
    73	     9 Catalysts <office@catalysts.cc>
    74	     8 Mark Korenberg <socketpair@gmail.com>
    75	     8 ICT <contact@ict.ac.cn>
    76	     7 Proskurin Kirill <kproskurin@mirantis.com>
    77	     7 guozhandong <18896723979@139.com>
    78	     6 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
    79	     6 Marov Aleksey <Marov.A@raidix.com>
    80	     6 Ker Liu <ker.liu@alcatel-lucent.com>
    81	     5 Diwakar Goel <diwakargoel@gmail.com>
    82	     4 chanyoung <park910113@gmail.com>
    83	     4 Canonical <contact@canonical.com>
    84	     3 root <root@osscr03r06s11.local.lan>
    85	     3 root <root@lxbre43a05.cern.ch>
    86	     3 root <root@korea-fg-ceph-57-117.120.120.117>
    87	     3 LiuYang <yippeetry@gmail.com>
    88	     2 SAP <contact@sap.com>
    89	     2 Nitin A Kamble <Nitin.Kamble@Teradata.com>
    90	     2 Malte Fiala <maltefiala@produktion.io>
    91	     2 Linaro <contact@linaro.org>
    92	     2 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
    93	     2 chrone <charlesalva@gmail.com>
    94	     1 Gui Hecheng <guihecheng@cmss.chinamobile.com>

Commits, by authors
     1	    994 Sage Weil <sweil@redhat.com>
     2	    555 Xie Xingguo <xie.xingguo@zte.com.cn>
     3	    434 Kefu Chai <kchai@redhat.com>
     4	    353 Jason Dillaman <dillaman@redhat.com>
     5	    258 John Spray <jspray@redhat.com>
     6	    211 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     7	    189 Michal Jarzabek <stiopa@gmail.com>
     8	    177 Casey Bodley <cbodley@redhat.com>
     9	    166 Haomai Wang <haomai@xsky.com>
    10	    144 Yehuda Sadeh <ysadehwe@redhat.com>
    11	    139 Samuel Just <sjust@redhat.com>
    12	    119 Igor Fedotov <ifedotov@mirantis.com>
    13	    117 Greg Farnum <gfarnum@redhat.com>
    14	    115 Jeff Layton <jlayton@redhat.com>
    15	    113 Yan, Zheng <zyan@redhat.com>
    16	    113 Mykola Golub <mgolub@mirantis.com>
    17	    112 David Zafman <dzafman@redhat.com>
    18	    111 Yann Dupont <yann@objoo.org>
    19	    103 Willem Jan Withagen <wjw@digiware.nl>
    20	    103 Nathan Cutler <ncutler@suse.com>
    21	     79 Josh Durgin <jdurgin@redhat.com>
    22	     72 Patrick Donnelly <pdonnell@redhat.com>
    23	     64 Yan Jun <yan.jun8@zte.com.cn>
    24	     63 Ma Jianpeng <jianpeng.ma@intel.com>
    25	     60 Ren Huanwen <ren.huanwen@zte.com.cn>
    26	     55 Matt Benjamin <mbenjamin@redhat.com>
    27	     45 Loic Dachary <ldachary@redhat.com>
    28	     43 Dongsheng Yang <dongsheng.yang@easystack.cn>
    29	     43 Abhishek Lekshmanan <abhishek@suse.com>
    30	     37 Ricardo Dias <rdias@suse.com>
    31	     36 Anirudha Bose <ani07nov@gmail.com>
    32	     35 Brad Hubbard <bhubbard@redhat.com>
    33	     32 Ramesh Chander <Ramesh.Chander@sandisk.com>
    34	     31 Venky Shankar <vshankar@redhat.com>
    35	     31 Adam C. Emerson <aemerson@redhat.com>
    36	     30 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
    37	     30 Song Baisen <song.baisen@zte.com.cn>
    38	     29 Ramana Raja <rraja@redhat.com>
    39	     29 Oleh Prypin <oleh@pryp.in>
    40	     26 Ilya Dryomov <idryomov@redhat.com>
    41	     26 Ali Maredia <amaredia@redhat.com>
    42	     25 Li Wang <li.wang@kylin-cloud.com>
    43	     25 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    44	     25 Bassam Tabbara <bassam.tabbara@quantum.com>
    45	     24 Luo Runbing <runsisi@zte.com.cn>
    46	     24 João Eduardo Luís <joao@suse.de>
    47	     23 Yuri Weinstein <yweinste@redhat.com>
    48	     23 Ken Dreyer <kdreyer@redhat.com>
    49	     21 John Coyle <dx9err@gmail.com>
    50	     20 Orit Wasserman <owasserm@redhat.com>
    51	     20 Adam Kupczyk <akupczyk@mirantis.com>
    52	     19 Xiaowei Chen <chen.xiaowei@h3c.com>
    53	     19 Piotr Dałek <git@predictor.org.pl>
    54	     19 Dan Mick <dmick@redhat.com>
    55	     18 Pan Liu <pan.liu@istuary.com>
    56	     17 Vasu Kulkarni <vasu@redhat.com>
    57	     16 Li Peng <lip@dtdream.com>
    58	     15 Robin H. Johnson <robin.johnson@dreamhost.com>
    59	     15 Avner BenHanoch <avnerb@mellanox.com>
    60	     14 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
    61	     14 Victor Denisov <denisovenator@gmail.com>
    62	     14 Tim Serong <tserong@suse.com>
    63	     14 Patrick Donnelly <batrick@batbytes.com>
    64	     14 David Disseldorp <ddiss@suse.de>
    65	     14 Daniel Gryniewicz <dang@redhat.com>
    66	     14 Boris Ranto <branto@redhat.com>
    67	     13 Sebastien Ponce <sebastien.ponce@cern.ch>
    68	     12 Vikhyat Umrao <vumrao@redhat.com>
    69	     12 Kiseleva Alyona <akiselyova@mirantis.com>
    70	     12 Haodong Tang <haodong.tang@intel.com>
    71	     12 Alfredo Deza <adeza@redhat.com>
    72	     11 Zhi Zhang <willzzhang@tencent.com>
    73	     11 xianxiaxiao <xianxia.xiao@kylin-cloud.com>
    74	     11 Wei Jin <jinwei15@wanda.cn>
    75	     11 Varada Kari <varada.kari@sandisk.com>
    76	     11 Karol Mroz <kmroz@suse.com>
    77	     10 Zhao Junwang <zhjwpku@gmail.com>
    78	     10 Wido den Hollander <wido@42on.com>
    79	     10 Jianjian Huo <jianjian.huo@ssi.samsung.com>
    80	      9 Xiaoxi Chen <xiaoxchen@ebay.com>
    81	      9 Douglas Fuller <dfuller@redhat.com>
    82	      9 Chengwei Yang <yangchengwei@qiyi.com>
    83	      8 Roi Dayan <roid@mellanox.com>
    84	      8 Pritha Srivastava <prsrivas@redhat.com>
    85	      8 Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
    86	      8 Owen Synge <osynge@suse.com>
    87	      8 Noah Watkins <nwatkins@redhat.com>
    88	      8 Mark Nelson <mnelson@redhat.com>
    89	      8 Manali Kulkarni <Manali.Kulkarni@sandisk.com>
    90	      8 Javier M. Mellid <jmunhoz@igalia.com>
    91	      8 Iain Buclaw <iain.buclaw@sociomantic.com>
    92	      7 Zhang Zezhu <zhang.zezhu@zte.com.cn>
    93	      7 Leo Zhang <nguzcf@gmail.com>
    94	      7 Jiaying Ren <mikulely@gmail.com>
    95	      7 J. Eric Ivancich <ivancich@redhat.com>
    96	      6 Weibing Zhang <atheism.zhang@gmail.com>
    97	      6 Wanlong Gao <wanlong.gao@easystack.cn>
    98	      6 Ryne Li <lizhenqiangsnake@gmail.com>
    99	      6 Hector Martin <marcan@marcan.st>
   100	      6 Adir Lev <adirl@mellanox.com>
   101	      5 Xinze Chi <xinze@xsky.com>
   102	      5 Weibing Zhang <zhangweibing@unitedstack.com>
   103	      5 Warren Usui <wusui@redhat.com>
   104	      5 Ning Yao <yaoning@unitedstack.com>
   105	      5 Jenkins <jenkins@ceph.com>
   106	      5 Huang Jun <hjwsm1989@gmail.com>
   107	      4 Zengran Zhang <zhangzengran@h3c.com>
   108	      4 Vu Pham <vu@mellanox.com>
   109	      4 Vishal Kanaujia <Vishal.Kanaujia@sandisk.com>
   110	      4 Uday Mullangi <umullan@L-IDCAA8G3QC-M.local>
   111	      4 Somnath Roy <somnath.roy@sandisk.com>
   112	      4 Shinobu Kinjo <shinobu@redhat.com>
   113	      4 Michael Sevilla <mikesevilla3@gmail.com>
   114	      4 Marcus Watts <mwatts@redhat.com>
   115	      4 Luo Runbing <runsisi@hust.edu.cn>
   116	      4 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
   117	      4 Frank Filz <ffilz@redhat.com>
   118	      4 Daniel Gollub <d.gollub@telekom.de>
   119	      4 Chendi Xue <chendi.xue@intel.com>
   120	      4 Alexandre Derumier <aderumier@odiso.com>
   121	      3 Zhiqiang Wang <zhiqiang@xsky.com>
   122	      3 Yuan Zhou <yuan.zhou@intel.com>
   123	      3 Yatin Kumbhare <yatinkumbhare@gmail.com>
   124	      3 wangsongbo <wangsongbo@unitedstack.com>
   125	      3 Tamil Muthamizhan <tmuthami@redhat.com>
   126	      3 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
   127	      3 Pete Zaitcev <zaitcev@redhat.com>
   128	      3 Na Xie <xie.na@h3c.com>
   129	      3 Mingxin Liu <mingxin@xsky.com>
   130	      3 Michel Normand <normand@linux.vnet.ibm.com>
   131	      3 Luo Kexue <luo.kexue@zte.com.cn>
   132	      3 Jie Wang <jie.wang@kylin-cloud.com>
   133	      3 Javeme <javaloveme@gmail.com>
   134	      3 Erwan Velu <erwan@redhat.com>
   135	      3 David Galloway <dgallowa@redhat.com>
   136	      3 Dan van der Ster <daniel.vanderster@cern.ch>
   137	      3 Bartłomiej Święcki <bartlomiej.swiecki@corp.ovh.com>
   138	      3 Allen Samuels <allen.samuels@sandisk.com>
   139	      3 Alexey Sheplyakov <asheplyakov@mirantis.com>
   140	      2 zhouruisong <236131368@qq.com>
   141	      2 Zhenyu Leng <lengzhenyu@ict.ac.cn>
   142	      2 Zhao Kun <jswps2011@163.com>
   143	      2 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
   144	      2 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
   145	      2 Zack Cerza <zack@redhat.com>
   146	      2 You Ji <youji@ebay.com>
   147	      2 Yongqiang He <he.yongqiang@h3c.com>
   148	      2 Xinxin Shu <shuxinxin@chinac.com>
   149	      2 whu_liuchang <nfcj000@qq.com>
   150	      2 Weijun Duan <duanweijun@h3c.com>
   151	      2 Warren Usui <wusui@magna002.ceph.redhat.com>
   152	      2 Vladislav Odintsov <odivlad@gmail.com>
   153	      2 Vicente Cheng <freeze.bilsted@gmail.com>
   154	      2 Uday Mullangi <udaymjl@gmail.com>
   155	      2 Tomy Cheru <tomy.cheru@sandisk.com>
   156	      2 Tianshan Qu <tianshan@xsky.com>
   157	      2 Tao Chang <changtao@hihuron.com>
   158	      2 Sirisha Guduru <SGuduru@walmartlabs.com>
   159	      2 Shilpa Jagannath <smanjara@redhat.com>
   160	      2 Sébastien Han <seb@redhat.com>
   161	      2 Roushan Ali <roushan.ali@sandisk.com>
   162	      2 root <root@lxbre43a05.cern.ch>
   163	      2 Patrick McGarry <pmcgarry@redhat.com>
   164	      2 Mehdi Abaakouk <sileht@redhat.com>
   165	      2 liuchang0812 <liuchang0812@gmail.com>
   166	      2 Li Tianqing <tianqing@unitedstack.com>
   167	      2 Ivo Jimenez <ivo.jimenez@gmail.com>
   168	      2 Ignacio Bravo <ibravo@hotmail.com>
   169	      2 Huan Zhang <zhanghuan@chinac.com>
   170	      2 Hong Zhangoole <hong.zhangoole@gmail.com>
   171	      2 Gong Chuang <gong.chuang@zte.com.cn>
   172	      2 François Lafont <flafdivers@free.fr>
   173	      2 Feng Yu <amoxic@126.com>
   174	      2 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
   175	      2 Etienne Menguy <etienne.menguy@corp.ovh.com>
   176	      2 Dan Horák <dan@danny.cz>
   177	      2 Chang-Yi Lee <cy.l@inwinstack.com>
   178	      2 Albert Tu <albert.t@inwinstack.com>
   179	      2 Abhishek Varshney <abhishek.varshney@flipkart.com>
   180	      1 Zhuang Xiaochun <zhuangxc89@163.com>
   181	      1 Zhao Chao <zhaochao1984@gmail.com>
   182	      1 zhangshaowen <zhang_shaowen@139.com>
   183	      1 Yuri Weinstein <yuri.weinstein@gmail.com>
   184	      1 Yibo Cai <yibo.cai@linaro.org>
   185	      1 Yang Honggang <joseph.yang@xtaotech.com>
   186	      1 Xu Biao <xubiao.codeyz@gmail.com>
   187	      1 Xuan Liu <liu.xuan@h3c.com>
   188	      1 Wu Xingyi <wuxingyi@letv.com>
   189	      1 Wenjun Huang <wenjunhuang@tencent.com>
   190	      1 Vaibhav Bhembre <vaibhav@digitalocean.com>
   191	      1 Thomas Serlin <tserlin@redhat.com>
   192	      1 Steven Dieffenbach <sdieffen@redhat.com>
   193	      1 snakeAngel2015 <li.jieA@h3c.com>
   194	      1 shylesh kumar <shylesh.mohan@gmail.com>
   195	      1 Shylesh Kumar <shmohan@redhat.com>
   196	      1 Shu, Xinxin <xinxin.shu@intel.com>
   197	      1 shiqi <m13913886148@gmail.com>
   198	      1 Shehbaz Jaffer <shehbaz.jaffer@mail.utoronto.ca>
   199	      1 Ruben Kerkhof <ruben@rubenkerkhof.com>
   200	      1 root <root@osscr03r06s11.local.lan>
   201	      1 root <root@korea-fg-ceph-57-117.120.120.117>
   202	      1 Roland Mechler <rmechler@cisco.com>
   203	      1 Ramakrishnan <ramakrishnan@dhcp35-178.lab.eng.blr.redhat.com>
   204	      1 Qinghua Jin <qhjin_dev@163.com>
   205	      1 Qiankun Zheng <zheng.qiankun@h3c.com>
   206	      1 Proskurin Kirill <kproskurin@mirantis.com>
   207	      1 Peter Maloney <peter.maloney@yahoo.ca>
   208	      1 Paweł Sadowski <pawel.sadowski@corp.ovh.com>
   209	      1 Nitin A Kamble <Nitin.Kamble@Teradata.com>
   210	      1 Nick Fisk <nick@fisk.me.uk>
   211	      1 MinSheng Lin <minsheng.l@inwinstack.com>
   212	      1 Mingxin Liu <mingxin.liu@kylin-cloud.com>
   213	      1 Min Chen <chenmin@xsky.com>
   214	      1 Mike Hackett <mhackett@redhat.com>
   215	      1 Mike Christie <mchristi@redhat.com>
   216	      1 Marov Aleksey <Marov.A@raidix.com>
   217	      1 Mark Korenberg <socketpair@gmail.com>
   218	      1 Marc Koderer <marc@koderer.com>
   219	      1 Malte Fiala <maltefiala@produktion.io>
   220	      1 Lu Shi <shi.lu@h3c.com>
   221	      1 LiuYang <yippeetry@gmail.com>
   222	      1 Linfei Hou <hou.linfei@h3c.com>
   223	      1 Lan De <lan.de3@zte.com.cn>
   224	      1 Ker Liu <ker.liu@alcatel-lucent.com>
   225	      1 Jon Bernard <jbernard@tuxion.com>
   226	      1 John Wilkins <jwilkins@redhat.com>
   227	      1 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
   228	      1 Jim Wright <jim@quadraturecapital.com>
   229	      1 Ji Chen <insomnia@139.com>
   230	      1 Jianjian huo <jianjian.huo@ssi.samsung.com>
   231	      1 Jesse Williamson <jesse.williamson@suse.com>
   232	      1 Jelle vd Kooij <vdkooij.jelle@gmail.com>
   233	      1 Jayashree Candadai <jayaajay@indiana.edu>
   234	      1 Jan Fajerski <jfajerski@suse.com>
   235	      1 James Page <james.page@ubuntu.com>
   236	      1 James Liu <james.liu@ssi.samsung.com>
   237	      1 Jaemyoun Lee <jaemyoun@gmail.com>
   238	      1 Ira Cooper <ira@samba.org>
   239	      1 Ira Cooper <ira@redhat.com>
   240	      1 Ilsoo Byun <ilsoo.byun@sk.com>
   241	      1 Igor Podoski <igor.podoski@ts.fujitsu.com>
   242	      1 Harald Klein <hari@vt100.at>
   243	      1 Hans van den Bogert <hansbogert@gmail.com>
   244	      1 guozhandong <18896723979@139.com>
   245	      1 Gui Hecheng <guihecheng@cmss.chinamobile.com>
   246	      1 Gregory Meno <gmeno@redhat.com>
   247	      1 gcharot <buixor@gmail.com>
   248	      1 Feng Guo <diluga@gmail.com>
   249	      1 Dong Wu <archer.wudong@gmail.com>
   250	      1 Diwakar Goel <diwakargoel@gmail.com>
   251	      1 DesmondS <jordanjimmy41177@gmail.com>
   252	      1 Daniel Oliveira <doliveira@suse.com>
   253	      1 Colin Walters <walters@redhat.com>
   254	      1 chrone <charlesalva@gmail.com>
   255	      1 chanyoung <park910113@gmail.com>
   256	      1 Bryan Stillwell <bryan.stillwell@twcable.com>
   257	      1 Brett Niver <bniver@redhat.com>
   258	      1 Billy Olsen <billy.olsen@canonical.com>
   259	      1 Barbora Ančincová <bara@redhat.com>
   260	      1 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
   261	      1 Alexander Graf <agraf@suse.de>

Commits, by organizations
     1	   3605 Red Hat <contact@redhat.com>
     2	    776 ZTE <contact@zte.com.cn>
     3	    499 Unaffiliated <no@organization.net>
     4	    492 Mirantis <contact@mirantis.com>
     5	    257 SUSE <contact@suse.com>
     6	    180 XSky <contact@xsky.com>
     7	    103 Digiware <contact@digiware.nl>
     8	     83 Intel <contact@intel.com>
     9	     58 SanDisk <contact@sandisk.com>
    10	     54 Kylin Cloud <contact@kylin-cloud.com>
    11	     49 Easystack <contact@easystack.cn>
    12	     36 H3C <contact@h3c.com>
    13	     33 Mellanox <contact@mellanox.com>
    14	     29 Deutsche Telekom <contact@telekom.de>
    15	     25 Quantum Corporation <info@quantum.com>
    16	     23 Yuri Weinstein <yweinste@redhat.com>
    17	     18 Pan Liu <pan.liu@istuary.com>
    18	     16 Dtdream <contact@dtdream.com>
    19	     16 CERN <contact@cern.ch>
    20	     15 UnitedStack <contact@unitedstack.com>
    21	     15 DreamHost <contact@dreamhost.com>
    22	     12 Tencent <contact@tencent.com>
    23	     12 Samsung <contact@samsung.com>
    24	     11 Wanda ffan <contact@wanda.cn>
    25	     11 Ebay <contact@ebay.com>
    26	     10 Wido 42on <contact@42on.com>
    27	     10 Walmart Labs <contact@walmartlabs.com>
    28	      9 iQIYI <edison@qiyi.com>
    29	      8 Sociomantic Labs <info@sociomantic.com>
    30	      8 Manali Kulkarni <Manali.Kulkarni@sandisk.com>
    31	      8 Igalia <contact@igalia.com>
    32	      6 Weibing Zhang <atheism.zhang@gmail.com>
    33	      5 inwinSTACK inc. <leo.l@inwinstack.com>
    34	      5 Inktank <contact@inktank.com>
    35	      4 Uday Mullangi <umullan@L-IDCAA8G3QC-M.local>
    36	      4 Odiso <contact@odiso.com>
    37	      4 Michael Sevilla <mikesevilla3@gmail.com>
    38	      4 Huazhong University of Science and Technology <contact@hust.edu.cn>
    39	      4 Fujitsu <contact@fujitsu.com>
    40	      4 Chinac <info@chinac.com>
    41	      3 Javeme <javaloveme@gmail.com>
    42	      3 IBM <contact@IBM.com>
    43	      3 Bartłomiej Święcki <bartlomiej.swiecki@corp.ovh.com>
    44	      2 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
    45	      2 whu_liuchang <nfcj000@qq.com>
    46	      2 Warren Usui <wusui@magna002.ceph.redhat.com>
    47	      2 Uday Mullangi <udaymjl@gmail.com>
    48	      2 Tomy Cheru <tomy.cheru@sandisk.com>
    49	      2 Sébastien Han <seb@redhat.com>
    50	      2 root <root@lxbre43a05.cern.ch>
    51	      2 OVH <contact@corp.ovh.com>
    52	      2 liuchang0812 <liuchang0812@gmail.com>
    53	      2 LETV <contact@letv.com>
    54	      2 Ivo Jimenez <ivo.jimenez@gmail.com>
    55	      2 ICT <contact@ict.ac.cn>
    56	      2 Hihuron <contact@huron.com>
    57	      2 Flipkart <contact@flipkart.com>
    58	      2 Canonical <contact@canonical.com>
    59	      1 zhangshaowen <zhang_shaowen@139.com>
    60	      1 Yuri Weinstein <yuri.weinstein@gmail.com>
    61	      1 University of Toronto <contact@mail.utoronto.ca>
    62	      1 Time Warner Cable Inc. <contact@twcable.com>
    63	      1 snakeAngel2015 <li.jieA@h3c.com>
    64	      1 SK Telecom <rnd@sktelecom.com>
    65	      1 shylesh kumar <shylesh.mohan@gmail.com>
    66	      1 SAP <contact@sap.com>
    67	      1 root <root@osscr03r06s11.local.lan>
    68	      1 root <root@korea-fg-ceph-57-117.120.120.117>
    69	      1 Ramakrishnan <ramakrishnan@dhcp35-178.lab.eng.blr.redhat.com>
    70	      1 Quadrature Capital Limited <info@quadraturecapital.com>
    71	      1 Proskurin Kirill <kproskurin@mirantis.com>
    72	      1 Paweł Sadowski <pawel.sadowski@corp.ovh.com>
    73	      1 Nitin A Kamble <Nitin.Kamble@Teradata.com>
    74	      1 Marov Aleksey <Marov.A@raidix.com>
    75	      1 Mark Korenberg <socketpair@gmail.com>
    76	      1 Malte Fiala <maltefiala@produktion.io>
    77	      1 LiuYang <yippeetry@gmail.com>
    78	      1 Linaro <contact@linaro.org>
    79	      1 Ker Liu <ker.liu@alcatel-lucent.com>
    80	      1 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
    81	      1 Jayashree Candadai <jayaajay@indiana.edu>
    82	      1 Hans van den Bogert <hansbogert@gmail.com>
    83	      1 guozhandong <18896723979@139.com>
    84	      1 Gui Hecheng <guihecheng@cmss.chinamobile.com>
    85	      1 gcharot <buixor@gmail.com>
    86	      1 Dong Wu <archer.wudong@gmail.com>
    87	      1 Diwakar Goel <diwakargoel@gmail.com>
    88	      1 DigitalOcean <contact@digitalocean.com>
    89	      1 DesmondS <jordanjimmy41177@gmail.com>
    90	      1 CISCO <contact@cisco.com>
    91	      1 chrone <charlesalva@gmail.com>
    92	      1 chanyoung <park910113@gmail.com>
    93	      1 Catalysts <office@catalysts.cc>
    94	      1 Alexander Graf <agraf@suse.de>

Reviews, by authors (one review spans multiple commits)
     1	    491 Sage Weil <sweil@redhat.com>
     2	    422 Kefu Chai <kchai@redhat.com>
     3	    192 John Spray <jspray@redhat.com>
     4	    178 Jason Dillaman <dillaman@redhat.com>
     5	    162 Casey Bodley <cbodley@redhat.com>
     6	    135 Greg Farnum <gfarnum@redhat.com>
     7	    117 Samuel Just <sjust@redhat.com>
     8	    117 Mykola Golub <mgolub@mirantis.com>
     9	     93 Loic Dachary <ldachary@redhat.com>
    10	     92 Josh Durgin <jdurgin@redhat.com>
    11	     81 Orit Wasserman <owasserm@redhat.com>
    12	     67 Yehuda Sadeh <ysadehwe@redhat.com>
    13	     66 Haomai Wang <haomai@xsky.com>
    14	     62 Xie Xingguo <xie.xingguo@zte.com.cn>
    15	     56 Igor Fedotov <ifedotov@mirantis.com>
    16	     38 Nathan Cutler <ncutler@suse.com>
    17	     38 Ali Maredia <amaredia@redhat.com>
    18	     30 Abhishek Lekshmanan <abhishek@suse.com>
    19	     23 Ken Dreyer <kdreyer@redhat.com>
    20	     22 Brad Hubbard <bhubbard@redhat.com>
    21	     19 Dan Mick <dmick@redhat.com>
    22	     18 Mark Nelson <mnelson@redhat.com>
    23	     15 Boris Ranto <branto@redhat.com>
    24	     15 Alfredo Deza <adeza@redhat.com>
    25	     13 Yan, Zheng <zyan@redhat.com>
    26	     13 Patrick Donnelly <pdonnell@redhat.com>
    27	     12 Willem Jan Withagen <wjw@digiware.nl>
    28	     12 João Eduardo Luís <joao@suse.de>
    29	     11 David Zafman <dzafman@redhat.com>
    30	     10 Varada Kari <varada.kari@sandisk.com>
    31	     10 Ramesh Chander <Ramesh.Chander@sandisk.com>
    32	      8 Matt Benjamin <mbenjamin@redhat.com>
    33	      8 Allen Samuels <allen.samuels@sandisk.com>
    34	      7 Somnath Roy <somnath.roy@sandisk.com>
    35	      7 Jeff Layton <jlayton@redhat.com>
    36	      5 Ramana Raja <rraja@redhat.com>
    37	      5 Ilya Dryomov <idryomov@redhat.com>
    38	      4 Tim Serong <tserong@suse.com>
    39	      4 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    40	      3 Venky Shankar <vshankar@redhat.com>
    41	      3 Song Baisen <song.baisen@zte.com.cn>
    42	      3 John Wilkins <jwilkins@redhat.com>
    43	      3 Erwan Velu <erwan@redhat.com>
    44	      2 Yuri Weinstein <yweins@redhat.com>
    45	      2 Xiaoxi Chen <xiaoxchen@ebay.com>
    46	      2 Vikhyat Umrao <vumrao@redhat.com>
    47	      2 Ricardo Dias <rdias@suse.com>
    48	      2 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
    49	      2 Oleh Prypin <oleh@pryp.in>
    50	      2 James Page <james.page@ubuntu.com>
    51	      2 Douglas Fuller <dfuller@redhat.com>
    52	      2 David Disseldorp <ddiss@suse.de>
    53	      2 Bassam Tabbara <bassam.tabbara@quantum.com>
    54	      2 Adam C. Emerson <aemerson@redhat.com>
    55	      1 Zack Cerza <zack@redhat.com>
    56	      1 Yuri Weinstein <yuri.weinstein@gmail.com>
    57	      1 Yehuda Sadeh <yehuda@redhat.com.>
    58	      1 Yazen Ghannam <yazen.ghannam@linaro.org>
    59	      1 Yatin Kumbhare <yatinkumbhare@gmail.com>
    60	      1 Xinze Chi <xinze@xsky.com>
    61	      1 Vasu Kulkarni <vasu@redhat.com>
    62	      1 Shylesh Kumar <shmohan@redhat.com>
    63	      1 Sébastien Han <han.sebastien@gmail.com>
    64	      1 Roi Dayan <roid@mellanox.com>
    65	      1 Pritha Srivastava <prsrivas@redhat.com>
    66	      1 Petr Lautrbach <plautrba@redhat.com>
    67	      1 Owen Synge <osynge@suse.com>
    68	      1 Orit Wasserman <owassrm@redhat.com>
    69	      1 Orit wasserman <owasserm@redhat.com>
    70	      1 Noah Watkins <nwatkins@redhat.com>
    71	      1 Nick Fisk <nick@fisk.me.uk>
    72	      1 Mellanox <adirl@mellanox.com>
    73	      1 Marcel Lauhoff <lauhoff@uni-mainz.de>
    74	      1 Ma Jianpeng <jianpeng.ma@intel.com>
    75	      1 Luo Kexue <luo.kexue@zte.com.cn>
    76	      1 Kari, Varada <varada.kari@sandisk.com>
    77	      1 Javier M. Mellid <jmunhoz@igalia.com>
    78	      1 Jan Fajerski <jfajerski@suse.com>
    79	      1 Huang Jun <hjwsm1989@gmail.com>
    80	      1 François Lafont <flafdivers@free.fr>
    81	      1 Dirk Mueller <dmueller@suse.com>
    82	      1 Dan MIck <dmick@redhat.com>
    83	      1 Alexandre Derumier <aderumier@odiso.com>
    84	      1 Adir lev <adirl@mellanox.com>

Reviews, by organizations (one review spans multiple commits)
     1	   2263 Red Hat <contact@redhat.com>
     2	    177 Mirantis <contact@mirantis.com>
     3	     91 SUSE <contact@suse.com>
     4	     67 XSky <contact@xsky.com>
     5	     66 ZTE <contact@zte.com.cn>
     6	     35 SanDisk <contact@sandisk.com>
     7	     12 Digiware <contact@digiware.nl>
     8	      6 Unaffiliated <no@organization.net>
     9	      2 Yuri Weinstein <yweins@redhat.com>
    10	      2 Quantum Corporation <info@quantum.com>
    11	      2 Mellanox <contact@mellanox.com>
    12	      2 Fujitsu <contact@fujitsu.com>
    13	      2 Ebay <contact@ebay.com>
    14	      2 Canonical <contact@canonical.com>
    15	      1 Yuri Weinstein <yuri.weinstein@gmail.com>
    16	      1 Yehuda Sadeh <yehuda@redhat.com.>
    17	      1 Sébastien Han <han.sebastien@gmail.com>
    18	      1 Orit Wasserman <owassrm@redhat.com>
    19	      1 Odiso <contact@odiso.com>
    20	      1 Mellanox <adirl@mellanox.com>
    21	      1 Linaro <contact@linaro.org>
    22	      1 Kari, Varada <varada.kari@sandisk.com>
    23	      1 Johannes Gutenberg-Universität Mainz <contact@uni-mainz.de>
    24	      1 Intel <contact@intel.com>
    25	      1 Inktank <contact@inktank.com>
    26	      1 Igalia <contact@igalia.com>
    27	      1 Cloudwatt <libre.licensing@cloudwatt.com>



--8323329-1660409522-1484942318=:3654--
