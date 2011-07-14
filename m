From: Christian Brunner <chb@muc.de>
Subject: crashed+peering PGs
Date: Thu, 14 Jul 2011 13:53:34 +0200
Message-ID: <CAO47_--LHXGjiByanZi+-v27b4BPsd5dXTrPbhw9HNYLHymeOA@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46724 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab1GNLxf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 07:53:35 -0400
Received: by vws1 with SMTP id 1so107550vws.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Jul 2011 04:53:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After running into some btrfs problems I reformated all my disks. I
did this in sequence. After every host I waited for the recovery to
complete.

At one point an osd on another host crashed, but I was able to restart
ist quickly.

After that process, the cluster has 6 crashed+peering PGs:

pg v4992886: 3712 pgs: 3706 active+clean, 6 crashed+peering; 571 GB
data, 565 GB used, 58938 GB / 59615 GB avail

When I try to scrub or repair the PGs, nothing happens:

$ ceph pg dump -o - | grep crashed
pg_stat objects mip     degr    unf     kb      bytes   log
disklog state   v       reported        up      acting  last_scrub
1.1ac   0       0       0       0       0       0       0       0
 crashed+peering 0'0     5869'576        [3,13]  [3,13]  0'0
2011-07-13 17:04:30.221618
0.1ad   0       0       0       0       0       0       198     198
 crashed+peering 3067'1194       5869'515        [3,13]  [3,13]
3067'1194       2011-07-13 17:04:29.221726
2.1ab   0       0       0       0       0       0       0       0
 crashed+peering 0'0     5869'576        [3,13]  [3,13]  0'0
2011-07-13 17:04:31.222145
1.6c    0       0       0       0       0       0       0       0
 crashed+peering 0'0     5869'577        [3,13]  [3,13]  0'0
2011-07-13 17:05:35.237286
0.6d    0       0       0       0       0       0       198     198
 crashed+peering 3067'636        5869'516        [3,13]  [3,13]
3067'636        2011-07-13 17:05:34.237024
2.6b    0       0       0       0       0       0       0       0
 crashed+peering 0'0     5869'577        [3,13]  [3,13]  0'0
2011-07-13 17:05:37.238474

$ ceph pg scrub 1.1ac
2011-07-14 13:51:20.975887 mon <- [pg,scrub,1.1ac]
2011-07-14 13:51:20.976564 mon2 -> 'instructing pg 1.1ac on osd3 to scrub' (0)

But I don't see any message with "ceph -w".

Is there anything else I can try?

Thanks,
Christian
