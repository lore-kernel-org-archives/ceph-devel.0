From: Yann Dupont <yann@objoo.org>
Subject: v11.0.2 (Kraken first dev release) contributor credits
Date: Wed, 19 Oct 2016 07:03:21 +0200
Message-ID: <c793e957-ef45-e137-b0ae-b8a391f741cb@objoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 2.mo179.mail-out.ovh.net ([178.33.250.45]:34063 "EHLO
        2.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbcJSFWh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Oct 2016 01:22:37 -0400
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 676C9231A
        for <ceph-devel@vger.kernel.org>; Wed, 19 Oct 2016 07:03:23 +0200 (CEST)
Received: from [192.168.21.21] (familledupont.org [78.201.40.7])
        (Authenticated sender: yann@objoo.org)
        by player732.ha.ovh.net (Postfix) with ESMTPSA id C1DBE100069
        for <ceph-devel@vger.kernel.org>; Wed, 19 Oct 2016 07:03:22 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Happy Cephers,

As Abhishek previously announced, v11.0.2 first development checkpoint 
for Kraken has been released. Nearly 6 months of hard work for all 
developers involved (First stable release for Jewel, v10.2.0, was April 
20). Kudos to all of them.

So now, here is the (long !) sorted list of authors and organizations 
who contributed to v11.0.2, by number of commits or reviews back to 
latest current stable version v10.2.0.

The affiliation of authors to organizations can be updated by submitting 
a patch to https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the 
number of commits. More often than not, the reviewer(s) is only 
mentioned in the message of the merge although it means that all 
associated commits have been reviewed. If you are curious about how it 
is done, do checkout the wiki entry at 
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenance_guide 
.

Number of lines added and removed, by authors
      1     51031 Sage Weil <sweil@redhat.com>
      2     32463 Jason Dillaman <dillaman@redhat.com>
      3     26383 John Spray <jspray@redhat.com>
      4     13840 Mykola Golub <mgolub@mirantis.com>
      5     10178 Warren Usui <wusui@redhat.com>
      6      9096 Radoslaw Zarzynski <rzarzynski@mirantis.com>
      7      8867 Kefu Chai <kchai@redhat.com>
      8      7363 Haomai Wang <haomai@xsky.com>
      9      7016 Ramesh Chander <Ramesh.Chander@sandisk.com>
     10      6452 Abhishek Lekshmanan <abhishek@suse.com>
     11      6011 Xie Xingguo <xie.xingguo@zte.com.cn>
     12      5440 Ricardo Dias <rdias@suse.com>
     13      4797 Igor Fedotov <ifedotov@mirantis.com>
     14      4228 Greg Farnum <gfarnum@redhat.com>
     15      3751 Casey Bodley <cbodley@redhat.com>
     16      3722 Victor Denisov <denisovenator@gmail.com>
     17      3580 Noah Watkins <nwatkins@redhat.com>
     18      3560 Yan, Zheng <zyan@redhat.com>
     19      3536 Samuel Just <sjust@redhat.com>
     20      3323 Michal Jarzabek <stiopa@gmail.com>
     21      2990 Nathan Cutler <ncutler@suse.com>
     22      2742 Venky Shankar <vshankar@redhat.com>
     23      2205 Oleh Prypin <oleh@pryp.in>
     24      1976 Ji Chen <insomnia@139.com>
     25      1892 Bassam Tabbara <bassam.tabbara@quantum.com>
     26      1840 Douglas Fuller <dfuller@redhat.com>
     27      1773 Yehuda Sadeh <ysadehwe@redhat.com>
     28      1696 Jeff Layton <jlayton@redhat.com>
     29      1626 Matt Benjamin <mbenjamin@redhat.com>
     30      1590 Dongsheng Yang <dongsheng.yang@easystack.cn>
     31      1568 Anirudha Bose <ani07nov@gmail.com>
     32      1501 David Zafman <dzafman@redhat.com>
     33      1426 Ali Maredia <amaredia@redhat.com>
     34      1176 zhouruisong <236131368@qq.com>
     35      1115 Frank Filz <ffilz@redhat.com>
     36      1051 Pritha Srivastava <prsrivas@redhat.com>
     37      1028 Willem Jan Withagen <wjw@digiware.nl>
     38       949 Josh Durgin <jdurgin@redhat.com>
     39       928 Daniel Gryniewicz <dang@redhat.com>
     40       919 Li Tianqing <tianqing@unitedstack.com>
     41       825 Xiaowei Chen <chen.xiaowei@h3c.com>
     42       753 David Disseldorp <ddiss@suse.de>
     43       694 Varada Kari <varada.kari@sandisk.com>
     44       671 Kiseleva Alyona <akiselyova@mirantis.com>
     45       657 Patrick Donnelly <pdonnell@redhat.com>
     46       565 Piotr Dałek <git@predictor.org.pl>
     47       546 Roushan Ali <roushan.ali@sandisk.com>
     48       545 Ramana Raja <rraja@redhat.com>
     49       512 Yan Jun <yan.jun8@zte.com.cn>
     50       495 Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
     51       483 Ren Huanwen <ren.huanwen@zte.com.cn>
     52       477 Ken Dreyer <kdreyer@redhat.com>
     53       473 Robin H. Johnson <robin.johnson@dreamhost.com>
     54       460 J. Eric Ivancich <ivancich@redhat.com>
     55       459 Ma Jianpeng <jianpeng.ma@intel.com>
     56       452 Avner BenHanoch <avnerb@mellanox.com>
     57       423 Hector Martin <marcan@marcan.st>
     58       389 Zhi Zhang <willzzhang@tencent.com>
     59       379 Zhiqiang Wang <zhiqiang@xsky.com>
     60       370 Daniel Gollub <d.gollub@telekom.de>
     61       364 Javier M. Mellid <jmunhoz@igalia.com>
     62       358 Song Baisen <song.baisen@zte.com.cn>
     63       354 Pete Zaitcev <zaitcev@redhat.com>
     64       345 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
     65       311 John Coyle <dx9err@gmail.com>
     66       306 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
     67       288 Mehdi Abaakouk <sileht@redhat.com>
     68       281 Brad Hubbard <bhubbard@redhat.com>
     69       280 Boris Ranto <branto@redhat.com>
     70       243 Vu Pham <vu@mellanox.com>
     71       227 Allen Samuels <allen.samuels@sandisk.com>
     72       217 Karol Mroz <kmroz@suse.com>
     73       217 Jiaying Ren <mikulely@gmail.com>
     74       215 Vaibhav Bhembre <vaibhav@digitalocean.com>
     75       212 Vikhyat Umrao <vumrao@redhat.com>
     76       210 Loic Dachary <ldachary@redhat.com>
     77       204 Mingxin Liu <mingxin@xsky.com>
     78       199 Tim Serong <tserong@suse.com>
     79       193 Ilya Dryomov <idryomov@redhat.com>
     80       182 Chendi Xue <chendi.xue@intel.com>
     81       164 Adam C. Emerson <aemerson@redhat.com>
     82       160 Shehbaz Jaffer <shehbaz.jaffer@mail.utoronto.ca>
     83       154 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
     84       151 Jianjian Huo <jianjian.huo@ssi.samsung.com>
     85       138 Luo Runbing <runsisi@zte.com.cn>
     86       137 Somnath Roy <somnath.roy@sandisk.com>
     87       130 Li Peng <lip@dtdream.com>
     88       120 Vishal Kanaujia <Vishal.Kanaujia@sandisk.com>
     89       116 Lu Shi <shi.lu@h3c.com>
     90       105 Orit Wasserman <owasserm@redhat.com>
     91       105 François Lafont <flafdivers@free.fr>
     92       101 Dan Mick <dmick@redhat.com>
     93        98 Ryne Li <lizhenqiangsnake@gmail.com>
     94        95 Haodong Tang <haodong.tang@intel.com>
     95        89 Wanlong Gao <wanlong.gao@easystack.cn>
     96        87 Yann Dupont <yann@objoo.org>
     97        84 Roi Dayan <roid@mellanox.com>
     98        83 You Ji <youji@ebay.com>
     99        81 Ning Yao <yaoning@unitedstack.com>
    100        73 David Galloway <dgallowa@redhat.com>
    101        72 Iain Buclaw <iain.buclaw@sociomantic.com>
    102        69 Alfredo Deza <adeza@redhat.com>
    103        68 Mike Christie <mchristi@redhat.com>
    104        62 Roland Mechler <rmechler@cisco.com>
    105        61 Adir Lev <adirl@mellanox.com>
    106        60 Xiaoxi Chen <xiaoxchen@ebay.com>
    107        58 Colin Walters <walters@redhat.com>
    108        55 Adam Kupczyk <akupczyk@mirantis.com>
    109        54 Ilsoo Byun <ilsoo.byun@sk.com>
    110        50 Zengran Zhang <zhangzengran@h3c.com>
    111        49 Jon Bernard <jbernard@tuxion.com>
    112        48 Jesse Williamson <jesse.williamson@suse.com>
    113        46 Harald Klein <hari@vt100.at>
    114        43 Mark Nelson <mnelson@redhat.com>
    115        40 Zhang Zezhu <zhang.zezhu@zte.com.cn>
    116        40 Erwan Velu <erwan@redhat.com>
    117        39 Peter Maloney <peter.maloney@yahoo.ca>
    118        37 Weibing Zhang <zhangweibing@unitedstack.com>
    119        37 Jan Fajerski <jfajerski@suse.com>
    120        36 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
    121        33 Yang Honggang <joseph.yang@xtaotech.com>
    122        33 Wei Jin <wjin.cn@gmail.com>
    123        32 Yongqiang He <he.yongqiang@h3c.com>
    124        30 Wido den Hollander <wido@42on.com>
    125        29 Steven Dieffenbach <sdieffen@redhat.com>
    126        28 Chengwei Yang <yangchengwei@qiyi.com>
    127        26 Yuan Zhou <yuan.zhou@intel.com>
    128        26 Tamil Muthamizhan <tmuthami@redhat.com>
    129        25 Tao Chang <changtao@hihuron.com>
    130        24 Vladislav Odintsov <odivlad@gmail.com>
    131        24 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
    132        23 Etienne Menguy <etienne.menguy@corp.ovh.com>
    133        22 Shu, Xinxin <xinxin.shu@intel.com>
    134        22 Shinobu Kinjo <shinobu@redhat.com>
    135        22 Dan Horák <dan@danny.cz>
    136        22 Chang-Yi Lee <cy.l@inwinstack.com>
    137        20 Luo Kexue <luo.kexue@zte.com.cn>
    138        19 Min Chen <chenmin@xsky.com>
    139        19 Michel Normand <normand@linux.vnet.ibm.com>
    140        16 Zhao Junwang <zhjwpku@gmail.com>
    141        16 Li Wang <li.wang@kylin-cloud.com>
    142        16 Jim Wright <jim@quadraturecapital.com>
    143        16 Jenkins <jenkins@ceph.com>
    144        15 Igor Podoski <igor.podoski@ts.fujitsu.com>
    145        14 Weijun Duan <duanweijun@h3c.com>
    146        14 MinSheng Lin <minsheng.l@inwinstack.com>
    147        13 Huan Zhang <zhanghuan@chinac.com>
    148        13 Alexey Sheplyakov <asheplyakov@mirantis.com>
    149        13 Alexandre Derumier <aderumier@odiso.com>
    150        12 Xinze Chi <xinze@xsky.com>
    151        12 Wenjun Huang <wenjunhuang@tencent.com>
    152        12 Lan De <lan.de3@zte.com.cn>
    153        12 Dan van der Ster <daniel.vanderster@cern.ch>
    154        12 Bryan Stillwell <bryan.stillwell@twcable.com>
    155        10 Mingxin Liu <mingxin.liu@kylin-cloud.com>
    156        10 Brett Niver <bniver@redhat.com>
    157        10 Abhishek Varshney <abhishek.varshney@flipkart.com>
    158         9 Xuan Liu <liu.xuan@h3c.com>
    159         9 Thomas Serlin <tserlin@redhat.com>
    160         9 Jaemyoun Lee <jaemyoun@gmail.com>
    161         9 Ira Cooper <ira@redhat.com>
    162         9 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
    163         8 Zhuang Xiaochun <zhuangxc89@163.com>
    164         8 Yatin Kumbhare <yatinkumbhare@gmail.com>
    165         8 Feng Guo <diluga@gmail.com>
    166         7 wangsongbo <wangsongbo@unitedstack.com>
    167         7 Luo Runbing <runsisi@hust.edu.cn>
    168         7 Ignacio Bravo <ibravo@hotmail.com>
    169         6 Xinxin Shu <shuxinxin@chinac.com>
    170         6 Sirisha Guduru <SGuduru@walmartlabs.com>
    171         6 Shilpa Jagannath <smanjara@redhat.com>
    172         6 Jianjian huo <jianjian.huo@ssi.samsung.com>
    173         5 Zhenyu Leng <lengzhenyu@ict.ac.cn>
    174         5 Shylesh Kumar <shmohan@redhat.com>
    175         5 Hong Zhangoole <hong.zhangoole@gmail.com>
    176         5 Albert Tu <albert.t@inwinstack.com>
    177         4 Zhao Kun <jswps2011@163.com>
    178         4 Zhao Chao <zhaochao1984@gmail.com>
    179         4 Wu Xingyi <wuxingyi@letv.com>
    180         4 Patrick McGarry <pmcgarry@redhat.com>
    181         4 Ira Cooper <ira@samba.org>
    182         4 Gong Chuang <gong.chuang@zte.com.cn>
    183         4 Feng Yu <amoxic@126.com>
    184         3 Vasu Kulkarni <vasu@redhat.com>
    185         3 Nick Fisk <nick@fisk.me.uk>
    186         3 Na Xie <xie.na@h3c.com>
    187         3 Leo Zhang <nguzcf@gmail.com>
    188         3 Jelle vd Kooij <vdkooij.jelle@gmail.com>
    189         3 Huang Jun <hjwsm1989@gmail.com>
    190         2 Yibo Cai <yibo.cai@linaro.org>
    191         2 Xu Biao <xubiao.codeyz@gmail.com>
    192         2 Vicente Cheng <freeze.bilsted@gmail.com>
    193         2 Tianshan Qu <tianshan@xsky.com>
    194         2 shiqi <m13913886148@gmail.com>
    195         2 Ruben Kerkhof <ruben@rubenkerkhof.com>
    196         2 Qinghua Jin <qhjin_dev@163.com>
    197         2 Qiankun Zheng <zheng.qiankun@h3c.com>
    198         2 Mike Hackett <mhackett@redhat.com>
    199         2 Linfei Hou <hou.linfei@h3c.com>
    200         2 John Wilkins <jwilkins@redhat.com>
    201         2 James Page <james.page@ubuntu.com>
    202         2 James Liu <james.liu@ssi.samsung.com>
    203         2 Barbora Ančincová <bara@redhat.com>
    204         1 Gregory Meno <gmeno@redhat.com>
    205         1 Daniel Oliveira <doliveira@suse.com>

Number of lines added and removed, by organization
      1    168999 Red Hat <contact@redhat.com>
      2     32194 Mirantis <contact@mirantis.com>
      3     16137 SUSE <contact@suse.com>
      4     10455 Unaffiliated <no@organization.net>
      5      8764 SanDisk <contact@sandisk.com>
      6      7979 XSky <contact@xsky.com>
      7      7884 ZTE <contact@zte.com.cn>
      8      1980 LETV <contact@letv.com>
      9      1892 Quantum Corporation <info@quantum.com>
     10      1679 Easystack <contact@easystack.cn>
     11      1207 H3C <contact@h3c.com>
     12      1044 UnitedStack <contact@unitedstack.com>
     13      1028 Digiware <contact@digiware.nl>
     14       840 Mellanox <contact@mellanox.com>
     15       784 Intel <contact@intel.com>
     16       501 Walmart Labs <contact@walmartlabs.com>
     17       473 DreamHost <contact@dreamhost.com>
     18       401 Tencent <contact@tencent.com>
     19       370 Deutsche Telekom <contact@telekom.de>
     20       364 Igalia <contact@igalia.com>
     21       360 Fujitsu <contact@fujitsu.com>
     22       215 DigitalOcean <contact@digitalocean.com>
     23       160 University of Toronto <contact@mail.utoronto.ca>
     24       159 Samsung <contact@samsung.com>
     25       143 Ebay <contact@ebay.com>
     26       130 Dtdream <contact@dtdream.com>
     27        72 Sociomantic Labs <info@sociomantic.com>
     28        62 CISCO <contact@cisco.com>
     29        54 SK Telecom <rnd@sktelecom.com>
     30        53 Inktank <contact@inktank.com>
     31        41 inwinSTACK inc. <leo.l@inwinstack.com>
     32        30 Wido 42on <contact@42on.com>
     33        28 iQIYI <edison@qiyi.com>
     34        26 Kylin Cloud <contact@kylin-cloud.com>
     35        25 Hihuron <contact@huron.com>
     36        23 OVH <contact@corp.ovh.com>
     37        19 IBM <contact@IBM.com>
     38        19 Chinac <info@chinac.com>
     39        16 Quadrature Capital Limited <info@quadraturecapital.com>
     40        13 Odiso <contact@odiso.com>
     41        12 Time Warner Cable Inc. <contact@twcable.com>
     42        12 CERN <contact@cern.ch>
     43        10 Flipkart <contact@flipkart.com>
     44         9 Catalysts <office@catalysts.cc>
     45         7 Huazhong University of Science and Technology 
<contact@hust.edu.cn>
     46         5 ICT <contact@ict.ac.cn>
     47         2 Linaro <contact@linaro.org>
     48         2 Canonical <contact@canonical.com>

Commits, by authors
      1        608 Sage Weil <sweil@redhat.com>
      2        461 Xie Xingguo <xie.xingguo@zte.com.cn>
      3        340 Kefu Chai <kchai@redhat.com>
      4        288 Jason Dillaman <dillaman@redhat.com>
      5        139 Michal Jarzabek <stiopa@gmail.com>
      6        137 Radoslaw Zarzynski <rzarzynski@mirantis.com>
      7        128 Haomai Wang <haomai@xsky.com>
      8        127 John Spray <jspray@redhat.com>
      9        113 Greg Farnum <gfarnum@redhat.com>
     10         93 Casey Bodley <cbodley@redhat.com>
     11         85 Yan, Zheng <zyan@redhat.com>
     12         85 Mykola Golub <mgolub@mirantis.com>
     13         84 Igor Fedotov <ifedotov@mirantis.com>
     14         81 Nathan Cutler <ncutler@suse.com>
     15         69 Willem Jan Withagen <wjw@digiware.nl>
     16         66 Yehuda Sadeh <ysadehwe@redhat.com>
     17         63 Yann Dupont <yann@objoo.org>
     18         59 Yan Jun <yan.jun8@zte.com.cn>
     19         51 Ma Jianpeng <jianpeng.ma@intel.com>
     20         49 Ren Huanwen <ren.huanwen@zte.com.cn>
     21         47 Jeff Layton <jlayton@redhat.com>
     22         39 Samuel Just <sjust@redhat.com>
     23         39 Dongsheng Yang <dongsheng.yang@easystack.cn>
     24         39 David Zafman <dzafman@redhat.com>
     25         38 Matt Benjamin <mbenjamin@redhat.com>
     26         36 Anirudha Bose <ani07nov@gmail.com>
     27         35 Ricardo Dias <rdias@suse.com>
     28         33 Abhishek Lekshmanan <abhishek@suse.com>
     29         30 Patrick Donnelly <pdonnell@redhat.com>
     30         27 Oleh Prypin <oleh@pryp.in>
     31         26 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
     32         25 Ali Maredia <amaredia@redhat.com>
     33         24 Song Baisen <song.baisen@zte.com.cn>
     34         24 Brad Hubbard <bhubbard@redhat.com>
     35         22 Josh Durgin <jdurgin@redhat.com>
     36         21 Ramesh Chander <Ramesh.Chander@sandisk.com>
     37         20 Luo Runbing <runsisi@zte.com.cn>
     38         18 Xiaowei Chen <chen.xiaowei@h3c.com>
     39         18 Venky Shankar <vshankar@redhat.com>
     40         18 John Coyle <dx9err@gmail.com>
     41         16 Ken Dreyer <kdreyer@redhat.com>
     42         14 Robin H. Johnson <robin.johnson@dreamhost.com>
     43         14 Ramana Raja <rraja@redhat.com>
     44         14 Piotr Dałek <git@predictor.org.pl>
     45         14 Li Peng <lip@dtdream.com>
     46         14 Boris Ranto <branto@redhat.com>
     47         13 Tim Serong <tserong@suse.com>
     48         13 Dan Mick <dmick@redhat.com>
     49         12 Vikhyat Umrao <vumrao@redhat.com>
     50         12 Loic Dachary <ldachary@redhat.com>
     51         12 Daniel Gryniewicz <dang@redhat.com>
     52         11 Karol Mroz <kmroz@suse.com>
     53         11 Bassam Tabbara <bassam.tabbara@quantum.com>
     54         11 Avner BenHanoch <avnerb@mellanox.com>
     55         10 Jianjian Huo <jianjian.huo@ssi.samsung.com>
     56         10 Ilya Dryomov <idryomov@redhat.com>
     57          9 Orit Wasserman <owasserm@redhat.com>
     58          9 Chengwei Yang <yangchengwei@qiyi.com>
     59          8 Victor Denisov <denisovenator@gmail.com>
     60          8 Varada Kari <varada.kari@sandisk.com>
     61          8 Roi Dayan <roid@mellanox.com>
     62          8 Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
     63          8 Noah Watkins <nwatkins@redhat.com>
     64          8 Haodong Tang <haodong.tang@intel.com>
     65          8 David Disseldorp <ddiss@suse.de>
     66          7 Zhi Zhang <willzzhang@tencent.com>
     67          7 Pritha Srivastava <prsrivas@redhat.com>
     68          7 Jiaying Ren <mikulely@gmail.com>
     69          7 J. Eric Ivancich <ivancich@redhat.com>
     70          7 Douglas Fuller <dfuller@redhat.com>
     71          6 Zhang Zezhu <zhang.zezhu@zte.com.cn>
     72          6 Xiaoxi Chen <xiaoxchen@ebay.com>
     73          6 Wanlong Gao <wanlong.gao@easystack.cn>
     74          6 Mark Nelson <mnelson@redhat.com>
     75          6 Hector Martin <marcan@marcan.st>
     76          6 Alfredo Deza <adeza@redhat.com>
     77          5 Weibing Zhang <zhangweibing@unitedstack.com>
     78          5 Javier M. Mellid <jmunhoz@igalia.com>
     79          4 Wei Jin <wjin.cn@gmail.com>
     80          4 Vu Pham <vu@mellanox.com>
     81          4 Somnath Roy <somnath.roy@sandisk.com>
     82          4 Shinobu Kinjo <shinobu@redhat.com>
     83          4 Kiseleva Alyona <akiselyova@mirantis.com>
     84          4 Frank Filz <ffilz@redhat.com>
     85          4 Daniel Gollub <d.gollub@telekom.de>
     86          4 Chendi Xue <chendi.xue@intel.com>
     87          4 Alexandre Derumier <aderumier@odiso.com>
     88          4 Adir Lev <adirl@mellanox.com>
     89          4 Adam C. Emerson <aemerson@redhat.com>
     90          3 Zhiqiang Wang <zhiqiang@xsky.com>
     91          3 Yuan Zhou <yuan.zhou@intel.com>
     92          3 Yatin Kumbhare <yatinkumbhare@gmail.com>
     93          3 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
     94          3 Pete Zaitcev <zaitcev@redhat.com>
     95          3 Ning Yao <yaoning@unitedstack.com>
     96          3 Mingxin Liu <mingxin@xsky.com>
     97          3 Michel Normand <normand@linux.vnet.ibm.com>
     98          3 Luo Kexue <luo.kexue@zte.com.cn>
     99          3 Erwan Velu <erwan@redhat.com>
    100          3 Dan van der Ster <daniel.vanderster@cern.ch>
    101          3 Allen Samuels <allen.samuels@sandisk.com>
    102          2 zhouruisong <236131368@qq.com>
    103          2 Zhao Kun <jswps2011@163.com>
    104          2 Zhao Junwang <zhjwpku@gmail.com>
    105          2 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
    106          2 Zengran Zhang <zhangzengran@h3c.com>
    107          2 You Ji <youji@ebay.com>
    108          2 Yongqiang He <he.yongqiang@h3c.com>
    109          2 Xinze Chi <xinze@xsky.com>
    110          2 Xinxin Shu <shuxinxin@chinac.com>
    111          2 Wido den Hollander <wido@42on.com>
    112          2 Weijun Duan <duanweijun@h3c.com>
    113          2 Warren Usui <wusui@redhat.com>
    114          2 wangsongbo <wangsongbo@unitedstack.com>
    115          2 Vladislav Odintsov <odivlad@gmail.com>
    116          2 Vishal Kanaujia <Vishal.Kanaujia@sandisk.com>
    117          2 Tao Chang <changtao@hihuron.com>
    118          2 Tamil Muthamizhan <tmuthami@redhat.com>
    119          2 Sirisha Guduru <SGuduru@walmartlabs.com>
    120          2 Shilpa Jagannath <smanjara@redhat.com>
    121          2 Ryne Li <lizhenqiangsnake@gmail.com>
    122          2 Patrick McGarry <pmcgarry@redhat.com>
    123          2 Na Xie <xie.na@h3c.com>
    124          2 Mehdi Abaakouk <sileht@redhat.com>
    125          2 Luo Runbing <runsisi@hust.edu.cn>
    126          2 Li Wang <li.wang@kylin-cloud.com>
    127          2 Li Tianqing <tianqing@unitedstack.com>
    128          2 Leo Zhang <nguzcf@gmail.com>
    129          2 Jenkins <jenkins@ceph.com>
    130          2 Ignacio Bravo <ibravo@hotmail.com>
    131          2 Huan Zhang <zhanghuan@chinac.com>
    132          2 Hong Zhangoole <hong.zhangoole@gmail.com>
    133          2 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
    134          2 François Lafont <flafdivers@free.fr>
    135          2 Feng Yu <amoxic@126.com>
    136          2 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
    137          2 Etienne Menguy <etienne.menguy@corp.ovh.com>
    138          2 David Galloway <dgallowa@redhat.com>
    139          2 Dan Horák <dan@danny.cz>
    140          2 Chang-Yi Lee <cy.l@inwinstack.com>
    141          2 Albert Tu <albert.t@inwinstack.com>
    142          2 Adam Kupczyk <akupczyk@mirantis.com>
    143          2 Abhishek Varshney <abhishek.varshney@flipkart.com>
    144          1 Zhuang Xiaochun <zhuangxc89@163.com>
    145          1 Zhenyu Leng <lengzhenyu@ict.ac.cn>
    146          1 Zhao Chao <zhaochao1984@gmail.com>
    147          1 Yibo Cai <yibo.cai@linaro.org>
    148          1 Yang Honggang <joseph.yang@xtaotech.com>
    149          1 Xu Biao <xubiao.codeyz@gmail.com>
    150          1 Xuan Liu <liu.xuan@h3c.com>
    151          1 Wu Xingyi <wuxingyi@letv.com>
    152          1 Wenjun Huang <wenjunhuang@tencent.com>
    153          1 Vicente Cheng <freeze.bilsted@gmail.com>
    154          1 Vasu Kulkarni <vasu@redhat.com>
    155          1 Vaibhav Bhembre <vaibhav@digitalocean.com>
    156          1 Tianshan Qu <tianshan@xsky.com>
    157          1 Thomas Serlin <tserlin@redhat.com>
    158          1 Steven Dieffenbach <sdieffen@redhat.com>
    159          1 Shylesh Kumar <shmohan@redhat.com>
    160          1 Shu, Xinxin <xinxin.shu@intel.com>
    161          1 shiqi <m13913886148@gmail.com>
    162          1 Shehbaz Jaffer <shehbaz.jaffer@mail.utoronto.ca>
    163          1 Ruben Kerkhof <ruben@rubenkerkhof.com>
    164          1 Roushan Ali <roushan.ali@sandisk.com>
    165          1 Roland Mechler <rmechler@cisco.com>
    166          1 Qinghua Jin <qhjin_dev@163.com>
    167          1 Qiankun Zheng <zheng.qiankun@h3c.com>
    168          1 Peter Maloney <peter.maloney@yahoo.ca>
    169          1 Nick Fisk <nick@fisk.me.uk>
    170          1 MinSheng Lin <minsheng.l@inwinstack.com>
    171          1 Mingxin Liu <mingxin.liu@kylin-cloud.com>
    172          1 Min Chen <chenmin@xsky.com>
    173          1 Mike Hackett <mhackett@redhat.com>
    174          1 Mike Christie <mchristi@redhat.com>
    175          1 Lu Shi <shi.lu@h3c.com>
    176          1 Linfei Hou <hou.linfei@h3c.com>
    177          1 Lan De <lan.de3@zte.com.cn>
    178          1 Jon Bernard <jbernard@tuxion.com>
    179          1 John Wilkins <jwilkins@redhat.com>
    180          1 Jim Wright <jim@quadraturecapital.com>
    181          1 Ji Chen <insomnia@139.com>
    182          1 Jianjian huo <jianjian.huo@ssi.samsung.com>
    183          1 Jesse Williamson <jesse.williamson@suse.com>
    184          1 Jelle vd Kooij <vdkooij.jelle@gmail.com>
    185          1 Jan Fajerski <jfajerski@suse.com>
    186          1 James Page <james.page@ubuntu.com>
    187          1 James Liu <james.liu@ssi.samsung.com>
    188          1 Jaemyoun Lee <jaemyoun@gmail.com>
    189          1 Ira Cooper <ira@samba.org>
    190          1 Ira Cooper <ira@redhat.com>
    191          1 Ilsoo Byun <ilsoo.byun@sk.com>
    192          1 Igor Podoski <igor.podoski@ts.fujitsu.com>
    193          1 Iain Buclaw <iain.buclaw@sociomantic.com>
    194          1 Huang Jun <hjwsm1989@gmail.com>
    195          1 Harald Klein <hari@vt100.at>
    196          1 Gregory Meno <gmeno@redhat.com>
    197          1 Gong Chuang <gong.chuang@zte.com.cn>
    198          1 Feng Guo <diluga@gmail.com>
    199          1 Daniel Oliveira <doliveira@suse.com>
    200          1 Colin Walters <walters@redhat.com>
    201          1 Bryan Stillwell <bryan.stillwell@twcable.com>
    202          1 Brett Niver <bniver@redhat.com>
    203          1 Barbora Ančincová <bara@redhat.com>
    204          1 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
    205          1 Alexey Sheplyakov <asheplyakov@mirantis.com>

Commits, by organizations
      1       2196 Red Hat <contact@redhat.com>
      2        650 ZTE <contact@zte.com.cn>
      3        357 Unaffiliated <no@organization.net>
      4        321 Mirantis <contact@mirantis.com>
      5        184 SUSE <contact@suse.com>
      6        138 XSky <contact@xsky.com>
      7         69 Digiware <contact@digiware.nl>
      8         67 Intel <contact@intel.com>
      9         45 Easystack <contact@easystack.cn>
     10         41 SanDisk <contact@sandisk.com>
     11         32 H3C <contact@h3c.com>
     12         27 Mellanox <contact@mellanox.com>
     13         14 Dtdream <contact@dtdream.com>
     14         14 DreamHost <contact@dreamhost.com>
     15         12 UnitedStack <contact@unitedstack.com>
     16         12 Samsung <contact@samsung.com>
     17         11 Quantum Corporation <info@quantum.com>
     18         10 Walmart Labs <contact@walmartlabs.com>
     19          9 iQIYI <edison@qiyi.com>
     20          8 Tencent <contact@tencent.com>
     21          8 Ebay <contact@ebay.com>
     22          5 inwinSTACK inc. <leo.l@inwinstack.com>
     23          5 Igalia <contact@igalia.com>
     24          4 Odiso <contact@odiso.com>
     25          4 Inktank <contact@inktank.com>
     26          4 Fujitsu <contact@fujitsu.com>
     27          4 Deutsche Telekom <contact@telekom.de>
     28          4 Chinac <info@chinac.com>
     29          3 Kylin Cloud <contact@kylin-cloud.com>
     30          3 IBM <contact@IBM.com>
     31          3 CERN <contact@cern.ch>
     32          2 Wido 42on <contact@42on.com>
     33          2 OVH <contact@corp.ovh.com>
     34          2 LETV <contact@letv.com>
     35          2 Huazhong University of Science and Technology 
<contact@hust.edu.cn>
     36          2 Hihuron <contact@huron.com>
     37          2 Flipkart <contact@flipkart.com>
     38          1 University of Toronto <contact@mail.utoronto.ca>
     39          1 Time Warner Cable Inc. <contact@twcable.com>
     40          1 Sociomantic Labs <info@sociomantic.com>
     41          1 SK Telecom <rnd@sktelecom.com>
     42          1 Quadrature Capital Limited <info@quadraturecapital.com>
     43          1 Linaro <contact@linaro.org>
     44          1 ICT <contact@ict.ac.cn>
     45          1 DigitalOcean <contact@digitalocean.com>
     46          1 CISCO <contact@cisco.com>
     47          1 Catalysts <office@catalysts.cc>
     48          1 Canonical <contact@canonical.com>

Reviews, by authors (one review spans multiple commits)
      1        321 Sage Weil <sweil@redhat.com>
      2        260 Kefu Chai <kchai@redhat.com>
      3        131 Casey Bodley <cbodley@redhat.com>
      4        118 John Spray <jspray@redhat.com>
      5        115 Jason Dillaman <dillaman@redhat.com>
      6         92 Mykola Golub <mgolub@mirantis.com>
      7         69 Greg Farnum <gfarnum@redhat.com>
      8         68 Samuel Just <sjust@redhat.com>
      9         62 Josh Durgin <jdurgin@redhat.com>
     10         61 Orit Wasserman <owasserm@redhat.com>
     11         44 Haomai Wang <haomai@xsky.com>
     12         41 Loic Dachary <ldachary@redhat.com>
     13         37 Xie Xingguo <xie.xingguo@zte.com.cn>
     14         37 Ali Maredia <amaredia@redhat.com>
     15         36 Yehuda Sadeh <ysadehwe@redhat.com>
     16         31 Igor Fedotov <ifedotov@mirantis.com>
     17         26 Nathan Cutler <ncutler@suse.com>
     18         21 Abhishek Lekshmanan <abhishek@suse.com>
     19         20 Ken Dreyer <kdreyer@redhat.com>
     20         15 Boris Ranto <branto@redhat.com>
     21         14 Mark Nelson <mnelson@redhat.com>
     22         13 Brad Hubbard <bhubbard@redhat.com>
     23         12 Alfredo Deza <adeza@redhat.com>
     24         11 Yan, Zheng <zyan@redhat.com>
     25         11 Willem Jan Withagen <wjw@digiware.nl>
     26         10 Ramesh Chander <Ramesh.Chander@sandisk.com>
     27         10 Dan Mick <dmick@redhat.com>
     28          8 David Zafman <dzafman@redhat.com>
     29          7 Varada Kari <varada.kari@sandisk.com>
     30          5 João Eduardo Luís <joao@suse.de>
     31          4 Tim Serong <tserong@suse.com>
     32          4 Somnath Roy <somnath.roy@sandisk.com>
     33          4 Patrick Donnelly <pdonnell@redhat.com>
     34          4 Matt Benjamin <mbenjamin@redhat.com>
     35          4 Ilya Dryomov <idryomov@redhat.com>
     36          3 Song Baisen <song.baisen@zte.com.cn>
     37          3 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     38          3 Erwan Velu <erwan@redhat.com>
     39          3 Allen Samuels <allen.samuels@sandisk.com>
     40          2 Xiaoxi Chen <xiaoxchen@ebay.com>
     41          2 Vikhyat Umrao <vumrao@redhat.com>
     42          2 Ramana Raja <rraja@redhat.com>
     43          2 Oleh Prypin <oleh@pryp.in>
     44          2 Jeff Layton <jlayton@redhat.com>
     45          2 Douglas Fuller <dfuller@redhat.com>
     46          2 David Disseldorp <ddiss@suse.de>
     47          2 Adam C. Emerson <aemerson@redhat.com>
     48          1 Zack Cerza <zack@redhat.com>
     49          1 Yatin Kumbhare <yatinkumbhare@gmail.com>
     50          1 Xinze Chi <xinze@xsky.com>
     51          1 Venky Shankar <vshankar@redhat.com>
     52          1 Roi Dayan <roid@mellanox.com>
     53          1 Ricardo Dias <rdias@suse.com>
     54          1 Pritha Srivastava <prsrivas@redhat.com>
     55          1 Piotr Dałek <piotr.dalek@ts.fujitsu.com>
     56          1 Petr Lautrbach <plautrba@redhat.com>
     57          1 Noah Watkins <nwatkins@redhat.com>
     58          1 Nick Fisk <nick@fisk.me.uk>
     59          1 Marcel Lauhoff <lauhoff@uni-mainz.de>
     60          1 Luo Kexue <luo.kexue@zte.com.cn>
     61          1 John Wilkins <jwilkins@redhat.com>
     62          1 Javier M. Mellid <jmunhoz@igalia.com>
     63          1 Jan Fajerski <jfajerski@suse.com>
     64          1 James Page <james.page@ubuntu.com>
     65          1 Huang Jun <hjwsm1989@gmail.com>
     66          1 François Lafont <flafdivers@free.fr>
     67          1 Dirk Mueller <dmueller@suse.com>
     68          1 Alexandre Derumier <aderumier@odiso.com>

Reviews, by organizations (one review spans multiple commits)
      1       1451 Red Hat <contact@redhat.com>
      2        126 Mirantis <contact@mirantis.com>
      3         61 SUSE <contact@suse.com>
      4         45 XSky <contact@xsky.com>
      5         41 ZTE <contact@zte.com.cn>
      6         24 SanDisk <contact@sandisk.com>
      7         11 Digiware <contact@digiware.nl>
      8          6 Unaffiliated <no@organization.net>
      9          2 Ebay <contact@ebay.com>
     10          1 Odiso <contact@odiso.com>
     11          1 Mellanox <contact@mellanox.com>
     12          1 Johannes Gutenberg-Universität Mainz 
<contact@uni-mainz.de>
     13          1 Inktank <contact@inktank.com>
     14          1 Igalia <contact@igalia.com>
     15          1 Fujitsu <contact@fujitsu.com>
     16          1 Cloudwatt <libre.licensing@cloudwatt.com>
     17          1 Canonical <contact@canonical.com>

