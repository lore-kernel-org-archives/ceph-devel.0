From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: v9.0.1 contributors credits
Date: Fri, 12 Jun 2015 12:51:42 +0530
Message-ID: <CANA9Uk6skXL2Bh7NQ7-yRdgH2ZUMiw5bkq-iaOuX+dCbEpFk-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34427 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbbFLHVn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Jun 2015 03:21:43 -0400
Received: by payr10 with SMTP id r10so17826188pay.1
        for <ceph-devel@vger.kernel.org>; Fri, 12 Jun 2015 00:21:43 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v9.0.1, by number of commits or reviews back to v9.0.0. The
affiliation of authors to organizations can be updated by submitting a
patch to https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, the details are at
https://wiki.ceph.com/Community/Ceph_contributors_list_maintenance_guid=
e

The number of lines added and removed can be surprisingly high when a
developer refactors part of the code, transforms a directory into a
submodule etc.

Number of lines added and removed, by authors
     1    8504 Jason Dillaman <dillaman@redhat.com>
     2    3853 Sage Weil <sweil@redhat.com>
     3    1288 Mykola Golub <mgolub@mirantis.com>
     4    1271 Kefu Chai <kchai@redhat.com>
     5    1115 Haomai Wang <haomaiwang@gmail.com>
     6     775 Yan, Zheng <zyan@redhat.com>
     7     711 Ilya Dryomov <idryomov@redhat.com>
     8     531 Ma Jianpeng <jianpeng.ma@intel.com>
     9     373 Yehuda Sadeh <ysadehwe@redhat.com>
    10     322 John Spray <jspray@redhat.com>
    11     293 Guang Yang <yguang@yahoo-inc.com>
    12     278 Radoslaw Zarzynski <rzarzynski@mirantis.com>
    13     218 Boris Ranto <branto@redhat.com>
    14     214 Loic Dachary <ldachary@redhat.com>
    15     188 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
    16     182 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    17     168 Kiseleva Alyona <akiselyova@mirantis.com>
    18     136 Zhiqiang Wang <zhiqiang.wang@intel.com>
    19      88 Thorsten Behrens <tbehrens@suse.com>
    20      68 Xinze Chi <xmdxcxz@gmail.com>
    21      57 Tim Serong <tserong@suse.com>
    22      56 Orit Wasserman <owasserm@redhat.com>
    23      54 Ning Yao <yaoning@ruijie.com.cn>
    24      38 Henry Chang <henry@bigtera.com>
    25      37 Robin H. Johnson <robbat2@gentoo.org>
    26      30 Shu, Xinxin <xinxin.shu@intel.com>
    27      30 Nathan Cutler <ncutler@suse.cz>
    28      27 Xiaoxi Chen <xiaoxi.chen@intel.com>
    29      23 Samuel Just <sjust@redhat.com>
    30      17 Nilamdyuti Goswami <ngoswami@redhat.com>
    31      16 Sergey Arkhipov <nineseconds@yandex.ru>
    32      15 Ken Dreyer <kdreyer@redhat.com>
    33      15 Greg Farnum <gfarnum@redhat.com>
    34      14 Owen Synge <osynge@suse.com>
    35      13 Yuri Weinstein <yuri.weinstein@inktank.com>
    36       8 Jenkins <jenkins@inktank.com>
    37       6 William A. Kennington III <william@wkennington.com>
    38       6 Rajesh Nambiar <rajesh.n@msystechnologies.com>
    39       6 BJ Lougee <almightybeeij@gmail.com>
    40       4 Wido den Hollander <wido@42on.com>
    41       4 Josh Durgin <jdurgin@redhat.com>
    42       3 Yuan Zhou <yuan.zhou@intel.com>
    43       2 Huang Jun <hjwsm1989@gmail.com>
    44       2 Herv=C3=A9 Rousseau <hroussea@cern.ch>
    45       2 Gerhard Muntingh <gerhard@warpnet.nl>
Number of lines added and removed, by organization
     1   16371 Red Hat <contact@redhat.com>
     2    1922 Mirantis <contact@mirantis.com>
     3    1251 Unaffiliated <no@organization.net>
     4     727 Intel <contact@intel.com>
     5     293 Yahoo! <contact@yahoo-inc.com>
     6     189 SUSE <contact@suse.com>
     7     182 Deutsche Telekom <contact@telekom.de>
     8      54 Ruijie Networks <contact@ruijie.com.cn>
     9      37 Gentoo <contact@gentoo.org>
    10      13 Yuri Weinstein <yuri.weinstein@inktank.com>
    11       8 Inktank <contact@inktank.com>
    12       6 MSys Technologies <contact@msystechnologies.com>
    13       4 Wido 42on <contact@42on.com>
    14       2 Warpnet B.V. <contact@warpnet.nl>
    15       2 CERN <contact@cern.ch>
Commits, by authors
     1       83 Jason Dillaman <dillaman@redhat.com>
     2       31 Sage Weil <sweil@redhat.com>
     3       30 Ma Jianpeng <jianpeng.ma@intel.com>
     4       30 Haomai Wang <haomaiwang@gmail.com>
     5       20 Yan, Zheng <zyan@redhat.com>
     6       19 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     7       16 Radoslaw Zarzynski <rzarzynski@mirantis.com>
     8       15 Yehuda Sadeh <ysadehwe@redhat.com>
     9       12 Zhiqiang Wang <zhiqiang.wang@intel.com>
    10       12 Mykola Golub <mgolub@mirantis.com>
    11       11 Loic Dachary <ldachary@redhat.com>
    12        9 Kefu Chai <kchai@redhat.com>
    13        7 Ilya Dryomov <idryomov@redhat.com>
    14        6 Nathan Cutler <ncutler@suse.cz>
    15        6 Kiseleva Alyona <akiselyova@mirantis.com>
    16        6 John Spray <jspray@redhat.com>
    17        6 Guang Yang <yguang@yahoo-inc.com>
    18        5 Ken Dreyer <kdreyer@redhat.com>
    19        4 Xinze Chi <xmdxcxz@gmail.com>
    20        4 Tim Serong <tserong@suse.com>
    21        4 Robin H. Johnson <robbat2@gentoo.org>
    22        4 Henry Chang <henry@bigtera.com>
    23        4 Dmitry Yatsushkevich <dyatsushkevich@mirantis.com>
    24        4 Boris Ranto <branto@redhat.com>
    25        3 Owen Synge <osynge@suse.com>
    26        3 Orit Wasserman <owasserm@redhat.com>
    27        2 Yuan Zhou <yuan.zhou@intel.com>
    28        2 Xiaoxi Chen <xiaoxi.chen@intel.com>
    29        2 Wido den Hollander <wido@42on.com>
    30        2 Thorsten Behrens <tbehrens@suse.com>
    31        2 Shu, Xinxin <xinxin.shu@intel.com>
    32        2 Josh Durgin <jdurgin@redhat.com>
    33        1 Yuri Weinstein <yuri.weinstein@inktank.com>
    34        1 William A. Kennington III <william@wkennington.com>
    35        1 Sergey Arkhipov <nineseconds@yandex.ru>
    36        1 Samuel Just <sjust@redhat.com>
    37        1 Rajesh Nambiar <rajesh.n@msystechnologies.com>
    38        1 Ning Yao <yaoning@ruijie.com.cn>
    39        1 Nilamdyuti Goswami <ngoswami@redhat.com>
    40        1 Jenkins <jenkins@inktank.com>
    41        1 Huang Jun <hjwsm1989@gmail.com>
    42        1 Herv=C3=A9 Rousseau <hroussea@cern.ch>
    43        1 Greg Farnum <gfarnum@redhat.com>
    44        1 Gerhard Muntingh <gerhard@warpnet.nl>
    45        1 BJ Lougee <almightybeeij@gmail.com>
Commits by organizations
     1      199 Red Hat <contact@redhat.com>
     2       48 Intel <contact@intel.com>
     3       42 Unaffiliated <no@organization.net>
     4       38 Mirantis <contact@mirantis.com>
     5       19 Deutsche Telekom <contact@telekom.de>
     6       15 SUSE <contact@suse.com>
     7        6 Yahoo! <contact@yahoo-inc.com>
     8        4 Gentoo <contact@gentoo.org>
     9        2 Wido 42on <contact@42on.com>
    10        1 Yuri Weinstein <yuri.weinstein@inktank.com>
    11        1 Warpnet B.V. <contact@warpnet.nl>
    12        1 Ruijie Networks <contact@ruijie.com.cn>
    13        1 MSys Technologies <contact@msystechnologies.com>
    14        1 Inktank <contact@inktank.com>
    15        1 CERN <contact@cern.ch>
Reviews by authors (one review spans multiple commits)
     1       35 Sage Weil <sweil@redhat.com>
     2       31 Josh Durgin <jdurgin@redhat.com>
     3       18 Loic Dachary <ldachary@redhat.com>
     4       17 Kefu Chai <kchai@redhat.com>
     5       16 Greg Farnum <gfarnum@redhat.com>
     6       15 Yehuda Sadeh <ysadehwe@redhat.com>
     7        9 Samuel Just <sjust@redhat.com>
     8        4 Ken Dreyer <kdreyer@redhat.com>
     9        2 John Spray <jspray@redhat.com>
    10        2 Joao Eduardo Luis <joao@suse.de>
    11        2 Jason Dillaman <dillaman@redhat.com>
    12        1 Yann Dupont <yann@objoo.org>
    13        1 Ilya Dryomov <idryomov@redhat.com>
    14        1 Guang Yang <yguang@yahoo-inc.com>
    15        1 David Zafman <dzafman@redhat.com>
    16        1 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    17        1 Alfredo Deza <adeza@redhat.com>
    18        1 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
Reviews by organizations (one review spans multiple commits)
     1      152 Red Hat <contact@redhat.com>
     2        2 SUSE <contact@suse.com>
     3        1 Yahoo! <contact@yahoo-inc.com>
     4        1 Unaffiliated <no@organization.net>
     5        1 Reliance Jio Infocomm Ltd. <contact@ril.com>
     6        1 Deutsche Telekom <contact@telekom.de>
---

Cheers
Swami
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
