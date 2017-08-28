From: zengran zhang <z13121369189@gmail.com>
Subject: question on bluestore wal io behavior
Date: Mon, 28 Aug 2017 16:48:33 +0800
Message-ID: <CALi+v1-yrvT1Q_rTHN88s3aTHmVV8c51cxqKkNCxxbKM2bJDJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35033 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdH1Ise (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Aug 2017 04:48:34 -0400
Received: by mail-it0-f68.google.com with SMTP id b76so3761791itb.2
        for <ceph-devel@vger.kernel.org>; Mon, 28 Aug 2017 01:48:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

hi,

we are testing bluestore and rocksdb, we observed that the wal block's
io is some odd... the iostate show that the wal block's `avgrq-sz` is
arountd 10, the perf record of the `block_rq_issue` captured as
follow:

bstore_kv_sync 26357 [005] 177034.327414: block:block_rq_issue: 8,96
WS 0 () 53904888 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [006] 177034.348115: block:block_rq_issue: 8,96
WS 0 () 77472296 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [006] 177034.359633: block:block_rq_issue: 8,96
WS 0 () 53904888 + 16 [bstore_kv_sync]
bstore_kv_sync 26357 [003] 177034.364816: block:block_rq_issue: 8,96
WS 0 () 77472304 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [009] 177034.550656: block:block_rq_issue: 8,96
WS 0 () 53904896 + 80 [bstore_kv_sync]
bstore_kv_sync 26357 [009] 177034.556734: block:block_rq_issue: 8,96
WS 0 () 77472320 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [008] 177034.592900: block:block_rq_issue: 8,96
WS 0 () 53904968 + 16 [bstore_kv_sync]
bstore_kv_sync 26357 [000] 177034.598323: block:block_rq_issue: 8,96
WS 0 () 77472328 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [011] 177034.635053: block:block_rq_issue: 8,96
WS 0 () 53904976 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [012] 177034.640036: block:block_rq_issue: 8,96
WS 0 () 77472336 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [014] 177034.670053: block:block_rq_issue: 8,96
WS 0 () 53904976 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [015] 177034.681708: block:block_rq_issue: 8,96
WS 0 () 77472344 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [015] 177034.692890: block:block_rq_issue: 8,96
WS 0 () 53904976 + 16 [bstore_kv_sync]
bstore_kv_sync 26357 [015] 177034.698320: block:block_rq_issue: 8,96
WS 0 () 77472352 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [016] 177034.710399: block:block_rq_issue: 8,96
WS 0 () 53904984 + 32 [bstore_kv_sync]
bstore_kv_sync 26357 [016] 177034.740153: block:block_rq_issue: 8,96
WS 0 () 77472360 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [013] 177034.760271: block:block_rq_issue: 8,96
WS 0 () 53905008 + 16 [bstore_kv_sync]
bstore_kv_sync 26357 [015] 177034.931293: block:block_rq_issue: 8,96
WS 0 () 53905016 + 56 [bstore_kv_sync]
bstore_kv_sync 26357 [017] 177034.973679: block:block_rq_issue: 8,96
WS 0 () 77472376 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [018] 177035.001517: block:block_rq_issue: 8,96
WS 0 () 53905064 + 16 [bstore_kv_sync]
bstore_kv_sync 26357 [010] 177035.006956: block:block_rq_issue: 8,96
WS 0 () 77472384 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [019] 177035.018570: block:block_rq_issue: 8,96
WS 0 () 53905072 + 24 [bstore_kv_sync]
bstore_kv_sync 26357 [010] 177035.032255: block:block_rq_issue: 8,96
WS 0 () 77472392 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [012] 177035.157029: block:block_rq_issue: 8,96
WS 0 () 77472400 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [013] 177035.172142: block:block_rq_issue: 8,96
WS 0 () 53905096 + 48 [bstore_kv_sync]
bstore_kv_sync 26357 [014] 177035.182179: block:block_rq_issue: 8,96
WS 0 () 77472408 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [015] 177035.209644: block:block_rq_issue: 8,96
WS 0 () 53905136 + 16 [bstore_kv_sync]
bstore_kv_sync 26357 [016] 177035.215506: block:block_rq_issue: 8,96
WS 0 () 77472416 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [017] 177035.226028: block:block_rq_issue: 8,96
WS 0 () 53905144 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [018] 177035.232176: block:block_rq_issue: 8,96
WS 0 () 77472424 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [000] 177035.246060: block:block_rq_issue: 8,96
WS 0 () 53905144 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [000] 177035.257132: block:block_rq_issue: 8,96
WS 0 () 77472432 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [000] 177035.268880: block:block_rq_issue: 8,96
WS 0 () 53905144 + 24 [bstore_kv_sync]
bstore_kv_sync 26357 [000] 177035.344242: block:block_rq_issue: 8,96
WS 0 () 53905160 + 16 [bstore_kv_sync]
bstore_kv_sync 26357 [000] 177035.382172: block:block_rq_issue: 8,96
WS 0 () 77472448 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [000] 177035.393062: block:block_rq_issue: 8,96
WS 0 () 53905168 + 16 [bstore_kv_sync]
bstore_kv_sync 26357 [000] 177035.398896: block:block_rq_issue: 8,96
WS 0 () 77472456 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [017] 177035.420992: block:block_rq_issue: 8,96
WS 0 () 53905176 + 8 [bstore_kv_sync]
bstore_kv_sync 26357 [018] 177035.432239: block:block_rq_issue: 8,96
WS 0 () 77472464 + 8 [bstore_kv_sync]

the io request on LBA 77xxx is always 8 sectors, and the the io
request on LBA 53xxx had some overlay areas...
my understand of the two sequent address (77xxx and 53xxx) is bluefs's
log and rocksdb'wal, why they alternate one by one so strictly...

we think this behavior may hurt the performance, hope anyone who could
give an analysis, thanks so much!
