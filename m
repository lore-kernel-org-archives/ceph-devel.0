From: Yann Dupont <yann@objoo.org>
Subject: v0.90 contributors credits
Date: Sat, 20 Dec 2014 00:34:09 +0100
Message-ID: <5494B5F1.4060002@objoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:55576 "EHLO
	6.mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaLSXlR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Dec 2014 18:41:17 -0500
Received: from mail420.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 0EF3AFFB888
	for <ceph-devel@vger.kernel.org>; Sat, 20 Dec 2014 00:34:29 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v0.90, by number of commits or reviews back to v0.89. The affiliation
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
      1       42 Sage Weil <sweil@redhat.com>
      2       35 Loic Dachary <ldachary@redhat.com>
      3       21 Haomai Wang <haomaiwang@gmail.com>
      4       20 Greg Farnum <gfarnum@redhat.com>
      5       16 Danny Al-Gaaf <danny.al-gaaf@bisect.de>
      6       11 David Zafman <dzafman@redhat.com>
      7        9 Ma Jianpeng <jianpeng.ma@intel.com>
      8        9 Ken Dreyer <kdreyer@redhat.com>
      9        8 Nilamdyuti Goswami <ngoswami@redhat.com>
     10        6 John Wilkins <jwilkins@redhat.com>
     11        5 Swami Reddy <swami.reddy@ril.com>
     12        5 Jason Dillaman <dillaman@redhat.com>
     13        4 Yan, Zheng <zyan@redhat.com>
     14        4 Sebastien Han <sebastien.han@enovance.com>
     15        3 Michal Jarzabek <stiopa@gmail.com>
     16        3 Kefu Chai <tchaikov@gmail.com>
     17        3 John Spray <jspray@redhat.com>
     18        3 Adam Spiers <aspiers@suse.com>
     19        3 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
     20        2 VRan Liu <gliuwr@gmail.com>
     21        2 Karl Eichwalder <ke@suse.de>
     22        2 Dongmao Zhang <deanraccoon@gmail.com>
     23        2 Dan Mick <dmick@redhat.com>
     24        1 Zhiqiang Wang <zhiqiang.wang@intel.com>
     25        1 Yuan Zhou <yuan.zhou@intel.com>
     26        1 Xinze Chi <xmdxcxz@gmail.com>
     27        1 Xiaoxi Chen <xiaoxi.chen@intel.com>
     28        1 Sebastien Ponce <sebastien.ponce@cern.ch>
     29        1 Sandon Van Ness <svanness@redhat.com>
     30        1 Rongze Zhu <zrzhit@gmail.com>
     31        1 Owen Synge <osynge@suse.com>
     32        1 Jenkins <jenkins@inktank.com>
     33        1 Federico Simoncelli <fsimonce@redhat.com>
     34        1 Chendi Xue <chendi.xue@intel.com>
     35        1 Blaine Gardner <blaine.gardner@hp.com>
     36        1 Adam Crume <adamcrume@gmail.com>
Commits by organizations
      1      141 Red Hat <contact@redhat.com>
      2       22 UnitedStack <contact@unitedstack.com>
      3       16 Deutsche Telekom <contact@telekom.de>
      4       13 Intel <contact@intel.com>
      5       11 Unaffiliated <no@organization.net>
      6        8 Reliance Jio Infocomm Ltd. <contact@ril.com>
      7        7 Inktank <contact@inktank.com>
      8        6 SUSE <contact@suse.com>
      9        4 eNovance <contact@enovance.com>
     10        1 University of California, Santa Cruz <contact@cs.ucsc.=
edu>
     11        1 HP <contact@hp.com>
     12        1 CERN <contact@cern.ch>
Reviews by authors (one review spans multiple commits)
      1       34 Loic Dachary <ldachary@redhat.com>
      2       25 Sage Weil <sweil@redhat.com>
      3        7 Samuel Just <sjust@redhat.com>
      4        6 Josh Durgin <jdurgin@redhat.com>
      5        5 John Wilkins <jwilkins@redhat.com>
      6        3 Sahid Orentino Ferdjaoui <sahid.ferdjaoui@redhat.com>
      7        3 Greg Farnum <gfarnum@redhat.com>
      8        2 Yehuda Sadeh <ysadehwe@redhat.com>
      9        2 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
     10        2 John Spray <jspray@redhat.com>
     11        2 David Zafman <dzafman@redhat.com>
     12        1 Yan, Zheng <zyan@redhat.com>
     13        1 Thorsten Behrens <tbehrens@suse.com>
     14        1 Pavan Rallabhandi <Pavan.Rallabhandi@sandisk.com>
     15        1 Ken Dreyer <kdreyer@redhat.com>
     16        1 Jason Dillaman <dillaman@redhat.com>
     17        1 Haomai Wang <haomaiwang@gmail.com>
     18        1 Adam Crume <adamcrume@gmail.com>
Reviews by organizations (one review spans multiple commits)
      1       92 Red Hat <contact@redhat.com>
      2        1 University of California, Santa Cruz <contact@cs.ucsc.=
edu>
      3        1 UnitedStack <contact@unitedstack.com>
      4        1 SanDisk <contact@sandisk.com>
      5        1 SUSE <contact@suse.com>
      6        1 Inktank <contact@inktank.com>
      7        1 Cloudwatt <libre.licensing@cloudwatt.com>


Cheers,
Yann

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
