From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: v0.92 contributors credits
Date: Wed, 4 Feb 2015 13:27:03 +0530
Message-ID: <CANA9Uk5v49L0H8vVew8wn2XbdLWdpeOTSk-Rz=UC6EtSOPP0rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:49490 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbbBDH5E convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Feb 2015 02:57:04 -0500
Received: by mail-qc0-f170.google.com with SMTP id p6so104744qcv.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 23:57:03 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v0.92, by number of commits or reviews back to v0.91. The affiliation
of authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, the details are at
https://wiki.ceph.com/Community/Ceph_contributors_list_maintenance_guid=
e
=2E

Number of lines added and removed, by authors
     1    3854 Yehuda Sadeh <ysadehwe@redhat.com>
     2    3149 Jason Dillaman <dillaman@redhat.com>
     3    2984 Dong Yuan <yuandong1222@gmail.com>
     4    2264 Sage Weil <sweil@redhat.com>
     5    1746 Guang Yang <yguang@yahoo-inc.com>
     6    1408 Andreas Peters <andreas.joachim.peters@cern.ch>
     7     737 Loic Dachary <ldachary@redhat.com>
     8     721 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
     9     650 John Spray <jspray@redhat.com>
    10     636 Xiaoxi Chen <xiaoxi.chen@intel.com>
    11     431 Zhiqiang Wang <zhiqiang.wang@intel.com>
    12     211 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
    13     167 Wido den Hollander <wido@42on.com>
    14     117 Haomai Wang <haomaiwang@gmail.com>
    15     104 Mykola Golub <mgolub@mirantis.com>
    16      74 Yan, Zheng <zyan@redhat.com>
    17      71 Ma Jianpeng <jianpeng.ma@intel.com>
    18      68 Josh Durgin <jdurgin@redhat.com>
    19      53 Kefu Chai <tchaikov@gmail.com>
    20      51 John Wilkins <jwilkins@redhat.com>
    21      32 Ken Dreyer <kdreyer@redhat.com>
    22      31 Nilamdyuti Goswami <ngoswami@redhat.com>
    23      30 Ning Yao <zay11022@gmail.com>
    24      16 Samuel Just <sjust@redhat.com>
    25      11 Matt Richards <mattjrichards@gmail.com>
    26      10 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
    27      10 Yann Dupont <yann@objoo.org>
    28       8 Jenkins <jenkins@inktank.com>
    29       4 Warren Usui <wusui@redhat.com>
    30       3 Mykola Golub <mgolub@zhuzha.mirantis.lviv.net>
    31       3 Lei Dong <leidong@yahoo-inc.com>
    32       3 Dan Mick <dmick@redhat.com>
    33       2 Jerry7X <875016668@qq.com>
    34       2 Dan van der Ster <daniel.vanderster@cern.ch>
Number of lines added and removed, by organization
     1   11607 Red Hat <contact@redhat.com>
     2    3101 UnitedStack <contact@unitedstack.com>
     3    1749 Yahoo! <contact@yahoo-inc.com>
     4    1410 CERN <contact@cern.ch>
     5    1138 Intel <contact@intel.com>
     6     211 Deutsche Telekom <contact@telekom.de>
     7     167 Wido 42on <contact@42on.com>
     8     109 Unaffiliated <no@organization.net>
     9     104 Mykola Golub <mgolub@mirantis.com>
    10      55 Inktank <contact@inktank.com>
    11      10 Ubuntu Kylin <contact@ubuntukylin.com>
Commits, by authors
     1       64 Sage Weil <sweil@redhat.com>
     2       41 Yehuda Sadeh <ysadehwe@redhat.com>
     3       31 Loic Dachary <ldachary@redhat.com>
     4       27 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     5       16 Jason Dillaman <dillaman@redhat.com>
     6       10 John Spray <jspray@redhat.com>
     7        9 Ma Jianpeng <jianpeng.ma@intel.com>
     8        9 Haomai Wang <haomaiwang@gmail.com>
     9        9 Guang Yang <yguang@yahoo-inc.com>
    10        9 Dong Yuan <yuandong1222@gmail.com>
    11        8 Zhiqiang Wang <zhiqiang.wang@intel.com>
    12        8 Yann Dupont <yann@objoo.org>
    13        8 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
    14        6 Kefu Chai <tchaikov@gmail.com>
    15        5 Yan, Zheng <zyan@redhat.com>
    16        5 Mykola Golub <mgolub@mirantis.com>
    17        3 Xiaoxi Chen <xiaoxi.chen@intel.com>
    18        3 Wido den Hollander <wido@42on.com>
    19        3 Ning Yao <zay11022@gmail.com>
    20        3 Nilamdyuti Goswami <ngoswami@redhat.com>
    21        3 Ken Dreyer <kdreyer@redhat.com>
    22        3 John Wilkins <jwilkins@redhat.com>
    23        2 Samuel Just <sjust@redhat.com>
    24        2 Matt Richards <mattjrichards@gmail.com>
    25        2 Josh Durgin <jdurgin@redhat.com>
    26        2 Andreas Peters <andreas.joachim.peters@cern.ch>
    27        1 Yunchuan Wen <yunchuanwen@ubuntukylin.com>
    28        1 Warren Usui <wusui@redhat.com>
    29        1 Mykola Golub <mgolub@zhuzha.mirantis.lviv.net>
    30        1 Lei Dong <leidong@yahoo-inc.com>
    31        1 Jerry7X <875016668@qq.com>
    32        1 Jenkins <jenkins@inktank.com>
    33        1 Dan van der Ster <daniel.vanderster@cern.ch>
    34        1 Dan Mick <dmick@redhat.com>
Commits by organizations
     1      188 Red Hat <contact@redhat.com>
     2       27 Deutsche Telekom <contact@telekom.de>
     3       21 Unaffiliated <no@organization.net>
     4       20 Intel <contact@intel.com>
     5       18 UnitedStack <contact@unitedstack.com>
     6       10 Yahoo! <contact@yahoo-inc.com>
     7        5 Mykola Golub <mgolub@mirantis.com>
     8        3 Wido 42on <contact@42on.com>
     9        3 Inktank <contact@inktank.com>
    10        3 CERN <contact@cern.ch>
    11        1 Ubuntu Kylin <contact@ubuntukylin.com>
Reviews by authors (one review spans multiple commits)
     1       34 Sage Weil <sweil@redhat.com>
     2       17 Josh Durgin <jdurgin@redhat.com>
     3       15 Loic Dachary <ldachary@redhat.com>
     4       14 Samuel Just <sjust@redhat.com>
     5       10 Greg Farnum <gfarnum@redhat.com>
     6        3 Haomai Wang <haomaiwang@gmail.com>
     7        2 John Spray <jspray@redhat.com>
     8        2 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
     9        2 Jason Dillaman <dillaman@redhat.com>
    10        1 Yehuda Sadeh <ysadehwe@redhat.com>
    11        1 Yan, Zheng <zyan@redhat.com>
    12        1 Ray Lv <xiangyulv@gmail.com>
    13        1 Ma Jianpeng <jianpeng.ma@intel.com>
    14        1 Ken Dreyer <kdreyer@redhat.com>
    15        1 John Wilkins <jwilkins@redhat.com>
Reviews by organizations (one review spans multiple commits)
     1      100 Red Hat <contact@redhat.com>
     2        3 UnitedStack <contact@unitedstack.com>
     3        1 Yahoo! <contact@yahoo-inc.com>
     4        1 Intel <contact@intel.com>

---

Cheers,
Swami
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
