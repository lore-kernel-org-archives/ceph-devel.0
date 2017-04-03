From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: v12.0.1 Contributor credits
Date: Mon, 3 Apr 2017 18:18:31 +0530
Message-ID: <CANA9Uk76o_w7DDyo=3WpnXLYdk_BKHHwGD0zVwz_JqNkhEvyJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35165 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdDCMsd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Apr 2017 08:48:33 -0400
Received: by mail-vk0-f45.google.com with SMTP id r69so136471680vke.2
        for <ceph-devel@vger.kernel.org>; Mon, 03 Apr 2017 05:48:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v12.0.1, by number of commits or reviews back to v12.0.0. The
affiliation of authors to organizations can be updated by submitting a
patch to https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge lthough it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenan=
ce_guide

Commits by authors
     1      309 Sage Weil <sweil@redhat.com>
     2       74 Kefu Chai <kchai@redhat.com>
     3       66 John Spray <jspray@redhat.com>
     4       59 Loic Dachary <ldachary@redhat.com>
     5       44 Yehuda Sadeh <ysadehwe@redhat.com>
     6       44 Jason Dillaman <dillaman@redhat.com>
     7       44 Dongsheng Yang <dongsheng.yang@easystack.cn>
     8       31 Chang Liu <liuchang0812@gmail.com>
     9       26 Yan, Zheng <zyan@redhat.com>
    10       25 Patrick Donnelly <pdonnell@redhat.com>
    11       24 Haomai Wang <haomai@xsky.com>
    12       19 Gui Hecheng <guihecheng@cmss.chinamobile.com>
    13       18 Matt Benjamin <mbenjamin@redhat.com>
    14       17 Willem Jan Withagen <wjw@digiware.nl>
    15       16 Nathan Cutler <ncutler@suse.com>
    16       16 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    17       14 Pan Liu <pan.liu@istuary.com>
    18       14 Igor Fedotov <ifedotov@mirantis.com>
    19       14 Casey Bodley <cbodley@redhat.com>
    20       13 Xie Xingguo <xie.xingguo@zte.com.cn>
    21       13 Mykola Golub <mgolub@mirantis.com>
    22       11 Venky Shankar <vshankar@redhat.com>
    23       10 Zack Cerza <zack@redhat.com>
    24       10 Song Baisen <song.baisen@zte.com.cn>
    25       10 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    26        9 Drunkard Zhang <gongfan193@gmail.com>
    27        9 Adam C. Emerson <aemerson@redhat.com>
    28        9 Abhishek Lekshmanan <abhishek@suse.com>
    29        8 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
    30        8 wangzhengyong <wangzhengyong@cmss.chinamobile.com>
    31        8 Samuel Just <sjust@redhat.com>
    32        8 Ma Jianpeng <jianpeng.ma@intel.com>
    33        8 Jiaying Ren <mikulely@gmail.com>
    34        6 David Zafman <dzafman@redhat.com>
    35        5 Sarit Zubakov <saritz@mellanox.com>
    36        5 Mingxin Liu <mingxin@xsky.com>
    37        5 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    38        5 Dan Mick <dmick@redhat.com>
    39        4 Yunchuan Wen <yunchuan.wen@kylin-cloud.com>
    40        4 Xiaoxi Chen <xiaoxchen@ebay.com>
    41        4 Vikhyat Umrao <vumrao@redhat.com>
    42        4 Ilya Dryomov <idryomov@redhat.com>
    43        4 Barbora An=C4=8Dincov=C3=A1 <bara@redhat.com>
    44        4 Adam Kupczyk <akupczyk@mirantis.com>
    45        3 Zhang Zezhu <zhang.zezhu@zte.com.cn>
    46        3 tangwenjun3 <tang.wenjun3@zte.com.cn>
    47        3 Orit Wasserman <owasserm@redhat.com>
    48        3 optimistyzy <optimistyzy@gmail.com>
    49        3 Ken Dreyer <kdreyer@redhat.com>
    50        3 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
    51        3 Greg Farnum <gfarnum@redhat.com>
    52        3 David Disseldorp <ddiss@suse.de>
    53        3 Brad Hubbard <bhubbard@redhat.com>
    54        3 Boris Ranto <branto@redhat.com>
    55        3 Adir Lev <adirl@mellanox.com>
    56        2 Ziye Yang <ziye.yang@intel.com>
    57        2 Zhiqiang Wang <zhiqiang@xsky.com>
    58        2 Wido den Hollander <wido@42on.com>
    59        2 Tahia Khan <tahia.khan@gmail.com>
    60        2 Saumay Agrawal <saumay.agrawal@gmail.com>
    61        2 Robin H. Johnson <robin.johnson@dreamhost.com>
    62        2 Pavan Rallabhandi <PRallabhandi@walmartlabs.com>
    63        2 lvshuhua <lvshuhua@cmss.chinamobile.com>
    64        2 lu.shasha <lu.shasha@eisoo.com>
    65        2 Luo Runbing <runsisi@zte.com.cn>
    66        2 Jie Wang <jie.wang@kylin-cloud.com>
    67        2 Erwan Velu <erwan@redhat.com>
    68        2 Edwin F. Boza <eboza@espol.edu.ec>
    69        2 DanielBar-On <danielbo@mellanox.com>
    70        2 Chuanhong Wang <wang.chuanhong@zte.com.cn>
    71        2 Bart=C5=82omiej =C5=9Awi=C4=99cki <bartlomiej.swiecki@corp.=
ovh.com>
    72        2 Amir Vadai <amir@vadai.me>
    73        1 ZVampirEM77 <enming.zhang@umcloud.com>
    74        1 Zhi Zhang <willzzhang@tencent.com>
    75        1 Zhao Chao <zhaochao1984@gmail.com>
    76        1 Yuri Weinstein <yuriw@redhat.com>
    77        1 Yankun Li <liyankun@unitedstack.com>
    78        1 wei xiao <wei.xiao@linaro.org>
    79        1 Wei Jin <jinwei15@wanda.cn>
    80        1 Victor Denisov <denisovenator@gmail.com>
    81        1 Tang Jin <tang.jin@istuary.com>
    82        1 Tamil Muthamizhan <tmuthami@redhat.com>
    83        1 Taeksang Kim <voidbag@gmail.com>
    84        1 shiqi <m13913886148@gmail.com>
    85        1 Shinobu Kinjo <shinobu@redhat.com>
    86        1 S=C3=A9bastien Han <shan@redhat.com>
    87        1 Ruben Kerkhof <ruben@rubenkerkhof.com>
    88        1 Ronak Jain <ronakjain@outlook.in>
    89        1 Ren Huanwen <ren.huanwen@zte.com.cn>
    90        1 Owen Synge <osynge@suse.com>
    91        1 Ning Yao <yaoning@unitedstack.com>
    92        1 Nikita Gerasimov <nikita.gerasimov@oracle.com>
    93        1 Michal Jarzabek <stiopa@gmail.com>
    94        1 Michael Eischer <michael.eischer@fau.de>
    95        1 Li Wang <li.wang@kylin-cloud.com>
    96        1 Liu Yang <yippeetry@gmail.com>
    97        1 lihongjie <lihongjie@cmss.chinamobile.com>
    98        1 Kyr Shatskyy <kyrylo.shatskyy@gmail.com>
    99        1 Josh Durgin <jdurgin@redhat.com>
   100        1 Jos Collin <jcollin@redhat.com>
   101        1 Jenkins <jenkins@ceph.com>
   102        1 Jan Fajerski <jfajerski@suse.com>
   103        1 hrchu <hrchu@cht.com.tw>
   104        1 Henrik Korkuc <henrik@uber.com>
   105        1 hechuang <hechuang@xsky.com>
   106        1 haodong.tang <tanghaodong25@gmail.com>
   107        1 Gu Zhongyan <guzhongyan@360.cn>
   108        1 Guillaume Abrioux <gabrioux@redhat.com>
   109        1 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
   110        1 Ganesh Mahalingam <ganesh.mahalingam@intel.com>
   111        1 Dave Chen <wei.d.chen@intel.com>
   112        1 Dan van der Ster <daniel.vanderster@cern.ch>
   113        1 craigchi <craig10624@gmail.com>
   114        1 Bassam Tabbara <bassam.tabbara@quantum.com>
   115        1 Ali Maredia <amaredia@redhat.com>
   116        1 Alexey Sheplyakov <asheplyakov@mirantis.com>
Commits by organizations
     1      765 Red Hat <contact@redhat.com>
     2       44 Easystack <contact@easystack.cn>
     3       43 Mirantis <contact@mirantis.com>
     4       41 China Mobile <contact@chinamobile.com>
     5       36 Unaffiliated <no@organization.net>
     6       35 SUSE <contact@suse.com>
     7       34 ZTE <contact@zte.com.cn>
     8       32 XSky <contact@xsky.com>
     9       32 Tencent <contact@tencent.com>
    10       17 Digiware <contact@digiware.nl>
    11       16 Deutsche Telekom <contact@telekom.de>
    12       15 Istuary Innovation Group <contact@istuary.com>
    13       12 Intel <contact@intel.com>
    14       10 Mellanox <contact@mellanox.com>
    15        7 Kylin Cloud <contact@kylin-cloud.com>
    16        4 Ebay <contact@ebay.com>
    17        2 Wido 42on <contact@42on.com>
    18        2 Walmart Labs <contact@walmartlabs.com>
    19        2 UnitedStack <contact@unitedstack.com>
    20        2 OVH <ceph@ovh.net>
    21        2 ESPOL <contact@espol.edu.ec>
    22        2 EISOO <contact@eisoo.com>
    23        2 Eayun <contact@eayun.com>
    24        2 DreamHost <contact@dreamhost.com>
    25        1 Wanda ffan <contact@wanda.cn>
    26        1 UMCloud <contact@umcloud.com>
    27        1 Uber <contact@uber.com>
    28        1 Quantum Corporation <info@quantum.com>
    29        1 Oracle <contact@oracle.com>
    30        1 Linaro <contact@linaro.org>
    31        1 Inktank <contact@inktank.com>
    32        1 FAU <contact@fau.de>
    33        1 Chunghwa Telecom <contact@cht.com.tw>
    34        1 CERN <contact@cern.ch>
Reviews by authors (one review spans multiple commits)
     1      112 Sage Weil <sweil@redhat.com>
     2       98 Kefu Chai <kchai@redhat.com>
     3       39 Jason Dillaman <dillaman@redhat.com>
     4       31 Casey Bodley <cbodley@redhat.com>
     5       29 Josh Durgin <jdurgin@redhat.com>
     6       24 Haomai Wang <haomai@xsky.com>
     7       21 Mykola Golub <mgolub@mirantis.com>
     8       18 Loic Dachary <ldachary@redhat.com>
     9       17 John Spray <jspray@redhat.com>
    10       16 Brad Hubbard <bhubbard@redhat.com>
    11       12 Yehuda Sadeh <ysadehwe@redhat.com>
    12       11 Yan, Zheng <zyan@redhat.com>
    13       10 Greg Farnum <gfarnum@redhat.com>
    14        9 Nathan Cutler <ncutler@suse.com>
    15        9 Igor Fedotov <ifedotov@mirantis.com>
    16        8 Adir Lev <adirl@mellanox.com>
    17        8 Abhishek Lekshmanan <abhishek@suse.com>
    18        6 Ken Dreyer <kdreyer@redhat.com>
    19        5 Xie Xingguo <xie.xingguo@zte.com.cn>
    20        4 Yuri Weinstein <yuriw@redhat.com>
    21        4 Samuel Just <sjust@redhat.com>
    22        4 Orit Wasserman <owasserm@redhat.com>
    23        4 David Zafman <dzafman@redhat.com>
    24        3 Matt Benjamin <mbenjamin@redhat.com>
    25        3 Jos Collin <jcollin@redhat.com>
    26        2 Yuri Weinstein <yweinstei@redhat.com>
    27        2 Willem Jan Withagen <wjw@digiware.nl>
    28        2 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    29        2 Piotr Da=C5=82ek <piotr.dalek@ts.fujitsu.com>
    30        2 Patrick Donnelly <pdonnell@redhat.com>
    31        2 Pan Liu <pan.liu@istuary.com>
    32        2 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@suse.de>
    33        2 Ilya Dryomov <idryomov@redhat.com>
    34        2 Dan Mick <dmick@redhat.com>
    35        2 Chang Liu <liuchang0812@gmail.com>
    36        2 Boris Ranto <branto@redhat.com>
    37        1 Zhiqiang Wang <zhiqiang@xsky.com>
    38        1 Varada Kari <varada.kari@sandisk.com>
    39        1 S=C3=A9bastien Han <shan@redhat.com>
    40        1 Nathan Cutler <nculter@suse.com>
    41        1 John Wilkins <jwilkins@redhat.com>
    42        1 Jiaying Ren <mikulely@gmail.com>
    43        1 Ian Colle <icolle@redhat.com>
    44        1 Dongsheng Yang <dongsheng.yang@easystack.cn>
    45        1 Alexey Sheplyakov <asheplyakov@mirantis.com>
    46        1 Adam C. Emerson <aemerson@redhat.com>
Reviews by organizations (one review spans multiple commits)
     1      430 Red Hat <contact@redhat.com>
     2       33 Mirantis <contact@mirantis.com>
     3       25 XSky <contact@xsky.com>
     4       19 SUSE <contact@suse.com>
     5        8 Mellanox <contact@mellanox.com>
     6        5 ZTE <contact@zte.com.cn>
     7        2 Yuri Weinstein <yweinstei@redhat.com>
     8        2 Tencent <contact@tencent.com>
     9        2 Istuary Innovation Group <contact@istuary.com>
    10        2 Fujitsu <contact@fujitsu.com>
    11        2 Digiware <contact@digiware.nl>
    12        2 Cloudwatt <libre.licensing@cloudwatt.com>
    13        1 Unaffiliated <no@organization.net>
    14        1 SanDisk <contact@sandisk.com>
    15        1 Nathan Cutler <nculter@suse.com>
    16        1 Ian Colle <icolle@redhat.com>
    17        1 Easystack <contact@easystack.cn>
=3D=3D=3D

Cheers
Swami
