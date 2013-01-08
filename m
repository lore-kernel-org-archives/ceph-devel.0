From: Bryan Stillwell <bstillwell@photobucket.com>
Subject: Adjusting replicas on argonaut
Date: Tue, 8 Jan 2013 15:11:17 -0700
Message-ID: <CADAfL_gk43_CQsEWY7Nn0uibLneGox5cdUj0g_1+LWOUNWth+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:47080 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab3AHWLS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jan 2013 17:11:18 -0500
Received: by mail-ob0-f175.google.com with SMTP id vb8so1378237obc.20
        for <ceph-devel@vger.kernel.org>; Tue, 08 Jan 2013 14:11:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I tried increasing the number of metadata replicas from 2 to 3 on my
test cluster with the following command:

ceph osd pool set metadata size 3


Afterwards it appears that all the metadata placement groups switch to
a degraded state and doesn't seem to be attempting to recover:

2013-01-08 14:49:37.352735 mon.0 [INF] pgmap v156393: 1920 pgs: 1280
active+clean, 640 active+degraded; 903 GB data, 1820 GB used, 2829 GB
/ 4650 GB avail; 1255/486359 degraded (0.258%)


Does anything need to be done after increasing the number of replicas?

Here's what the OSD tree looks like:

root@a1:~# ceph osd tree
dumped osdmap tree epoch 1303
# id    weight  type name       up/down reweight
-1      4.99557 pool default
-3      4.99557         rack unknownrack
-2      2.49779                 host b1
0       0.499557                                osd.0   up      1
1       0.499557                                osd.1   up      1
2       0.499557                                osd.2   up      1
3       0.499557                                osd.3   up      1
4       0.499557                                osd.4   up      1
-4      2.49779                 host b2
5       0.499557                                osd.5   up      1
6       0.499557                                osd.6   up      1
7       0.499557                                osd.7   up      1
8       0.499557                                osd.8   up      1
9       0.499557                                osd.9   up      1


Thanks,
Bryan
