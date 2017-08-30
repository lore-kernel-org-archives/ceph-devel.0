From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Contributor credits for v12.2.0 Luminous
Date: Wed, 30 Aug 2017 11:04:11 +0200
Message-ID: <87y3q1juk4.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:48889 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdH3JEO (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Wed, 30 Aug 2017 05:04:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


Yet another release of Ceph is out, here is a sorted list of authors and
organizations who contributed to v12.2.0, by number of commits or
reviews back to v11.2.0. Thanks everyone for contributing, and keep
up the good work

The affiliation of authors to organizations can be updated by submitting
a patch to https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenance_guide

Number of lines added and removed, by authors
     1	305892 John Spray <jspray@redhat.com>
     2	 81557 Sage Weil <sweil@redhat.com>
     3	 51914 Jason Dillaman <dillaman@redhat.com>
     4	 21218 Ganesh Mahalingam <ganesh.mahalingam@intel.com>
     5	 18870 Yehuda Sadeh <ysadehwe@redhat.com>
     6	 17753 Radoslaw Zarzynski <rzarzyns@redhat.com>
     7	 16767 Mykola Golub <mgolub@mirantis.com>
     8	 16241 Kefu Chai <kchai@redhat.com>
     9	 15785 Abhishek Lekshmanan <abhishek@suse.com>
    10	 14665 Casey Bodley <cbodley@redhat.com>
    11	 13806 J. Eric Ivancich <ivancich@redhat.com>
    12	 13467 Ricardo Dias <rdias@suse.com>
    13	 12635 Chang Liu <liuchang0812@gmail.com>
    14	 10832 Adam C. Emerson <aemerson@redhat.com>
    15	 10262 Nathan Cutler <ncutler@suse.com>
    16	  9400 Amir Vadai <amir@vadai.me>
    17	  6685 Igor Fedotov <ifedotov@mirantis.com>
    18	  6518 Adam Kupczyk <akupczyk@redhat.com>
    19	  6388 Xie Xingguo <xie.xingguo@zte.com.cn>
    20	  5678 Alfredo Deza <adeza@redhat.com>
    21	  5503 Dongsheng Yang <dongsheng.yang@easystack.cn>
    22	  5289 Loic Dachary <ldachary@redhat.com>
    23	  5197 Yan, Zheng <zyan@redhat.com>
    24	  5116 Samuel Just <sjust@redhat.com>
    25	  4743 David Zafman <dzafman@redhat.com>
    26	  4312 Greg Farnum <gfarnum@redhat.com>
    27	  4087 Pritha Srivastava <prsrivas@redhat.com>
    28	  4047 Boris Ranto <branto@redhat.com>
    29	  3867 Adir Lev <adirl@mellanox.com>
    30	  3792 Orit Wasserman <owasserm@redhat.com>
    31	  3521 Patrick Donnelly <pdonnell@redhat.com>
    32	  3002 Josh Durgin <jdurgin@redhat.com>
    33	  2777 Jos Collin <jcollin@redhat.com>
    34	  2664 João Eduardo Luís <joao@suse.de>
    35	  2488 Venky Shankar <vshankar@redhat.com>
    36	  2465 Piotr Dałek <piotr.dalek@corp.ovh.com>
    37	  2379 Willem Jan Withagen <wjw@digiware.nl>
    38	  2356 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
    39	  2333 John Wilkins <jwilkins@redhat.com>
    40	  2278 Andrew Solomon <asolomon@us.ibm.com>
    41	  2274 Haomai Wang <haomai@xsky.com>
    42	  2273 Wido den Hollander <wido@42on.com>
    43	  2138 wangzhengyong <wangzhengyong@cmss.chinamobile.com>
    44	  2064 Brad Hubbard <bhubbard@redhat.com>
    45	  2061 Jesse Williamson <jesse.williamson@suse.com>
    46	  1910 Matt Benjamin <mbenjamin@redhat.com>
    47	  1778 Gui Hecheng <guihecheng@cmss.chinamobile.com>
    48	  1685 Victor Denisov <denisovenator@gmail.com>
    49	  1409 Dan Mick <dmick@redhat.com>
    50	  1223 Ma Jianpeng <jianpeng.ma@intel.com>
    51	  1211 Neha Ojha <nojha@redhat.com>
    52	  1109 Marcus Watts <mwatts@redhat.com>
    53	  1052 Pan Liu <pan.liu@istuary.com>
    54	   928 Ilya Dryomov <idryomov@redhat.com>
    55	   928 Bartłomiej Święcki <bartlomiej.swiecki@corp.ovh.com>
    56	   890 Myoungwon Oh <omwmw@sk.com>
    57	   885 Luo Runbing <runsisi@zte.com.cn>
    58	   842 Douglas Fuller <dfuller@redhat.com>
    59	   773 Bassam Tabbara <bassam.tabbara@quantum.com>
    60	   714 Andrew Schoen <aschoen@redhat.com>
    61	   635 Xiaowei Chen <chen.xiaowei@h3c.com>
    62	   634 Yuri Weinstein <yuriw@redhat.com>
    63	   619 John Coyle <dx9err@gmail.com>
    64	   605 Ning Yao <yaoning@unitedstack.com>
    65	   578 Ali Maredia <amaredia@redhat.com>
    66	   567 Zack Cerza <zack@redhat.com>
    67	   563 mychoxin <mychoxin@gmail.com>
    68	   526 James Page <james.page@ubuntu.com>
    69	   515 Vasu Kulkarni <vasu@redhat.com>
    70	   495 Tim Serong <tserong@suse.com>
    71	   475 Pan Liu <wanjun.lp@alibaba-inc.com>
    72	   469 Anjaneya Chagam <anjaneya.chagam@intel.com>
    73	   462 Radoslaw Zarzynski <rzarzynski@redhat.com>
    74	   461 Ziye Yang <ziye.yang@intel.com>
    75	   459 Zengran Zhang <zhangzengran@h3c.com>
    76	   439 lu.shasha <lu.shasha@eisoo.com>
    77	   422 lvshuhua <lvshuhua@cmss.chinamobile.com>
    78	   399 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
    79	   363 Varada Kari <varada.kari@sandisk.com>
    80	   353 Jiaying Ren <jiaying.ren@umcloud.com>
    81	   300 Fang Yuxiang <fang.yuxiang@eisoo.com>
    82	   287 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
    83	   287 Daniel Oliveira <doliveira@suse.com>
    84	   270 Shinobu Kinjo <shinobu@redhat.com>
    85	   267 Yan Jun <yan.jun8@zte.com.cn>
    86	   267 wei xiao <wei.xiao@linaro.org>
    87	   266 Song Weibin <song.weibin@zte.com.cn>
    88	   245 Victor Araujo <ve.ar91@gmail.com>
    89	   241 Amit Kumar <amitkuma@redhat.com>
    90	   240 Chu Hua-Rong <hrchu@cht.com.tw>
    91	   233 Michal Jarzabek <stiopa@gmail.com>
    92	   232 Ren Huanwen <ren.huanwen@zte.com.cn>
    93	   231 Luo Runbing <runsisi@hust.edu.cn>
    94	   227 Jan Fajerski <jfajerski@suse.com>
    95	   224 Ira Cooper <ira@samba.org>
    96	   221 Javier M. Mellid <jmunhoz@igalia.com>
    97	   218 Song Baisen <song.baisen@zte.com.cn>
    98	   212 Zhi Zhang <willzzhang@tencent.com>
    99	   190 optimistyzy <optimistyzy@gmail.com>
   100	   185 Abhishek Varshney <abhishek.varshney@flipkart.com>
   101	   179 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
   102	   178 Zhiqiang Wang <zhiqiang@xsky.com>
   103	   177 Zhou Zhengping <johnzzpcrystal@gmail.com>
   104	   171 Michael Sevilla <mikesevilla3@gmail.com>
   105	   167 Andrew Shewmaker <agshew@gmail.com>
   106	   166 Mark Nelson <mnelson@redhat.com>
   107	   157 Zhang Lei <zhanglei@trendytech.com.cn>
   108	   157 Dongdong Tao <tdd21151186@gmail.com>
   109	   141 David Disseldorp <ddiss@suse.de>
   110	   138 Harald Klein <hari@vt100.at>
   111	   134 Barbora Ančincová <bara@redhat.com>
   112	   130 Huang Jun <huangjun@xsky.com>
   113	   129 Mingxin Liu <mingxin@xsky.com>
   114	   129 Edgaras Lukosevicius <edgaras.lukosevicius@gmail.com>
   115	   126 Chuanhong Wang <wang.chuanhong@zte.com.cn>
   116	   125 Tamil Muthamizhan <tmuthami@redhat.com>
   117	   124 Mohamad Gebai <mgebai@suse.com>
   118	   124 Leo Zhang <nguzcf@gmail.com>
   119	   122 Ji Chen <insomnia@139.com>
   120	   114 Zhu Shangzhong <zhu.shangzhong@zte.com.cn>
   121	   114 Logan Blyth <mrbojangles3@gmail.com>
   122	   112 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
   123	   108 Yang Honggang <joseph.yang@xtaotech.com>
   124	   103 Joe Buck <jbbuck@gmail.com>
   125	   101 Haodong Tang <haodong.tang@intel.com>
   126	   100 Yanhu Cao <gmayyyha@gmail.com>
   127	    98 Sarit Zubakov <saritz@mellanox.com>
   128	    98 Jens Rosenboom <j.rosenboom@x-ion.de>
   129	    97 Erwan Velu <erwan@redhat.com>
   130	    90 Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
   131	    89 Jeegn Chen <jeegnchen@gmail.com>
   132	    87 Drunkard Zhang <gongfan193@gmail.com>
   133	    85 Caijin Caij <caijin.caij@alibaba-inc.com>
   134	    83 Warren Usui <wusui@redhat.com>
   135	    81 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
   136	    80 Vicente Cheng <vicente_cheng@bigtera.com>
   137	    80 Jenkins <jenkins@ceph.com>
   138	    80 Fabian Grünbichler <f.gruenbichler@proxmox.com>
   139	    79 Ken Dreyer <kdreyer@redhat.com>
   140	    77 Xiaoxi Chen <xiaoxchen@ebay.com>
   141	    65 Luo Kexue <luo.kexue@zte.com.cn>
   142	    63 Bryan Stillwell <bstillwell@godaddy.com>
   143	    62 Sam Lang <sam.lang@inktank.com>
   144	    61 Vikhyat Umrao <vumrao@redhat.com>
   145	    59 Shiqi <m13913886148@gmail.com>
   146	    58 Enming Zhang <enming.zhang@umcloud.com>
   147	    57 Xiaoyan Li <xiaoyan.li@intel.com>
   148	    57 Guillaume Abrioux <gabrioux@redhat.com>
   149	    53 Zhao Chao <zhaochao1984@gmail.com>
   150	    53 Nikita Gerasimov <nikita.gerasimov@oracle.com>
   151	    50 Lin Bing <hawkerous@gmail.com>
   152	    49 Robin H. Johnson <robin.johnson@dreamhost.com>
   153	    49 Daniel Gryniewicz <dang@redhat.com>
   154	    48 Yuli Yang <yuliyang@cmss.chinamobile.com>
   155	    47 Zhang Zezhu <zhang.zezhu@zte.com.cn>
   156	    45 Patrick McGarry <pmcgarry@redhat.com>
   157	    40 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
   158	    39 Guo-Fu Tseng <david_tseng@bigtera.com>
   159	    38 Xie Rui <875016668@qq.com>
   160	    36 Wei Jin <jinwei15@wanda.cn>
   161	    36 Saumay Agrawal <saumay.agrawal@gmail.com>
   162	    36 Liu Hong <liuhong@cmss.chinamobile.com>
   163	    35 Yu Shengzuo <yu.shengzuo@99cloud.net>
   164	    35 Li Wang <li.wang@kylin-cloud.com>
   165	    33 Dave Chen <wei.d.chen@intel.com>
   166	    32 Nick Fisk <nick@fisk.me.uk>
   167	    31 Swami Reddy <swami.reddy@ril.com>
   168	    31 Shun Song <song.shun3@zte.com.cn>
   169	    31 Guo Zhandong <guozhandong@cmss.chinamobile.com>
   170	    31 Dan van der Ster <daniel.vanderster@cern.ch>
   171	    30 Orlando Moreno <orlando.moreno@intel.com>
   172	    27 Hong Zhangoole <hong.zhangoole@gmail.com>
   173	    26 Daniel Bar-On <danielbo@mellanox.com>
   174	    23 Andrey Parfenov <aparfenov@virtuozzo.com>
   175	    22 Zheng Yin <zhengyin@chinac.com>
   176	    22 Jeff Layton <jlayton@redhat.com>
   177	    22 Allen Samuels <allen.samuels@sandisk.com>
   178	    21 Rishabh Kumar <kris.kr296@gmail.com>
   179	    21 Oren Duer <oren@mellanox.com>
   180	    20 Xuehan Xu <xxhdx1985126@163.com>
   181	    20 Xianxia Xiao <xianxia.xiao@kylin-cloud.com>
   182	    20 Weibing Zhang <atheism.zhang@gmail.com>
   183	    20 Sébastien Han <shan@redhat.com>
   184	    20 Henrik Korkuc <henrik@uber.com>
   185	    19 Sameer Tiwari <stiwari@salesforce.com>
   186	    19 Jamin W. Collins <jamin.collins@gmail.com>
   187	    18 Spandan Kumar Sahu <spandankumarsahu@gmail.com>
   188	    18 Peng Cheng Zhang <pengcheng.zhang@easystack.cn>
   189	    18 Karol Mroz <kmroz@suse.com>
   190	    16 Kuan-Kai Chiu <big.chiu@bigtera.com>
   191	    15 Wu Jian <wujian3659@163.com>
   192	    15 Tang Jin <tang.jin@istuary.com>
   193	    14 Li Hongjie <lihongjie@cmss.chinamobile.com>
   194	    14 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
   195	    13 Yao Zongyou <yaozongyou@vip.qq.com>
   196	    13 James Liu <james.liu@alibaba-inc.com>
   197	    12 Tushar Gohad <tushar.gohad@intel.com>
   198	    12 Tommi Virtanen <tv@inktank.com>
   199	    12 Stephon Striplin <stephon.striplin@dreamhost.com>
   200	    12 Sander Pool <sander.pool@inktank.com>
   201	    12 Jianyu Li <joannyli@foxmail.com>
   202	    11 Tianshan Qu <tianshan@xsky.com>
   203	    11 Ramesh Chander <Ramesh.Chander@sandisk.com>
   204	    11 Hongtong Liu <hongtong.liu@istuary.com>
   205	    11 Alan Somers <asomers@gmail.com>
   206	    10 Yankun Li <liyankun@unitedstack.com>
   207	    10 Uday Mullangi <udaymjl@gmail.com>
   208	     9 Tang Wenjun <tang.wenjun3@zte.com.cn>
   209	     9 Donglin Peng <donglinpeng@cmss.chinamobile.com>
   210	     9 Dingdang Zhang <boqian.zy@alibaba-inc.com>
   211	     9 Chenfang Xian <chenfangxian@cmss.chinamobile.com>
   212	     9 Alexey Sheplyakov <asheplyakov@mirantis.com>
   213	     9 Adam Wolfe Gordon <awg@digitalocean.com>
   214	     8 Thomas Serlin <tserlin@redhat.com>
   215	     8 Ronak Jain <ronakjain@outlook.in>
   216	     8 Hans van den Bogert <hansbogert@gmail.com>
   217	     8 Giovani Rinaldi <gr.gigio@terra.com.br>
   218	     8 Aleksei Gutikov <aleksey.gutikov@synesis.ru>
   219	     7 Xinze Chi <xinze@xsky.com>
   220	     7 Pascal Bach <pasci.bach@gmail.com>
   221	     7 Jie Wang <jie.wang@kylin-cloud.com>
   222	     7 Avner BenHanoch <avnerb@mellanox.com>
   223	     6 Yanchun Bai <yanchun.bai@istuary.com>
   224	     6 Ted-Chang <ted.g.zhang@live.com>
   225	     6 Tahia Khan <tahia.khan@gmail.com>
   226	     6 Samuel Matzek <smatzek@us.ibm.com>
   227	     6 Redick Wang <redickwang@tencent.com>
   228	     6 Peter Maloney <peter.maloney@yahoo.ca>
   229	     6 Peng Zhang <zphj1987@gmail.com>
   230	     6 Nick Erdmann <n@nirf.de>
   231	     6 Gu Zhongyan <guzhongyan@360.cn>
   232	     6 Chen Hg <mesfet@126.com>
   233	     5 Sirisha Guduru <SGuduru@walmartlabs.com>
   234	     5 Ilsoo Byun <ilsoo.byun@sk.com>
   235	     4 Zhang Weibing <zhangweibing@unitedstack.com>
   236	     4 Vedant Nanda <vedant15114@iiitd.ac.in>
   237	     4 Shengjing Zhu <zhsj@umcloud.com>
   238	     4 Patrick Dinnen <pdinnen@gmail.com>
   239	     4 Liyan <liyan.wang@xtaotech.com>
   240	     4 Liu Yang <yippeetry@gmail.com>
   241	     4 Kyr Shatskyy <kyrylo.shatskyy@gmail.com>
   242	     4 Ilya Shipitsin <chipitsine@gmail.com>
   243	     4 Henry Chang <henry_chang@bigtera.com>
   244	     4 He Chuang <hechuang@xsky.com>
   245	     4 haodong.tang <tanghaodong25@gmail.com>
   246	     4 Fan Yang <yangf@neunn.com>
   247	     4 Edwin F. Boza <eboza@espol.edu.ec>
   248	     4 clove <clove@zte.com.cn>
   249	     3 Xinying Song <songxinying@cloudin.cn>
   250	     2 Wuming Qiao <wumingqiao@inspur.com>
   251	     2 Taeksang Kim <voidbag@gmail.com>
   252	     2 Svyatoslav <razmyslov@viva64.com>
   253	     2 Sven Seeberg <sseebergelverfeldt@suse.com>
   254	     2 Shengjing Zhu <zsj950618@gmail.com>
   255	     2 Ruben Kerkhof <ruben@rubenkerkhof.com>
   256	     2 Owen Synge <osynge@suse.com>
   257	     2 MinSheng Lin <minsheng.l@inwinstack.com>
   258	     2 Ming Lin <ming.lin@alibaba-inc.com>
   259	     2 Michal Koutný <mkoutny@suse.com>
   260	     2 Michael Eischer <michael.eischer@fau.de>
   261	     2 Liu Yuhong <liuyuhong@cmss.chinamobile.com>
   262	     2 Jeff Green <jeffgreen@jpgit.com>
   263	     2 Gu Zhongyan <guzhongyan@ceph01v.ops.corp.qihoo.net>
   264	     2 craigchi <craig10624@gmail.com>
   265	     2 Alessandro Barbieri <ale.barbio@alice.it>
   266	     1 Yunfei Guan <yunfei.guan@xtaotech.com>
   267	     1 Yixun Lan <dlan@gentoo.org>
   268	     1 Xiubo Li <lixiubo@cmss.chinamobile.com>
   269	     1 Tone Zhang <tone.zhang@linaro.org>
   270	     1 Peng Xie <peng.hse@xtaotech.com>
   271	     1 John Lin <johnlinp@gmail.com>

Number of lines added and removed, by organization
     1	583895 Red Hat <contact@redhat.com>
     2	 49406 Mirantis <contact@mirantis.com>
     3	 45537 SUSE <contact@suse.com>
     4	 26712 Unaffiliated <no@organization.net>
     5	 23604 Intel <contact@intel.com>
     6	  8692 ZTE <contact@zte.com.cn>
     7	  7131 China Mobile <contact@chinamobile.com>
     8	  5521 Easystack <contact@easystack.cn>
     9	  4019 Mellanox <contact@mellanox.com>
    10	  3393 OVH <ceph@ovh.net>
    11	  2733 XSky <contact@xsky.com>
    12	  2379 Digiware <contact@digiware.nl>
    13	  2284 IBM <contact@IBM.com>
    14	  2273 Wido 42on <contact@42on.com>
    15	  1094 H3C <contact@h3c.com>
    16	  1084 Istuary Innovation Group <contact@istuary.com>
    17	   923 Inktank <contact@inktank.com>
    18	   773 Quantum Corporation <info@quantum.com>
    19	   739 EISOO <contact@eisoo.com>
    20	   619 UnitedStack <contact@unitedstack.com>
    21	   584 Alibaba <contact@alibaba-inc.com>
    22	   526 Canonical <contact@canonical.com>
    23	   461 Kylin Cloud <contact@kylin-cloud.com>
    24	   415 UMCloud <contact@umcloud.com>
    25	   396 SanDisk <contact@sandisk.com>
    26	   268 Linaro <contact@linaro.org>
    27	   254 Cloudwatt <libre.licensing@cloudwatt.com>
    28	   240 Chunghwa Telecom <contact@cht.com.tw>
    29	   231 Huazhong University of Science and Technology <contact@hust.edu.cn>
    30	   221 Igalia <contact@igalia.com>
    31	   218 Tencent <contact@tencent.com>
    32	   216 Trendy Tech <contact@trendytech.com.cn>
    33	   185 Flipkart <contact@flipkart.com>
    34	   179 Deutsche Telekom <contact@telekom.de>
    35	   139 Bigtera <contact@bigtera.com>
    36	   124 T2Cloud <contact@t2cloud.net>
    37	   122 LETV <contact@letv.com>
    38	   103 University of California, Santa Cruz <contact@cs.ucsc.edu>
    39	    98 X-ion GmbH <contact@x-ion.de>
    40	    95 Walmart Labs <contact@walmartlabs.com>
    41	    80 Proxmox Server Solutions GmbH <office@proxmox.com>
    42	    77 Ebay <contact@ebay.com>
    43	    63 GoDaddy <contact@godaddy.com>
    44	    61 DreamHost <contact@dreamhost.com>
    45	    57 Eayun <contact@eayun.com>
    46	    53 Oracle <contact@oracle.com>
    47	    36 Wanda ffan <contact@wanda.cn>
    48	    35 99Cloud Inc <contact@99cloud.net>
    49	    31 Reliance Jio Infocomm Ltd. <contact@ril.com>
    50	    31 CERN <contact@cern.ch>
    51	    23 Virtuozzo <contact@virtuozzo.com>
    52	    22 Chinac <info@chinac.com>
    53	    20 Uber Technologies Inc. <contact@uber.com>
    54	    19 Salesforce <contact@salesforce.com>
    55	    14 Catalysts <office@catalysts.cc>
    56	    11 Spectra Logic <contact@spectralogic.com>
    57	     9 DigitalOcean <contact@digitalocean.com>
    58	     8 Tera <contact@tera.com.br>
    59	     8 Synesis <contact@synesis.ru>
    60	     8 Budgetenergie <itbeheer@budgetenergie.nl>
    61	     5 SK Telecom <rnd@sktelecom.com>
    62	     4 Neunn <service@neunn.com>
    63	     4 Liyan <liyan.wang@xtaotech.com>
    64	     4 Indraprastha Institute of Information Technology, Delhi <contact@iiitd.ac.in>
    65	     4 ESPOL <contact@espol.edu.ec>
    66	     3 Cloudin <contact@cloudin>
    67	     2 XTao Co. Ltd. <contact@xtaotech.com>
    68	     2 Viva64 <contact@viva64.com>
    69	     2 inwinSTACK inc. <leo.l@inwinstack.com>
    70	     2 Inspur <contact@inspur.com>
    71	     2 FAU <contact@fau.de>
    72	     1 Gentoo <contact@gentoo.org>

Commits, by authors
     1	   1608 Sage Weil <sweil@redhat.com>
     2	    446 Kefu Chai <kchai@redhat.com>
     3	    328 John Spray <jspray@redhat.com>
     4	    291 Jason Dillaman <dillaman@redhat.com>
     5	    237 Xie Xingguo <xie.xingguo@zte.com.cn>
     6	    208 Casey Bodley <cbodley@redhat.com>
     7	    190 Yehuda Sadeh <ysadehwe@redhat.com>
     8	    187 Yan, Zheng <zyan@redhat.com>
     9	    185 Radoslaw Zarzynski <rzarzyns@redhat.com>
    10	    162 Alfredo Deza <adeza@redhat.com>
    11	    148 Abhishek Lekshmanan <abhishek@suse.com>
    12	    128 David Zafman <dzafman@redhat.com>
    13	    117 Loic Dachary <ldachary@redhat.com>
    14	    112 Nathan Cutler <ncutler@suse.com>
    15	    111 Patrick Donnelly <pdonnell@redhat.com>
    16	    108 Willem Jan Withagen <wjw@digiware.nl>
    17	     93 Chang Liu <liuchang0812@gmail.com>
    18	     78 Mykola Golub <mgolub@mirantis.com>
    19	     77 Greg Farnum <gfarnum@redhat.com>
    20	     74 Orit Wasserman <owasserm@redhat.com>
    21	     71 Jos Collin <jcollin@redhat.com>
    22	     70 Dan Mick <dmick@redhat.com>
    23	     68 Haomai Wang <haomai@xsky.com>
    24	     67 Igor Fedotov <ifedotov@mirantis.com>
    25	     56 Adam C. Emerson <aemerson@redhat.com>
    26	     55 Josh Durgin <jdurgin@redhat.com>
    27	     51 Matt Benjamin <mbenjamin@redhat.com>
    28	     50 Brad Hubbard <bhubbard@redhat.com>
    29	     47 Dongsheng Yang <dongsheng.yang@easystack.cn>
    30	     42 Ma Jianpeng <jianpeng.ma@intel.com>
    31	     39 Adam Kupczyk <akupczyk@redhat.com>
    32	     38 Gui Hecheng <guihecheng@cmss.chinamobile.com>
    33	     38 Amir Vadai <amir@vadai.me>
    34	     36 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
    35	     36 Pan Liu <pan.liu@istuary.com>
    36	     35 Samuel Just <sjust@redhat.com>
    37	     33 wangzhengyong <wangzhengyong@cmss.chinamobile.com>
    38	     31 Jiaying Ren <jiaying.ren@umcloud.com>
    39	     31 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    40	     28 Ren Huanwen <ren.huanwen@zte.com.cn>
    41	     28 Jesse Williamson <jesse.williamson@suse.com>
    42	     28 Boris Ranto <branto@redhat.com>
    43	     27 Amit Kumar <amitkuma@redhat.com>
    44	     26 Piotr Dałek <piotr.dalek@corp.ovh.com>
    45	     26 João Eduardo Luís <joao@suse.de>
    46	     26 Ilya Dryomov <idryomov@redhat.com>
    47	     24 Vasu Kulkarni <vasu@redhat.com>
    48	     24 Swami Reddy <swami.reddy@ril.com>
    49	     24 Pritha Srivastava <prsrivas@redhat.com>
    50	     23 Ricardo Dias <rdias@suse.com>
    51	     23 Neha Ojha <nojha@redhat.com>
    52	     22 Yan Jun <yan.jun8@zte.com.cn>
    53	     22 Luo Runbing <runsisi@zte.com.cn>
    54	     21 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
    55	     20 lu.shasha <lu.shasha@eisoo.com>
    56	     20 Douglas Fuller <dfuller@redhat.com>
    57	     19 Song Baisen <song.baisen@zte.com.cn>
    58	     19 Mingxin Liu <mingxin@xsky.com>
    59	     18 Drunkard Zhang <gongfan193@gmail.com>
    60	     17 Zack Cerza <zack@redhat.com>
    61	     17 Fang Yuxiang <fang.yuxiang@eisoo.com>
    62	     16 Xiaowei Chen <chen.xiaowei@h3c.com>
    63	     16 Huang Jun <huangjun@xsky.com>
    64	     15 Wido den Hollander <wido@42on.com>
    65	     15 Venky Shankar <vshankar@redhat.com>
    66	     15 Radoslaw Zarzynski <rzarzynski@redhat.com>
    67	     15 J. Eric Ivancich <ivancich@redhat.com>
    68	     14 Pan Liu <wanjun.lp@alibaba-inc.com>
    69	     14 Marcus Watts <mwatts@redhat.com>
    70	     14 Li Wang <li.wang@kylin-cloud.com>
    71	     14 Adir Lev <adirl@mellanox.com>
    72	     13 Myoungwon Oh <omwmw@sk.com>
    73	     13 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
    74	     13 Bassam Tabbara <bassam.tabbara@quantum.com>
    75	     12 Tim Serong <tserong@suse.com>
    76	     12 Sarit Zubakov <saritz@mellanox.com>
    77	     12 Mark Nelson <mnelson@redhat.com>
    78	     11 Zhang Lei <zhanglei@trendytech.com.cn>
    79	     11 optimistyzy <optimistyzy@gmail.com>
    80	     11 Leo Zhang <nguzcf@gmail.com>
    81	     10 Yanhu Cao <gmayyyha@gmail.com>
    82	     10 John Wilkins <jwilkins@redhat.com>
    83	     10 Jenkins <jenkins@ceph.com>
    84	     10 Chu Hua-Rong <hrchu@cht.com.tw>
    85	      9 Zhang Zezhu <zhang.zezhu@zte.com.cn>
    86	      9 Shiqi <m13913886148@gmail.com>
    87	      8 Zhi Zhang <willzzhang@tencent.com>
    88	      8 Zhiqiang Wang <zhiqiang@xsky.com>
    89	      8 Yuri Weinstein <yuriw@redhat.com>
    90	      8 Wei Jin <jinwei15@wanda.cn>
    91	      8 Lin Bing <hawkerous@gmail.com>
    92	      8 John Coyle <dx9err@gmail.com>
    93	      7 Ning Yao <yaoning@unitedstack.com>
    94	      7 Mohamad Gebai <mgebai@suse.com>
    95	      7 Michal Jarzabek <stiopa@gmail.com>
    96	      7 Luo Kexue <luo.kexue@zte.com.cn>
    97	      7 Ken Dreyer <kdreyer@redhat.com>
    98	      7 Caijin Caij <caijin.caij@alibaba-inc.com>
    99	      7 Andrew Schoen <aschoen@redhat.com>
   100	      6 Xiaoxi Chen <xiaoxchen@ebay.com>
   101	      6 Xianxia Xiao <xianxia.xiao@kylin-cloud.com>
   102	      6 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
   103	      6 Varada Kari <varada.kari@sandisk.com>
   104	      6 Tommi Virtanen <tv@inktank.com>
   105	      6 Song Weibin <song.weibin@zte.com.cn>
   106	      6 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
   107	      6 lvshuhua <lvshuhua@cmss.chinamobile.com>
   108	      6 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
   109	      6 Dongdong Tao <tdd21151186@gmail.com>
   110	      6 Ali Maredia <amaredia@redhat.com>
   111	      6 Abhishek Varshney <abhishek.varshney@flipkart.com>
   112	      5 Ziye Yang <ziye.yang@intel.com>
   113	      5 Zhu Shangzhong <zhu.shangzhong@zte.com.cn>
   114	      5 Yuli Yang <yuliyang@cmss.chinamobile.com>
   115	      5 Weibing Zhang <atheism.zhang@gmail.com>
   116	      5 Tamil Muthamizhan <tmuthami@redhat.com>
   117	      5 Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
   118	      5 Jan Fajerski <jfajerski@suse.com>
   119	      5 James Page <james.page@ubuntu.com>
   120	      5 David Disseldorp <ddiss@suse.de>
   121	      5 Dave Chen <wei.d.chen@intel.com>
   122	      5 Daniel Bar-On <danielbo@mellanox.com>
   123	      5 Barbora Ančincová <bara@redhat.com>
   124	      4 Xiaoyan Li <xiaoyan.li@intel.com>
   125	      4 Vikhyat Umrao <vumrao@redhat.com>
   126	      4 Victor Araujo <ve.ar91@gmail.com>
   127	      4 Tang Jin <tang.jin@istuary.com>
   128	      4 Shinobu Kinjo <shinobu@redhat.com>
   129	      4 Hong Zhangoole <hong.zhangoole@gmail.com>
   130	      4 Ganesh Mahalingam <ganesh.mahalingam@intel.com>
   131	      4 Enming Zhang <enming.zhang@umcloud.com>
   132	      4 Dan van der Ster <daniel.vanderster@cern.ch>
   133	      4 Daniel Oliveira <doliveira@suse.com>
   134	      4 Bartłomiej Święcki <bartlomiej.swiecki@corp.ovh.com>
   135	      4 Andrey Parfenov <aparfenov@virtuozzo.com>
   136	      4 Andrew Solomon <asolomon@us.ibm.com>
   137	      3 Zhou Zhengping <johnzzpcrystal@gmail.com>
   138	      3 Zhao Chao <zhaochao1984@gmail.com>
   139	      3 Yu Shengzuo <yu.shengzuo@99cloud.net>
   140	      3 Yao Zongyou <yaozongyou@vip.qq.com>
   141	      3 Yankun Li <liyankun@unitedstack.com>
   142	      3 Yang Honggang <joseph.yang@xtaotech.com>
   143	      3 Xinze Chi <xinze@xsky.com>
   144	      3 Warren Usui <wusui@redhat.com>
   145	      3 Vicente Cheng <vicente_cheng@bigtera.com>
   146	      3 Tushar Gohad <tushar.gohad@intel.com>
   147	      3 Tang Wenjun <tang.wenjun3@zte.com.cn>
   148	      3 Sébastien Han <shan@redhat.com>
   149	      3 Oren Duer <oren@mellanox.com>
   150	      3 Li Hongjie <lihongjie@cmss.chinamobile.com>
   151	      3 Jie Wang <jie.wang@kylin-cloud.com>
   152	      3 Jens Rosenboom <j.rosenboom@x-ion.de>
   153	      3 Hongtong Liu <hongtong.liu@istuary.com>
   154	      3 Guo Zhandong <guozhandong@cmss.chinamobile.com>
   155	      3 Fabian Grünbichler <f.gruenbichler@proxmox.com>
   156	      3 Erwan Velu <erwan@redhat.com>
   157	      3 Chuanhong Wang <wang.chuanhong@zte.com.cn>
   158	      3 Anjaneya Chagam <anjaneya.chagam@intel.com>
   159	      2 Zheng Yin <zhengyin@chinac.com>
   160	      2 Tianshan Qu <tianshan@xsky.com>
   161	      2 Thomas Serlin <tserlin@redhat.com>
   162	      2 Tahia Khan <tahia.khan@gmail.com>
   163	      2 Spandan Kumar Sahu <spandankumarsahu@gmail.com>
   164	      2 Shun Song <song.shun3@zte.com.cn>
   165	      2 Saumay Agrawal <saumay.agrawal@gmail.com>
   166	      2 Sameer Tiwari <stiwari@salesforce.com>
   167	      2 Ronak Jain <ronakjain@outlook.in>
   168	      2 Robin H. Johnson <robin.johnson@dreamhost.com>
   169	      2 Rishabh Kumar <kris.kr296@gmail.com>
   170	      2 Redick Wang <redickwang@tencent.com>
   171	      2 Ramesh Chander <Ramesh.Chander@sandisk.com>
   172	      2 Peng Zhang <zphj1987@gmail.com>
   173	      2 Orlando Moreno <orlando.moreno@intel.com>
   174	      2 Nikita Gerasimov <nikita.gerasimov@oracle.com>
   175	      2 Nick Erdmann <n@nirf.de>
   176	      2 mychoxin <mychoxin@gmail.com>
   177	      2 Luo Runbing <runsisi@hust.edu.cn>
   178	      2 Liu Yang <yippeetry@gmail.com>
   179	      2 Liu Hong <liuhong@cmss.chinamobile.com>
   180	      2 Ji Chen <insomnia@139.com>
   181	      2 Jeff Layton <jlayton@redhat.com>
   182	      2 Henrik Korkuc <henrik@uber.com>
   183	      2 He Chuang <hechuang@xsky.com>
   184	      2 Haodong Tang <haodong.tang@intel.com>
   185	      2 Hans van den Bogert <hansbogert@gmail.com>
   186	      2 Gu Zhongyan <guzhongyan@360.cn>
   187	      2 Fan Yang <yangf@neunn.com>
   188	      2 Edwin F. Boza <eboza@espol.edu.ec>
   189	      2 Donglin Peng <donglinpeng@cmss.chinamobile.com>
   190	      2 Dingdang Zhang <boqian.zy@alibaba-inc.com>
   191	      2 Daniel Gryniewicz <dang@redhat.com>
   192	      2 Bryan Stillwell <bstillwell@godaddy.com>
   193	      2 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
   194	      2 Alexey Sheplyakov <asheplyakov@mirantis.com>
   195	      2 Adam Wolfe Gordon <awg@digitalocean.com>
   196	      1 Zhang Weibing <zhangweibing@unitedstack.com>
   197	      1 Zengran Zhang <zhangzengran@h3c.com>
   198	      1 Yunfei Guan <yunfei.guan@xtaotech.com>
   199	      1 Yixun Lan <dlan@gentoo.org>
   200	      1 Yanchun Bai <yanchun.bai@istuary.com>
   201	      1 Xuehan Xu <xxhdx1985126@163.com>
   202	      1 Xiubo Li <lixiubo@cmss.chinamobile.com>
   203	      1 Xinying Song <songxinying@cloudin.cn>
   204	      1 Xie Rui <875016668@qq.com>
   205	      1 Wuming Qiao <wumingqiao@inspur.com>
   206	      1 Wu Jian <wujian3659@163.com>
   207	      1 wei xiao <wei.xiao@linaro.org>
   208	      1 Victor Denisov <denisovenator@gmail.com>
   209	      1 Vedant Nanda <vedant15114@iiitd.ac.in>
   210	      1 Uday Mullangi <udaymjl@gmail.com>
   211	      1 Tone Zhang <tone.zhang@linaro.org>
   212	      1 Ted-Chang <ted.g.zhang@live.com>
   213	      1 Taeksang Kim <voidbag@gmail.com>
   214	      1 Svyatoslav <razmyslov@viva64.com>
   215	      1 Sven Seeberg <sseebergelverfeldt@suse.com>
   216	      1 Stephon Striplin <stephon.striplin@dreamhost.com>
   217	      1 Sirisha Guduru <SGuduru@walmartlabs.com>
   218	      1 Shengjing Zhu <zsj950618@gmail.com>
   219	      1 Shengjing Zhu <zhsj@umcloud.com>
   220	      1 Sander Pool <sander.pool@inktank.com>
   221	      1 Samuel Matzek <smatzek@us.ibm.com>
   222	      1 Sam Lang <sam.lang@inktank.com>
   223	      1 Ruben Kerkhof <ruben@rubenkerkhof.com>
   224	      1 Peter Maloney <peter.maloney@yahoo.ca>
   225	      1 Peng Xie <peng.hse@xtaotech.com>
   226	      1 Peng Cheng Zhang <pengcheng.zhang@easystack.cn>
   227	      1 Patrick McGarry <pmcgarry@redhat.com>
   228	      1 Patrick Dinnen <pdinnen@gmail.com>
   229	      1 Pascal Bach <pasci.bach@gmail.com>
   230	      1 Owen Synge <osynge@suse.com>
   231	      1 Nick Fisk <nick@fisk.me.uk>
   232	      1 MinSheng Lin <minsheng.l@inwinstack.com>
   233	      1 Ming Lin <ming.lin@alibaba-inc.com>
   234	      1 Michal Koutný <mkoutny@suse.com>
   235	      1 Michael Sevilla <mikesevilla3@gmail.com>
   236	      1 Michael Eischer <michael.eischer@fau.de>
   237	      1 Logan Blyth <mrbojangles3@gmail.com>
   238	      1 Liyan <liyan.wang@xtaotech.com>
   239	      1 Liu Yuhong <liuyuhong@cmss.chinamobile.com>
   240	      1 Kyr Shatskyy <kyrylo.shatskyy@gmail.com>
   241	      1 Kuan-Kai Chiu <big.chiu@bigtera.com>
   242	      1 Karol Mroz <kmroz@suse.com>
   243	      1 John Lin <johnlinp@gmail.com>
   244	      1 Joe Buck <jbbuck@gmail.com>
   245	      1 Jianyu Li <joannyli@foxmail.com>
   246	      1 Jeff Green <jeffgreen@jpgit.com>
   247	      1 Jeegn Chen <jeegnchen@gmail.com>
   248	      1 Javier M. Mellid <jmunhoz@igalia.com>
   249	      1 Jamin W. Collins <jamin.collins@gmail.com>
   250	      1 James Liu <james.liu@alibaba-inc.com>
   251	      1 Ira Cooper <ira@samba.org>
   252	      1 Ilya Shipitsin <chipitsine@gmail.com>
   253	      1 Ilsoo Byun <ilsoo.byun@sk.com>
   254	      1 Henry Chang <henry_chang@bigtera.com>
   255	      1 Harald Klein <hari@vt100.at>
   256	      1 haodong.tang <tanghaodong25@gmail.com>
   257	      1 Gu Zhongyan <guzhongyan@ceph01v.ops.corp.qihoo.net>
   258	      1 Guo-Fu Tseng <david_tseng@bigtera.com>
   259	      1 Guillaume Abrioux <gabrioux@redhat.com>
   260	      1 Giovani Rinaldi <gr.gigio@terra.com.br>
   261	      1 Edgaras Lukosevicius <edgaras.lukosevicius@gmail.com>
   262	      1 craigchi <craig10624@gmail.com>
   263	      1 clove <clove@zte.com.cn>
   264	      1 Chen Hg <mesfet@126.com>
   265	      1 Chenfang Xian <chenfangxian@cmss.chinamobile.com>
   266	      1 Avner BenHanoch <avnerb@mellanox.com>
   267	      1 Andrew Shewmaker <agshew@gmail.com>
   268	      1 Allen Samuels <allen.samuels@sandisk.com>
   269	      1 Alessandro Barbieri <ale.barbio@alice.it>
   270	      1 Aleksei Gutikov <aleksey.gutikov@synesis.ru>
   271	      1 Alan Somers <asomers@gmail.com>

Commits, by organizations
     1	   4631 Red Hat <contact@redhat.com>
     2	    374 SUSE <contact@suse.com>
     3	    370 ZTE <contact@zte.com.cn>
     4	    370 Mirantis <contact@mirantis.com>
     5	    287 Unaffiliated <no@organization.net>
     6	    144 China Mobile <contact@chinamobile.com>
     7	    118 XSky <contact@xsky.com>
     8	    108 Digiware <contact@digiware.nl>
     9	     70 Intel <contact@intel.com>
    10	     48 Easystack <contact@easystack.cn>
    11	     44 Kylin Cloud <contact@kylin-cloud.com>
    12	     44 Istuary Innovation Group <contact@istuary.com>
    13	     39 Inktank <contact@inktank.com>
    14	     37 EISOO <contact@eisoo.com>
    15	     36 UMCloud <contact@umcloud.com>
    16	     35 Mellanox <contact@mellanox.com>
    17	     31 Deutsche Telekom <contact@telekom.de>
    18	     30 OVH <ceph@ovh.net>
    19	     25 Alibaba <contact@alibaba-inc.com>
    20	     24 Reliance Jio Infocomm Ltd. <contact@ril.com>
    21	     20 Trendy Tech <contact@trendytech.com.cn>
    22	     17 H3C <contact@h3c.com>
    23	     15 Wido 42on <contact@42on.com>
    24	     13 Quantum Corporation <info@quantum.com>
    25	     11 UnitedStack <contact@unitedstack.com>
    26	     11 T2Cloud <contact@t2cloud.net>
    27	     10 Tencent <contact@tencent.com>
    28	     10 Chunghwa Telecom <contact@cht.com.tw>
    29	      9 SanDisk <contact@sandisk.com>
    30	      8 Wanda ffan <contact@wanda.cn>
    31	      6 Walmart Labs <contact@walmartlabs.com>
    32	      6 Flipkart <contact@flipkart.com>
    33	      6 Ebay <contact@ebay.com>
    34	      6 Bigtera <contact@bigtera.com>
    35	      5 IBM <contact@IBM.com>
    36	      5 Eayun <contact@eayun.com>
    37	      5 Cloudwatt <libre.licensing@cloudwatt.com>
    38	      5 Canonical <contact@canonical.com>
    39	      4 Virtuozzo <contact@virtuozzo.com>
    40	      4 CERN <contact@cern.ch>
    41	      3 X-ion GmbH <contact@x-ion.de>
    42	      3 Proxmox Server Solutions GmbH <office@proxmox.com>
    43	      3 DreamHost <contact@dreamhost.com>
    44	      3 99Cloud Inc <contact@99cloud.net>
    45	      2 XTao Co. Ltd. <contact@xtaotech.com>
    46	      2 Uber Technologies Inc. <contact@uber.com>
    47	      2 Salesforce <contact@salesforce.com>
    48	      2 Oracle <contact@oracle.com>
    49	      2 Neunn <service@neunn.com>
    50	      2 Linaro <contact@linaro.org>
    51	      2 LETV <contact@letv.com>
    52	      2 Huazhong University of Science and Technology <contact@hust.edu.cn>
    53	      2 GoDaddy <contact@godaddy.com>
    54	      2 ESPOL <contact@espol.edu.ec>
    55	      2 DigitalOcean <contact@digitalocean.com>
    56	      2 Chinac <info@chinac.com>
    57	      2 Catalysts <office@catalysts.cc>
    58	      2 Budgetenergie <itbeheer@budgetenergie.nl>
    59	      1 Viva64 <contact@viva64.com>
    60	      1 University of California, Santa Cruz <contact@cs.ucsc.edu>
    61	      1 Tera <contact@tera.com.br>
    62	      1 Synesis <contact@synesis.ru>
    63	      1 Spectra Logic <contact@spectralogic.com>
    64	      1 SK Telecom <rnd@sktelecom.com>
    65	      1 Liyan <liyan.wang@xtaotech.com>
    66	      1 inwinSTACK inc. <leo.l@inwinstack.com>
    67	      1 Inspur <contact@inspur.com>
    68	      1 Indraprastha Institute of Information Technology, Delhi <contact@iiitd.ac.in>
    69	      1 Igalia <contact@igalia.com>
    70	      1 Gentoo <contact@gentoo.org>
    71	      1 FAU <contact@fau.de>
    72	      1 Cloudin <contact@cloudin>

Reviews, by authors (one review spans multiple commits)
     1	    602 Sage Weil <sweil@redhat.com>
     2	    570 Kefu Chai <kchai@redhat.com>
     3	    221 Casey Bodley <cbodley@redhat.com>
     4	    169 Josh Durgin <jdurgin@redhat.com>
     5	    161 Jason Dillaman <dillaman@redhat.com>
     6	    129 John Spray <jspray@redhat.com>
     7	     99 Haomai Wang <haomai@xsky.com>
     8	     90 Mykola Golub <mgolub@mirantis.com>
     9	     80 Greg Farnum <gfarnum@redhat.com>
    10	     78 Loic Dachary <ldachary@redhat.com>
    11	     75 Xie Xingguo <xie.xingguo@zte.com.cn>
    12	     68 Igor Fedotov <ifedotov@mirantis.com>
    13	     67 Jos Collin <jcollin@redhat.com>
    14	     61 Patrick Donnelly <pdonnell@redhat.com>
    15	     59 Yehuda Sadeh <ysadehwe@redhat.com>
    16	     57 Yan, Zheng <zyan@redhat.com>
    17	     52 Brad Hubbard <bhubbard@redhat.com>
    18	     44 Orit Wasserman <owasserm@redhat.com>
    19	     35 Abhishek Lekshmanan <abhishek@suse.com>
    20	     26 Nathan Cutler <ncutler@suse.com>
    21	     25 Willem Jan Withagen <wjw@digiware.nl>
    22	     23 Radoslaw Zarzynski <rzarzyns@redhat.com>
    23	     20 Ken Dreyer <kdreyer@redhat.com>
    24	     17 João Eduardo Luís <joao@suse.de>
    25	     17 Daniel Gryniewicz <dang@redhat.com>
    26	     17 Alfredo Deza <adeza@redhat.com>
    27	     17 Adam C. Emerson <aemerson@redhat.com>
    28	     16 Samuel Just <sjust@redhat.com>
    29	     16 David Zafman <dzafman@redhat.com>
    30	     15 Matt Benjamin <mbenjamin@redhat.com>
    31	     13 Yuri Weinstein <yuriw@redhat.com>
    32	     13 Boris Ranto <branto@redhat.com>
    33	     12 Pan Liu <pan.liu@istuary.com>
    34	     12 Dan Mick <dmick@redhat.com>
    35	     10 Adir Lev <adirl@mellanox.com>
    36	      8 Varada Kari <varada.kari@sandisk.com>
    37	      5 Mark Nelson <mnelson@redhat.com>
    38	      5 Chang Liu <liuchang0812@gmail.com>
    39	      4 Ilya Dryomov <idryomov@redhat.com>
    40	      3 Venky Shankar <vshankar@redhat.com>
    41	      3 Ricardo Dias <rdias@suse.com>
    42	      3 Ramesh Chander <Ramesh.Chander@sandisk.com>
    43	      3 Radoslaw Zarzynski <rzarzynski@redhat.com>
    44	      3 Pritha Srivastava <prsrivas@redhat.com>
    45	      3 Neha Ojha <nojha@redhat.com>
    46	      3 John Wilkins <jwilkins@redhat.com>
    47	      3 J. Eric Ivancich <ivancich@redhat.com>
    48	      3 Jeff Layton <jlayton@redhat.com>
    49	      3 Dongsheng Yang <dongsheng.yang@easystack.cn>
    50	      3 David Disseldorp <ddiss@suse.de>
    51	      3 Adam Kupczyk <akupczyk@redhat.com>
    52	      2 Wido den Hollander <wido@42on.com>
    53	      2 Vasu Kulkarni <vasu@redhat.com>
    54	      2 Sébastien Han <shan@redhat.com>
    55	      2 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
    56	      2 Piotr Dałek <piotr.dalek@corp.ovh.com>
    57	      2 Pan Liu <wanjun.lp@alibaba-inc.com>
    58	      2 Douglas Fuller <dfuller@redhat.com>
    59	      2 Alexey Sheplyakov <asheplyakov@mirantis.com>
    60	      1 Коренберг Марк <socketpair@gmail.com>
    61	      1 Zhiqiang Wang <zhiqiang@xsky.com>
    62	      1 Warren Usui <wusui@redhat.com>
    63	      1 Tim Serong <tserong@suse.com>
    64	      1 Tamil Muthamizhan <tmuthami@redhat.com>
    65	      1 Robin H. Johnson <robbat2@gentoo.org>
    66	      1 Ren Huanwen <ren.huanwen@zte.com.cn>
    67	      1 Orit wasserman <owasserm@redhat.com>
    68	      1 Mike Christie <mchristi@redhat.com>
    69	      1 Michal Koutný <mkoutny@suse.com>
    70	      1 Michael Sevilla <mikesevilla3@gmail.com>
    71	      1 Jiaying Ren <jiaying.ren@umcloud.com>
    72	      1 Jianpeng Ma <jianpeng@intel.com>
    73	      1 Ian Colle <icolle@redhat.com>
    74	      1 Eric Ivancich <ivancich@redhat.com>
    75	      1 Dan MIck <dmick@redhat.com>
    76	      1 Chunmei Liu <chunmei.liu@intel.com>
    77	      1 Bassam Tabbara <Bassam.Tabbara@Quantum.com>
    78	      1 Bassam Tabbara <bassam.tabbara@quantum.com>
    79	      1 Andrew Schoen <aschoen@redhat.com>
    80	      1 Amit Kumar <amitkuma@redhat.com>
    81	      1 Amir Vadai <amir@vadai.me>
    82	      1 Allen Samuels <allen.samuels@sandisk.com>
    83	      1 Ali Maredia <amaredia@redhat.com>
    84	      1 Adam C. Emerson <aemerson@linuxbox.com>

Reviews, by organizations (one review spans multiple commits)
     1	   2539 Red Hat <contact@redhat.com>
     2	    185 Mirantis <contact@mirantis.com>
     3	    100 XSky <contact@xsky.com>
     4	     86 SUSE <contact@suse.com>
     5	     76 ZTE <contact@zte.com.cn>
     6	     25 Digiware <contact@digiware.nl>
     7	     12 SanDisk <contact@sandisk.com>
     8	     12 Istuary Innovation Group <contact@istuary.com>
     9	     10 Mellanox <contact@mellanox.com>
    10	     10 Cloudwatt <libre.licensing@cloudwatt.com>
    11	      8 Unaffiliated <no@organization.net>
    12	      4 Inktank <contact@inktank.com>
    13	      3 Easystack <contact@easystack.cn>
    14	      2 Wido 42on <contact@42on.com>
    15	      2 Quantum Corporation <info@quantum.com>
    16	      2 OVH <ceph@ovh.net>
    17	      2 Intel <contact@intel.com>
    18	      2 Fujitsu <contact@fujitsu.com>
    19	      2 Alibaba <contact@alibaba-inc.com>
    20	      1 UMCloud <contact@umcloud.com>
    21	      1 The Linux Box <contact@linuxbox.com>
    22	      1 Gentoo <contact@gentoo.org>

-- 
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
