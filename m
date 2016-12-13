From: Igor Fedotov <ifedotov@mirantis.com>
Subject: A way to reduce BlueStore KV traffic
Date: Tue, 13 Dec 2016 19:21:25 +0300
Message-ID: <dc12e490-1c62-93a1-e65a-8e8fb423b8f7@mirantis.com>
References: <es4in77lf83vwmserwh0urhs.1481225501151@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f175.google.com ([209.85.213.175]:35005 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753379AbcLMQV1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Dec 2016 11:21:27 -0500
Received: by mail-yb0-f175.google.com with SMTP id d128so18452962ybh.2
        for <ceph-devel@vger.kernel.org>; Tue, 13 Dec 2016 08:21:27 -0800 (PST)
Received: from [127.0.0.1] ([91.218.144.129])
        by smtp.googlemail.com with ESMTPSA id f76sm19783499ywb.18.2016.12.13.08.21.25
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 08:21:26 -0800 (PST)
In-Reply-To: <es4in77lf83vwmserwh0urhs.1481225501151@email.android.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hey cephers!

We are fighting for KV traffic reduction in BlueStore for a while.
We're pushing huge amount of data to KV (object meta data,  write ahead 
log, block device allocation map etc ) and this impacts the performance 
dramatically. Below I'm trying to fix that by storing most of object 
meta data to block device directly. Actually we should use a second 
(fast) block device that can be physically co-located with DB or WAL 
devices.
Let's start from onode meta data only for the sake of simplicity.
We have somewhat 4K - 64K and even more meta data per single onode for 
4M object.  That includes user attrs, csum info, logical to physical 
extent mappings etc. This information is updated (partially or totally) 
on each write. The idea is to save that info to fast block device by 
direct use of an additional BlockDevice instance. E.g. one can allocate 
additional partition sharing the same physical device with DB for that. 
Instead of full onode representation KV DB will contain allocated 
physical extents layout for this meta data similar to blob pextents 
vector on per-onode basis - i.e. some indexing info.  Plus some minor 
data too if needed. Additionally KV to hold free space tracking info 
from the second FreeList manager for fast block device.
When saving onode bluestore has to allocate required space at fast 
device, mark old extents for release, write both onode and user data to 
block devices (in parallel) and update a db with space allocations. I.e. 
meta data overwrite procedure starts to resemble user data overwrite.

Similar idea can be applied for WAL - one can store user data to fast 
device directly and update indexing information in KV only.

Indexing information is pretty short and perhaps one should read it into 
memory on store mount and do not retrieve from DB during the operation.

This way DB traffic is reduced considerably and hence compaction will 
happen less frequently. Moreover we might probably remove var encoding 
stuff since we can be less careful about serialized onode size from now on.

There is some POC code located at
https://github.com/ifed01/ceph/tree/wip_bluestore_minimize_db
POC code lacks WAL support, index retrieval on startup, var encoding 
elimination at the moment.
Performance testing are still in progress.

Any thoughts/comments?

Thanks,
Igor
