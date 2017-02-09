From: Loic Dachary <loic@dachary.org>
Subject: v12.0.0 Contributor credits
Date: Fri, 10 Feb 2017 00:10:04 +0100
Message-ID: <2cc997fb-f1a8-2743-d07f-2336c5f4e09a@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60671 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdBIXKL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2017 18:10:11 -0500
Received: from mfilter10-d.gandi.net (mfilter10-d.gandi.net [217.70.178.139])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id A65D9A80CD
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 00:10:07 +0100 (CET)
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter10-d.gandi.net (mfilter10-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id VGewSzk_X0Zr for <ceph-devel@vger.kernel.org>;
        Fri, 10 Feb 2017 00:10:05 +0100 (CET)
Received: from [192.168.3.6] (x4e37ae53.dyn.telefonica.de [78.55.174.83])
        (Authenticated sender: loic@dachary.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 66672A80CE
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 00:10:05 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v12.0.0, by number of commits or reviews back to kraken. The
affiliation of authors to organizations can be updated by submitting a
patch to https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenance_guide

Number of lines added and removed, by authors
     1	 10648 Ricardo Dias <rdias@suse.com>
     2	  6422 Sage Weil <sweil@redhat.com>
     3	  5907 Adam C. Emerson <aemerson@redhat.com>
     4	  5574 Mykola Golub <mgolub@mirantis.com>
     5	  5160 Jason Dillaman <dillaman@redhat.com>
     6	  3723 Adir Lev <adirl@mellanox.com>
     7	  3274 Pritha Srivastava <prsrivas@redhat.com>
     8	  2226 Igor Fedotov <ifedotov@mirantis.com>
     9	  2163 Amir Vadai <amir@vadai.me>
    10	  1719 Nathan Cutler <ncutler@suse.com>
    11	   993 Yan, Zheng <zyan@redhat.com>
    12	   946 Kefu Chai <kchai@redhat.com>
    13	   910 Samuel Just <sjust@redhat.com>
    14	   775 Chang Liu <liuchang0812@gmail.com>
    15	   761 Pan Liu <pan.liu@istuary.com>
    16	   573 Loic Dachary <ldachary@redhat.com>
    17	   471 Venky Shankar <vshankar@redhat.com>
    18	   467 Anjaneya Chagam <anjaneya.chagam@intel.com>
    19	   446 Xie Xingguo <xie.xingguo@zte.com.cn>
    20	   436 John Spray <jspray@redhat.com>
    21	   363 Varada Kari <varada.kari@sandisk.com>
    22	   336 Bassam Tabbara <bassam.tabbara@quantum.com>
    23	   294 Haomai Wang <haomai@xsky.com>
    24	   283 Matt Benjamin <mbenjamin@redhat.com>
    25	   273 Abhishek Lekshmanan <abhishek@suse.com>
    26	   238 Willem Jan Withagen <wjw@digiware.nl>
    27	   234 Casey Bodley <cbodley@redhat.com>
    28	   198 Brad Hubbard <bhubbard@redhat.com>
    29	   197 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
    30	   176 Michal Jarzabek <stiopa@gmail.com>
    31	   158 David Zafman <dzafman@redhat.com>
    32	   145 Marcus Watts <mwatts@redhat.com>
    33	   135 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
    34	   129 Edgaras Lukosevicius <edgaras.lukosevicius@gmail.com>
    35	   118 Tamil Muthamizhan <tmuthami@redhat.com>
    36	    90 Huang Jun <hjwsm1989@gmail.com>
    37	    88 Ren Huanwen <ren.huanwen@zte.com.cn>
    38	    77 optimistyzy <optimistyzy@gmail.com>
    39	    76 Orit Wasserman <owasserm@redhat.com>
    40	    73 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
    41	    66 Mingxin Liu <mingxin@xsky.com>
    42	    53 Bartłomiej Święcki <bartlomiej.swiecki@corp.ovh.com>
    43	    52 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
    44	    50 Song Baisen <song.baisen@zte.com.cn>
    45	    45 Patrick McGarry <pmcgarry@redhat.com>
    46	    34 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    47	    32 Nick Fisk <nick@fisk.me.uk>
    48	    30 Vasu Kulkarni <vasu@redhat.com>
    49	    30 Orlando Moreno <orlando.moreno@intel.com>
    50	    29 Yehuda Sadeh <ysadehwe@redhat.com>
    51	    29 Li Wang <li.wang@kylin-cloud.com>
    52	    28 Ning Yao <yaoning@unitedstack.com>
    53	    26 Zack Cerza <zack@redhat.com>
    54	    23 Yuri Weinstein <yuriw@redhat.com>
    55	    22 Ilya Dryomov <idryomov@redhat.com>
    56	    22 Dave Chen <wei.d.chen@intel.com>
    57	    22 Allen Samuels <allen.samuels@sandisk.com>
    58	    21 Oren Duer <oren@mellanox.com>
    59	    20 Xianxia Xiao <xianxia.xiao@kylin-cloud.com>
    60	    19 Jamin W. Collins <jamin.collins@gmail.com>
    61	    17 Wido den Hollander <wido@42on.com>
    62	    17 Wei Jin <jinwei15@wanda.cn>
    63	    17 Piotr Dałek <piotr.dalek@corp.ovh.com>
    64	    15 Ma Jianpeng <jianpeng.ma@intel.com>
    65	    13 lvshuhua <lvshuhua@cmss.chinamobile.com>
    66	    13 Greg Farnum <gfarnum@redhat.com>
    67	    10 Weibing Zhang <zhangweibing@unitedstack.com>
    68	    10 Luo Runbing <runsisi@zte.com.cn>
    69	     9 Ramesh Chander <Ramesh.Chander@sandisk.com>
    70	     9 Patrick Donnelly <pdonnell@redhat.com>
    71	     9 Jan Fajerski <jfajerski@suse.com>
    72	     9 Hongtong Liu <hongtong.liu@istuary.com>
    73	     9 Dongsheng Yang <dongsheng.yang@easystack.cn>
    74	     8 wangzhengyong <wangzhengyong@cmss.chinamobile.com>
    75	     8 Jenkins <jenkins@ceph.com>
    76	     8 donglinpeng <donglinpeng@cmss.chinamobile.com>
    77	     7 Sarit Zubakov <saritz@mellanox.com>
    78	     7 Rishabh Kumar <kris.kr296@gmail.com>
    79	     7 Pascal Bach <pasci.bach@gmail.com>
    80	     7 Fang Yuxiang <fang.yuxiang@eisoo.com>
    81	     7 Avner BenHanoch <avnerb@mellanox.com>
    82	     6 Samuel Matzek <smatzek@us.ibm.com>
    83	     6 Ronak Jain <ronakjain@outlook.in>
    84	     5 Xiaoxi Chen <xiaoxchen@ebay.com>
    85	     5 Sirisha Guduru <SGuduru@walmartlabs.com>
    86	     4 Zhiqiang Wang <zhiqiang@xsky.com>
    87	     4 Yan Jun <yan.jun8@zte.com.cn>
    88	     4 Ilya Shipitsin <chipitsine@gmail.com>
    89	     3 Xinze Chi <xinze@xsky.com>
    90	     3 Jie Wang <jie.wang@kylin-cloud.com>
    91	     3 Ganesh Mahalingam <ganesh.mahalingam@intel.com>
    92	     3 Chuanhong Wang <wang.chuanhong@zte.com.cn>
    93	     2 Yankun Li <liyankun@unitedstack.com>
    94	     2 Michal Koutný <mkoutny@suse.com>
    95	     2 Liu Yang <yippeetry@gmail.com>
    96	     2 John Coyle <dx9err@gmail.com>
    97	     2 Gu Zhongyan <guzhongyan@360.cn>
    98	     1 Yixun Lan <dlan@gentoo.org>
    99	     1 Tang Jin <tang.jin@istuary.com>
   100	     1 John Lin <johnlinp@gmail.com>
   101	     1 Dan Mick <dmick@redhat.com>

Number of lines added and removed, by organization
     1	 26465 Red Hat <contact@redhat.com>
     2	 12651 SUSE <contact@suse.com>
     3	  7834 Mirantis <contact@mirantis.com>
     4	  3758 Mellanox <contact@mellanox.com>
     5	  2769 Unaffiliated <no@organization.net>
     6	   775 Tencent <contact@tencent.com>
     7	   771 Istuary Innovation Group <contact@istuary.com>
     8	   601 ZTE <contact@zte.com.cn>
     9	   537 Intel <contact@intel.com>
    10	   394 SanDisk <contact@sandisk.com>
    11	   367 XSky <contact@xsky.com>
    12	   336 Quantum Corporation <info@quantum.com>
    13	   249 Kylin Cloud <contact@kylin-cloud.com>
    14	   238 Digiware <contact@digiware.nl>
    15	   237 China Mobile <contact@chinamobile.com>
    16	    70 OVH <ceph@ovh.net>
    17	    45 Inktank <contact@inktank.com>
    18	    40 UnitedStack <contact@unitedstack.com>
    19	    17 Wido 42on <contact@42on.com>
    20	    17 Wanda ffan <contact@wanda.cn>
    21	     9 Easystack <contact@easystack.cn>
    22	     7 EISOO <contact@eisoo.com>
    23	     6 IBM <contact@IBM.com>
    24	     5 Walmart Labs <contact@walmartlabs.com>
    25	     5 Ebay <contact@ebay.com>
    26	     1 Gentoo <contact@gentoo.org>

Commits, by authors
     1	    118 Sage Weil <sweil@redhat.com>
     2	     64 Abhishek Lekshmanan <abhishek@suse.com>
     3	     47 Yan, Zheng <zyan@redhat.com>
     4	     38 Jason Dillaman <dillaman@redhat.com>
     5	     28 Xie Xingguo <xie.xingguo@zte.com.cn>
     6	     28 Mykola Golub <mgolub@mirantis.com>
     7	     24 Kefu Chai <kchai@redhat.com>
     8	     23 Willem Jan Withagen <wjw@digiware.nl>
     9	     23 Nathan Cutler <ncutler@suse.com>
    10	     23 Igor Fedotov <ifedotov@mirantis.com>
    11	     17 Chang Liu <liuchang0812@gmail.com>
    12	     16 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
    13	     16 Brad Hubbard <bhubbard@redhat.com>
    14	     16 Adam C. Emerson <aemerson@redhat.com>
    15	     15 Pan Liu <pan.liu@istuary.com>
    16	     15 John Spray <jspray@redhat.com>
    17	     14 Haomai Wang <haomai@xsky.com>
    18	     12 Pritha Srivastava <prsrivas@redhat.com>
    19	     12 Li Wang <li.wang@kylin-cloud.com>
    20	     11 Ricardo Dias <rdias@suse.com>
    21	     11 Huang Jun <hjwsm1989@gmail.com>
    22	     10 Matt Benjamin <mbenjamin@redhat.com>
    23	      8 Ren Huanwen <ren.huanwen@zte.com.cn>
    24	      8 Orit Wasserman <owasserm@redhat.com>
    25	      8 Mingxin Liu <mingxin@xsky.com>
    26	      7 Marcus Watts <mwatts@redhat.com>
    27	      7 David Zafman <dzafman@redhat.com>
    28	      7 Casey Bodley <cbodley@redhat.com>
    29	      6 Xianxia Xiao <xianxia.xiao@kylin-cloud.com>
    30	      6 Varada Kari <varada.kari@sandisk.com>
    31	      6 Samuel Just <sjust@redhat.com>
    32	      6 optimistyzy <optimistyzy@gmail.com>
    33	      6 Bassam Tabbara <bassam.tabbara@quantum.com>
    34	      5 Song Baisen <song.baisen@zte.com.cn>
    35	      4 Wei Jin <jinwei15@wanda.cn>
    36	      4 Venky Shankar <vshankar@redhat.com>
    37	      4 Tamil Muthamizhan <tmuthami@redhat.com>
    38	      4 Michal Jarzabek <stiopa@gmail.com>
    39	      4 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
    40	      4 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
    41	      4 Dave Chen <wei.d.chen@intel.com>
    42	      4 Amir Vadai <amir@vadai.me>
    43	      4 Adir Lev <adirl@mellanox.com>
    44	      3 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
    45	      3 Yuri Weinstein <yuriw@redhat.com>
    46	      3 Wido den Hollander <wido@42on.com>
    47	      3 Vasu Kulkarni <vasu@redhat.com>
    48	      3 Oren Duer <oren@mellanox.com>
    49	      3 Luo Runbing <runsisi@zte.com.cn>
    50	      2 Yehuda Sadeh <ysadehwe@redhat.com>
    51	      2 Xinze Chi <xinze@xsky.com>
    52	      2 Weibing Zhang <zhangweibing@unitedstack.com>
    53	      2 Sarit Zubakov <saritz@mellanox.com>
    54	      2 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    55	      2 Orlando Moreno <orlando.moreno@intel.com>
    56	      2 Ma Jianpeng <jianpeng.ma@intel.com>
    57	      2 lvshuhua <lvshuhua@cmss.chinamobile.com>
    58	      2 Loic Dachary <ldachary@redhat.com>
    59	      2 Hongtong Liu <hongtong.liu@istuary.com>
    60	      2 Fang Yuxiang <fang.yuxiang@eisoo.com>
    61	      2 Dongsheng Yang <dongsheng.yang@easystack.cn>
    62	      2 Bartłomiej Święcki <bartlomiej.swiecki@corp.ovh.com>
    63	      2 Anjaneya Chagam <anjaneya.chagam@intel.com>
    64	      1 Zhiqiang Wang <zhiqiang@xsky.com>
    65	      1 Zack Cerza <zack@redhat.com>
    66	      1 Yixun Lan <dlan@gentoo.org>
    67	      1 Yankun Li <liyankun@unitedstack.com>
    68	      1 Yan Jun <yan.jun8@zte.com.cn>
    69	      1 Xiaoxi Chen <xiaoxchen@ebay.com>
    70	      1 wangzhengyong <wangzhengyong@cmss.chinamobile.com>
    71	      1 Tang Jin <tang.jin@istuary.com>
    72	      1 Sirisha Guduru <SGuduru@walmartlabs.com>
    73	      1 Samuel Matzek <smatzek@us.ibm.com>
    74	      1 Ronak Jain <ronakjain@outlook.in>
    75	      1 Rishabh Kumar <kris.kr296@gmail.com>
    76	      1 Ramesh Chander <Ramesh.Chander@sandisk.com>
    77	      1 Piotr Dałek <piotr.dalek@corp.ovh.com>
    78	      1 Patrick McGarry <pmcgarry@redhat.com>
    79	      1 Patrick Donnelly <pdonnell@redhat.com>
    80	      1 Pascal Bach <pasci.bach@gmail.com>
    81	      1 Ning Yao <yaoning@unitedstack.com>
    82	      1 Nick Fisk <nick@fisk.me.uk>
    83	      1 Michal Koutný <mkoutny@suse.com>
    84	      1 Liu Yang <yippeetry@gmail.com>
    85	      1 John Lin <johnlinp@gmail.com>
    86	      1 John Coyle <dx9err@gmail.com>
    87	      1 Jie Wang <jie.wang@kylin-cloud.com>
    88	      1 Jenkins <jenkins@ceph.com>
    89	      1 Jan Fajerski <jfajerski@suse.com>
    90	      1 Jamin W. Collins <jamin.collins@gmail.com>
    91	      1 Ilya Shipitsin <chipitsine@gmail.com>
    92	      1 Ilya Dryomov <idryomov@redhat.com>
    93	      1 Gu Zhongyan <guzhongyan@360.cn>
    94	      1 Greg Farnum <gfarnum@redhat.com>
    95	      1 Ganesh Mahalingam <ganesh.mahalingam@intel.com>
    96	      1 Edgaras Lukosevicius <edgaras.lukosevicius@gmail.com>
    97	      1 donglinpeng <donglinpeng@cmss.chinamobile.com>
    98	      1 Dan Mick <dmick@redhat.com>
    99	      1 Chuanhong Wang <wang.chuanhong@zte.com.cn>
   100	      1 Avner BenHanoch <avnerb@mellanox.com>
   101	      1 Allen Samuels <allen.samuels@sandisk.com>

Commits, by organizations
     1	    355 Red Hat <contact@redhat.com>
     2	    100 SUSE <contact@suse.com>
     3	     53 Mirantis <contact@mirantis.com>
     4	     46 ZTE <contact@zte.com.cn>
     5	     40 Unaffiliated <no@organization.net>
     6	     35 Kylin Cloud <contact@kylin-cloud.com>
     7	     25 XSky <contact@xsky.com>
     8	     23 Digiware <contact@digiware.nl>
     9	     18 Istuary Innovation Group <contact@istuary.com>
    10	     17 Tencent <contact@tencent.com>
    11	     11 Intel <contact@intel.com>
    12	     11 China Mobile <contact@chinamobile.com>
    13	     10 Mellanox <contact@mellanox.com>
    14	      8 SanDisk <contact@sandisk.com>
    15	      6 Quantum Corporation <info@quantum.com>
    16	      4 Wanda ffan <contact@wanda.cn>
    17	      4 UnitedStack <contact@unitedstack.com>
    18	      3 Wido 42on <contact@42on.com>
    19	      3 OVH <ceph@ovh.net>
    20	      2 EISOO <contact@eisoo.com>
    21	      2 Easystack <contact@easystack.cn>
    22	      1 Walmart Labs <contact@walmartlabs.com>
    23	      1 Inktank <contact@inktank.com>
    24	      1 IBM <contact@IBM.com>
    25	      1 Gentoo <contact@gentoo.org>
    26	      1 Ebay <contact@ebay.com>

Reviews, by authors (one review spans multiple commits)
     1	     93 Sage Weil <sweil@redhat.com>
     2	     76 Kefu Chai <kchai@redhat.com>
     3	     35 Jason Dillaman <dillaman@redhat.com>
     4	     28 Haomai Wang <haomai@xsky.com>
     5	     22 Igor Fedotov <ifedotov@mirantis.com>
     6	     19 Mykola Golub <mgolub@mirantis.com>
     7	     18 John Spray <jspray@redhat.com>
     8	     17 Josh Durgin <jdurgin@redhat.com>
     9	     14 Xie Xingguo <xie.xingguo@zte.com.cn>
    10	     14 Casey Bodley <cbodley@redhat.com>
    11	     13 Greg Farnum <gfarnum@redhat.com>
    12	     12 Samuel Just <sjust@redhat.com>
    13	      8 Loic Dachary <ldachary@redhat.com>
    14	      6 Yehuda Sadeh <ysadehwe@redhat.com>
    15	      6 Brad Hubbard <bhubbard@redhat.com>
    16	      5 Yuri Weinstein <yuriw@redhat.com>
    17	      5 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    18	      4 Patrick Donnelly <pdonnell@redhat.com>
    19	      4 Alfredo Deza <adeza@redhat.com>
    20	      3 Yan, Zheng <zyan@redhat.com>
    21	      3 Ramesh Chander <Ramesh.Chander@sandisk.com>
    22	      3 Pan Liu <pan.liu@istuary.com>
    23	      3 João Eduardo Luís <joao@suse.de>
    24	      3 Abhishek Lekshmanan <abhishek@suse.com>
    25	      2 Willem Jan Withagen <wjw@digiware.nl>
    26	      2 Varada Kari <varada.kari@sandisk.com>
    27	      2 Ricardo Dias <rdias@suse.com>
    28	      2 Nathan Cutler <ncutler@suse.com>
    29	      2 Jeff Layton <jlayton@redhat.com>
    30	      2 David Zafman <dzafman@redhat.com>
    31	      2 Dan Mick <dmick@redhat.com>
    32	      2 Chang Liu <liuchang0812@gmail.com>
    33	      2 Adir Lev <adirl@mellanox.com>
    34	      1 Коренберг Марк <socketpair@gmail.com>
    35	      1 Orit wasserman <owasserm@redhat.com>
    36	      1 Michal Koutný <mkoutny@suse.com>
    37	      1 Ilya Dryomov <idryomov@redhat.com>
    38	      1 Dan MIck <dmick@redhat.com>
    39	      1 Daniel Gryniewicz <dang@redhat.com>
    40	      1 Amir Vadai <amir@vadai.me>
    41	      1 Allen Samuels <allen.samuels@sandisk.com>
    42	      1 Ali Maredia <amaredia@redhat.com>
    43	      1 Adam C. Emerson <aemerson@redhat.com>

Reviews, by organizations (one review spans multiple commits)
     1	    326 Red Hat <contact@redhat.com>
     2	     46 Mirantis <contact@mirantis.com>
     3	     28 XSky <contact@xsky.com>
     4	     14 ZTE <contact@zte.com.cn>
     5	     11 SUSE <contact@suse.com>
     6	      6 SanDisk <contact@sandisk.com>
     7	      3 Istuary Innovation Group <contact@istuary.com>
     8	      2 Unaffiliated <no@organization.net>
     9	      2 Tencent <contact@tencent.com>
    10	      2 Mellanox <contact@mellanox.com>
    11	      2 Digiware <contact@digiware.nl>


-- 
Loïc Dachary, Artisan Logiciel Libre

