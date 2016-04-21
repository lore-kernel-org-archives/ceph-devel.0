From: Yann Dupont <yd@objoo.org>
Subject: v10.2.0 (Jewel) Contributor credits.
Date: Thu, 21 Apr 2016 22:23:17 +0200
Message-ID: <571936B5.4080808@objoo.org>
References: <563FCB3C.5090207@objoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mo1.mail-out.ovh.net ([178.32.228.1]:58657 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbcDUU7I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2016 16:59:08 -0400
Received: from mail191.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 31E6510103EC
	for <ceph-devel@vger.kernel.org>; Thu, 21 Apr 2016 22:23:21 +0200 (CEST)
In-Reply-To: <563FCB3C.5090207@objoo.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Community <ceph-community@lists.ceph.com>, ceph-devel@vger.kernel.org

Hi Everybody,

time flies and the new stable version of Ceph is already OUT,=20
congratulations everyone !

Here is the sorted list of authors and organizations who contributed to=
=20
Jewel (v10.2.0), by number of commits or reviews back to old stable=20
version Infernalis (v9.2.0).

The affiliation of authors to organizations can be updated by submittin=
g=20
a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of the=
=20
number of commits. More often than not, the reviewer(s) is only=20
mentioned in the message of the merge although it means that all=20
associated commits have been reviewed. If you are curious about how it=20
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maint=
enance_guide

Number of lines added and removed, by authors
      1    155761 Sage Weil <sweil@redhat.com>
      2    120047 Jason Dillaman <dillaman@redhat.com>
      3     44596 Yehuda Sadeh <ysadehwe@redhat.com>
      4     32986 Matt Benjamin <mbenjamin@redhat.com>
      5     27647 Loic Dachary <ldachary@redhat.com>
      6     13454 Haomai Wang <haomai@xsky.com>
      7     12686 John Spray <jspray@redhat.com>
      8     11467 Orit Wasserman <owasserm@redhat.com>
      9     11182 Mykola Golub <mgolub@mirantis.com>
     10     10742 Mehdi Abaakouk <sileht@redhat.com>
     11     10732 Ali Maredia <amaredia@redhat.com>
     12      8878 Adam C. Emerson <aemerson@redhat.com>
     13      8852 Yan, Zheng <zyan@redhat.com>
     14      6661 Casey Bodley <cbodley@redhat.com>
     15      6214 Samuel Just <sjust@redhat.com>
     16      5340 Robin H. Johnson <robin.johnson@dreamhost.com>
     17      5057 Kefu Chai <kchai@redhat.com>
     18      3804 Vicente Cheng <freeze.bilsted@gmail.com>
     19      3678 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     20      3399 Nathan Cutler <ncutler@suse.com>
     21      3010 Hector Martin <marcan@marcan.st>
     22      2487 David Zafman <dzafman@redhat.com>
     23      2476 Xie Xingguo <xie.xingguo@zte.com.cn>
     24      2315 Josh Durgin <jdurgin@redhat.com>
     25      2241 Robin H. Johnson <robbat2@gentoo.org>
     26      2085 Ji Chen <insomnia@139.com>
     27      2016 Javier M. Mellid <jmunhoz@igalia.com>
     28      1881 Ricardo Dias <rdias@suse.com>
     29      1872 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     30      1869 Greg Farnum <gfarnum@redhat.com>
     31      1741 Robert LeBlanc <robert.leblanc@endurance.com>
     32      1540 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
     33      1525 Barbora An=C4=8Dincov=C3=A1 <bara@redhat.com>
     34      1499 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
     35      1422 Somnath Roy <somnath.roy@sandisk.com>
     36      1391 Abhishek Lekshmanan <abhishek@suse.com>
     37      1370 Pete Zaitcev <zaitcev@redhat.com>
     38      1345 Marcel Lauhoff <lauhoff@uni-mainz.de>
     39      1249 Wido den Hollander <wido@42on.com>
     40      1236 Kiseleva Alyona <akiselyova@mirantis.com>
     41      1216 Rohan Mars <code@rohanmars.com>
     42      1160 Xinze Chi <xinze@xsky.com>
     43      1059 Guang Yang <yguang@yahoo-inc.com>
     44       985 Zhiqiang Wang <zhiqiang.wang@intel.com>
     45       973 Igor Fedotov <ifedotov@mirantis.com>
     46       910 David Coles <dcoles@gaikai.com>
     47       856 Jianjian Huo <samuel.huo@gmail.com>
     48       784 Shu, Xinxin <xinxin.shu@intel.com>
     49       749 Ma Jianpeng <jianpeng.ma@intel.com>
     50       740 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
     51       615 Erwan Velu <erwan@redhat.com>
     52       582 Igor Podoski <igor.podoski@ts.fujitsu.com>
     53       483 Michal Jarzabek <stiopa@gmail.com>
     54       466 Adam Kupczyk <akupczyk@mirantis.com>
     55       425 Jashan Kamboj <jashank42@gmail.com>
     56       401 Boris Ranto <branto@redhat.com>
     57       394 Yann Dupont <yann@objoo.org>
     58       348 Jacek J. =C5=81akis <jacek.lakis@intel.com>
     59       330 Nishtha Rai <nishtha3rai@gmail.com>
     60       314 Xiaowei Chen <chen.xiaowei@h3c.com>
     61       312 Roi Dayan <roid@mellanox.com>
     62       298 Vikhyat Umrao <vumrao@redhat.com>
     63       267 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
     64       266 John Coyle <dx9err@gmail.com>
     65       260 Dan Mick <dmick@redhat.com>
     66       253 Shun Song <song.shun3@zte.com.cn>
     67       233 MingXin Liu <mingxin.liu@kylin-cloud.com>
     68       213 Sangdi Xu <xu.sangdi@h3c.com>
     69       209 Song Baisen <song.baisen@zte.com.cn>
     70       198 Ning Yao <yaoning@ruijie.com.cn>
     71       196 Xiaoxi Chen <xiaoxi.chen@intel.com>
     72       189 Dunrong Huang <riegamaths@gmail.com>
     73       175 Ken Dreyer <kdreyer@redhat.com>
     74       152 Sarthak Munshi <sarthakmunshi@gmail.com>
     75       152 Karol Mroz <kmroz@suse.com>
     76       150 Aron Gunn <ritz_303@yahoo.com>
     77       136 Dan van der Ster <daniel.vanderster@cern.ch>
     78       124 Ilya Dryomov <idryomov@redhat.com>
     79       123 Ruifeng Yang <yangruifeng.09209@h3c.com>
     80       122 Tao Chang <changtao@hihuron.com>
     81       112 Brad Hubbard <bhubbard@redhat.com>
     82       110 Zhi Zhang <willzzhang@tencent.com>
     83       108 Daniel Gryniewicz <dang@redhat.com>
     84       108 Avner BenHanoch <avnerb@mellanox.com>
     85        99 Weijun Duan <duanweijun@h3c.com>
     86        98 Yuan Zhou <yuan.zhou@intel.com>
     87        96 Joaquim Rocha <joaquim.rocha@cern.ch>
     88        95 Dongsheng Yang <dongsheng.yang@easystack.cn>
     89        94 Joe Julian <jjulian@io.com>
     90        87 Swami Reddy <swami.reddy@ril.com>
     91        84 Bo Cai <cai.bo@h3c.com>
     92        79 Mike Shuey <shuey@purdue.edu>
     93        78 Alfredo Deza <adeza@redhat.com>
     94        73 Marcus Watts <mwatts@redhat.com>
     95        70 Ren Huanwen <ren.huanwen@zte.com.cn>
     96        64 Jenkins <jenkins@ceph.com>
     97        63 Sahithi R V <tansy.rv@gmail.com>
     98        63 Alexey Sheplyakov <asheplyakov@mirantis.com>
     99        62 Xiangwei Wu <wuxiangwei@h3c.com>
    100        62 Abhishek Varshney <abhishek.varshney@flipkart.com>
    101        61 Cilang Zhao <zhao.cilang@h3c.com>
    102        60 Yongqiang He <he.yongqiang@h3c.com>
    103        60 Florent Manens <florent@beezim.fr>
    104        58 Zhiqiang Wang <zhiqiang@xsky.com>
    105        53 James Page <james.page@ubuntu.com>
    106        51 Kongming Wu <wu.kongming@h3c.com>
    107        50 Javen Wu <javen.wu@xtaotech.com>
    108        49 Qiankun Zheng <zheng.qiankun@h3c.com>
    109        47 Li Wang <li.wang@kylin-cloud.com>
    110        46 Jianhui Yuan <zuiwanyuan@gmail.com>
    111        45 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
    112        45 James Liu <james.liu@ssi.samsung.com>
    113        44 Zengran Zhang <zhangzengran@h3c.com>
    114        44 Na Xie <xie.na@h3c.com>
    115        42 Wenjun Huang <wenjunhuang@tencent.com>
    116        41 Noah Watkins <nwatkins@redhat.com>
    117        37 You Ji <youji@ebay.com>
    118        37 Bin Zheng <zhengbin.08747@h3c.com>
    119        34 Wei Feng <feng.wei@h3c.com>
    120        34 Luo Runbing <runsisi@hust.edu.cn>
    121        32 Roland Mechler <rmechler@cisco.com>
    122        32 Gu Zhongyan <guzhongyan@360.cn>
    123        29 Shang Ding <dingshang2013@163.com>
    124        28 Subramanyam Varanasi <s.varanasi@ssi.samsung.com>
    125        26 Wei Jin <wjin.cn@gmail.com>
    126        26 Fangchen Sun <sunspot0105@gmail.com>
    127        25 Jiaying Ren <mikulely@gmail.com>
    128        24 Wei Luo <weilluo@tencent.com>
    129        23 Emile Snyder <emsnyder@ebay.com>
    130        23 Dunrong Huang <dunrong.huang@eayun.com>
    131        22 David Disseldorp <ddiss@suse.de>
    132        21 Venky Shankar <vshankar@redhat.com>
    133        20 Jie Wang <jie.wang@kylin-cloud.com>
    134        19 Patrick Donnelly <batrick@batbytes.com>
    135        19 Luis Periquito <luis.periquito@ocado.com>
    136        18 Donghai Xu <xu.donghai@h3c.com>
    137        17 Vasu Kulkarni <vasu.kulkarni@gmail.com>
    138        17 Douglas Fuller <dfuller@redhat.com>
    139        16 Florent Bautista <florent@coppint.com>
    140        15 Xiaoxi Chen <xiaoxchen@ebay.com>
    141        15 Richard W.M. Jones <rjones@redhat.com>
    142        15 Jevon Qiao <qiaojianfeng@unitedstack.com>
    143        14 Rachana Patel <rachana83.patel@gmail.com>
    144        14 Jeffrey Lu <lzhng2000@aliyun.com>
    145        11 Zhang Huan <zhanghuan@ict.ac.cn>
    146        11 Yankun Li <liyankun@unitedstack.com>
    147        11 Rahul Aggarwal <rahul.1aggarwal@gmail.com>
    148        11 Nilamdyuti Goswami <ngoswami@redhat.com>
    149        11 Brian Felton <bjfelton@gmail.com>
    150        10 Zhao Junwang <zhjwpku@gmail.com>
    151        10 Eric Lee <eric.lee@hgst.com>
    152        10 Edward Yang <eyang@us.fujitsu.com>
    153        10 Chengyuan Li <chengyli@ebay.com>
    154        10 Anthony Alba <ascanio.alba7@gmail.com>
    155         9 Luo Kexue <luo.kexue@zte.com.cn>
    156         9 Liu Peiyan <liu.peiyang@h3c.com>
    157         9 Chuanhong Wang <wang.chuanhong@zte.com.cn>
    158         9 Chendi Xue <chendi.xue@intel.com>
    159         8 Vitja Makarov <vitja.makarov@gmail.com>
    160         8 Fran=C3=A7ois Lafont <flafdivers@free.fr>
    161         7 Willem Jan Withagen <wjw@digiware.nl>
    162         7 Rust Shen <rustinpeace@163.com>
    163         7 Drunkard Zhang <gongfan193@gmail.com>
    164         6 YiQiang Chen <cyqsign@163.com>
    165         6 Li Tianqing <tianqing@unitedstack.com>
    166         4 Zack Cerza <zack@redhat.com>
    167         4 You Ji <jiyou09@gmail.com>
    168         4 Yan Jun <yan.jun8@zte.com.cn>
    169         4 Tobias Suckow <tobias@suckow.biz>
    170         4 Tianshan Qu <tianshan@xsky.com>
    171         4 Kris Jurka <kjurka@locatortechnologies.com>
    172         4 Jeremy Qian <vanpire110@163.com>
    173         4 Eric Cook <llua@gmx.com>
    174         3 Yehua Chen <chen.yehua@h3c.com>
    175         3 Luo Runbing <runsisi@zte.com.cn>
    176         3 Etienne Menguy <etienne.menguy@corp.ovh.com>
    177         2 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
    178         2 Star Guo <star.guo@mevoco.com>
    179         2 Qinghua Jin <qhjin_dev@163.com>
    180         2 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    181         2 Owen Synge <osynge@suse.com>
    182         2 Mauricio Garavaglia <mauriciogaravaglia@gmail.com>
    183         2 Marc Koderer <marc@koderer.com>
    184         2 Lenz Grimmer <lenz@grimmer.com>
    185         2 Jonas Keidel <jonas@jonas-keidel.de>
    186         2 John Wilkins <jwilkins@redhat.com>
    187         2 Jingkai Yuan <jingkai.yuan@intel.com>
    188         2 Ivan Grcic <igrcic@gmail.com>
    189         2 Herv=C3=A9 Rousseau <hroussea@cern.ch>
    190         2 Dongmao Zhang <deanraccoon@gmail.com>
    191         2 Darrell Enns <darrell@darrellenns.com>
    192         2 Chris Holcombe <chris.holcombe@nebula.com>
    193         2 Accela Zhao <accelazh@gmail.com>
    194         2 Aaron Bassett <abassett@gmail.com>
    195         1 R=C3=A9mi Buisson <remi.buisson@cdiscount.com>
    196         1 Ning Yao <yaoning@unitedstack.com>
    197         1 Ira Cooper <ira@redhat.com>
    198         1 Ilya Shipitsin <ilia@localhost.localdomain>

Number of lines added and removed, by organization
      1    473203 Red Hat <contact@redhat.com>
      2     17598 Mirantis <contact@mirantis.com>
      3     14676 XSky <contact@xsky.com>
      4     11747 Unaffiliated <no@organization.net>
      5      7082 SUSE <contact@suse.com>
      6      5340 DreamHost <contact@dreamhost.com>
      7      3171 Intel <contact@intel.com>
      8      3035 ZTE <contact@zte.com.cn>
      9      2241 Gentoo <contact@gentoo.org>
     10      2164 SanDisk <contact@sandisk.com>
     11      2091 Fujitsu <contact@fujitsu.com>
     12      2087 LETV <contact@letv.com>
     13      2016 Igalia <contact@igalia.com>
     14      1872 Deutsche Telekom <contact@telekom.de>
     15      1840 Kylin Cloud <contact@kylin-cloud.com>
     16      1741 Endurance International Group <contact@endurance.com>
     17      1350 H3C <contact@h3c.com>
     18      1345 Johannes Gutenberg-Universit=C3=A4t Mainz=20
<contact@uni-mainz.de>
     19      1249 Wido 42on <contact@42on.com>
     20      1109 Inktank <contact@inktank.com>
     21      1059 Yahoo! <contact@yahoo-inc.com>
     22       910 Gaikai <contact@gaikai.com>
     23       420 Mellanox <contact@mellanox.com>
     24       234 CERN <contact@cern.ch>
     25       198 Ruijie Networks <contact@ruijie.com.cn>
     26       176 Tencent <contact@tencent.com>
     27       122 Hihuron <contact@huron.com>
     28       119 Reliance Jio Infocomm Ltd. <contact@ril.com>
     29        95 Easystack <contact@easystack.cn>
     30        94 IO <contact@io.com>
     31        85 Ebay <contact@ebay.com>
     32        79 Purdue University <contact@purdue.edu>
     33        73 Samsung <contact@samsung.com>
     34        62 Flipkart <contact@flipkart.com>
     35        60 Beezim <contact@beezim.fr>
     36        53 Canonical <contact@canonical.com>
     37        34 Huazhong University of Science and Technology=20
<contact@hust.edu.cn>
     38        33 UnitedStack <contact@unitedstack.com>
     39        32 CISCO <contact@cisco.com>
     40        23 Eayun <contact@eayun.com>
     41        19 Ocado <contact@ocado.com>
     42        14 Aliyun <contact@aliyun.com>
     43        11 ICT <contact@ict.ac.cn>
     44        10 HGST <contact@hgst.com>
     45         7 Digiware <contact@digiware.nl>
     46         4 Locator Technologies <contact@locatortechnologies.com=
>
     47         3 OVH <contact@corp.ovh.com>
     48         2 SAP <contact@sap.com>
     49         2 Nebula <info@nebula.com>
     50         2 Mevoco <contact@mevoco.com>
     51         2 Grimmer <lenz@grimmer.com>
     52         1 Cdiscount <contact@cdiscount.com>

Commits, by authors
      1        835 Sage Weil <sweil@redhat.com>
      2        552 Yehuda Sadeh <ysadehwe@redhat.com>
      3        545 Jason Dillaman <dillaman@redhat.com>
      4        322 Matt Benjamin <mbenjamin@redhat.com>
      5        301 Xie Xingguo <xie.xingguo@zte.com.cn>
      6        221 Orit Wasserman <owasserm@redhat.com>
      7        169 John Spray <jspray@redhat.com>
      8        164 Yan, Zheng <zyan@redhat.com>
      9        163 Loic Dachary <ldachary@redhat.com>
     10        150 Haomai Wang <haomai@xsky.com>
     11        144 Kefu Chai <kchai@redhat.com>
     12        134 Casey Bodley <cbodley@redhat.com>
     13        102 Mykola Golub <mgolub@mirantis.com>
     14         95 Samuel Just <sjust@redhat.com>
     15         86 Ali Maredia <amaredia@redhat.com>
     16         80 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     17         74 Robin H. Johnson <robbat2@gentoo.org>
     18         72 Swami Reddy <swami.reddy@ril.com>
     19         68 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     20         67 Nathan Cutler <ncutler@suse.com>
     21         60 David Zafman <dzafman@redhat.com>
     22         59 Abhishek Lekshmanan <abhishek@suse.com>
     23         58 Ma Jianpeng <jianpeng.ma@intel.com>
     24         56 Yann Dupont <yann@objoo.org>
     25         55 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
     26         39 Javier M. Mellid <jmunhoz@igalia.com>
     27         36 Erwan Velu <erwan@redhat.com>
     28         34 Josh Durgin <jdurgin@redhat.com>
     29         32 Greg Farnum <gfarnum@redhat.com>
     30         29 Robin H. Johnson <robin.johnson@dreamhost.com>
     31         27 Jashan Kamboj <jashank42@gmail.com>
     32         25 Xinze Chi <xinze@xsky.com>
     33         23 Ricardo Dias <rdias@suse.com>
     34         23 John Coyle <dx9err@gmail.com>
     35         22 Vicente Cheng <freeze.bilsted@gmail.com>
     36         20 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
     37         20 Dunrong Huang <riegamaths@gmail.com>
     38         19 Zhiqiang Wang <zhiqiang.wang@intel.com>
     39         19 Adam C. Emerson <aemerson@redhat.com>
     40         18 Guang Yang <yguang@yahoo-inc.com>
     41         17 Wido den Hollander <wido@42on.com>
     42         16 Ren Huanwen <ren.huanwen@zte.com.cn>
     43         16 Nishtha Rai <nishtha3rai@gmail.com>
     44         16 Ken Dreyer <kdreyer@redhat.com>
     45         16 Jianjian Huo <samuel.huo@gmail.com>
     46         15 Shu, Xinxin <xinxin.shu@intel.com>
     47         15 Robert LeBlanc <robert.leblanc@endurance.com>
     48         15 Igor Fedotov <ifedotov@mirantis.com>
     49         15 Dan Mick <dmick@redhat.com>
     50         14 Rohan Mars <code@rohanmars.com>
     51         14 Ning Yao <yaoning@ruijie.com.cn>
     52         14 Michal Jarzabek <stiopa@gmail.com>
     53         14 Hector Martin <marcan@marcan.st>
     54         13 Brad Hubbard <bhubbard@redhat.com>
     55         12 Dongsheng Yang <dongsheng.yang@easystack.cn>
     56         11 Xiaowei Chen <chen.xiaowei@h3c.com>
     57         11 Roi Dayan <roid@mellanox.com>
     58         11 Pete Zaitcev <zaitcev@redhat.com>
     59         11 Mehdi Abaakouk <sileht@redhat.com>
     60         10 Sangdi Xu <xu.sangdi@h3c.com>
     61         10 Ilya Dryomov <idryomov@redhat.com>
     62         10 Boris Ranto <branto@redhat.com>
     63         10 Barbora An=C4=8Dincov=C3=A1 <bara@redhat.com>
     64         10 Avner BenHanoch <avnerb@mellanox.com>
     65          9 Zhi Zhang <willzzhang@tencent.com>
     66          8 Xiaoxi Chen <xiaoxi.chen@intel.com>
     67          8 Li Wang <li.wang@kylin-cloud.com>
     68          8 Karol Mroz <kmroz@suse.com>
     69          8 Jiaying Ren <mikulely@gmail.com>
     70          8 Jenkins <jenkins@ceph.com>
     71          8 Igor Podoski <igor.podoski@ts.fujitsu.com>
     72          7 You Ji <youji@ebay.com>
     73          7 Song Baisen <song.baisen@zte.com.cn>
     74          7 Ruifeng Yang <yangruifeng.09209@h3c.com>
     75          7 Ji Chen <insomnia@139.com>
     76          7 David Coles <dcoles@gaikai.com>
     77          7 Bo Cai <cai.bo@h3c.com>
     78          6 Zengran Zhang <zhangzengran@h3c.com>
     79          6 Yuan Zhou <yuan.zhou@intel.com>
     80          6 Weijun Duan <duanweijun@h3c.com>
     81          6 Wei Jin <wjin.cn@gmail.com>
     82          6 Somnath Roy <somnath.roy@sandisk.com>
     83          6 Na Xie <xie.na@h3c.com>
     84          6 Marcel Lauhoff <lauhoff@uni-mainz.de>
     85          6 Kongming Wu <wu.kongming@h3c.com>
     86          6 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
     87          6 Dan van der Ster <daniel.vanderster@cern.ch>
     88          6 Adam Kupczyk <akupczyk@mirantis.com>
     89          5 Vikhyat Umrao <vumrao@redhat.com>
     90          5 Tao Chang <changtao@hihuron.com>
     91          5 Qiankun Zheng <zheng.qiankun@h3c.com>
     92          5 MingXin Liu <mingxin.liu@kylin-cloud.com>
     93          5 Marcus Watts <mwatts@redhat.com>
     94          5 Kiseleva Alyona <akiselyova@mirantis.com>
     95          5 James Page <james.page@ubuntu.com>
     96          5 Jacek J. =C5=81akis <jacek.lakis@intel.com>
     97          5 Aron Gunn <ritz_303@yahoo.com>
     98          4 Yankun Li <liyankun@unitedstack.com>
     99          4 Xiangwei Wu <wuxiangwei@h3c.com>
    100          4 Luo Runbing <runsisi@hust.edu.cn>
    101          4 Jie Wang <jie.wang@kylin-cloud.com>
    102          4 Douglas Fuller <dfuller@redhat.com>
    103          4 Daniel Gryniewicz <dang@redhat.com>
    104          4 Cilang Zhao <zhao.cilang@h3c.com>
    105          3 Zhiqiang Wang <zhiqiang@xsky.com>
    106          3 Yongqiang He <he.yongqiang@h3c.com>
    107          3 Wei Feng <feng.wei@h3c.com>
    108          3 Patrick Donnelly <batrick@batbytes.com>
    109          3 Mike Shuey <shuey@purdue.edu>
    110          3 Joe Julian <jjulian@io.com>
    111          3 Joaquim Rocha <joaquim.rocha@cern.ch>
    112          3 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    113          3 David Disseldorp <ddiss@suse.de>
    114          2 Willem Jan Withagen <wjw@digiware.nl>
    115          2 Wenjun Huang <wenjunhuang@tencent.com>
    116          2 Venky Shankar <vshankar@redhat.com>
    117          2 Shun Song <song.shun3@zte.com.cn>
    118          2 Sarthak Munshi <sarthakmunshi@gmail.com>
    119          2 Sahithi R V <tansy.rv@gmail.com>
    120          2 Roland Mechler <rmechler@cisco.com>
    121          2 Noah Watkins <nwatkins@redhat.com>
    122          2 Luo Kexue <luo.kexue@zte.com.cn>
    123          2 Li Tianqing <tianqing@unitedstack.com>
    124          2 Jevon Qiao <qiaojianfeng@unitedstack.com>
    125          2 James Liu <james.liu@ssi.samsung.com>
    126          2 Florent Manens <florent@beezim.fr>
    127          2 Dunrong Huang <dunrong.huang@eayun.com>
    128          2 Drunkard Zhang <gongfan193@gmail.com>
    129          2 Donghai Xu <xu.donghai@h3c.com>
    130          2 Chuanhong Wang <wang.chuanhong@zte.com.cn>
    131          2 Chengyuan Li <chengyli@ebay.com>
    132          2 Alfredo Deza <adeza@redhat.com>
    133          2 Alexey Sheplyakov <asheplyakov@mirantis.com>
    134          2 Abhishek Varshney <abhishek.varshney@flipkart.com>
    135          1 Zhao Junwang <zhjwpku@gmail.com>
    136          1 Zhang Huan <zhanghuan@ict.ac.cn>
    137          1 Zeqiang Zhuang <zhuang.zeqiang@h3c.com>
    138          1 Zack Cerza <zack@redhat.com>
    139          1 You Ji <jiyou09@gmail.com>
    140          1 YiQiang Chen <cyqsign@163.com>
    141          1 Yehua Chen <chen.yehua@h3c.com>
    142          1 Yan Jun <yan.jun8@zte.com.cn>
    143          1 Xiaoxi Chen <xiaoxchen@ebay.com>
    144          1 Wei Qiaomiao <wei.qiaomiao@zte.com.cn>
    145          1 Wei Luo <weilluo@tencent.com>
    146          1 Vitja Makarov <vitja.makarov@gmail.com>
    147          1 Vasu Kulkarni <vasu.kulkarni@gmail.com>
    148          1 Tobias Suckow <tobias@suckow.biz>
    149          1 Tianshan Qu <tianshan@xsky.com>
    150          1 Subramanyam Varanasi <s.varanasi@ssi.samsung.com>
    151          1 Star Guo <star.guo@mevoco.com>
    152          1 Shang Ding <dingshang2013@163.com>
    153          1 Rust Shen <rustinpeace@163.com>
    154          1 Richard W.M. Jones <rjones@redhat.com>
    155          1 R=C3=A9mi Buisson <remi.buisson@cdiscount.com>
    156          1 Rahul Aggarwal <rahul.1aggarwal@gmail.com>
    157          1 Rachana Patel <rachana83.patel@gmail.com>
    158          1 Qinghua Jin <qhjin_dev@163.com>
    159          1 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    160          1 Owen Synge <osynge@suse.com>
    161          1 Ning Yao <yaoning@unitedstack.com>
    162          1 Nilamdyuti Goswami <ngoswami@redhat.com>
    163          1 Mauricio Garavaglia <mauriciogaravaglia@gmail.com>
    164          1 Marc Koderer <marc@koderer.com>
    165          1 Luo Runbing <runsisi@zte.com.cn>
    166          1 Luis Periquito <luis.periquito@ocado.com>
    167          1 Liu Peiyan <liu.peiyang@h3c.com>
    168          1 Lenz Grimmer <lenz@grimmer.com>
    169          1 Kris Jurka <kjurka@locatortechnologies.com>
    170          1 Jonas Keidel <jonas@jonas-keidel.de>
    171          1 John Wilkins <jwilkins@redhat.com>
    172          1 Jingkai Yuan <jingkai.yuan@intel.com>
    173          1 Jianhui Yuan <zuiwanyuan@gmail.com>
    174          1 Jeremy Qian <vanpire110@163.com>
    175          1 Jeffrey Lu <lzhng2000@aliyun.com>
    176          1 Javen Wu <javen.wu@xtaotech.com>
    177          1 Ivan Grcic <igrcic@gmail.com>
    178          1 Ira Cooper <ira@redhat.com>
    179          1 Ilya Shipitsin <ilia@localhost.localdomain>
    180          1 Herv=C3=A9 Rousseau <hroussea@cern.ch>
    181          1 Gu Zhongyan <guzhongyan@360.cn>
    182          1 Fran=C3=A7ois Lafont <flafdivers@free.fr>
    183          1 Florent Bautista <florent@coppint.com>
    184          1 Fangchen Sun <sunspot0105@gmail.com>
    185          1 Etienne Menguy <etienne.menguy@corp.ovh.com>
    186          1 Eric Lee <eric.lee@hgst.com>
    187          1 Eric Cook <llua@gmx.com>
    188          1 Emile Snyder <emsnyder@ebay.com>
    189          1 Edward Yang <eyang@us.fujitsu.com>
    190          1 Dongmao Zhang <deanraccoon@gmail.com>
    191          1 Darrell Enns <darrell@darrellenns.com>
    192          1 Chris Holcombe <chris.holcombe@nebula.com>
    193          1 Chendi Xue <chendi.xue@intel.com>
    194          1 Brian Felton <bjfelton@gmail.com>
    195          1 Bin Zheng <zhengbin.08747@h3c.com>
    196          1 Anthony Alba <ascanio.alba7@gmail.com>
    197          1 Accela Zhao <accelazh@gmail.com>
    198          1 Aaron Bassett <abassett@gmail.com>

Commits, by organizations
      1       3740 Red Hat <contact@redhat.com>
      2        333 ZTE <contact@zte.com.cn>
      3        278 Unaffiliated <no@organization.net>
      4        210 Mirantis <contact@mirantis.com>
      5        179 XSky <contact@xsky.com>
      6        163 SUSE <contact@suse.com>
      7        113 Intel <contact@intel.com>
      8         84 H3C <contact@h3c.com>
      9         74 Gentoo <contact@gentoo.org>
     10         73 Reliance Jio Infocomm Ltd. <contact@ril.com>
     11         68 Deutsche Telekom <contact@telekom.de>
     12         64 Fujitsu <contact@fujitsu.com>
     13         39 Igalia <contact@igalia.com>
     14         37 Kylin Cloud <contact@kylin-cloud.com>
     15         29 DreamHost <contact@dreamhost.com>
     16         21 Mellanox <contact@mellanox.com>
     17         18 Yahoo! <contact@yahoo-inc.com>
     18         17 Wido 42on <contact@42on.com>
     19         15 Endurance International Group <contact@endurance.com=
>
     20         14 Ruijie Networks <contact@ruijie.com.cn>
     21         13 SanDisk <contact@sandisk.com>
     22         12 Tencent <contact@tencent.com>
     23         12 Easystack <contact@easystack.cn>
     24         11 Ebay <contact@ebay.com>
     25         10 CERN <contact@cern.ch>
     26          9 UnitedStack <contact@unitedstack.com>
     27          8 LETV <contact@letv.com>
     28          7 Gaikai <contact@gaikai.com>
     29          6 Johannes Gutenberg-Universit=C3=A4t Mainz <contact@u=
ni=20
mainz.de>
     30          5 Hihuron <contact@huron.com>
     31          5 Canonical <contact@canonical.com>
     32          4 Inktank <contact@inktank.com>
     33          4 Huazhong University of Science and Technology=20
<contact@hust.edu.cn>
     34          3 Samsung <contact@samsung.com>
     35          3 Purdue University <contact@purdue.edu>
     36          3 IO <contact@io.com>
     37          2 Flipkart <contact@flipkart.com>
     38          2 Eayun <contact@eayun.com>
     39          2 Digiware <contact@digiware.nl>
     40          2 CISCO <contact@cisco.com>
     41          2 Beezim <contact@beezim.fr>
     42          1 SAP <contact@sap.com>
     43          1 OVH <contact@corp.ovh.com>
     44          1 Ocado <contact@ocado.com>
     45          1 Nebula <info@nebula.com>
     46          1 Mevoco <contact@mevoco.com>
     47          1 Locator Technologies <contact@locatortechnologies.co=
m>
     48          1 ICT <contact@ict.ac.cn>
     49          1 HGST <contact@hgst.com>
     50          1 Grimmer <lenz@grimmer.com>
     51          1 Cdiscount <contact@cdiscount.com>
     52          1 Aliyun <contact@aliyun.com>

Reviews, by authors (one review spans multiple commits)
      1        336 Sage Weil <sweil@redhat.com>
      2        209 Kefu Chai <kchai@redhat.com>
      3        200 Josh Durgin <jdurgin@redhat.com>
      4        129 Loic Dachary <ldachary@redhat.com>
      5        104 Yehuda Sadeh <ysadehwe@redhat.com>
      6         85 Jason Dillaman <dillaman@redhat.com>
      7         63 Greg Farnum <gfarnum@redhat.com>
      8         53 Samuel Just <sjust@redhat.com>
      9         32 John Spray <jspray@redhat.com>
     10         29 Orit Wasserman <owasserm@redhat.com>
     11         25 Haomai Wang <haomai@xsky.com>
     12         24 Nathan Cutler <ncutler@suse.com>
     13         23 Ken Dreyer <kdreyer@redhat.com>
     14         19 Abhishek Lekshmanan <abhishek@suse.com>
     15         17 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
     16         17 Casey Bodley <cbodley@redhat.com>
     17         17 Boris Ranto <branto@redhat.com>
     18         16 Yan, Zheng <zyan@redhat.com>
     19         15 David Zafman <dzafman@redhat.com>
     20         12 Matt Benjamin <mbenjamin@redhat.com>
     21         12 Dan Mick <dmick@redhat.com>
     22          9 Li Wang <li.wang@kylin-cloud.com>
     23          7 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
     24          7 Alfredo Deza <adeza@redhat.com>
     25          4 Xinze Chi <xinze@xsky.com>
     26          3 Xie Xingguo <xie.xingguo@zte.com.cn>
     27          3 Robin H. Johnson <robin.johnson@dreamhost.com>
     28          2 Willem Jan Withagen <wjw@digiware.nl>
     29          2 Varada Kari <varada.kari@sandisk.com>
     30          2 Mehdi Abaakouk <sileht@redhat.com>
     31          2 Igor Fedotov <ifedotov@mirantis.com>
     32          2 Huang Jun <hjwsm1989@gmail.com>
     33          2 Guang Yang <yguang@yahoo-inc.com>
     34          2 Erwan Velu <erwan@redhat.com>
     35          2 Brad Hubbard <bhubbard@redhat.com>
     36          2 Adam C. Emerson <aemerson@redhat.com>
     37          1 Yankun Li <liyankun@unitedstack.com>
     38          1 Xiaoxi Chen <xiaoxi.chen@intel.com>
     39          1 Vicente Cheng <freeze.bilsted@gmail.com>
     40          1 Tim Serong <tserong@suse.com>
     41          1 Song Baisen <song.baisen@zte.com.cn>
     42          1 Shu, Xinxin <xinxin.shu@intel.com>
     43          1 Sebastien Ponce <sebastien.ponce@cern.ch>
     44          1 Sangdi Xu <xu.sangdi@h3c.com>
     45          1 Robert LeBlanc <robert.leblanc@endurance.com>
     46          1 Ricardo Dias <rdias@suse.com>
     47          1 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     48          1 Pete Zaitcev <zaitcev@redhat.com>
     49          1 Ning Yao <yaoning@ruijie.com.cn>
     50          1 Mykola Golub <mgolub@mirantis.com>
     51          1 Mark Nelson <mnelson@redhat.com>
     52          1 Karol Mroz <kmroz@suse.com>
     53          1 John Wilkins <jwilkins@redhat.com>
     54          1 Ilya Dryomov <idryomov@redhat.com>
     55          1 Hector Martin <marcan@marcan.st>
     56          1 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
     57          1 David Disseldorp <ddiss@suse.de>
     58          1 David Coles <dcoles@gaikai.com>
     59          1 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     60          1 Daniel Gryniewicz <dang@redhat.com>
     61          1 Chengyuan Li <chengyli@ebay.com>
     62          1 Andreas Peters <andreas.joachim.peters@cern.ch>
     63          1 Ali Maredia <amaredia@redhat.com>

Reviews, by organizations (one review spans multiple commits)
      1       1371 Red Hat <contact@redhat.com>
      2         64 SUSE <contact@suse.com>
      3         29 XSky <contact@xsky.com>
      4          9 Kylin Cloud <contact@kylin-cloud.com>
      5          7 Fujitsu <contact@fujitsu.com>
      6          4 ZTE <contact@zte.com.cn>
      7          4 Unaffiliated <no@organization.net>
      8          4 Mirantis <contact@mirantis.com>
      9          3 SanDisk <contact@sandisk.com>
     10          3 DreamHost <contact@dreamhost.com>
     11          2 Yahoo! <contact@yahoo-inc.com>
     12          2 Intel <contact@intel.com>
     13          2 Digiware <contact@digiware.nl>
     14          2 CERN <contact@cern.ch>
     15          1 UnitedStack <contact@unitedstack.com>
     16          1 Ruijie Networks <contact@ruijie.com.cn>
     17          1 Inktank <contact@inktank.com>
     18          1 H3C <contact@h3c.com>
     19          1 Gaikai <contact@gaikai.com>
     20          1 Endurance International Group <contact@endurance.com=
>
     21          1 Ebay <contact@ebay.com>
     22          1 Deutsche Telekom <contact@telekom.de>
     23          1 Cloudwatt <libre.licensing@cloudwatt.com>


Cheers, Yann.

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
