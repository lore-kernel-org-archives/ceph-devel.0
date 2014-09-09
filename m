From: M Ranga Swami Reddy <swamireddy@gmail.com>
Subject: v0.85 contributors credits
Date: Tue, 9 Sep 2014 07:41:26 +0530
Message-ID: <CANA9Uk4uJjw370wima3Jum_E=RZ=PdoH_pmDtJxRpd2GtS5orQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:41065 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbaIICL2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Sep 2014 22:11:28 -0400
Received: by mail-lb0-f177.google.com with SMTP id l4so5241444lbv.22
        for <ceph-devel@vger.kernel.org>; Mon, 08 Sep 2014 19:11:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi Ceph,

Here is a sorted list of authors and organizations who contributed to
v0.85, by number of commits or reviews back to v0.84. The affiliation
of authors to organizations can be updated by submitting a patch to
https://github.com/ceph/ceph/blob/master/.organizationmap

All commits are reviewed, but the number of reviews is a fraction of
the number of commits. More often than not, the reviewer(s) is only
mentioned in the message of the merge although it means that all
associated commits have been reviewed. If you are curious about how it
is done, the details are at
https://wiki.ceph.com/Community/Ceph_contributors_list_maintenance_guid=
e
=2E

Commits by authors
     1      136 Sage Weil <sweil@redhat.com>
     2       35 Loic Dachary <loic@dachary.org>
     3       20 Yehuda Sadeh <ysadey@redhat.com>
     4       17 Samuel Just <sam.just@inktank.com>
     5        9 John Wilkins <john.wilkins@inktank.com>
     6        8 Greg Farnum <greg@inktank.com>
     7        8 Alfredo Deza <alfredo.deza@inktank.com>
     8        7 Shu, Xinxin <xinxin.shu@intel.com>
     9        7 Ma Jianpeng <jianpeng.ma@intel.com>
    10        6 Somnath Roy <somnath.roy@sandisk.com>
    11        5 Wido den Hollander <wido@42on.com>
    12        4 Dan Mick <dan.mick@inktank.com>
    13        3 Zhiqiang Wang <wonzhq@hotmail.com>
    14        3 Kevin Cox <kevincox@kevincox.ca>
    15        3 Josh Durgin <josh.durgin@inktank.com>
    16        3 Haomai Wang <haomaiwang@gmail.com>
    17        2 Pavan Rallabhandi <pavan.rallabhandi@sandisk.com>
    18        2 Luis Pab=C3=B3n <lpabon@redhat.com>
    19        2 John Spray <jspray@redhat.com>
    20        2 Andreas Peters <andreas.joachim.peters@cern.ch>
    21        1 Owen Synge <osynge@suse.com>
    22        1 Matt Benjamin <matt@linuxbox.com>
    23        1 Jenkins <jenkins@inktank.com>
    24        1 Ilya Dryomov <ilya.dryomov@inktank.com>
    25        1 Boris Ranto <branto@redhat.com>
    26        1 Anand Bhat <anand.bhat@sandisk.com>
    27        1 Abhishek Lekshmanan <abhishek.lekshmanan@ril.com>
Commits by organizations
     1      128 Red Hat <contact@redhat.com>
     2       84 Inktank <contact@inktank.com>
     3       35 Cloudwatt <libre.licensing@cloudwatt.com>
     4       14 Intel <contact@intel.com>
     5        9 SanDisk <contact@sandisk.com>
     6        6 Unaffiliated <no@organization.net>
     7        5 Wido 42on <contact@42on.com>
     8        3 UnitedStack <contact@unitedstack.com>
     9        2 CERN <contact@cern.ch>
    10        1 The Linux Box <contact@linuxbox.com>
    11        1 SUSE <contact@suse.com>
    12        1 Reliance Jio Infocomm Ltd. <contact@ril.com>
Reviews by authors (one review spans multiple commits)
     1       39 Sage Weil <sweil@redhat.com>
     2       13 Samuel Just <sam.just@inktank.com>
     3        3 Josh Durgin <josh.durgin@inktank.com>
     4        3 Jo=C3=A3o Eduardo Lu=C3=ADs <joao.luis@inktank.com>
     5        3 Alfredo Deza <adeza@redhat.com>
     6        2 Yehuda Sadeh <ysadey@redhat.com>
     7        2 Ma Jianpeng <jianpeng.ma@intel.com>
     8        2 Loic Dachary <loic@dachary.org>
     9        2 John Spray <jspray@redhat.com>
    10        1 Yan, Zheng <zheng.z.yan@intel.com>
    11        1 Xiaoxi Chen <xiaoxi.chen@intel.com>
    12        1 Stephen Jahl <stephenjahl@gmail.com>
    13        1 Kevin Cox <kevincox@kevincox.ca>
    14        1 John Wilkins <john.wilkins@inktank.com>
    15        1 Jo=C3=A3o Eduardo Lu=C3=ADs <joao@redhat.com>
    16        1 Haomai Wang <haomaiwang@gmail.com>
    17        1 Greg Farnum <greg@inktank.com>
    18        1 Brian Rak <dn@devicenull.org>
    19        1 Andreas Peters <andreas.joachim.peters@cern.ch>
Reviews by organizations (one review spans multiple commits)
     1       46 Red Hat <contact@redhat.com>
     2       22 Inktank <contact@inktank.com>
     3        4 Intel <contact@intel.com>
     4        2 Cloudwatt <libre.licensing@cloudwatt.com>
     5        1 UnitedStack <contact@unitedstack.com>
     6        1 Unaffiliated <no@organization.net>
     7        1 MIT Computer Science and Artificial Intelligence
Laboratory <webmaster@csail.mit.edu>
     8        1 GameServers.com <contact@gameservers.com>
     9        1 CERN <contact@cern.ch>


Cheers
Swami
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
