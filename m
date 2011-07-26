From: Christian Brunner <chb@muc.de>
Subject: peering PGs
Date: Tue, 26 Jul 2011 08:49:12 +0200
Message-ID: <CAO47_-87BvxVrgAXEqX6y59Mv_fmNZ9b=BK056OUiCSrt9Dwng@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54657 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174Ab1GZGtN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jul 2011 02:49:13 -0400
Received: by vxh35 with SMTP id 35so107286vxh.19
        for <ceph-devel@vger.kernel.org>; Mon, 25 Jul 2011 23:49:12 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Another kernel crash another invalid ceph state...

A memory allocation failure in the kernel (ixgbe) of one OSD-Server
lead to a domino effect in our ceph cluster with "0 up, 0 in".

When I restarted the cluster everything came up again. But I still
have 6 peering PGs:

pg v5898472: 3712 pgs: 3706 active+clean, 6 peering; 745 GB data, 775
GB used, 57642 GB / 59615 GB avail

# ceph pg dump -o - | grep peering
0.190   22      0       0       0       90112   92274688        200
 200     peering 6500'1256       7167'1063       [15,1]  [15,1]
6500'1256       2011-07-22 11:22:55.798745
3.18d   385     0       0       0       1529498 1566204928      300
 300     peering 7013'134376     7167'20162      [15,1]  [15,1]
6933'132427     2011-07-22 11:22:56.488471
0.4c    9       0       0       0       36864   37748736        200
 200     peering 6500'673        7163'1095       [12,1]  [12,1]
6500'673        2011-07-22 11:22:20.226119
3.49    171     0       0       0       671467  687580272       295
 295     peering 7013'10276      7163'2879       [12,1]  [12,1]
6933'9455       2011-07-22 11:22:20.701854
0.35e   6       0       0       0       24576   25165824        200
 200     peering 6500'628        7163'1142       [12,1]  [12,1]
6500'628        2011-07-22 11:22:19.267804
3.35b   198     0       0       0       791800  810803200       297
 297     peering 7013'66727      7163'5759       [12,1]  [12,1]
6933'65715      2011-07-22 11:22:20.035265


"ceph pg map" is consistent with "ceph pg dump":

# ceph pg map 0.190
2011-07-26 08:46:19.330981 mon <- [pg,map,0.190]
2011-07-26 08:46:19.331981 mon1 -> 'osdmap e7273 pg 0.190 (0.190) ->
up [15,1] acting [15,1]' (0)


But directorys of the PGs are present on multiple nodes (for example
on osd005 for 0.190):

/ceph/osd.001/current/0.190_head
/ceph/osd.001/snap_1650435/0.190_head
/ceph/osd.001/snap_1650445/0.190_head
/ceph/osd.005/current/0.190_head
/ceph/osd.005/snap_1572317/0.190_head
/ceph/osd.005/snap_1572323/0.190_head
/ceph/osd.015/current/0.190_head
/ceph/osd.015/snap_1467152/0.190_head

Any hint on how to proceed yould be great.

Thanks,
Christian
