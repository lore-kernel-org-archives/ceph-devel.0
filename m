From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: v0.89 contributors credits
Date: Fri, 5 Dec 2014 11:21:53 +0530
Message-ID: <CANA9Uk49jXQ7DxiEvObQ6kXCsdWjK2fB1K7=F+ieFbP97tA-3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:59007 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbaLEFvx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Dec 2014 00:51:53 -0500
Received: by mail-qg0-f53.google.com with SMTP id q108so3888qgd.40
        for <ceph-devel@vger.kernel.org>; Thu, 04 Dec 2014 21:51:53 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v0.89, by number of commits or reviews back to v0.88. The affiliation
of authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, the details are at
https://wiki.ceph.com/Community/Ceph_contributors_list_maintenance_guid=
e

Commits by authors
     1       78 Sage Weil <sweil@redhat.com>
     2       67 Loic Dachary <ldachary@redhat.com>
     3       54 Greg Farnum <gfarnum@redhat.com>
     4       33 David Zafman <dzafman@redhat.com>
     5       25 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
     6       22 Haomai Wang <haomaiwang@gmail.com>
     7       13 Ma Jianpeng <jianpeng.ma@intel.com>
     8       10 Ken Dreyer <kdreyer@redhat.com>
     9       10 John Wilkins <jwilkins@redhat.com>
    10        9 Yehuda Sadeh <ysadehwe@redhat.com>
    11        8 Yan, Zheng <zyan@redhat.com>
    12        8 Nilamdyuti Goswami <ngoswami@redhat.com>
    13        8 John Spray <jspray@redhat.com>
    14        8 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
    15        8 Jason Dillaman <dillaman@redhat.com>
    16        5 Swami Reddy <swami.reddy@ril.com>
    17        5 Sebastien Han <sebastien.han@enovance.com>
    18        5 Janne Grunau <j@jannau.net>
    19        4 Xinze Chi <xmdxcxz@gmail.com>
    20        4 Dan Mick <dmick@redhat.com>
    21        3 VRan Liu <gliuwr@gmail.com>
    22        3 Michal Jarzabek <stiopa@gmail.com>
    23        3 Kefu Chai <tchaikov@gmail.com>
    24        3 Dongmao Zhang <deanraccoon@gmail.com>
    25        3 Adam Spiers <aspiers@suse.com>
    26        3 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
    27        2 Zhiqiang Wang <wonzhq@hotmail.com>
    28        2 Yuan Zhou <yuan.zhou@intel.com>
    29        2 Rongze Zhu <zrzhit@gmail.com>
    30        2 Owen Synge <osynge@suse.com>
    31        2 Karl Eichwalder <ke@suse.de>
    32        2 Ding Dinghua <dingdinghua85@gmail.com>
    33        2 Chendi.Xue <chendi.xue@intel.com>
    34        1 Xiaoxi Chen <xiaoxi.chen@intel.com>
    35        1 Sebastien Ponce <sebastien.ponce@cern.ch>
    36        1 Sandon Van Ness <sandon@redhat.com>
    37        1 Ray Lv <xiangyulv@gmail.com>
    38        1 Patrick McGarry <pmcgarry@redhat.com>
    39        1 Lei Dong <leidong@yahoo-inc.com>
    40        1 Kevin Dalley <kevin@kelphead.org>
    41        1 Josh Durgin <jdurgin@redhat.com>
    42        1 Jenkins <jenkins@inktank.com>
    43        1 Federico Simoncelli <fsimonce@redhat.com>
    44        1 Federico Gimenez <fgimenez@coit.es>
    45        1 Dong Yuan <yuandong1222@gmail.com>
    46        1 Dan van der Ster <daniel.vanderster@cern.ch>
    47        1 Boris Ranto <branto@redhat.com>
    48        1 Blaine Gardner <blaine.gardner@hp.com>
    49        1 Adam Crume <adamcrume@gmail.com>
Commits by organizations
     1      272 Red Hat <contact@redhat.com>
     2       38 Inktank <contact@inktank.com>
     3       25 UnitedStack <contact@unitedstack.com>
     4       25 Deutsche Telekom <contact@telekom.de>
     5       24 Unaffiliated <no@organization.net>
     6       18 Intel <contact@intel.com>
     7        8 Reliance Jio Infocomm Ltd. <contact@ril.com>
     8        7 SUSE <contact@suse.com>
     9        5 eNovance <contact@enovance.com>
    10        2 Chendi.Xue <chendi.xue@intel.com>
    11        2 CERN <contact@cern.ch>
    12        1 Yahoo! <contact@yahoo-inc.com>
    13        1 University of California, Santa Cruz <contact@cs.ucsc.e=
du>
    14        1 Sandon Van Ness <sandon@redhat.com>
    15        1 Lei Dong <leidong@yahoo-inc.com>
    16        1 HGST <contact@hgst.com>
    17        1 Blaine Gardner <blaine.gardner@hp.com>
Reviews by authors (one review spans multiple commits)
     1       53 Sage Weil <sweil@redhat.com>
     2       39 Loic Dachary <ldachary@redhat.com>
     3       20 Samuel Just <sjust@redhat.com>
     4       19 Josh Durgin <jdurgin@redhat.com>
     5       10 Greg Farnum <gfarnum@redhat.com>
     6        6 Yehuda Sadeh <ysadehwe@redhat.com>
     7        6 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
     8        5 John Wilkins <jwilkins@redhat.com>
     9        4 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
    10        4 John Spray <jspray@redhat.com>
    11        4 Haomai Wang <haomaiwang@gmail.com>
    12        3 David Zafman <dzafman@redhat.com>
    13        2 Jason Dillaman <dillaman@redhat.com>
    14        1 Yan, Zheng <zyan@redhat.com>
    15        1 Thorsten Behrens <tbehrens@suse.com>
    16        1 Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
    17        1 Laurent Guerby <laurent@guerby.net>
    18        1 Ken Dreyer <kdreyer@redhat.com>
    19        1 Christophe Courtaut <christophe.courtaut@gmail.com>
    20        1 Adam Crume <adamcrume@gmail.com>
Reviews by organizations (one review spans multiple commits)
     1      160 Red Hat <contact@redhat.com>
     2       13 Inktank <contact@inktank.com>
     3        4 UnitedStack <contact@unitedstack.com>
     4        1 University of California, Santa Cruz <contact@cs.ucsc.e=
du>
     5        1 Unaffiliated <no@organization.net>
     6        1 SUSE <contact@suse.com>
     7        1 SanDisk <contact@sandisk.com>
     8        1 Cloudwatt <libre.licensing@cloudwatt.com>



Cheers
Swami
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
