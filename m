From: lin zhou <hnuzhoulin2@gmail.com>
Subject: Fwd: object unfound before finish backfill,up set diff from acting set
Date: Thu, 24 Mar 2016 20:00:46 +0800
Message-ID: <CAKO+7k3F5Dspkv4R-1ZdpEgF2T5XrO=RtzMRu0FFw+qzU8qnjQ@mail.gmail.com>
References: <CAKO+7k0y2qu2U3PRG2=DB67OQGuFCDMpKxBfRqrT6H0LgQpu3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34230 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbcCXMAs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 08:00:48 -0400
Received: by mail-oi0-f65.google.com with SMTP id f188so4451946oig.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 05:00:47 -0700 (PDT)
In-Reply-To: <CAKO+7k0y2qu2U3PRG2=DB67OQGuFCDMpKxBfRqrT6H0LgQpu3A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,how to deal with unfound object.

and command ceph pg 4.438 mark_unfound_lost revert/delete does not work.



---------- Forwarded message ----------
From: lin zhou <hnuzhoulin2@gmail.com>
Date: 2016-03-21 16:22 GMT+08:00
Subject: object unfound before finish backfill,up set diff from acting set
To: ceph-users@ceph.com


Hi,guys

my cluster face a network problem so it occur some error.after solve
network problem.

latency of some osds in one node is high,using ceph osd perf,which come to 3000+

so I delete this osd from cluster,keep osd data device.
after recover and backfill,then I face the problem describe in
title.ceph health detail is :

pg 4.438 is active+recovering+degraded+remapped, acting [7,11], 1 unfound
pg 4.438 is stuck unclean for 135368.626141, current state
active+recovering+degraded+remapped, last acting [7,11]
recovery 1062/4842087 objects degraded (0.022%); 1/2028378 unfound (0.000%)

root@node-67:~# ceph pg map 4.438
osdmap e42522 pg 4.438 (4.438) -> up [34,20,30] acting [7,11]

I can  see the pg data in deleted osd.6,which have some different with
the existing osd.7 and osd.11
can I copy the pg data to the new up set? ignore acting set?

some info is below,the output of pg query is the attachment.


root@node-67:~# ceph pg 4.438 list_missing
{ "offset": { "oid": "",
      "key": "",
      "snapid": 0,
      "hash": 0,
      "max": 0,
      "pool": -1,
      "namespace": ""},
  "num_missing": 1,
  "num_unfound": 1,
  "objects": [
        { "oid": { "oid": "rbd_data.188b9163c78e9.00000000000015f2",
              "key": "",
              "snapid": -2,
              "hash": 2427198520,
              "max": 0,
              "pool": 4,
              "namespace": ""},
          "need": "39188'2314230",
          "have": "39174'2314229",
          "locations": []}],

rootceph pg 4.438 mark_unfound_lost revert
Error EINVAL: pg has 1 unfound objects but we haven't probed all
sources, not marking lost

root@node-67:~# ceph pg 4.438 mark_unfound_lost delete
Error EINVAL: pg has 1 unfound objects but we haven't probed all
sources, not marking lost

pg query output is
:https://drive.google.com/file/d/0B08hG89CXoPbb2p0ZFc2OGRRQmpkcGVuZnoxNFJnQS05UDlv/view
-------------------------
hnuzhoulin2@gmail.com
