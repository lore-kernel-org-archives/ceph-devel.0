From: Mark Nelson <mark.a.nelson@gmail.com>
Subject: New(ish) LMDBstore KeyValuedB backend and testing
Date: Tue, 11 Jul 2017 09:23:00 -0500
Message-ID: <e81ae2ee-8e6e-3276-d373-fe26f58f23e9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:33989 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932651AbdGKOXI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Jul 2017 10:23:08 -0400
Received: by mail-it0-f53.google.com with SMTP id v202so16588527itb.1
        for <ceph-devel@vger.kernel.org>; Tue, 11 Jul 2017 07:23:08 -0700 (PDT)
Received: from ?IPv6:2603:3016:1200:fb00::7c96? ([2603:3016:1200:fb00::7c96])
        by smtp.gmail.com with ESMTPSA id e12sm45961ioj.8.2017.07.11.07.23.01
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jul 2017 07:23:01 -0700 (PDT)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi guys,

A month or so ago I started rewriting Xinxin Shu's old LMDB kvdb PR to 
work with master.  I've now got it to the point where it no longer 
segfaults during performance tests as the kvstore for bluestore.

The new PR is here:

https://github.com/ceph/ceph/pull/16257

The original version needed some work to get into a functional state. 
Some of this was just general things like adding cmake support and 
adding functionality to conform to the current KeyValueDB interface. 
Beyond that, the biggest issue was reworking it to not keep multiple 
concurrent write transactions open.  Other minor issues include removing 
various temporary string conversions and memory copies where possible.

One remaining issue is that Bluestore's BitmapFreelistManager keeps a 
read iterator open indefinitely.  This translates to keeping a read-only 
lmdb txn open, which makes new writes to the database grow the database 
rather than reusing free-pages (ie the db grows without bound with new 
writes).

A (buggy) fix for this is being attempted in another PR (currently 
probably breaks freelist management, segfaults for large min_alloc 
sizes), but fixes the db growth issue:

https://github.com/ceph/ceph/pull/16243

Write performance is fairly low (as expected) vs rocksdb, though it's 
possible we may be able to improve some of that via a WAL or similar 
mechanism.  Most of the time is spent doing fdatasync via mdb_env_sync. 
It might be possible to make the bluestore write workload more favorable 
to lmdb (bigger key/value pairs) but that's potentially a lot of work.

Space-amp so far seems like it might be lower than rocksdb in our 
current configuration though which could be good for large HDD 
configurations where the DB is on flash and raw write performance is 
less of an issue.

I think it would be good to try to get some other key/value stores like 
forestdb or even the aging zetascale into a functional state and do some 
more comparison testing.

Mark
