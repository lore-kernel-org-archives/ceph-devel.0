From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: v10.0.2 Contributor credits
Date: Thu, 14 Jan 2016 23:28:47 +0530
Message-ID: <CANA9Uk7hiWNBDV9N+NqSOt4yUwTweYb2hR3sd1a=k1rkQbrrYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f48.google.com ([209.85.213.48]:32829 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434AbcANR6t convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jan 2016 12:58:49 -0500
Received: by mail-vk0-f48.google.com with SMTP id i129so146729825vkb.0
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jan 2016 09:58:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v10.0.2, by number of commits or reviews back to v10.0.1. The
affiliation of authors to organizations can be updated by submitting a
patch to https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed, but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge, although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maint=
enance_guide

Number of lines added and removed, by authors
     1   33807 Jason Dillaman <dillaman@redhat.com>
     2    3497 Yehuda Sadeh <ysadehwe@redhat.com>
     3    3239 Mykola Golub <mgolub@mirantis.com>
     4    2919 Hector Martin <marcan@marcan.st>
     5    1829 Ji Chen <insomnia@139.com>
     6    1496 John Spray <jspray@redhat.com>
     7    1399 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
     8    1354 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     9     817 Pete Zaitcev <zaitcev@redhat.com>
    10     808 Nathan Cutler <ncutler@suse.com>
    11     635 Haomai Wang <haomai@xsky.com>
    12     514 Sage Weil <sweil@redhat.com>
    13     425 Rohan Mars <code@rohanmars.com>
    14     328 Loic Dachary <ldachary@redhat.com>
    15     252 Xinze Chi <xinze@xsky.com>
    16     239 Michal Jarzabek <stiopa@gmail.com>
    17     206 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    18     187 Igor Podoski <igor.podoski@ts.fujitsu.com>
    19     176 Adam Kupczyk <akupczyk@mirantis.com>
    20     174 Yan, Zheng <zyan@redhat.com>
    21     172 Dan Mick <dmick@redhat.com>
    22     125 Guang Yang <yguang@yahoo-inc.com>
    23      97 Vikhyat Umrao <vumrao@redhat.com>
    24      77 Ning Yao <yaoning@ruijie.com.cn>
    25      70 Orit Wasserman <owasserm@redhat.com>
    26      65 Zhi Zhang <zhangz.david@outlook.com>
    27      64 Samuel Just <sjust@redhat.com>
    28      57 John Coyle <dx9err@gmail.com>
    29      55 Bo Cai <cai.bo@h3c.com>
    30      53 Jacek J. =C5=81akis <jacek.lakis@intel.com>
    31      40 Xiaowei Chen <chen.xiaowei@h3c.com>
    32      39 Noah Watkins <nwatkins@redhat.com>
    33      38 Kiseleva Alyona <akiselyova@mirantis.com>
    34      35 Igor Fedotov <ifedotov@mirantis.com>
    35      30 Xie Xingguo <xie.xingguo@zte.com.cn>
    36      30 Wei Feng <feng.wei@h3c.com>
    37      29 Xiaoxi Chen <xiaoxi.chen@intel.com>
    38      29 Shang Ding <dingshang2013@163.com>
    39      28 Florent Manens <florent@beezim.fr>
    40      26 Kefu Chai <kchai@redhat.com>
    41      24 Dunrong Huang <riegamaths@gmail.com>
    42      23 Kongming Wu <wu.kongming@h3c.com>
    43      19 Cilang Zhao <zhao.cilang@h3c.com>
    44      18 Josh Durgin <jdurgin@redhat.com>
    45      18 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    46      12 Jie Wang <jie.wang@kylin-cloud.com>
    47      11 Zhang Huan <zhanghuan@ict.ac.cn>
    48      11 Nilamdyuti Goswami <ngoswami@redhat.com>
    49      10 Anthony Alba <ascanio.alba7@gmail.com>
    50       9 Ilya Dryomov <idryomov@redhat.com>
    51       8 Qiankun Zheng <zheng.qiankun@h3c.com>
    52       8 Jenkins <jenkins@ceph.com>
    53       8 James Page <james.page@ubuntu.com>
    54       7 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
    55       7 Drunkard Zhang <gongfan193@gmail.com>
    56       5 Ma Jianpeng <jianpeng.ma@intel.com>
    57       5 Chengyuan Li <chengyli@ebay.com>
    58       5 changtao <changtao@hihuron.com>
    59       4 Na Xie <xie.na@h3c.com>
    60       4 Jiaying Ren <mikulely@gmail.com>
    61       4 Jeremy Qian <vanpire110@163.com>
    62       4 Brad Hubbard <bhubbard@redhat.com>
    63       3 Robin H. Johnson <robin.johnson@dreamhost.com>
    64       3 David Zafman <dzafman@redhat.com>
    65       3 Chuanhong Wang <wang.chuanhong@zte.com.cn>
    66       2 Zengran Zhang <zhangzengran@h3c.com>
    67       2 Yongqiang He <he.yongqiang@h3c.com>
    68       2 Ruifeng Yang <yangruifeng.09209@h3c.com>
    69       2 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    70       2 Marc Koderer <marc@koderer.com>
    71       2 Li Wang <li.wang@kylin-cloud.com>
    72       2 Lenz Grimmer <lenz@grimmer.com>
    73       2 Ken Dreyer <kdreyer@redhat.com>
    74       2 Douglas Fuller <dfuller@redhat.com>
    75       2 Accela Zhao <accelazh@gmail.com>

Number of lines added and removed, by organization
     1   40111 Red Hat <contact@redhat.com>
     2    4842 Mirantis <contact@mirantis.com>
     3    3720 Unaffiliated <no@organization.net>
     4    1829 LETV <contact@letv.com>
     5    1413 Kylin Cloud <contact@kylin-cloud.com>
     6    1047 Inktank <contact@inktank.com>
     7     887 XSky <contact@xsky.com>
     8     808 SUSE <contact@suse.com>
     9     393 Fujitsu <contact@fujitsu.com>
    10     185 H3C <wentao@h3c.com>
    11     125 Yahoo! <contact@yahoo-inc.com>
    12      87 Intel <contact@intel.com>
    13      77 Ruijie Networks <contact@ruijie.com.cn>
    14      65 Tencent <contact@tencent.com>
    15      33 ZTE <contact@zte.com.cn>
    16      28 Beezim <contact@beezim.fr>
    17      18 Reliance Jio Infocomm Ltd. <contact@ril.com>
    18      11 ICT <contact@ict.ac.cn>
    19       9 SanDisk <contact@sandisk.com>
    20       8 Canonical <contact@canonical.com>
    21       5 Hihuron <contact@huron.com>
    22       5 Ebay <contact@ebay.com>
    23       3 DreamHost <contact@dreamhost.com>
    24       2 SAP <contact@sap.com>
    25       2 Grimmer <lenz@grimmer.com>

Commits, by authors
     1      129 Jason Dillaman <dillaman@redhat.com>
     2       23 Haomai Wang <haomai@xsky.com>
     3       22 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     4       21 Yehuda Sadeh <ysadehwe@redhat.com>
     5       20 John Spray <jspray@redhat.com>
     6       18 Mykola Golub <mgolub@mirantis.com>
     7       15 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
     8       14 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
     9       13 Nathan Cutler <ncutler@suse.com>
    10       11 Loic Dachary <ldachary@redhat.com>
    11       11 Hector Martin <marcan@marcan.st>
    12       10 Xinze Chi <xinze@xsky.com>
    13       10 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    14        8 Yan, Zheng <zyan@redhat.com>
    15        8 Sage Weil <sweil@redhat.com>
    16        6 Samuel Just <sjust@redhat.com>
    17        6 Guang Yang <yguang@yahoo-inc.com>
    18        5 Ning Yao <yaoning@ruijie.com.cn>
    19        4 Rohan Mars <code@rohanmars.com>
    20        4 Michal Jarzabek <stiopa@gmail.com>
    21        4 Kefu Chai <kchai@redhat.com>
    22        4 Josh Durgin <jdurgin@redhat.com>
    23        3 Xiaoxi Chen <xiaoxi.chen@intel.com>
    24        3 Pete Zaitcev <zaitcev@redhat.com>
    25        3 Orit Wasserman <owasserm@redhat.com>
    26        3 Ma Jianpeng <jianpeng.ma@intel.com>
    27        3 John Coyle <dx9err@gmail.com>
    28        3 Jacek J. =C5=81akis <jacek.lakis@intel.com>
    29        3 Igor Podoski <igor.podoski@ts.fujitsu.com>
    30        3 Dunrong Huang <riegamaths@gmail.com>
    31        3 Dan Mick <dmick@redhat.com>
    32        2 Zhi Zhang <zhangz.david@outlook.com>
    33        2 Xie Xingguo <xie.xingguo@zte.com.cn>
    34        2 Wei Feng <feng.wei@h3c.com>
    35        2 Robin H. Johnson <robin.johnson@dreamhost.com>
    36        2 Qiankun Zheng <zheng.qiankun@h3c.com>
    37        2 Jie Wang <jie.wang@kylin-cloud.com>
    38        2 Jiaying Ren <mikulely@gmail.com>
    39        2 Igor Fedotov <ifedotov@mirantis.com>
    40        2 Evgeniy Firsov <evgeniy.firsov@sandisk.com>
    41        2 Drunkard Zhang <gongfan193@gmail.com>
    42        2 Cilang Zhao <zhao.cilang@h3c.com>
    43        2 changtao <changtao@hihuron.com>
    44        2 Bo Cai <cai.bo@h3c.com>
    45        2 Adam Kupczyk <akupczyk@mirantis.com>
    46        1 Zhang Huan <zhanghuan@ict.ac.cn>
    47        1 Zengran Zhang <zhangzengran@h3c.com>
    48        1 Yongqiang He <he.yongqiang@h3c.com>
    49        1 Xiaowei Chen <chen.xiaowei@h3c.com>
    50        1 Vikhyat Umrao <vumrao@redhat.com>
    51        1 Shang Ding <dingshang2013@163.com>
    52        1 Ruifeng Yang <yangruifeng.09209@h3c.com>
    53        1 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    54        1 Noah Watkins <nwatkins@redhat.com>
    55        1 Nilamdyuti Goswami <ngoswami@redhat.com>
    56        1 Na Xie <xie.na@h3c.com>
    57        1 Marc Koderer <marc@koderer.com>
    58        1 Li Wang <li.wang@kylin-cloud.com>
    59        1 Lenz Grimmer <lenz@grimmer.com>
    60        1 Kongming Wu <wu.kongming@h3c.com>
    61        1 Kiseleva Alyona <akiselyova@mirantis.com>
    62        1 Ken Dreyer <kdreyer@redhat.com>
    63        1 Ji Chen <insomnia@139.com>
    64        1 Jeremy Qian <vanpire110@163.com>
    65        1 Jenkins <jenkins@ceph.com>
    66        1 James Page <james.page@ubuntu.com>
    67        1 Ilya Dryomov <idryomov@redhat.com>
    68        1 Florent Manens <florent@beezim.fr>
    69        1 Douglas Fuller <dfuller@redhat.com>
    70        1 David Zafman <dzafman@redhat.com>
    71        1 Chuanhong Wang <wang.chuanhong@zte.com.cn>
    72        1 Chengyuan Li <chengyli@ebay.com>
    73        1 Brad Hubbard <bhubbard@redhat.com>
    74        1 Anthony Alba <ascanio.alba7@gmail.com>
    75        1 Accela Zhao <accelazh@gmail.com>

Commits, by organizations
     1      227 Red Hat <contact@redhat.com>
     2       45 Mirantis <contact@mirantis.com>
     3       33 XSky <contact@xsky.com>
     4       33 Unaffiliated <no@organization.net>
     5       18 Kylin Cloud <contact@kylin-cloud.com>
     6       14 Reliance Jio Infocomm Ltd. <contact@ril.com>
     7       14 H3C <wentao@h3c.com>
     8       13 SUSE <contact@suse.com>
     9       13 Fujitsu <contact@fujitsu.com>
    10        9 Intel <contact@intel.com>
    11        6 Yahoo! <contact@yahoo-inc.com>
    12        5 Ruijie Networks <contact@ruijie.com.cn>
    13        3 ZTE <contact@zte.com.cn>
    14        3 SanDisk <contact@sandisk.com>
    15        2 Tencent <contact@tencent.com>
    16        2 Inktank <contact@inktank.com>
    17        2 Hihuron <contact@huron.com>
    18        2 DreamHost <contact@dreamhost.com>
    19        1 SAP <contact@sap.com>
    20        1 LETV <contact@letv.com>
    21        1 ICT <contact@ict.ac.cn>
    22        1 Grimmer <lenz@grimmer.com>
    23        1 Ebay <contact@ebay.com>
    24        1 Canonical <contact@canonical.com>
    24        1 Canonical <contact@canonical.com>
    25        1 Beezim <contact@beezim.fr>

Reviews, by authors (one review spans multiple commits)
     1       47 Josh Durgin <jdurgin@redhat.com>
     2       39 Sage Weil <sweil@redhat.com>
     3       26 Loic Dachary <ldachary@redhat.com>
     4       19 Kefu Chai <kchai@redhat.com>
     5       10 Yehuda Sadeh <ysadehwe@redhat.com>
     6        8 Greg Farnum <gfarnum@redhat.com>
     7        7 Jason Dillaman <dillaman@redhat.com>
     8        6 John Spray <jspray@redhat.com>
     9        4 Xinze Chi <xinze@xsky.com>
    10        4 Nathan Cutler <ncutler@suse.com>
    11        4 Haomai Wang <haomai@xsky.com>
    12        3 Ken Dreyer <kdreyer@redhat.com>
    13        2 Varada Kari <varada.kari@sandisk.com>
    14        2 Samuel Just <sjust@redhat.com>
    15        2 Dan Mick <dmick@redhat.com>
    16        2 Boris Ranto <branto@redhat.com>
    17        2 Alfredo Deza <adeza@redhat.com>
    18        1 Yan, Zheng <zyan@redhat.com>
    19        1 Shu, Xinxin <xinxin.shu@intel.com>
    20        1 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    21        1 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    22        1 Pete Zaitcev <zaitcev@redhat.com>
    23        1 Ning Yao <yaoning@ruijie.com.cn>
    24        1 Li Wang <li.wang@kylin-cloud.com>
    25        1 David Zafman <dzafman@redhat.com>
    26        1 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    27        1 Andreas Peters <andreas.joachim.peters@cern.ch>
    28        1 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>

Reviews, by organizations (one review spans multiple commits)
     1      176 Red Hat <contact@redhat.com>
     2        8 XSky <contact@xsky.com>
     3        4 SUSE <contact@suse.com>
     4        2 SanDisk <contact@sandisk.com>
     5        1 Ruijie Networks <contact@ruijie.com.cn>
     6        1 Reliance Jio Infocomm Ltd. <contact@ril.com>
     7        1 Mirantis <contact@mirantis.com>
     8        1 Kylin Cloud <contact@kylin-cloud.com>
     9        1 Intel <contact@intel.com>
    10        1 Fujitsu <contact@fujitsu.com>
    11        1 Deutsche Telekom <contact@telekom.de>
    12        1 CERN <contact@cern.ch>

=3D=3D=3D=3D

Cheers
Swami
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
