From: Abhishek L <abhishek@suse.com>
Subject: v11.2.0 Kraken contributor credits
Date: Fri, 20 Jan 2017 15:00:52 +0100
Message-ID: <87wpdp25m3.fsf@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:57622 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752156AbdATOBM (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Fri, 20 Jan 2017 09:01:12 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-community@ceph.com

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi cephers,

As announced previously, a new stable version of Ceph, Kraken is out,
congratulations to everyone for making this happen!

Here is a sorted list of authors & organizations who've contributed to
Kraken(v11.2.0), by number of commits &/ reviews back to the last stable re=
lease
Jewel (v10.2.0).

The affiliations of authors to organizations can be updated by submitting a=
 patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the num=
ber
of commits. More often than not, the reviewer(s) is only mentioned in the
message of the merge although it means that all associated commits have been
reviewed. If you are curious about how it is done, do checkout the wiki ent=
ry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenan=
ce_guide

In order to get featured in lists like this one, consider contributing to c=
eph.
Every bit helps :) Developer guide at http://docs.ceph.com/docs/master/dev/=
 &
documentation guide at http://docs.ceph.com/docs/master/start/documenting-c=
eph/

Number of lines added and removed, by authors
     1	201956 Sage Weil <sweil@redhat.com>
     2	 74153 Zack Cerza <zack@redhat.com>
     3	 58021 John Spray <jspray@redhat.com>
     4	 51387 Samuel Just <sjust@redhat.com>
     5	 42814 Jason Dillaman <dillaman@redhat.com>
     6	 23498 Haomai Wang <haomai@xsky.com>
     7	 19561 Yuri Weinstein <yuriw@redhat.com>
     8	 19121 Warren Usui <wusui@redhat.com>
     9	 17913 Tamil Muthamizhan <tmuthami@redhat.com>
    10	 15542 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    11	 14924 Kefu Chai <kchai@redhat.com>
    12	 14769 Mykola Golub <mgolub@mirantis.com>
    13	 14649 Josh Durgin <jdurgin@redhat.com>
    14	 13289 Abhishek Lekshmanan <abhishek@suse.com>
    15	 12085 Tommi Virtanen <tv@inktank.com>
    16	  9059 David Zafman <dzafman@redhat.com>
    17	  8863 Ramesh Chander <Ramesh.Chander@sandisk.com>
    18	  8342 Loic Dachary <ldachary@redhat.com>
    19	  7240 Xie Xingguo <xie.xingguo@zte.com.cn>
    20	  7236 Igor Fedotov <ifedotov@mirantis.com>
    21	  7157 Greg Farnum <gfarnum@redhat.com>
    22	  6918 Yehuda Sadeh <ysadehwe@redhat.com>
    23	  6795 Yan, Zheng <zyan@redhat.com>
    24	  6376 Casey Bodley <cbodley@redhat.com>
    25	  5450 Ricardo Dias <rdias@suse.com>
    26	  4761 Sam Lang <sam.lang@inktank.com>
    27	  4667 Victor Denisov <denisovenator@gmail.com>
    28	  4568 Dan Mick <dmick@redhat.com>
    29	  4254 Michal Jarzabek <stiopa@gmail.com>
    30	  3878 Jeff Layton <jlayton@redhat.com>
    31	  3732 Joe Buck <jbbuck@gmail.com>
    32	  3622 Noah Watkins <nwatkins@redhat.com>
    33	  3505 Bassam Tabbara <bassam.tabbara@quantum.com>
    34	  3307 Nathan Cutler <ncutler@suse.com>
    35	  3306 Venky Shankar <vshankar@redhat.com>
    36	  2727 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    37	  2264 Oleh Prypin <oleh@pryp.in>
    38	  2208 Kiseleva Alyona <akiselyova@mirantis.com>
    39	  2169 Sebastien Ponce <sebastien.ponce@cern.ch>
    40	  2125 Matt Benjamin <mbenjamin@redhat.com>
    41	  2084 Willem Jan Withagen <wjw@digiware.nl>
    42	  1995 Sandon Van Ness <svanness@redhat.com>
    43	  1977 Douglas Fuller <dfuller@redhat.com>
    44	  1976 Ji Chen <insomnia@139.com>
    45	  1955 Patrick Donnelly <pdonnell@redhat.com>
    46	  1877 Ma Jianpeng <jianpeng.ma@intel.com>
    47	  1849 Patrick Donnelly <batrick@batbytes.com>
    48	  1805 Alfredo Deza <adeza@redhat.com>
    49	  1663 Caleb Miles <caleb.miles@inktank.com>
    50	  1624 Dongsheng Yang <dongsheng.yang@easystack.cn>
    51	  1568 Anirudha Bose <ani07nov@gmail.com>
    52	  1433 Ali Maredia <amaredia@redhat.com>
    53	  1270 Ramana Raja <rraja@redhat.com>
    54	  1179 Zhou Rui Song <236131368@qq.com>
    55	  1171 Orit Wasserman <owasserm@redhat.com>
    56	  1115 Frank Filz <ffilz@redhat.com>
    57	  1065 Vasu Kulkarni <vasu@redhat.com>
    58	  1054 Pritha Srivastava <prsrivas@redhat.com>
    59	   978 Daniel Gryniewicz <dang@redhat.com>
    60	   931 Michael Sevilla <mikesevilla3@gmail.com>
    61	   919 Li Tianqing <tianqing@unitedstack.com>
    62	   839 Xiaowei Chen <chen.xiaowei@h3c.com>
    63	   802 David Disseldorp <ddiss@suse.de>
    64	   784 Adam Kupczyk <akupczyk@mirantis.com>
    65	   781 Varada Kari <varada.kari@sandisk.com>
    66	   745 Adam C. Emerson <aemerson@redhat.com>
    67	   736 Gr=C3=A9gory Charot <buixor@gmail.com>
    68	   690 Piotr Da=C5=82ek <git@predictor.org.pl>
    69	   672 Roushan Ali <roushan.ali@sandisk.com>
    70	   663 Ken Dreyer <kdreyer@redhat.com>
    71	   660 Sander Pool <sander.pool@inktank.com>
    72	   654 Ilya Dryomov <idryomov@redhat.com>
    73	   649 Alexey Sheplyakov <asheplyakov@mirantis.com>
    74	   605 Javier M. Mellid <jmunhoz@igalia.com>
    75	   593 Ren Huanwen <ren.huanwen@zte.com.cn>
    76	   565 Mike Ryan <mike.ryan@inktank.com>
    77	   561 Yan Jun <yan.jun8@zte.com.cn>
    78	   554 Andrew Schoen <aschoen@redhat.com>
    79	   552 Robin H. Johnson <robin.johnson@dreamhost.com>
    80	   495 Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
    81	   485 Avner BenHanoch <avnerb@mellanox.com>
    82	   473 Manali Kulkarni <Manali.Kulkarni@sandisk.com>
    83	   460 J. Eric Ivancich <ivancich@redhat.com>
    84	   457 Zhao Junwang <zhjwpku@gmail.com>
    85	   423 Zhi Zhang <willzzhang@tencent.com>
    86	   423 Hector Martin <marcan@marcan.st>
    87	   411 Iain Buclaw <iain.buclaw@sociomantic.com>
    88	   409 Mark Nelson <mnelson@redhat.com>
    89	   408 Brad Hubbard <bhubbard@redhat.com>
    90	   382 Pan Liu <pan.liu@istuary.com>
    91	   379 Zhiqiang Wang <zhiqiang@xsky.com>
    92	   373 Song Baisen <song.baisen@zte.com.cn>
    93	   370 Daniel Gollub <d.gollub@telekom.de>
    94	   365 Ryne Li <lizhenqiangsnake@gmail.com>
    95	   358 John Coyle <dx9err@gmail.com>
    96	   354 Pete Zaitcev <zaitcev@redhat.com>
    97	   345 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    98	   326 Ivo Jimenez <ivo.jimenez@gmail.com>
    99	   324 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
   100	   292 Vishal Kanaujia <Vishal.Kanaujia@sandisk.com>
   101	   288 Mehdi Abaakouk <sileht@redhat.com>
   102	   280 Boris Ranto <branto@redhat.com>
   103	   243 Vu Pham <vu@mellanox.com>
   104	   239 Wei Jin <jinwei15@wanda.cn>
   105	   227 Allen Samuels <allen.samuels@sandisk.com>
   106	   217 Karol Mroz <kmroz@suse.com>
   107	   217 Jiaying Ren <mikulely@gmail.com>
   108	   215 Vaibhav Bhembre <vaibhav@digitalocean.com>
   109	   212 Vikhyat Umrao <vumrao@redhat.com>
   110	   204 Mingxin Liu <mingxin@xsky.com>
   111	   201 Tim Serong <tserong@suse.com>
   112	   182 Chendi Xue <chendi.xue@intel.com>
   113	   174 Tomy Cheru <tomy.cheru@sandisk.com>
   114	   174 Haodong Tang <haodong.tang@intel.com>
   115	   174 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
   116	   172 Wido den Hollander <wido@42on.com>
   117	   163 Xiaoxi Chen <xiaoxchen@ebay.com>
   118	   160 Shehbaz Jaffer <shehbaz.jaffer@mail.utoronto.ca>
   119	   154 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
   120	   154 Luo Runbing <runsisi@zte.com.cn>
   121	   152 Yann Dupont <yann@objoo.org>
   122	   151 Jianjian Huo <jianjian.huo@ssi.samsung.com>
   123	   137 Somnath Roy <somnath.roy@sandisk.com>
   124	   134 Li Peng <lip@dtdream.com>
   125	   133 Bart=C5=82omiej =C5=9Awi=C4=99cki <bartlomiej.swiecki@corp.ov=
h.com>
   126	   123 Shylesh Kumar <shmohan@redhat.com>
   127	   116 Lu Shi <shi.lu@h3c.com>
   128	   114 Ning Yao <yaoning@unitedstack.com>
   129	   105 Fran=C3=A7ois Lafont <flafdivers@free.fr>
   130	    89 Wanlong Gao <wanlong.gao@easystack.cn>
   131	    86 Li Wang <li.wang@kylin-cloud.com>
   132	    84 Roi Dayan <roid@mellanox.com>
   133	    83 You Ji <youji@ebay.com>
   134	    81 Eleanor Cawthon <eleanor.cawthon@inktank.com>
   135	    81 Chris Lee <chris.lee@dreamhost.com>
   136	    80 David Galloway <dgallowa@redhat.com>
   137	    80 Adir Lev <adirl@mellanox.com>
   138	    77 Alex Elder <elder@inktank.com>
   139	    76 Luo Runbing <runsisi@hust.edu.cn>
   140	    74 Mark Kampe <mark.kampe@dreamhost.com>
   141	    68 Mike Christie <mchristi@redhat.com>
   142	    68 Gregory Meno <gmeno@redhat.com>
   143	    64 Zengran Zhang <zhangzengran@h3c.com>
   144	    62 Roland Mechler <rmechler@cisco.com>
   145	    62 Christophe Courtaut <christophe.courtaut@gmail.com>
   146	    59 Ramakrishnan Periyasamy <rperiyas@redhat.com>
   147	    58 Weibing Zhang <zhangweibing@unitedstack.com>
   148	    58 Colin Walters <walters@redhat.com>
   149	    57 Shotaro Kawaguchi <kawaguchi.s@jp.fujitsu.com>
   150	    54 Ilsoo Byun <ilsoo.byun@sk.com>
   151	    53 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
   152	    50 Chang Liu <liuchang0812@gmail.com>
   153	    49 Jon Bernard <jbernard@tuxion.com>
   154	    49 Guang Yang <yguang@yahoo-inc.com>
   155	    48 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
   156	    48 Jesse Williamson <jesse.williamson@suse.com>
   157	    46 Harald Klein <hari@vt100.at>
   158	    44 Owen Synge <osynge@suse.com>
   159	    43 Xinze Chi <xinze@xsky.com>
   160	    42 Zhang Zezhu <zhang.zezhu@zte.com.cn>
   161	    40 Jenkins <jenkins@ceph.com>
   162	    40 Erwan Velu <erwan@redhat.com>
   163	    39 Peter Maloney <peter.maloney@yahoo.ca>
   164	    38 Marcus Watts <mwatts@redhat.com>
   165	    37 S=C3=A9bastien Han <shan@redhat.com>
   166	    37 Pawe=C5=82 Sadowski <pawel.sadowski@corp.ovh.com>
   167	    37 Jayashree Candadai <jayaajay@indiana.edu>
   168	    37 Jan Fajerski <jfajerski@suse.com>
   169	    34 Uday Mullangi <udaymjl@gmail.com>
   170	    34 Leo Zhang <nguzcf@gmail.com>
   171	    33 Yang Honggang <joseph.yang@xtaotech.com>
   172	    32 Yongqiang He <he.yongqiang@h3c.com>
   173	    29 Steven Dieffenbach <sdieffen@redhat.com>
   174	    28 Xianxia Xiao <xianxia.xiao@kylin-cloud.com>
   175	    28 Chengwei Yang <yangchengwei@qiyi.com>
   176	    26 Yuan Zhou <yuan.zhou@intel.com>
   177	    26 wangsongbo <wangsongbo@unitedstack.com>
   178	    25 Tao Chang <changtao@hihuron.com>
   179	    24 Vladislav Odintsov <odivlad@gmail.com>
   180	    24 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
   181	    23 Etienne Menguy <etienne.menguy@corp.ovh.com>
   182	    22 Shu, Xinxin <xinxin.shu@intel.com>
   183	    22 Shinobu Kinjo <shinobu@redhat.com>
   184	    22 Hans van den Bogert <hansbogert@gmail.com>
   185	    22 Dan Hor=C3=A1k <dan@danny.cz>
   186	    22 Chang-Yi Lee <cy.l@inwinstack.com>
   187	    20 Luo Kexue <luo.kexue@zte.com.cn>
   188	    19 Min Chen <chenmin@xsky.com>
   189	    19 Michel Normand <normand@linux.vnet.ibm.com>
   190	    19 Alexander Graf <agraf@suse.de>
   191	    17 Jie Li <li.jieA@h3c.com>
   192	    16 Jim Wright <jim@quadraturecapital.com>
   193	    16 Javeme <javaloveme@gmail.com>
   194	    15 Igor Podoski <igor.podoski@ts.fujitsu.com>
   195	    15 Dong Wu <archer.wudong@gmail.com>
   196	    14 Weijun Duan <duanweijun@h3c.com>
   197	    14 MinSheng Lin <minsheng.l@inwinstack.com>
   198	    14 Huang Jun <hjwsm1989@gmail.com>
   199	    14 Gong Chuang <gong.chuang@zte.com.cn>
   200	    14 Desmond Shih <desmond.s@inwinstack.com>
   201	    13 Huan Zhang <zhanghuan@chinac.com>
   202	    13 Alexandre Derumier <aderumier@odiso.com>
   203	    12 Wenjun Huang <wenjunhuang@tencent.com>
   204	    12 Stephon Striplin <stephon.striplin@dreamhost.com>
   205	    12 Lan De <lan.de3@zte.com.cn>
   206	    12 Dan van der Ster <daniel.vanderster@cern.ch>
   207	    12 Bryan Stillwell <bryan.stillwell@twcable.com>
   208	    11 Zhang Shaowen <zhang_shaowen@139.com>
   209	    11 Jie Wang <jie.wang@kylin-cloud.com>
   210	    10 Vicente Cheng <freeze.bilsted@gmail.com>
   211	    10 Mingxin Liu <mingxin.liu@kylin-cloud.com>
   212	    10 Brett Niver <bniver@redhat.com>
   213	    10 Abhishek Varshney <abhishek.varshney@flipkart.com>
   214	     9 Xuan Liu <liu.xuan@h3c.com>
   215	     9 Thomas Serlin <tserlin@redhat.com>
   216	     9 Na Xie <xie.na@h3c.com>
   217	     9 Jaemyoun Lee <jaemyoun@gmail.com>
   218	     9 Ira Cooper <ira@redhat.com>
   219	     9 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
   220	     8 Zhuang Xiaochun <zhuangxc89@163.com>
   221	     8 Zhenyu Leng <lengzhenyu@ict.ac.cn>
   222	     8 Yatin Kumbhare <yatinkumbhare@gmail.com>
   223	     8 Mark Korenberg <socketpair@gmail.com>
   224	     8 Feng Guo <diluga@gmail.com>
   225	     8 Armando Segnini <armaseg@gmail.com>
   226	     7 Proskurin Kirill <kproskurin@mirantis.com>
   227	     7 Joe Buck <joe.buck@inktank.com>
   228	     7 Ignacio Bravo <ibravo@hotmail.com>
   229	     7 Guo Zhandong <guozhandong@cmss.chinamobile.com>
   230	     6 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
   231	     6 Xinxin Shu <shuxinxin@chinac.com>
   232	     6 Sirisha Guduru <SGuduru@walmartlabs.com>
   233	     6 Shilpa Jagannath <smanjara@redhat.com>
   234	     6 Marov Aleksey <Marov.A@raidix.com>
   235	     6 Ker Liu <ker.liu@alcatel-lucent.com>
   236	     6 Jianjian huo <jianjian.huo@ssi.samsung.com>
   237	     6 Colin P. McCabe <colinm@hq.newdream.net>
   238	     5 Tianshan Qu <tianshan@xsky.com>
   239	     5 Hong Zhangoole <hong.zhangoole@gmail.com>
   240	     5 Diwakar Goel <diwakargoel@gmail.com>
   241	     5 Albert Tu <albert.t@inwinstack.com>
   242	     4 Zhao Kun <jswps2011@163.com>
   243	     4 Zhao Chao <zhaochao1984@gmail.com>
   244	     4 Wu Xingyi <wuxingyi@letv.com>
   245	     4 Patrick McGarry <pmcgarry@redhat.com>
   246	     4 Ira Cooper <ira@samba.org>
   247	     4 Feng Yu <amoxic@126.com>
   248	     4 Chanyoung Park <park910113@gmail.com>
   249	     3 Nick Fisk <nick@fisk.me.uk>
   250	     3 Liu Yang <yippeetry@gmail.com>
   251	     3 Kapil Sharma <ksharma@suse.com>
   252	     3 Jelle vd Kooij <vdkooij.jelle@gmail.com>
   253	     2 Yibo Cai <yibo.cai@linaro.org>
   254	     2 Xu Biao <xubiao.codeyz@gmail.com>
   255	     2 shiqi <m13913886148@gmail.com>
   256	     2 Sam Zaydel <szaydel@gmail.com>
   257	     2 Ruben Kerkhof <ruben@rubenkerkhof.com>
   258	     2 Qinghua Jin <qhjin_dev@163.com>
   259	     2 Qiankun Zheng <zheng.qiankun@h3c.com>
   260	     2 Nitin A Kamble <Nitin.Kamble@Teradata.com>
   261	     2 Mike Hackett <mhackett@redhat.com>
   262	     2 Marc Koderer <marc@koderer.com>
   263	     2 Malte Fiala <maltefiala@produktion.io>
   264	     2 Linfei Hou <hou.linfei@h3c.com>
   265	     2 John Wilkins <jwilkins@redhat.com>
   266	     2 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
   267	     2 James Page <james.page@ubuntu.com>
   268	     2 James Liu <james.liu@ssi.samsung.com>
   269	     2 Charles Alva <charlesalva@gmail.com>
   270	     2 Billy Olsen <billy.olsen@canonical.com>
   271	     2 Barbora An=C4=8Dincov=C3=A1 <bara@redhat.com>
   272	     1 Gui Hecheng <guihecheng@cmss.chinamobile.com>
   273	     1 Daniel Oliveira <doliveira@suse.com>

Number of lines added and removed, by organization
     1 	617883 Red Hat <contact@redhat.com>
     2 	 45862 Mirantis <contact@mirantis.com>
     3 	 25504 SUSE <contact@suse.com>
     4 	 24148 XSky <contact@xsky.com>
     5 	 16399 Unaffiliated <no@organization.net>
     6 	 11643 SanDisk <contact@sandisk.com>
     7 	  9333 ZTE <contact@zte.com.cn>
     8 	  3732 University of California, Santa Cruz <contact@cs.ucsc.edu>
     9 	  3505 Quantum Corporation <info@quantum.com>
    10 	  2306 Intel <contact@intel.com>
    11 	  2181 CERN <contact@cern.ch>
    12 	  2084 Digiware <contact@digiware.nl>
    13 	  1980 LETV <contact@letv.com>
    14 	  1713 Easystack <contact@easystack.cn>
    15 	  1258 H3C <contact@h3c.com>
    16 	  1117 UnitedStack <contact@unitedstack.com>
    17 	   892 Mellanox <contact@mellanox.com>
    18 	   853 Cloudwatt <libre.licensing@cloudwatt.com>
    19 	   766 DreamHost <contact@dreamhost.com>
    20 	   605 Igalia <contact@igalia.com>
    21 	   544 Deutsche Telekom <contact@telekom.de>
    22 	   501 Walmart Labs <contact@walmartlabs.com>
    23 	   485 Tencent <contact@tencent.com>
    24 	   417 Fujitsu <contact@fujitsu.com>
    25 	   411 Sociomantic Labs <info@sociomantic.com>
    26 	   382 Istuary Innovation Group <contact@istuary.com>
    27 	   246 Ebay <contact@ebay.com>
    28 	   239 Wanda ffan <contact@wanda.cn>
    29 	   215 DigitalOcean <contact@digitalocean.com>
    30 	   193 OVH <contact@corp.ovh.com>
    31 	   183 Kylin Cloud <contact@kylin-cloud.com>
    32 	   172 Wido 42on <contact@42on.com>
    33 	   160 University of Toronto <contact@mail.utoronto.ca>
    34 	   159 Samsung <contact@samsung.com>
    35 	   134 Dtdream <contact@dtdream.com>
    36 	    76 Huazhong University of Science and Technology <contact@hust.=
edu.cn>
    37 	    62 CISCO <contact@cisco.com>
    38 	    55 inwinSTACK inc. <leo.l@inwinstack.com>
    39 	    54 SK Telecom <rnd@sktelecom.com>
    40 	    49 Yahoo! <contact@yahoo-inc.com>
    41 	    37 Indiana University <contact@indiana.edu>
    42 	    28 iQIYI <edison@qiyi.com>
    43 	    25 Hihuron <contact@huron.com>
    44 	    19 IBM <contact@IBM.com>
    45 	    19 Chinac <info@chinac.com>
    46 	    16 Quadrature Capital Limited <info@quadraturecapital.com>
    47 	    16 China Mobile <contact@chinamobile.com>
    48 	    13 Odiso <contact@odiso.com>
    49 	    12 Time Warner Cable Inc. <contact@twcable.com>
    50 	    10 Flipkart <contact@flipkart.com>
    51 	     9 Catalysts <office@catalysts.cc>
    52 	     8 ICT <contact@ict.ac.cn>
    53 	     6 Raidix International <contact@raidix.com>
    54 	     6 Alcatel Lucent <contact@alcatel-lucent.com>
    55 	     4 Canonical <contact@canonical.com>
    56 	     2 Teradata <contact@teradata.com>
    57 	     2 SAP <contact@sap.com>
    58 	     2 Linaro <contact@linaro.org>
    59 	     2 Enproduktion GmbH <contact@produktion.io>

Commits, by authors
     1	   2177 Sage Weil <sweil@redhat.com>
     2	    620 Zack Cerza <zack@redhat.com>
     3	    555 Xie Xingguo <xie.xingguo@zte.com.cn>
     4	    554 John Spray <jspray@redhat.com>
     5	    458 Josh Durgin <jdurgin@redhat.com>
     6	    443 Kefu Chai <kchai@redhat.com>
     7	    377 Jason Dillaman <dillaman@redhat.com>
     8	    277 Samuel Just <sjust@redhat.com>
     9	    262 Yuri Weinstein <yuriw@redhat.com>
    10	    243 Loic Dachary <ldachary@redhat.com>
    11	    227 Greg Farnum <gfarnum@redhat.com>
    12	    211 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    13	    192 Yehuda Sadeh <ysadehwe@redhat.com>
    14	    189 Michal Jarzabek <stiopa@gmail.com>
    15	    177 Casey Bodley <cbodley@redhat.com>
    16	    170 David Zafman <dzafman@redhat.com>
    17	    169 Haomai Wang <haomai@xsky.com>
    18	    157 Tamil Muthamizhan <tmuthami@redhat.com>
    19	    151 Yan, Zheng <zyan@redhat.com>
    20	    140 Tommi Virtanen <tv@inktank.com>
    21	    120 Igor Fedotov <ifedotov@mirantis.com>
    22	    115 Jeff Layton <jlayton@redhat.com>
    23	    115 Alfredo Deza <adeza@redhat.com>
    24	    113 Mykola Golub <mgolub@mirantis.com>
    25	    111 Yann Dupont <yann@objoo.org>
    26	    106 Nathan Cutler <ncutler@suse.com>
    27	    103 Willem Jan Withagen <wjw@digiware.nl>
    28	    103 Warren Usui <wusui@redhat.com>
    29	     99 Sandon Van Ness <svanness@redhat.com>
    30	     88 Dan Mick <dmick@redhat.com>
    31	     86 Sam Lang <sam.lang@inktank.com>
    32	     72 Patrick Donnelly <pdonnell@redhat.com>
    33	     65 Ma Jianpeng <jianpeng.ma@intel.com>
    34	     64 Yan Jun <yan.jun8@zte.com.cn>
    35	     60 Ren Huanwen <ren.huanwen@zte.com.cn>
    36	     57 Joe Buck <jbbuck@gmail.com>
    37	     55 Matt Benjamin <mbenjamin@redhat.com>
    38	     52 Orit Wasserman <owasserm@redhat.com>
    39	     43 Dongsheng Yang <dongsheng.yang@easystack.cn>
    40	     43 Abhishek Lekshmanan <abhishek@suse.com>
    41	     41 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    42	     39 Ilya Dryomov <idryomov@redhat.com>
    43	     37 Ricardo Dias <rdias@suse.com>
    44	     36 Anirudha Bose <ani07nov@gmail.com>
    45	     35 Brad Hubbard <bhubbard@redhat.com>
    46	     32 Vasu Kulkarni <vasu@redhat.com>
    47	     32 Ramesh Chander <Ramesh.Chander@sandisk.com>
    48	     31 Venky Shankar <vshankar@redhat.com>
    49	     31 Adam C. Emerson <aemerson@redhat.com>
    50	     30 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
    51	     30 Song Baisen <song.baisen@zte.com.cn>
    52	     30 Ken Dreyer <kdreyer@redhat.com>
    53	     29 Ramana Raja <rraja@redhat.com>
    54	     29 Oleh Prypin <oleh@pryp.in>
    55	     26 Ali Maredia <amaredia@redhat.com>
    56	     25 Li Wang <li.wang@kylin-cloud.com>
    57	     25 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    58	     25 Bassam Tabbara <bassam.tabbara@quantum.com>
    59	     24 Luo Runbing <runsisi@zte.com.cn>
    60	     23 Robin H. Johnson <robin.johnson@dreamhost.com>
    61	     21 John Coyle <dx9err@gmail.com>
    62	     21 Andrew Schoen <aschoen@redhat.com>
    63	     20 Adam Kupczyk <akupczyk@mirantis.com>
    64	     19 Xiaowei Chen <chen.xiaowei@h3c.com>
    65	     19 Piotr Da=C5=82ek <git@predictor.org.pl>
    66	     18 Pan Liu <pan.liu@istuary.com>
    67	     17 Mark Nelson <mnelson@redhat.com>
    68	     16 Li Peng <lip@dtdream.com>
    69	     15 Sebastien Ponce <sebastien.ponce@cern.ch>
    70	     15 Avner BenHanoch <avnerb@mellanox.com>
    71	     14 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
    72	     14 Victor Denisov <denisovenator@gmail.com>
    73	     14 Tim Serong <tserong@suse.com>
    74	     14 Patrick Donnelly <batrick@batbytes.com>
    75	     14 David Disseldorp <ddiss@suse.de>
    76	     14 Daniel Gryniewicz <dang@redhat.com>
    77	     14 Boris Ranto <branto@redhat.com>
    78	     12 Vikhyat Umrao <vumrao@redhat.com>
    79	     12 Kiseleva Alyona <akiselyova@mirantis.com>
    80	     12 Haodong Tang <haodong.tang@intel.com>
    81	     12 Caleb Miles <caleb.miles@inktank.com>
    82	     11 Zhi Zhang <willzzhang@tencent.com>
    83	     11 Xianxia Xiao <xianxia.xiao@kylin-cloud.com>
    84	     11 Wei Jin <jinwei15@wanda.cn>
    85	     11 Weibing Zhang <zhangweibing@unitedstack.com>
    86	     11 Varada Kari <varada.kari@sandisk.com>
    87	     11 Noah Watkins <nwatkins@redhat.com>
    88	     11 Karol Mroz <kmroz@suse.com>
    89	     11 Douglas Fuller <dfuller@redhat.com>
    90	     10 Zhao Junwang <zhjwpku@gmail.com>
    91	     10 Xiaoxi Chen <xiaoxchen@ebay.com>
    92	     10 Wido den Hollander <wido@42on.com>
    93	     10 Jianjian Huo <jianjian.huo@ssi.samsung.com>
    94	      9 Chengwei Yang <yangchengwei@qiyi.com>
    95	      9 Alex Elder <elder@inktank.com>
    96	      8 Roi Dayan <roid@mellanox.com>
    97	      8 Pritha Srivastava <prsrivas@redhat.com>
    98	      8 Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
    99	      8 Owen Synge <osynge@suse.com>
   100	      8 Manali Kulkarni <Manali.Kulkarni@sandisk.com>
   101	      8 Javier M. Mellid <jmunhoz@igalia.com>
   102	      8 Iain Buclaw <iain.buclaw@sociomantic.com>
   103	      7 Zhang Zezhu <zhang.zezhu@zte.com.cn>
   104	      7 Leo Zhang <nguzcf@gmail.com>
   105	      7 Jiaying Ren <mikulely@gmail.com>
   106	      7 J. Eric Ivancich <ivancich@redhat.com>
   107	      7 Gregory Meno <gmeno@redhat.com>
   108	      6 Xinze Chi <xinze@xsky.com>
   109	      6 Wanlong Gao <wanlong.gao@easystack.cn>
   110	      6 Uday Mullangi <udaymjl@gmail.com>
   111	      6 Ryne Li <lizhenqiangsnake@gmail.com>
   112	      6 Mike Ryan <mike.ryan@inktank.com>
   113	      6 Hector Martin <marcan@marcan.st>
   114	      6 Adir Lev <adirl@mellanox.com>
   115	      5 Ning Yao <yaoning@unitedstack.com>
   116	      5 Jenkins <jenkins@ceph.com>
   117	      5 Huang Jun <hjwsm1989@gmail.com>
   118	      4 Zengran Zhang <zhangzengran@h3c.com>
   119	      4 Vu Pham <vu@mellanox.com>
   120	      4 Vishal Kanaujia <Vishal.Kanaujia@sandisk.com>
   121	      4 Somnath Roy <somnath.roy@sandisk.com>
   122	      4 Shinobu Kinjo <shinobu@redhat.com>
   123	      4 Sander Pool <sander.pool@inktank.com>
   124	      4 Michael Sevilla <mikesevilla3@gmail.com>
   125	      4 Marcus Watts <mwatts@redhat.com>
   126	      4 Luo Runbing <runsisi@hust.edu.cn>
   127	      4 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
   128	      4 Frank Filz <ffilz@redhat.com>
   129	      4 Daniel Gollub <d.gollub@telekom.de>
   130	      4 Chendi Xue <chendi.xue@intel.com>
   131	      4 Chang Liu <liuchang0812@gmail.com>
   132	      4 Alexandre Derumier <aderumier@odiso.com>
   133	      3 Zhou Rui Song <236131368@qq.com>
   134	      3 Zhiqiang Wang <zhiqiang@xsky.com>
   135	      3 Yuan Zhou <yuan.zhou@intel.com>
   136	      3 Yatin Kumbhare <yatinkumbhare@gmail.com>
   137	      3 wangsongbo <wangsongbo@unitedstack.com>
   138	      3 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
   139	      3 Pete Zaitcev <zaitcev@redhat.com>
   140	      3 Na Xie <xie.na@h3c.com>
   141	      3 Mingxin Liu <mingxin@xsky.com>
   142	      3 Michel Normand <normand@linux.vnet.ibm.com>
   143	      3 Luo Kexue <luo.kexue@zte.com.cn>
   144	      3 Jie Wang <jie.wang@kylin-cloud.com>
   145	      3 Javeme <javaloveme@gmail.com>
   146	      3 Ivo Jimenez <ivo.jimenez@gmail.com>
   147	      3 Erwan Velu <erwan@redhat.com>
   148	      3 David Galloway <dgallowa@redhat.com>
   149	      3 Dan van der Ster <daniel.vanderster@cern.ch>
   150	      3 Bart=C5=82omiej =C5=9Awi=C4=99cki <bartlomiej.swiecki@corp.o=
vh.com>
   151	      3 Allen Samuels <allen.samuels@sandisk.com>
   152	      3 Alexey Sheplyakov <asheplyakov@mirantis.com>
   153	      2 Zhenyu Leng <lengzhenyu@ict.ac.cn>
   154	      2 Zhao Kun <jswps2011@163.com>
   155	      2 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
   156	      2 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
   157	      2 You Ji <youji@ebay.com>
   158	      2 Yongqiang He <he.yongqiang@h3c.com>
   159	      2 Xinxin Shu <shuxinxin@chinac.com>
   160	      2 Weijun Duan <duanweijun@h3c.com>
   161	      2 Vladislav Odintsov <odivlad@gmail.com>
   162	      2 Vicente Cheng <freeze.bilsted@gmail.com>
   163	      2 Tomy Cheru <tomy.cheru@sandisk.com>
   164	      2 Tianshan Qu <tianshan@xsky.com>
   165	      2 Tao Chang <changtao@hihuron.com>
   166	      2 Sirisha Guduru <SGuduru@walmartlabs.com>
   167	      2 Shylesh Kumar <shmohan@redhat.com>
   168	      2 Shilpa Jagannath <smanjara@redhat.com>
   169	      2 S=C3=A9bastien Han <shan@redhat.com>
   170	      2 Roushan Ali <roushan.ali@sandisk.com>
   171	      2 Patrick McGarry <pmcgarry@redhat.com>
   172	      2 Mehdi Abaakouk <sileht@redhat.com>
   173	      2 Li Tianqing <tianqing@unitedstack.com>
   174	      2 Joe Buck <joe.buck@inktank.com>
   175	      2 Ignacio Bravo <ibravo@hotmail.com>
   176	      2 Huan Zhang <zhanghuan@chinac.com>
   177	      2 Hong Zhangoole <hong.zhangoole@gmail.com>
   178	      2 Guang Yang <yguang@yahoo-inc.com>
   179	      2 Gong Chuang <gong.chuang@zte.com.cn>
   180	      2 Fran=C3=A7ois Lafont <flafdivers@free.fr>
   181	      2 Feng Yu <amoxic@126.com>
   182	      2 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
   183	      2 Etienne Menguy <etienne.menguy@corp.ovh.com>
   184	      2 Dan Hor=C3=A1k <dan@danny.cz>
   185	      2 Christophe Courtaut <christophe.courtaut@gmail.com>
   186	      2 Chang-Yi Lee <cy.l@inwinstack.com>
   187	      2 Albert Tu <albert.t@inwinstack.com>
   188	      2 Abhishek Varshney <abhishek.varshney@flipkart.com>
   189	      1 Zhuang Xiaochun <zhuangxc89@163.com>
   190	      1 Zhao Chao <zhaochao1984@gmail.com>
   191	      1 Zhang Shaowen <zhang_shaowen@139.com>
   192	      1 Yibo Cai <yibo.cai@linaro.org>
   193	      1 Yang Honggang <joseph.yang@xtaotech.com>
   194	      1 Xu Biao <xubiao.codeyz@gmail.com>
   195	      1 Xuan Liu <liu.xuan@h3c.com>
   196	      1 Wu Xingyi <wuxingyi@letv.com>
   197	      1 Wenjun Huang <wenjunhuang@tencent.com>
   198	      1 Vaibhav Bhembre <vaibhav@digitalocean.com>
   199	      1 Thomas Serlin <tserlin@redhat.com>
   200	      1 Steven Dieffenbach <sdieffen@redhat.com>
   201	      1 Stephon Striplin <stephon.striplin@dreamhost.com>
   202	      1 Shu, Xinxin <xinxin.shu@intel.com>
   203	      1 Shotaro Kawaguchi <kawaguchi.s@jp.fujitsu.com>
   204	      1 shiqi <m13913886148@gmail.com>
   205	      1 Shehbaz Jaffer <shehbaz.jaffer@mail.utoronto.ca>
   206	      1 Sam Zaydel <szaydel@gmail.com>
   207	      1 Ruben Kerkhof <ruben@rubenkerkhof.com>
   208	      1 Roland Mechler <rmechler@cisco.com>
   209	      1 Ramakrishnan Periyasamy <rperiyas@redhat.com>
   210	      1 Qinghua Jin <qhjin_dev@163.com>
   211	      1 Qiankun Zheng <zheng.qiankun@h3c.com>
   212	      1 Proskurin Kirill <kproskurin@mirantis.com>
   213	      1 Peter Maloney <peter.maloney@yahoo.ca>
   214	      1 Pawe=C5=82 Sadowski <pawel.sadowski@corp.ovh.com>
   215	      1 Nitin A Kamble <Nitin.Kamble@Teradata.com>
   216	      1 Nick Fisk <nick@fisk.me.uk>
   217	      1 MinSheng Lin <minsheng.l@inwinstack.com>
   218	      1 Mingxin Liu <mingxin.liu@kylin-cloud.com>
   219	      1 Min Chen <chenmin@xsky.com>
   220	      1 Mike Hackett <mhackett@redhat.com>
   221	      1 Mike Christie <mchristi@redhat.com>
   222	      1 Marov Aleksey <Marov.A@raidix.com>
   223	      1 Mark Korenberg <socketpair@gmail.com>
   224	      1 Mark Kampe <mark.kampe@dreamhost.com>
   225	      1 Marc Koderer <marc@koderer.com>
   226	      1 Malte Fiala <maltefiala@produktion.io>
   227	      1 Lu Shi <shi.lu@h3c.com>
   228	      1 Liu Yang <yippeetry@gmail.com>
   229	      1 Linfei Hou <hou.linfei@h3c.com>
   230	      1 Lan De <lan.de3@zte.com.cn>
   231	      1 Ker Liu <ker.liu@alcatel-lucent.com>
   232	      1 Kapil Sharma <ksharma@suse.com>
   233	      1 Jon Bernard <jbernard@tuxion.com>
   234	      1 John Wilkins <jwilkins@redhat.com>
   235	      1 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
   236	      1 Jim Wright <jim@quadraturecapital.com>
   237	      1 Jie Li <li.jieA@h3c.com>
   238	      1 Ji Chen <insomnia@139.com>
   239	      1 Jianjian huo <jianjian.huo@ssi.samsung.com>
   240	      1 Jesse Williamson <jesse.williamson@suse.com>
   241	      1 Jelle vd Kooij <vdkooij.jelle@gmail.com>
   242	      1 Jayashree Candadai <jayaajay@indiana.edu>
   243	      1 Jan Fajerski <jfajerski@suse.com>
   244	      1 James Page <james.page@ubuntu.com>
   245	      1 James Liu <james.liu@ssi.samsung.com>
   246	      1 Jaemyoun Lee <jaemyoun@gmail.com>
   247	      1 Ira Cooper <ira@samba.org>
   248	      1 Ira Cooper <ira@redhat.com>
   249	      1 Ilsoo Byun <ilsoo.byun@sk.com>
   250	      1 Igor Podoski <igor.podoski@ts.fujitsu.com>
   251	      1 Harald Klein <hari@vt100.at>
   252	      1 Hans van den Bogert <hansbogert@gmail.com>
   253	      1 Guo Zhandong <guozhandong@cmss.chinamobile.com>
   254	      1 Gui Hecheng <guihecheng@cmss.chinamobile.com>
   255	      1 Gr=C3=A9gory Charot <buixor@gmail.com>
   256	      1 Feng Guo <diluga@gmail.com>
   257	      1 Eleanor Cawthon <eleanor.cawthon@inktank.com>
   258	      1 Dong Wu <archer.wudong@gmail.com>
   259	      1 Diwakar Goel <diwakargoel@gmail.com>
   260	      1 Desmond Shih <desmond.s@inwinstack.com>
   261	      1 Daniel Oliveira <doliveira@suse.com>
   262	      1 Colin Walters <walters@redhat.com>
   263	      1 Colin P. McCabe <colinm@hq.newdream.net>
   264	      1 Chris Lee <chris.lee@dreamhost.com>
   265	      1 Charles Alva <charlesalva@gmail.com>
   266	      1 Chanyoung Park <park910113@gmail.com>
   267	      1 Bryan Stillwell <bryan.stillwell@twcable.com>
   268	      1 Brett Niver <bniver@redhat.com>
   269	      1 Billy Olsen <billy.olsen@canonical.com>
   270	      1 Barbora An=C4=8Dincov=C3=A1 <bara@redhat.com>
   271	      1 Armando Segnini <armaseg@gmail.com>
   272	      1 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
   273	      1 Alexander Graf <agraf@suse.de>

Commits, by organizations
     1 	   7852 Red Hat <contact@redhat.com>
     2 	    776 ZTE <contact@zte.com.cn>
     3 	    527 Unaffiliated <no@organization.net>
     4 	    494 Mirantis <contact@mirantis.com>
     5 	    262 SUSE <contact@suse.com>
     6 	    184 XSky <contact@xsky.com>
     7 	    103 Digiware <contact@digiware.nl>
     8 	     89 Intel <contact@intel.com>
     9 	     68 SanDisk <contact@sandisk.com>
    10 	     57 University of California, Santa Cruz <contact@cs.ucsc.edu>
    11 	     54 Kylin Cloud <contact@kylin-cloud.com>
    12 	     49 Easystack <contact@easystack.cn>
    13 	     37 H3C <contact@h3c.com>
    14 	     33 Mellanox <contact@mellanox.com>
    15 	     30 DreamHost <contact@dreamhost.com>
    16 	     29 Deutsche Telekom <contact@telekom.de>
    17 	     26 Cloudwatt <libre.licensing@cloudwatt.com>
    18 	     25 Quantum Corporation <info@quantum.com>
    19 	     21 UnitedStack <contact@unitedstack.com>
    20 	     18 Istuary Innovation Group <contact@istuary.com>
    21 	     18 CERN <contact@cern.ch>
    22 	     16 Dtdream <contact@dtdream.com>
    23 	     16 Tencent <contact@tencent.com>
    24 	     12 Samsung <contact@samsung.com>
    25 	     12 Ebay <contact@ebay.com>
    26 	     11 Wanda ffan <contact@wanda.cn>
    27 	     10 Wido 42on <contact@42on.com>
    28 	     10 Walmart Labs <contact@walmartlabs.com>
    29 	      9 iQIYI <edison@qiyi.com>
    30 	      8 Sociomantic Labs <info@sociomantic.com>
    31 	      8 Igalia <contact@igalia.com>
    32 	      6 OVH <contact@corp.ovh.com>
    33 	      6 inwinSTACK inc. <leo.l@inwinstack.com>
    34 	      5 Fujitsu <contact@fujitsu.com>
    35 	      5 China Mobile <contact@chinamobile.com>
    36 	      4 Odiso <contact@odiso.com>
    37 	      4 Huazhong University of Science and Technology <contact@hust=
.edu.cn>
    38 	      4 Chinac <info@chinac.com>
    39 	      3 IBM <contact@IBM.com>
    40 	      2 Yahoo! <contact@yahoo-inc.com>
    41 	      2 LETV <contact@letv.com>
    42 	      2 ICT <contact@ict.ac.cn>
    43 	      2 Hihuron <contact@huron.com>
    44 	      2 Flipkart <contact@flipkart.com>
    45 	      2 Canonical <contact@canonical.com>
    46 	      1 University of Toronto <contact@mail.utoronto.ca>
    47 	      1 Time Warner Cable Inc. <contact@twcable.com>
    48 	      1 Teradata <contact@teradata.com>
    49 	      1 SK Telecom <rnd@sktelecom.com>
    50 	      1 SAP <contact@sap.com>
    51 	      1 Raidix International <contact@raidix.com>
    52 	      1 Quadrature Capital Limited <info@quadraturecapital.com>
    53 	      1 Linaro <contact@linaro.org>
    54 	      1 Indiana University <contact@indiana.edu>
    55 	      1 Enproduktion GmbH <contact@produktion.io>
    56 	      1 DigitalOcean <contact@digitalocean.com>
    57 	      1 CISCO <contact@cisco.com>
    58 	      1 Catalysts <office@catalysts.cc>
    59 	      1 Alcatel Lucent <contact@alcatel-lucent.com>

Reviews, by authors (one review spans multiple commits)
     1	    522 Sage Weil <sweil@redhat.com>
     2	    427 Kefu Chai <kchai@redhat.com>
     3	    217 John Spray <jspray@redhat.com>
     4	    206 Greg Farnum <gfarnum@redhat.com>
     5	    202 Josh Durgin <jdurgin@redhat.com>
     6	    185 Jason Dillaman <dillaman@redhat.com>
     7	    163 Casey Bodley <cbodley@redhat.com>
     8	    147 Samuel Just <sjust@redhat.com>
     9	    117 Mykola Golub <mgolub@mirantis.com>
    10	    116 Loic Dachary <ldachary@redhat.com>
    11	     82 Orit Wasserman <owasserm@redhat.com>
    12	     71 Yehuda Sadeh <ysadehwe@redhat.com>
    13	     66 Haomai Wang <haomai@xsky.com>
    14	     62 Xie Xingguo <xie.xingguo@zte.com.cn>
    15	     55 Igor Fedotov <ifedotov@mirantis.com>
    16	     40 Nathan Cutler <ncutler@suse.com>
    17	     38 Ali Maredia <amaredia@redhat.com>
    18	     30 Dan Mick <dmick@redhat.com>
    19	     30 Abhishek Lekshmanan <abhishek@suse.com>
    20	     24 Ken Dreyer <kdreyer@redhat.com>
    21	     22 Brad Hubbard <bhubbard@redhat.com>
    22	     19 Alfredo Deza <adeza@redhat.com>
    23	     18 Mark Nelson <mnelson@redhat.com>
    24	     18 David Zafman <dzafman@redhat.com>
    25	     15 Boris Ranto <branto@redhat.com>
    26	     13 Yan, Zheng <zyan@redhat.com>
    27	     13 Sam Lang <sam.lang@inktank.com>
    28	     13 Patrick Donnelly <pdonnell@redhat.com>
    29	     12 Willem Jan Withagen <wjw@digiware.nl>
    30	     12 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    31	     11 Varada Kari <varada.kari@sandisk.com>
    32	     10 Warren Usui <wusui@redhat.com>
    33	     10 Ramesh Chander <Ramesh.Chander@sandisk.com>
    34	      8 Yuri Weinstein <yuriw@redhat.com>
    35	      8 Matt Benjamin <mbenjamin@redhat.com>
    36	      8 Allen Samuels <allen.samuels@sandisk.com>
    37	      7 Somnath Roy <somnath.roy@sandisk.com>
    38	      7 Jeff Layton <jlayton@redhat.com>
    39	      6 Travis Rhoden <trhoden@redhat.com>
    40	      5 Ramana Raja <rraja@redhat.com>
    41	      5 Ilya Dryomov <idryomov@redhat.com>
    42	      4 Tim Serong <tserong@suse.com>
    43	      4 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    44	      3 Xiaoxi Chen <xiaoxchen@ebay.com>
    45	      3 Venky Shankar <vshankar@redhat.com>
    46	      3 Song Baisen <song.baisen@zte.com.cn>
    47	      3 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    48	      3 John Wilkins <jwilkins@redhat.com>
    49	      3 Erwan Velu <erwan@redhat.com>
    50	      3 Abhishek Varshney <abhishek.varshney@flipkart.com>
    51	      2 Zack Cerza <zack@redhat.com>
    52	      2 Vikhyat Umrao <vumrao@redhat.com>
    53	      2 Ricardo Dias <rdias@suse.com>
    54	      2 Oleh Prypin <oleh@pryp.in>
    55	      2 James Page <james.page@ubuntu.com>
    56	      2 Douglas Fuller <dfuller@redhat.com>
    57	      2 David Disseldorp <ddiss@suse.de>
    58	      2 Bassam Tabbara <bassam.tabbara@quantum.com>
    59	      2 Adir Lev <adirl@mellanox.com>
    60	      2 Adam C. Emerson <aemerson@redhat.com>
    61	      1 Yazen Ghannam <yazen.ghannam@linaro.org>
    62	      1 Yatin Kumbhare <yatinkumbhare@gmail.com>
    63	      1 Xinze Chi <xinze@xsky.com>
    64	      1 Vasu Kulkarni <vasu@redhat.com>
    65	      1 Tamil Muthamizhan <tmuthami@redhat.com>
    66	      1 Takeshi Miyamae <miyamae.takeshi@jp.fujitsu.com>
    67	      1 Shylesh Kumar <shmohan@redhat.com>
    68	      1 S=C3=A9bastien Han <shan@redhat.com>
    69	      1 Sandon Van Ness <svanness@redhat.com>
    70	      1 Roi Dayan <roid@mellanox.com>
    71	      1 Pritha Srivastava <prsrivas@redhat.com>
    72	      1 Petr Lautrbach <plautrba@redhat.com>
    73	      1 Owen Synge <osynge@suse.com>
    74	      1 Orit wasserman <owasserm@redhat.com>
    75	      1 Noah Watkins <nwatkins@redhat.com>
    76	      1 Nick Fisk <nick@fisk.me.uk>
    77	      1 Marcel Lauhoff <lauhoff@uni-mainz.de>
    78	      1 Ma Jianpeng <jianpeng.ma@intel.com>
    79	      1 Luo Kexue <luo.kexue@zte.com.cn>
    80	      1 Joe Julian <jjulian@io.com>
    81	      1 Joe Buck <jbbuck@gmail.com>
    82	      1 Javier M. Mellid <jmunhoz@igalia.com>
    83	      1 Jan Fajerski <jfajerski@suse.com>
    84	      1 Huang Jun <hjwsm1989@gmail.com>
    85	      1 Guang Yang <yguang@yahoo-inc.com>
    86	      1 Fran=C3=A7ois Lafont <flafdivers@free.fr>
    87	      1 Dirk Mueller <dmueller@suse.com>
    88	      1 Dan MIck <dmick@redhat.com>
    89	      1 Alexandre Derumier <aderumier@odiso.com>

Reviews, by organizations (one review spans multiple commits)
     1 	   2636 Red Hat <contact@redhat.com>
     2 	    176 Mirantis <contact@mirantis.com>
     3 	     93 SUSE <contact@suse.com>
     4 	     67 XSky <contact@xsky.com>
     5 	     66 ZTE <contact@zte.com.cn>
     6 	     36 SanDisk <contact@sandisk.com>
     7 	     12 Digiware <contact@digiware.nl>
     8 	      6 Unaffiliated <no@organization.net>
     9 	      4 Fujitsu <contact@fujitsu.com>
    10 	      3 Mellanox <contact@mellanox.com>
    11 	      3 Flipkart <contact@flipkart.com>
    12 	      3 Ebay <contact@ebay.com>
    13 	      2 Quantum Corporation <info@quantum.com>
    14 	      2 Canonical <contact@canonical.com>
    15 	      1 Yahoo! <contact@yahoo-inc.com>
    16 	      1 University of California, Santa Cruz <contact@cs.ucsc.edu>
    17 	      1 Odiso <contact@odiso.com>
    18 	      1 Linaro <contact@linaro.org>
    19 	      1 Johannes Gutenberg-Universit=C3=A4t Mainz <contact@uni-main=
z.de>
    20 	      1 IO <contact@io.com>
    21 	      1 Intel <contact@intel.com>
    22 	      1 Igalia <contact@igalia.com>
    23 	      1 Cloudwatt <libre.licensing@cloudwatt.com>
=2D-
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton, =
HRB 21284 (AG N=C3=BCrnberg)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJYghgfAAoJEPnwZB8bZe1f95MIAJG14+lkA/i4bPgxGDCrS1Ub
pu536Stm09ZywqYfMe27kykZQBbsw9tPTdSpukufv3mHVOB4bwkCGhNt96mVQOrV
DB5WpFoRF7h32XIk2R1sRJJoNEZGt2+hOXOn8YPrdN2LoTafPN+2Onyx7PqllJPe
eSqe+gyL42doJ39ZDm7nDAoYLzHK8aF59HvpdaWVM6Uzc2KIdFukLvRwcYFHYJ9d
ObgLrSaXjNTf2t27GyQrM2DJQ2Us1yTirWXA4Fip01kkwjKQOtsgBN4k9mzMwT4b
u0yD72x+DC+IJSxmsEpXKqkAFctiL1bGgUmsKv4I8Z0IzG/RUxAQcRQMQf74dZs=
=DA0j
-----END PGP SIGNATURE-----
--=-=-=--
