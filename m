From: John Spray <jspray@redhat.com>
Subject: Re: Contributor credits for Luminous v12.1.0 RC
Date: Mon, 26 Jun 2017 20:37:08 +0100
Message-ID: <CALe9h7c=F6EuAvu_bOmPFb19ocjZE9faHF6wRrG-GwBVZbPT6A@mail.gmail.com>
References: <f32cec8db925296fccb5b408e06229ce@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35709 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbdFZTha (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Jun 2017 15:37:30 -0400
Received: by mail-wm0-f46.google.com with SMTP id w126so6475892wme.0
        for <ceph-devel@vger.kernel.org>; Mon, 26 Jun 2017 12:37:29 -0700 (PDT)
In-Reply-To: <f32cec8db925296fccb5b408e06229ce@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek <abhishek@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jun 26, 2017 at 7:49 PM, Abhishek <abhishek@suse.com> wrote:
> Hi Ceph,
>
> The first release candidate for Luminous was out,
> here is a sorted list of authors and organizations
> who contributed to v12.1.0 RC, by number of commits &/or
> reviews back to v12.0.3. Thank you everyone for contributing, and keep
> up the good work. The affiliation of authors to organizations can be
> updated by submitting a patch to
> https://github.com/ceph/ceph/blob/master/.organizationmap
>
> All commits are reviewed but the number of reviews is a fraction of
> the number of commits. More often than not, the reviewer(s) is only
> mentioned in the message of the merge although it means that all
> associated commits have been reviewed. If you are curious about how it
> is done, do checkout the wiki entry at
> http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenance_guide
>
> Number of lines added and removed, by authors

>      1  282468 John Spray <jspray@redhat.com>

Let me be the first to confess that I did not really write 282k lines
of code :-)  I think that's probably the js/css in the dashboard
module throwing the stats.

John


>      2   21177 Ganesh Mahalingam <ganesh.mahalingam@intel.com>
>      3   14387 Sage Weil <sweil@redhat.com>
>      4    8403 Yehuda Sadeh <ysadehwe@redhat.com>
>      5    7012 Radoslaw Zarzynski <rzarzynski@mirantis.com>
>      6    6129 Casey Bodley <cbodley@redhat.com>
>      7    4554 Adam C. Emerson <aemerson@redhat.com>
>      8    4429 Kefu Chai <kchai@redhat.com>
>      9    3946 Jason Dillaman <dillaman@redhat.com>
>     10    3892 Amir Vadai <amir@vadai.me>
>     11    3772 Boris Ranto <branto@redhat.com>
>     12    3413 Orit Wasserman <owasserm@redhat.com>
>     13    2711 Mykola Golub <mgolub@mirantis.com>
>     14    2468 Greg Farnum <gfarnum@redhat.com>
>     15    2128 João Eduardo Luís <joao@suse.de>
>     16    2025 Xie Xingguo <xie.xingguo@zte.com.cn>
>     17    1452 Yan, Zheng <zyan@redhat.com>
>     18    1322 Jesse Williamson <jesse.williamson@suse.com>
>     19    1315 Abhishek Lekshmanan <abhishek@suse.com>
>     20    1218 Jos Collin <jcollin@redhat.com>
>     21    1012 Willem Jan Withagen <wjw@digiware.nl>
>     22     994 Brad Hubbard <bhubbard@redhat.com>
>     23     887 Myoungwon Oh <omwmw@sk.com>
>     24     870 Marcus Watts <mwatts@redhat.com>
>     25     767 Pritha Srivastava <prsrivas@redhat.com>
>     26     743 Piotr Dałek <piotr.dalek@corp.ovh.com>
>     27     639 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
>     28     635 Xiaowei Chen <chen.xiaowei@h3c.com>
>     29     628 Loic Dachary <ldachary@redhat.com>
>     30     551 mychoxin <mychoxin@gmail.com>
>     31     544 Ma Jianpeng <jianpeng.ma@intel.com>
>     32     519 Neha Ojha <nojha@redhat.com>
>     33     512 David Zafman <dzafman@redhat.com>
>     34     489 Matt Benjamin <mbenjamin@redhat.com>
>     35     482 Haomai Wang <haomai@xsky.com>
>     36     477 Adam Kupczyk <akupczyk@mirantis.com>
>     37     453 Tim Serong <tserong@suse.com>
>     38     398 Pan Liu <wanjun.lp@alibaba-inc.com>
>     39     386 Chang Liu <liuchang0812@gmail.com>
>     40     380 Nathan Cutler <ncutler@suse.com>
>     41     354 Luo Runbing <runsisi@zte.com.cn>
>     42     334 Andrew Solomon <asolomon@us.ibm.com>
>     43     287 Daniel Oliveira <doliveira@suse.com>
>     44     276 J. Eric Ivancich <ivancich@redhat.com>
>     45     268 Igor Fedotov <ifedotov@mirantis.com>
>     46     250 lu.shasha <lu.shasha@eisoo.com>
>     47     221 Javier M. Mellid <jmunhoz@igalia.com>
>     48     206 Fang Yuxiang <fang.yuxiang@eisoo.com>
>     49     175 Ilya Dryomov <idryomov@redhat.com>
>     50     163 Victor Araujo <ve.ar91@gmail.com>
>     51     150 Dan Mick <dmick@redhat.com>
>     52     120 Leo Zhang <nguzcf@gmail.com>
>     53     114 Mohamad Gebai <mgebai@suse.com>
>     54     114 Logan Blyth <mrbojangles3@gmail.com>
>     55     107 Jiaying Ren <jiaying.ren@umcloud.com>
>     56      99 Gui Hecheng <guihecheng@cmss.chinamobile.com>
>     57      94 Jens Rosenboom <j.rosenboom@x-ion.de>
>     58      82 Zhi Zhang <willzzhang@tencent.com>
>     59      71 Zhang Lei <243290414@qq.com>
>     60      65 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
>     61      64 James Page <james.page@ubuntu.com>
>     62      53 Xiaoyan Li <xiaoyan.li@intel.com>
>     63      52 Vicente Cheng <vicente_cheng@bigtera.com>
>     64      49 Lin Bing <hawkerous@gmail.com>
>     65      45 Ken Dreyer <kdreyer@redhat.com>
>     66      44 Jin Cai <caijin.caij@alibaba-inc.com>
>     67      43 Daniel Gryniewicz <dang@redhat.com>
>     68      40 Ren Huanwen <ren.huanwen@zte.com.cn>
>     69      39 Yuli Yang <yuliyang@cmss.chinamobile.com>
>     70      37 Dongdong Tao <tdd21151186@gmail.com>
>     71      34 Adir Lev <adirl@mellanox.com>
>     72      27 Drunkard Zhang <gongfan193@gmail.com>
>     73      26 Patrick Donnelly <pdonnell@redhat.com>
>     74      20 Guo Zhandong <guozhandong@cmss.chinamobile.com>
>     75      20 Enming Zhang <enming.zhang@umcloud.com>
>     76      19 Sameer Tiwari <stiwari@salesforce.com>
>     77      19 Bassam Tabbara <bassam.tabbara@quantum.com>
>     78      18 Mingxin Liu <mingxin@xsky.com>
>     79      17 Zhang Zezhu <zhang.zezhu@zte.com.cn>
>     80      17 Daniel Bar-On <danielbo@mellanox.com>
>     81      16 Shiqi <m13913886148@gmail.com>
>     82      12 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
>     83      10 Tushar Gohad <tushar.gohad@intel.com>
>     84       9 Chenfang Xian <chenfangxian@cmss.chinamobile.com>
>     85       9 Ali Maredia <amaredia@redhat.com>
>     86       8 Yao Zongyou <yaozongyou@vip.qq.com>
>     87       8 Thomas Serlin <tserlin@redhat.com>
>     88       8 Fabian Grünbichler <f.gruenbichler@proxmox.com>
>     89       7 Yu Shengzuo <yu.shengzuo@99cloud.net>
>     90       6 Zheng Yin <zhengyin@chinac.com>
>     91       6 Yuri Weinstein <yuriw@redhat.com>
>     92       6 Redick Wang <redickwang@tencent.com>
>     93       6 Mark Nelson <mnelson@redhat.com>
>     94       6 Dongsheng Yang <dongsheng.yang@easystack.cn>
>     95       4 Henry Chang <henry_chang@bigtera.com>
>     96       4 Barbora Ančincová <bara@redhat.com>
>     97       3 Yanhu Cao <gmayyyha@gmail.com>
>     98       2 Shengjing Zhu <zsj950618@gmail.com>
>     99       2 Sarit Zubakov <saritz@mellanox.com>
>    100       2 MinSheng Lin <minsheng.l@inwinstack.com>
>    101       2 Liu Yuhong <liuyuhong@cmss.chinamobile.com>
>    102       2 Li Hongjie <lihongjie@cmss.chinamobile.com>
>    103       2 Hong Zhangoole <hong.zhangoole@gmail.com>
>    104       2 Alessandro Barbieri <ale.barbio@alice.it>
>
> Number of lines added and removed, by organization
>      1  342166 Red Hat <contact@redhat.com>
>      2   21784 Intel <contact@intel.com>
>      3   10468 Mirantis <contact@mirantis.com>
>      4    6194 Unaffiliated <no@organization.net>
>      5    5999 SUSE <contact@suse.com>
>      6    2436 ZTE <contact@zte.com.cn>
>      7    1012 Digiware <contact@digiware.nl>
>      8     875 China Mobile <contact@chinamobile.com>
>      9     743 OVH <ceph@ovh.net>
>     10     635 H3C <contact@h3c.com>
>     11     500 XSky <contact@xsky.com>
>     12     456 EISOO <contact@eisoo.com>
>     13     442 Alibaba <contact@alibaba-inc.com>
>     14     334 IBM <contact@IBM.com>
>     15     221 Igalia <contact@igalia.com>
>     16     127 UMCloud <contact@umcloud.com>
>     17     120 T2Cloud <contact@t2cloud.net>
>     18      94 X-ion GmbH <contact@x-ion.de>
>     19      88 Tencent <contact@tencent.com>
>     20      64 Canonical <contact@canonical.com>
>     21      56 Bigtera <contact@bigtera.com>
>     22      53 Mellanox <contact@mellanox.com>
>     23      19 Salesforce <contact@salesforce.com>
>     24      19 Quantum Corporation <info@quantum.com>
>     25      16 Trendy Tech <contact@trendytech.com.cn>
>     26      12 Catalysts <office@catalysts.cc>
>     27       8 Proxmox Server Solutions GmbH <office@proxmox.com>
>     28       7 99Cloud Inc <contact@99cloud.net>
>     29       6 Easystack <contact@easystack.cn>
>     30       6 Chinac <info@chinac.com>
>     31       2 inwinSTACK inc. <leo.l@inwinstack.com>
>
> Commits, by authors
>      1      328 Sage Weil <sweil@redhat.com>
>      2      123 Yehuda Sadeh <ysadehwe@redhat.com>
>      3      102 Kefu Chai <kchai@redhat.com>
>      4       73 Radoslaw Zarzynski <rzarzynski@mirantis.com>
>      5       63 John Spray <jspray@redhat.com>
>      6       51 Greg Farnum <gfarnum@redhat.com>
>      7       50 Yan, Zheng <zyan@redhat.com>
>      8       50 Casey Bodley <cbodley@redhat.com>
>      9       46 Orit Wasserman <owasserm@redhat.com>
>     10       38 Abhishek Lekshmanan <abhishek@suse.com>
>     11       37 Jason Dillaman <dillaman@redhat.com>
>     12       33 Xie Xingguo <xie.xingguo@zte.com.cn>
>     13       25 Willem Jan Withagen <wjw@digiware.nl>
>     14       21 Nathan Cutler <ncutler@suse.com>
>     15       20 Jos Collin <jcollin@redhat.com>
>     16       20 Boris Ranto <branto@redhat.com>
>     17       18 Haomai Wang <haomai@xsky.com>
>     18       18 Amir Vadai <amir@vadai.me>
>     19       16 Xiaowei Chen <chen.xiaowei@h3c.com>
>     20       16 Jesse Williamson <jesse.williamson@suse.com>
>     21       16 Adam C. Emerson <aemerson@redhat.com>
>     22       14 João Eduardo Luís <joao@suse.de>
>     23       12 Chang Liu <liuchang0812@gmail.com>
>     24       11 Neha Ojha <nojha@redhat.com>
>     25       11 Myoungwon Oh <omwmw@sk.com>
>     26       11 Mykola Golub <mgolub@mirantis.com>
>     27       11 Dan Mick <dmick@redhat.com>
>     28       11 Brad Hubbard <bhubbard@redhat.com>
>     29       10 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
>     30       10 Gui Hecheng <guihecheng@cmss.chinamobile.com>
>     31        9 Pritha Srivastava <prsrivas@redhat.com>
>     32        9 Loic Dachary <ldachary@redhat.com>
>     33        9 Leo Zhang <nguzcf@gmail.com>
>     34        9 Igor Fedotov <ifedotov@mirantis.com>
>     35        8 Luo Runbing <runsisi@zte.com.cn>
>     36        8 Jiaying Ren <jiaying.ren@umcloud.com>
>     37        7 Matt Benjamin <mbenjamin@redhat.com>
>     38        7 Ma Jianpeng <jianpeng.ma@intel.com>
>     39        7 lu.shasha <lu.shasha@eisoo.com>
>     40        7 Lin Bing <hawkerous@gmail.com>
>     41        7 Fang Yuxiang <fang.yuxiang@eisoo.com>
>     42        7 David Zafman <dzafman@redhat.com>
>     43        6 Zhang Lei <243290414@qq.com>
>     44        6 Drunkard Zhang <gongfan193@gmail.com>
>     45        5 Zhi Zhang <willzzhang@tencent.com>
>     46        5 Piotr Dałek <piotr.dalek@corp.ovh.com>
>     47        5 Patrick Donnelly <pdonnell@redhat.com>
>     48        5 Pan Liu <wanjun.lp@alibaba-inc.com>
>     49        5 Mohamad Gebai <mgebai@suse.com>
>     50        4 Yuli Yang <yuliyang@cmss.chinamobile.com>
>     51        4 Tim Serong <tserong@suse.com>
>     52        4 Shiqi <m13913886148@gmail.com>
>     53        4 Ren Huanwen <ren.huanwen@zte.com.cn>
>     54        4 J. Eric Ivancich <ivancich@redhat.com>
>     55        4 Ilya Dryomov <idryomov@redhat.com>
>     56        4 Daniel Oliveira <doliveira@suse.com>
>     57        3 Zhang Zezhu <zhang.zezhu@zte.com.cn>
>     58        3 Xiaoyan Li <xiaoyan.li@intel.com>
>     59        3 Mingxin Liu <mingxin@xsky.com>
>     60        3 Ken Dreyer <kdreyer@redhat.com>
>     61        3 Bassam Tabbara <bassam.tabbara@quantum.com>
>     62        3 Adam Kupczyk <akupczyk@mirantis.com>
>     63        2 Vicente Cheng <vicente_cheng@bigtera.com>
>     64        2 Tushar Gohad <tushar.gohad@intel.com>
>     65        2 Thomas Serlin <tserlin@redhat.com>
>     66        2 Sameer Tiwari <stiwari@salesforce.com>
>     67        2 Redick Wang <redickwang@tencent.com>
>     68        2 Mark Nelson <mnelson@redhat.com>
>     69        2 Jens Rosenboom <j.rosenboom@x-ion.de>
>     70        2 Fabian Grünbichler <f.gruenbichler@proxmox.com>
>     71        2 Dongdong Tao <tdd21151186@gmail.com>
>     72        2 Daniel Bar-On <danielbo@mellanox.com>
>     73        2 Andrew Solomon <asolomon@us.ibm.com>
>     74        2 Adir Lev <adirl@mellanox.com>
>     75        1 Zheng Yin <zhengyin@chinac.com>
>     76        1 Yu Shengzuo <yu.shengzuo@99cloud.net>
>     77        1 Yuri Weinstein <yuriw@redhat.com>
>     78        1 Yao Zongyou <yaozongyou@vip.qq.com>
>     79        1 Yanhu Cao <gmayyyha@gmail.com>
>     80        1 Victor Araujo <ve.ar91@gmail.com>
>     81        1 Shengjing Zhu <zsj950618@gmail.com>
>     82        1 Sarit Zubakov <saritz@mellanox.com>
>     83        1 mychoxin <mychoxin@gmail.com>
>     84        1 MinSheng Lin <minsheng.l@inwinstack.com>
>     85        1 Marcus Watts <mwatts@redhat.com>
>     86        1 Logan Blyth <mrbojangles3@gmail.com>
>     87        1 Liu Yuhong <liuyuhong@cmss.chinamobile.com>
>     88        1 Li Hongjie <lihongjie@cmss.chinamobile.com>
>     89        1 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
>     90        1 Jin Cai <caijin.caij@alibaba-inc.com>
>     91        1 Javier M. Mellid <jmunhoz@igalia.com>
>     92        1 James Page <james.page@ubuntu.com>
>     93        1 Hong Zhangoole <hong.zhangoole@gmail.com>
>     94        1 Henry Chang <henry_chang@bigtera.com>
>     95        1 Guo Zhandong <guozhandong@cmss.chinamobile.com>
>     96        1 Ganesh Mahalingam <ganesh.mahalingam@intel.com>
>     97        1 Enming Zhang <enming.zhang@umcloud.com>
>     98        1 Dongsheng Yang <dongsheng.yang@easystack.cn>
>     99        1 Daniel Gryniewicz <dang@redhat.com>
>    100        1 Chenfang Xian <chenfangxian@cmss.chinamobile.com>
>    101        1 Barbora Ančincová <bara@redhat.com>
>    102        1 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
>    103        1 Ali Maredia <amaredia@redhat.com>
>    104        1 Alessandro Barbieri <ale.barbio@alice.it>
>
> Commits, by organizations
>      1      996 Red Hat <contact@redhat.com>
>      2      102 SUSE <contact@suse.com>
>      3       96 Mirantis <contact@mirantis.com>
>      4       70 Unaffiliated <no@organization.net>
>      5       48 ZTE <contact@zte.com.cn>
>      6       29 China Mobile <contact@chinamobile.com>
>      7       25 Digiware <contact@digiware.nl>
>      8       21 XSky <contact@xsky.com>
>      9       16 H3C <contact@h3c.com>
>     10       14 EISOO <contact@eisoo.com>
>     11       13 Intel <contact@intel.com>
>     12        9 UMCloud <contact@umcloud.com>
>     13        9 T2Cloud <contact@t2cloud.net>
>     14        7 Tencent <contact@tencent.com>
>     15        6 Alibaba <contact@alibaba-inc.com>
>     16        5 OVH <ceph@ovh.net>
>     17        5 Mellanox <contact@mellanox.com>
>     18        4 Trendy Tech <contact@trendytech.com.cn>
>     19        3 Quantum Corporation <info@quantum.com>
>     20        3 Bigtera <contact@bigtera.com>
>     21        2 X-ion GmbH <contact@x-ion.de>
>     22        2 Salesforce <contact@salesforce.com>
>     23        2 Proxmox Server Solutions GmbH <office@proxmox.com>
>     24        2 IBM <contact@IBM.com>
>     25        1 inwinSTACK inc. <leo.l@inwinstack.com>
>     26        1 Igalia <contact@igalia.com>
>     27        1 Easystack <contact@easystack.cn>
>     28        1 Chinac <info@chinac.com>
>     29        1 Catalysts <office@catalysts.cc>
>     30        1 Canonical <contact@canonical.com>
>     31        1 99Cloud Inc <contact@99cloud.net>
>
> Reviews, by authors (one review spans multiple commits)
>      1      118 Kefu Chai <kchai@redhat.com>
>      2       94 Sage Weil <sweil@redhat.com>
>      3       52 Casey Bodley <cbodley@redhat.com>
>      4       46 Josh Durgin <jdurgin@redhat.com>
>      5       28 John Spray <jspray@redhat.com>
>      6       19 Jason Dillaman <dillaman@redhat.com>
>      7       17 Loic Dachary <ldachary@redhat.com>
>      8       16 Greg Farnum <gfarnum@redhat.com>
>      9       15 Igor Fedotov <ifedotov@mirantis.com>
>     10       13 Xie Xingguo <xie.xingguo@zte.com.cn>
>     11       13 Mykola Golub <mgolub@mirantis.com>
>     12       10 Yan, Zheng <zyan@redhat.com>
>     13       10 Patrick Donnelly <pdonnell@redhat.com>
>     14       10 Jos Collin <jcollin@redhat.com>
>     15       10 Haomai Wang <haomai@xsky.com>
>     16        9 Yehuda Sadeh <ysadehwe@redhat.com>
>     17        9 Brad Hubbard <bhubbard@redhat.com>
>     18        8 Orit Wasserman <owasserm@redhat.com>
>     19        7 Willem Jan Withagen <wjw@digiware.nl>
>     20        6 Radoslaw Zarzynski <rzarzynski@mirantis.com>
>     21        6 Adam C. Emerson <aemerson@redhat.com>
>     22        5 Nathan Cutler <ncutler@suse.com>
>     23        5 Ken Dreyer <kdreyer@redhat.com>
>     24        5 Daniel Gryniewicz <dang@redhat.com>
>     25        5 Boris Ranto <branto@redhat.com>
>     26        5 Abhishek Lekshmanan <abhishek@suse.com>
>     27        4 Varada Kari <varada.kari@sandisk.com>
>     28        4 Mark Nelson <mnelson@redhat.com>
>     29        3 Dan Mick <dmick@redhat.com>
>     30        3 Alfredo Deza <adeza@redhat.com>
>     31        2 Piotr Dałek <piotr.dalek@corp.ovh.com>
>     32        2 Neha Ojha <nojha@redhat.com>
>     33        2 David Zafman <dzafman@redhat.com>
>     34        1 Wido den Hollander <wido@42on.com>
>     35        1 Vasu Kulkarni <vasu@redhat.com>
>     36        1 Tim Serong <tserong@suse.com>
>     37        1 Pan Liu <wanjun.lp@alibaba-inc.com>
>     38        1 John Wilkins <jwilkins@redhat.com>
>     39        1 João Eduardo Luís <joao@suse.de>
>     40        1 Douglas Fuller <dfuller@redhat.com>
>     41        1 David Disseldorp <ddiss@suse.de>
>     42        1 Bassam Tabbara <bassam.tabbara@quantum.com>
>     43        1 Alexey Sheplyakov <asheplyakov@mirantis.com>
>     44        1 Adam Kupczyk <akupczyk@mirantis.com>
>
> Reviews, by organizations (one review spans multiple commits)
>      1      477 Red Hat <contact@redhat.com>
>      2       36 Mirantis <contact@mirantis.com>
>      3       13 ZTE <contact@zte.com.cn>
>      4       13 SUSE <contact@suse.com>
>      5       10 XSky <contact@xsky.com>
>      6        7 Digiware <contact@digiware.nl>
>      7        7 Cloudwatt <libre.licensing@cloudwatt.com>
>      8        4 SanDisk <contact@sandisk.com>
>      9        2 OVH <ceph@ovh.net>
>     10        1 Wido 42on <contact@42on.com>
>     11        1 Quantum Corporation <info@quantum.com>
>     12        1 Alibaba <contact@alibaba-inc.com>
>
> Best,
> Abhishek
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
