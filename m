From: handong He <hedongho@gmail.com>
Subject: osd full still writing data while cluster recovering
Date: Wed, 28 Jun 2017 17:57:23 +0800
Message-ID: <CALCdKocMeqpY=3dx8BqE96-9Gvt7bYo4DJHEP4bbU9vmUsRSkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36455 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbdF1J5e (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 05:57:34 -0400
Received: by mail-qt0-f181.google.com with SMTP id i2so44985865qta.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jun 2017 02:57:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

I'm using ceph-jewel 10.2.7 for some test.
Discovered that when an osd is full(like full_ratio=3D0.95), client
write failed, which is normal. But a full osd cannot stop a recovering
cluster writing data, make osd used ratio from 95% to100%. When that
happen, osd will be down for no space left and cannot startup anymore.

So the question is : can the cluster auto stop recovering while osd is
reaching full without setting the norecover flag manually?  Or is it
already fix in the latest version?

Consider this situation: a half-full cluster with many osds. For some
bad luck(netlink down| server down | or others) in midnight, some osds
down|out and trigger cluster recovery, makes some  other health osds'
used% to 100% (experienceless in operation and maintenance, please fix
me if i'm wrong). Unluckly, this just like a plague and make much more
osds down. It maybe easy to fix one down osd like that, but a disaster
to fix 10+ osds with 100% space used.


here is my test environment and steps:

three nodes, each node has one monitor and one osd(10G hdd for
convenient), running in vm.
ceph conf is basic.
pool size set to 2.
using 'rados bench' writing data to osds.

1. exec command  to set osd full ratio:
# ceph pg set_full_ratio 0.8
# ceph pg set nearfull_ratio 0.7

2. writing data, when an osd is reaching full, stop writing and mark
out one osd with command:
# ceph osd out 0

3. waiting for cluster recovering finished , and exec command:
# ceph osd df
# ceph osd tree

we can find that other osds is down.

Thanks and Best Regards=EF=BC=81

He Handong
