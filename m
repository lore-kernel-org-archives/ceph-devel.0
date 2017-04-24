From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: v12.0.2 Luminous Contributor credits
Date: Mon, 24 Apr 2017 23:31:49 +0200
Message-ID: <58FE6EC5.2010600@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:53940 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S978092AbdDXVc1 (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 24 Apr 2017 17:32:27 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph,

Yet another release of Ceph is out, here is a sorted list of authors and
organizations who contributed to v12.0.2, by number of commits or
reviews back to v12.0.1. Thank you everyone for contributing, and keep
up the good work. The affiliation of authors to organizations can be
updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, do checkout the wiki entry at
http://tracker.ceph.com/projects/ceph/wiki/Ceph_contributors_list_maintenance_guide 



Number of lines added and removed, by authors
      1      8375 Radoslaw Zarzynski <rzarzynski@mirantis.com>
      2      8345 Sage Weil <sweil@redhat.com>
      3      6111 Adam Kupczyk <akupczyk@mirantis.com>
      4      3833 Kefu Chai <kchai@redhat.com>
      5      3250 Casey Bodley <cbodley@redhat.com>
      6      2844 Amir Vadai <amir@vadai.me>
      7      2819 Ricardo Dias <rdias@suse.com>
      8      2527 Igor Fedotov <ifedotov@mirantis.com>
      9      2284 Abhishek Lekshmanan <abhishek@suse.com>
     10      2239 Mykola Golub <mgolub@mirantis.com>
     11      2193 John Wilkins <jwilkins@redhat.com>
     12      1944 Andrew Solomon <asolomon@us.ibm.com>
     13      1871 Jason Dillaman <dillaman@redhat.com>
     14      1667 Loic Dachary <ldachary@redhat.com>
     15      1427 David Zafman <dzafman@redhat.com>
     16      1333 Chang Liu <liuchang0812@gmail.com>
     17      1324 Jos Collin <jcollin@redhat.com>
     18       970 John Spray <jspray@redhat.com>
     19       866 Yan, Zheng <zyan@redhat.com>
     20       865 Josh Durgin <jdurgin@redhat.com>
     21       772 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
     22       572 Samuel Just <sjust@redhat.com>
     23       538 Ning Yao <yaoning@unitedstack.com>
     24       538 Ali Maredia <amaredia@redhat.com>
     25       393 Ziye Yang <ziye.yang@intel.com>
     26       390 Nathan Cutler <ncutler@suse.com>
     27       389 lvshuhua <lvshuhua@cmss.chinamobile.com>
     28       367 Douglas Fuller <dfuller@redhat.com>
     29       313 Matt Benjamin <mbenjamin@redhat.com>
     30       301 Jesse Williamson <jesse.williamson@suse.com>
     31       297 Willem Jan Withagen <wjw@digiware.nl>
     32       269 Shinobu Kinjo <shinobu@redhat.com>
     33       269 Boris Ranto <branto@redhat.com>
     34       264 Brad Hubbard <bhubbard@redhat.com>
     35       226 Haomai Wang <haomai@xsky.com>
     36       224 Ira Cooper <ira@samba.org>
     37       138 Harald Klein <hari@vt100.at>
     38       137 Patrick Donnelly <pdonnell@redhat.com>
     39       112 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
     40        82 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     41        76 Dan Mick <dmick@redhat.com>
     42        72 Fabian Grünbichler <f.gruenbichler@proxmox.com>
     43        71 Piotr Dałek <piotr.dalek@corp.ovh.com>
     44        67 Yang Honggang <joseph.yang@xtaotech.com>
     45        65 Gui Hecheng <guihecheng@cmss.chinamobile.com>
     46        62 optimistyzy <optimistyzy@gmail.com>
     47        60 Pan Liu <pan.liu@istuary.com>
     48        55 Ma Jianpeng <jianpeng.ma@intel.com>
     49        49 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
     50        49 Erwan Velu <erwan@redhat.com>
     51        38 Adam C. Emerson <aemerson@redhat.com>
     52        33 Shiqi <m13913886148@gmail.com>
     53        33 Sarit Zubakov <saritz@mellanox.com>
     54        31 wangzhengyong <wangzhengyong@cmss.chinamobile.com>
     55        30 Wido den Hollander <wido@42on.com>
     56        28 Yu Shengzuo <yu.shengzuo@99cloud.net>
     57        27 Yehuda Sadeh <ysadehwe@redhat.com>
     58        27 Ilya Dryomov <idryomov@redhat.com>
     59        27 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
     60        23 Vasu Kulkarni <vasu@redhat.com>
     61        23 Andrey Parfenov <aparfenov@virtuozzo.com>
     62        19 Song Baisen <song.baisen@zte.com.cn>
     63        19 Henrik Korkuc <henrik@uber.com>
     64        18 J. Eric Ivancich <ivancich@redhat.com>
     65        16 Zhang Zezhu <zhang.zezhu@zte.com.cn>
     66        15 Wei Jin <jinwei15@wanda.cn>
     67        14 Sébastien Han <shan@redhat.com>
     68        14 Rishabh Kumar <kris.kr296@gmail.com>
     69        14 Fang Yuxiang <fang.yuxiang@eisoo.com>
     70        11 Tim Serong <tserong@suse.com>
     71        11 Guo Zhandong <guozhandong@cmss.chinamobile.com>
     72         9 Weibing Zhang <zhangweibing@unitedstack.com>
     73         8 Mingxin Liu <mingxin@xsky.com>
     74         8 Jenkins <jenkins@ceph.com>
     75         8 Hans van den Bogert <hansbogert@gmail.com>
     76         6 Yanchun Bai <yanchun.bai@istuary.com>
     77         6 Mohamad Gebai <mgebai@suse.com>
     78         5 Luo Runbing <runsisi@zte.com.cn>
     79         5 Chu Hua-Rong <hrchu@cht.com.tw>
     80         4 Vedant Nanda <vedant15114@iiitd.ac.in>
     81         4 Patrick Dinnen <pdinnen@gmail.com>
     82         4 Michal Jarzabek <stiopa@gmail.com>
     83         4 Huang Jun <hjwsm1989@gmail.com>
     84         4 Dan van der Ster <daniel.vanderster@cern.ch>
     85         3 Pritha Srivastava <prsrivas@redhat.com>
     86         3 Alexey Sheplyakov <asheplyakov@mirantis.com>
     87         2 Yao Zongyou <yaozongyou@vip.qq.com>
     88         2 Tang Jin <tang.jin@istuary.com>
     89         2 Sven Seeberg <sseebergelverfeldt@suse.com>
     90         2 Orit Wasserman <owasserm@redhat.com>
     91         2 Liu Hong <liuhong@cmss.chinamobile.com>
     92         2 Li Hongjie <lihongjie@cmss.chinamobile.com>
     93         2 Leo Zhang <nguzcf@gmail.com>
     94         2 Hongtong Liu <hongtong.liu@istuary.com>
     95         2 He Chuang <hechuang@xsky.com>
     96         2 Anjaneya Chagam <anjaneya.chagam@intel.com>
     97         2 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
     98         1 YunfeiGuan <yunfei.guan@xtaotech.com>
     99         1 Xie Xingguo <xie.xingguo@zte.com.cn>
    100         1 Tone Zhang <tone.zhang@linaro.org>

Number of lines added and removed, by organization
      1     29768 Red Hat <contact@redhat.com>
      2     19255 Mirantis <contact@mirantis.com>
      3      5813 SUSE <contact@suse.com>
      4      3168 Unaffiliated <no@organization.net>
      5      1944 IBM <contact@IBM.com>
      6      1333 Tencent <contact@tencent.com>
      7      1321 China Mobile <contact@chinamobile.com>
      8       547 UnitedStack <contact@unitedstack.com>
      9       450 Intel <contact@intel.com>
     10       297 Digiware <contact@digiware.nl>
     11       236 XSky <contact@xsky.com>
     12       193 Cloudwatt <libre.licensing@cloudwatt.com>
     13        82 Deutsche Telekom <contact@telekom.de>
     14        72 Proxmox Server Solutions GmbH <contcat@proxmox.com>
     15        71 OVH <ceph@ovh.net>
     16        70 Istuary Innovation Group <contact@istuary.com>
     17        41 ZTE <contact@zte.com.cn>
     18        33 Trendy Tech <contact@trendytech.com.cn>
     19        33 Mellanox <contact@mellanox.com>
     20        30 Wido 42on <contact@42on.com>
     21        28 99Cloud Inc <contact@99cloud.net>
     22        23 Virtuozzo <contact@virtuozzo.com>
     23        19 Uber Technologies Inc. <contact@uber.com>
     24        15 Wanda ffan <contact@wanda.cn>
     25        14 EISOO <contact@eisoo.com>
     26         8 Budgetenergie <itbeheer@budgetenergie.nl>
     27         5 Chunghwa Telecom <contact@cht.com.tw>
     28         4 Indraprastha Institute of Information Technology, 
Delhi <contact@iiitd.ac.in>
     29         4 CERN <contact@cern.ch>
     30         2 Catalysts <office@catalysts.cc>
     31         1 XTao Co. Ltd. <contact@xtaotech.com>
     32         1 Linaro <contact@linaro.org>

Commits, by authors
      1        199 Sage Weil <sweil@redhat.com>
      2         70 Kefu Chai <kchai@redhat.com>
      3         68 Radoslaw Zarzynski <rzarzynski@mirantis.com>
      4         38 David Zafman <dzafman@redhat.com>
      5         37 Casey Bodley <cbodley@redhat.com>
      6         33 John Spray <jspray@redhat.com>
      7         25 Adam Kupczyk <akupczyk@mirantis.com>
      8         23 Yan, Zheng <zyan@redhat.com>
      9         20 Chang Liu <liuchang0812@gmail.com>
     10         19 Loic Dachary <ldachary@redhat.com>
     11         18 Jason Dillaman <dillaman@redhat.com>
     12         15 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     13         14 Nathan Cutler <ncutler@suse.com>
     14         14 Amir Vadai <amir@vadai.me>
     15         13 Brad Hubbard <bhubbard@redhat.com>
     16         12 Willem Jan Withagen <wjw@digiware.nl>
     17         12 Ricardo Dias <rdias@suse.com>
     18         11 Josh Durgin <jdurgin@redhat.com>
     19         11 Jos Collin <jcollin@redhat.com>
     20         11 Igor Fedotov <ifedotov@mirantis.com>
     21         11 Adam C. Emerson <aemerson@redhat.com>
     22         10 Mykola Golub <mgolub@mirantis.com>
     23          9 Abhishek Lekshmanan <abhishek@suse.com>
     24          8 Dan Mick <dmick@redhat.com>
     25          7 wangzhengyong <wangzhengyong@cmss.chinamobile.com>
     26          6 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
     27          6 Matt Benjamin <mbenjamin@redhat.com>
     28          6 Jesse Williamson <jesse.williamson@suse.com>
     29          5 Zhang Shaowen <zhangshaowen@cmss.chinamobile.com>
     30          5 Samuel Just <sjust@redhat.com>
     31          5 Patrick Donnelly <pdonnell@redhat.com>
     32          5 Pan Liu <pan.liu@istuary.com>
     33          5 Haomai Wang <haomai@xsky.com>
     34          5 Gui Hecheng <guihecheng@cmss.chinamobile.com>
     35          4 Vasu Kulkarni <vasu@redhat.com>
     36          4 Sarit Zubakov <saritz@mellanox.com>
     37          4 Ning Yao <yaoning@unitedstack.com>
     38          4 Ma Jianpeng <jianpeng.ma@intel.com>
     39          4 Boris Ranto <branto@redhat.com>
     40          4 Andrey Parfenov <aparfenov@virtuozzo.com>
     41          3 Ziye Yang <ziye.yang@intel.com>
     42          3 Weibing Zhang <zhangweibing@unitedstack.com>
     43          3 Tim Serong <tserong@suse.com>
     44          3 Shiqi <m13913886148@gmail.com>
     45          3 Shinobu Kinjo <shinobu@redhat.com>
     46          3 Luo Runbing <runsisi@zte.com.cn>
     47          3 John Wilkins <jwilkins@redhat.com>
     48          3 Ilya Dryomov <idryomov@redhat.com>
     49          3 Douglas Fuller <dfuller@redhat.com>
     50          2 Zhang Zezhu <zhang.zezhu@zte.com.cn>
     51          2 Yu Shengzuo <yu.shengzuo@99cloud.net>
     52          2 Wei Jin <jinwei15@wanda.cn>
     53          2 Song Baisen <song.baisen@zte.com.cn>
     54          2 Sébastien Han <shan@redhat.com>
     55          2 Piotr Dałek <piotr.dalek@corp.ovh.com>
     56          2 optimistyzy <optimistyzy@gmail.com>
     57          2 Mingxin Liu <mingxin@xsky.com>
     58          2 lvshuhua <lvshuhua@cmss.chinamobile.com>
     59          2 J. Eric Ivancich <ivancich@redhat.com>
     60          2 Hans van den Bogert <hansbogert@gmail.com>
     61          2 Guo Zhandong <guozhandong@cmss.chinamobile.com>
     62          2 Dan van der Ster <daniel.vanderster@cern.ch>
     63          2 Andrew Solomon <asolomon@us.ibm.com>
     64          2 Ali Maredia <amaredia@redhat.com>
     65          1 YunfeiGuan <yunfei.guan@xtaotech.com>
     66          1 Yehuda Sadeh <ysadehwe@redhat.com>
     67          1 Yao Zongyou <yaozongyou@vip.qq.com>
     68          1 Yang Honggang <joseph.yang@xtaotech.com>
     69          1 Yanchun Bai <yanchun.bai@istuary.com>
     70          1 Xie Xingguo <xie.xingguo@zte.com.cn>
     71          1 Wido den Hollander <wido@42on.com>
     72          1 Vedant Nanda <vedant15114@iiitd.ac.in>
     73          1 Tone Zhang <tone.zhang@linaro.org>
     74          1 Tang Jin <tang.jin@istuary.com>
     75          1 Sven Seeberg <sseebergelverfeldt@suse.com>
     76          1 Rishabh Kumar <kris.kr296@gmail.com>
     77          1 Pritha Srivastava <prsrivas@redhat.com>
     78          1 Patrick Dinnen <pdinnen@gmail.com>
     79          1 Orit Wasserman <owasserm@redhat.com>
     80          1 Mohamad Gebai <mgebai@suse.com>
     81          1 Michal Jarzabek <stiopa@gmail.com>
     82          1 Liu Hong <liuhong@cmss.chinamobile.com>
     83          1 Li Hongjie <lihongjie@cmss.chinamobile.com>
     84          1 Leo Zhang <nguzcf@gmail.com>
     85          1 Jing Wenjun <jingwenjun@cmss.chinamobile.com>
     86          1 Jenkins <jenkins@ceph.com>
     87          1 Ira Cooper <ira@samba.org>
     88          1 Huang Jun <hjwsm1989@gmail.com>
     89          1 Hongtong Liu <hongtong.liu@istuary.com>
     90          1 Henrik Korkuc <henrik@uber.com>
     91          1 He Chuang <hechuang@xsky.com>
     92          1 Harald Klein <hari@vt100.at>
     93          1 Gaurav Kumar Garg <garg.gaurav52@gmail.com>
     94          1 Fang Yuxiang <fang.yuxiang@eisoo.com>
     95          1 Fabian Grünbichler <f.gruenbichler@proxmox.com>
     96          1 Erwan Velu <erwan@redhat.com>
     97          1 Chu Hua-Rong <hrchu@cht.com.tw>
     98          1 Anjaneya Chagam <anjaneya.chagam@intel.com>
     99          1 Andreas Gerstmayr <andreas.gerstmayr@catalysts.cc>
    100          1 Alexey Sheplyakov <asheplyakov@mirantis.com>

Commits, by organizations
      1        544 Red Hat <contact@redhat.com>
      2        115 Mirantis <contact@mirantis.com>
      3         46 SUSE <contact@suse.com>
      4         25 Unaffiliated <no@organization.net>
      5         24 China Mobile <contact@chinamobile.com>
      6         20 Tencent <contact@tencent.com>
      7         15 Deutsche Telekom <contact@telekom.de>
      8         12 Digiware <contact@digiware.nl>
      9          8 ZTE <contact@zte.com.cn>
     10          8 XSky <contact@xsky.com>
     11          8 Istuary Innovation Group <contact@istuary.com>
     12          8 Intel <contact@intel.com>
     13          7 UnitedStack <contact@unitedstack.com>
     14          4 Virtuozzo <contact@virtuozzo.com>
     15          4 Mellanox <contact@mellanox.com>
     16          3 Trendy Tech <contact@trendytech.com.cn>
     17          2 Wanda ffan <contact@wanda.cn>
     18          2 OVH <ceph@ovh.net>
     19          2 IBM <contact@IBM.com>
     20          2 CERN <contact@cern.ch>
     21          2 Budgetenergie <itbeheer@budgetenergie.nl>
     22          2 99Cloud Inc <contact@99cloud.net>
     23          1 XTao Co. Ltd. <contact@xtaotech.com>
     24          1 Wido 42on <contact@42on.com>
     25          1 Uber Technologies Inc. <contact@uber.com>
     26          1 Proxmox Server Solutions GmbH <contcat@proxmox.com>
     27          1 Linaro <contact@linaro.org>
     28          1 Indraprastha Institute of Information Technology, 
Delhi <contact@iiitd.ac.in>
     29          1 EISOO <contact@eisoo.com>
     30          1 Cloudwatt <libre.licensing@cloudwatt.com>
     31          1 Chunghwa Telecom <contact@cht.com.tw>
     32          1 Catalysts <office@catalysts.cc>

Reviews, by authors (one review spans multiple commits)
      1         75 Sage Weil <sweil@redhat.com>
      2         62 Kefu Chai <kchai@redhat.com>
      3         24 Casey Bodley <cbodley@redhat.com>
      4         20 Jason Dillaman <dillaman@redhat.com>
      5         19 Haomai Wang <haomai@xsky.com>
      6         17 John Spray <jspray@redhat.com>
      7         15 Loic Dachary <ldachary@redhat.com>
      8         15 Josh Durgin <jdurgin@redhat.com>
      9         13 Orit Wasserman <owasserm@redhat.com>
     10         12 Mykola Golub <mgolub@mirantis.com>
     11         10 Yehuda Sadeh <ysadehwe@redhat.com>
     12          9 Yan, Zheng <zyan@redhat.com>
     13          8 Patrick Donnelly <pdonnell@redhat.com>
     14          8 Brad Hubbard <bhubbard@redhat.com>
     15          6 Igor Fedotov <ifedotov@mirantis.com>
     16          5 Willem Jan Withagen <wjw@digiware.nl>
     17          5 Greg Farnum <gfarnum@redhat.com>
     18          5 Daniel Gryniewicz <dang@redhat.com>
     19          4 Pan Liu <pan.liu@istuary.com>
     20          3 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     21          3 Dan Mick <dmick@redhat.com>
     22          3 Adam C. Emerson <aemerson@redhat.com>
     23          3 Abhishek Lekshmanan <abhishek@suse.com>
     24          2 Xie Xingguo <xie.xingguo@zte.com.cn>
     25          2 Nathan Cutler <ncutler@suse.com>
     26          2 Ken Dreyer <kdreyer@redhat.com>
     27          2 David Zafman <dzafman@redhat.com>
     28          1 Varada Kari <varada.kari@sandisk.com>
     29          1 Sébastien Han <shan@redhat.com>
     30          1 Ricardo Dias <rdias@suse.com>
     31          1 Mike Christie <mchristi@redhat.com>
     32          1 Jos Collin <jcollin@redhat.com>
     33          1 John Wilkins <jwilkins@redhat.com>
     34          1 J. Eric Ivancich <ivancich@redhat.com>
     35          1 Jeff Layton <jlayton@redhat.com>
     36          1 Dongsheng Yang <dongsheng.yang@easystack.cn>
     37          1 Chang Liu <liuchang0812@gmail.com>

Reviews, by organizations (one review spans multiple commits)
      1        302 Red Hat <contact@redhat.com>
      2         21 Mirantis <contact@mirantis.com>
      3         19 XSky <contact@xsky.com>
      4          6 SUSE <contact@suse.com>
      5          5 Digiware <contact@digiware.nl>
      6          4 Istuary Innovation Group <contact@istuary.com>
      7          2 ZTE <contact@zte.com.cn>
      8          1 Tencent <contact@tencent.com>
      9          1 SanDisk <contact@sandisk.com>
     10          1 Easystack <contact@easystack.cn>

-- 
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, 
HRB 21284 (AG Nürnberg)

